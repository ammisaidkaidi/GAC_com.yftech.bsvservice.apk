# GAC_com.yftech.bsvservice.apk

Full Java-readable decompilation of **`com.yftech.bsvservice.apk`**, the blind-spot-view (side camera) service — a trimmed sibling of the AVM service from the [yftech-apks](https://github.com/ammisaidkaidi/yftech-apks) collection.

> Source APK: [com.yftech.bsvservice.apk](https://github.com/ammisaidkaidi/yftech-apks/blob/main/com.yftech.bsvservice.apk)  
> SHA-256: `84f4928a052baaf9073fcb135ac074ec544f689c84d5c0f3adf91021cfc33e71`  
> Size: 2.7 MB  
> Decompiled with **jadx 1.5.0** (Java sources) + **apktool 3.0.3** (smali / resources)  
> Generated: 2026-10-18

---

## 1. What this app is, what it does, and what it is for

`com.yftech.bsvservice` is the **Blind-Spot View (BSV) camera service** for YF Tech (GAC) head-units. It is a **specialised fork of `com.yftech.avmservice`**: the package tree, class names, state machine, DVR recorder and window framework are nearly identical, but everything to do with surround view, radar and MCU CAN protocol has been stripped out and replaced by a single `BSVWindow`. What remains is a persistent service whose only job is to pop a **full-screen 1920×720 side-camera preview** (the blind-spot camera) on top of the HMI when the vehicle asks for it, and to record it as a DVR clip. It runs as `android.uid.system`, `persistent=true`, is started by `BootCompletedReceiver` and exports the AutoChips binder action **`com.autochips.camera.BACKCAR_SERVICE`**.

**Purpose / why it exists on the device:**

Blind-spot view is a **safety-mandated, event-driven** feature: the camera must appear the moment the driver signals a lane change (or the vehicle logic decides to), with no user interaction, and must not be delayable by activity switches or by the HMI being busy. Putting it in its own persistent system-UID service means the vehicle logic (via `com.yftech.vehicle.sdk.CarDeviceManager` / `MpuProjectManager` / `CarConfig`) can raise a window instantly. It is shipped as a separate APK from the AVM service so that vehicles fitted only with BSV (and no 360° camera / no radar) can omit the heavier AVM package entirely — the two APKs never coexist.

**How it works (runtime flow):**

1. `BootCompletedReceiver` starts `BsvService` on `BOOT_COMPLETED`; the service goes foreground with notification channel `BsvService` (id 105) so it survives low memory.
2. `BsvService` observes the same signals as the AVM service: `BackCar.Listener` (AutoChips backcar signal), the `PREQB_POWERON/OFF` and `QB_POWERON/OFF` power broadcasts, `IUserSwitchObserver` for user switches, and `HomeReadyReceiver` for the launcher being ready.
3. `AvmControl` (the shared decision brain) reads vehicle type (`CAR_TYPE_A58 / A88 / A79`) and device type from `CarConfig`, and decides when to show or hide the window. Only `BSVWindow` is instantiated — the RVC / SAVM / Radar windows of the AVM build are absent.
4. `BSVWindow` is a `WindowManager` overlay (`BaseWindow`) holding a 1920×720 `CameraPreview` (`SurfaceView`) plus a hint `TextView`, an error layout (`mErrLayout` / `mErrView`, shown on `mIsCameraSystemErr` / `isShown_nosig`), and a touch-input filter view while the camera is up.
5. `CameraStateMachine` (Closed → Opening → Opened → Previewing → PreviewingAndRecording → Recording, plus a QBOff state) drives `CameraOperation`, the Camera2 wrapper: open camera, start/stop preview, start/stop/urgent record, snapshot, resolution/width/height/start-x/start-y, watermark, mic.
6. `AudioFocus` takes transient audio focus so navigation/radio audio ducks while the blind-spot view is displayed.
7. `PermissionsManager` brokers the CAMERA / RECORD_AUDIO grants, `Archiver` + `StorageUtil` write the DVR files, and `MIPIDVRActivity` (with `RecordSettingsView` and `WatermarkSettingsView`) is the debug/settings screen for recording parameters.

**Notable findings:**

- **This APK is a near-clone of `com.yftech.avmservice`** — 589 of the same 603 Java files, same Android Support Library bundle, same `CameraStateMachine` / `CameraOperation` / `AVMMonitor` / `Archiver` code. If you have the AVM repo, read that README first; this document only lists what differs.
- Differences vs `com.yftech.avmservice`: no `procotol/` package at all — **no `MCUCommNative`, no `libAvmMcuComm.so`, no CAN/RVC/SAVM/Radar protocols**. No `RadarWindow` / `RadarShowWindow` / `RVCWindow` / `SAVMWindow` / `CameraSelView`; the only overlay is `BSVWindow` (1920×720). No sound-pool / tone classes (`MySoundPool`, `SoundPoolPlayer`, `TonePlay`, `APASoundPool`).
- It reuses the `com.autochips.camera.BACKCAR_SERVICE` action name even though it is a blind-spot service — so it is bind-compatible with the AVM service from a client's point of view.
- Same privileged permission set as AVM: `INTERNAL_SYSTEM_WINDOW`, `EXPAND_STATUS_BAR`, `STATUS_BAR`, `FORCE_STOP_PACKAGES`, `INTERACT_ACROSS_USERS_FULL`, `REORDER_TASKS`, `com.yftech.permission.service.main.screen`, `com.yftech.permission.service.vehicle.COMMON`.
- Depends on vendor frameworks absent from the APK: `com.autochips.backcar.BackCar`, `com.autochips.metazone.AtcMetazone`, `com.yftech.vehicle.sdk.{CarConfig,CarDeviceManager,MpuProjectManager}`, `com.yftech.vehicle.internal.adapter.{ICarConfig,IBaseApi}`.
- No network endpoints, no native `loadLibrary`, no reflection abuse, no SQL — purely local camera + vehicle-bus driven.
- Bundles the full Android Support Library v4/v7 (AppCompat, ConstraintLayout, transitions) which dominates the file count.

## 2. APK metadata

| Property | Value |
|---|---|
| Package name | `com.yftech.bsvservice` |
| Version name / code | `1.0` / `1` |
| minSdk / targetSdk / maxSdk | `26` / `28` / `None` |
| sharedUserId | `android.uid.system` |
| `<application>` attributes | `name=com.yftech.bsvservice.App`, `label=@string/app_name`, `icon=@drawable/mipi_camera`, `theme=@style/AppTheme`, `allowBackup=true`, `persistent=true` |
| Java classes decompiled | **589** files / 589 top-level types |
| Smali files | **1508** |
| Total Java lines | ~131,108 |
| Total methods | ~27,063 |
| Permissions requested | **19** |
| Declared (custom) permissions | **0** |
| Activities / Services / Receivers / Providers | 1 / 1 / 1 / 0 |

## 3. Repository layout

```
.
├── README.md                  <- this file (full class/function catalogue + analysis)
├── sources/                   <- jadx: decompiled JAVA sources (.java)  **start here**
│   └── <package path>/<Class>.java
├── resources/                 <- jadx: decoded manifest + resources + assets
│   ├── AndroidManifest.xml
│   ├── res/                   <- layouts, drawables, values (near-original form)
│   └── assets/                <- raw asset files (config .properties, etc.)
├── smali/                     <- apktool: disassembled Dalvik bytecode (.smali)
│   └── <package path>/<Class>.smali
├── smali_classes2..N/         <- apktool: extra dex files (when present)
├── original/                  <- apktool: files that could not be decoded (META-INF, …)
├── AndroidManifest.apktool.xml<- apktool copy of the manifest (raw attribute order)
└── apktool.yml                <- apktool build metadata
```

`sources/` is the Java-readable tree — this is what you want to read. `smali/` is the same code in Dalvik assembly (useful when jadx output is ambiguous).

## 4. Permissions

### Requested permissions

| Permission |
|---|
| `android.permission.RECEIVE_BOOT_COMPLETED` |
| `android.permission.FOREGROUND_SERVICE` |
| `android.permission.CAMERA` |
| `android.permission.RECORD_AUDIO` |
| `android.permission.WAKE_LOCK` |
| `android.permission.ACCESS_FINE_LOCATION` |
| `android.permission.BROADCAST_STICKY` |
| `android.permission.SYSTEM_ALERT_WINDOW` |
| `android.permission.INTERNAL_SYSTEM_WINDOW` |
| `android.permission.STOP_APP_SWITCHES` |
| `android.permission.EXPAND_STATUS_BAR` |
| `android.permission.STATUS_BAR` |
| `android.permission.FORCE_STOP_PACKAGES` |
| `android.permission.GET_TASKS` |
| `android.permission.REORDER_TASKS` |
| `android.permission.INTERACT_ACROSS_USERS` |
| `android.permission.INTERACT_ACROSS_USERS_FULL` |
| `com.yftech.permission.service.main.screen` |
| `com.yftech.permission.service.vehicle.COMMON` |

## 5. Declared components

### Activities (1)

| Class | Exported | Enabled | Guarded by | Intent actions |
|---|---|---|---|---|
| `com.yftech.bsvservice.activity.MIPIDVRActivity` | — | — | — | `android.intent.action.MAIN` |

### Services (1)

| Class | Exported | Enabled | Guarded by | Intent actions |
|---|---|---|---|---|
| `com.yftech.bsvservice.BsvService` | true | true | — | `com.autochips.camera.BACKCAR_SERVICE` |

### Broadcast receivers (1)

| Class | Exported | Enabled | Guarded by | Intent actions |
|---|---|---|---|---|
| `com.yftech.bsvservice.BootCompletedReceiver` | — | — | — | `android.intent.action.BOOT_COMPLETED` |

### Content providers (0)

_none_

## 6. Package map

| Package | Classes | Methods | Lines |
|---|---:|---:|---:|
| `android.support.v7.widget` | 71 | 4518 | 20,384 |
| `android.support.v4.app` | 53 | 3923 | 17,347 |
| `android.support.v4.widget` | 31 | 2394 | 10,129 |
| `com.yftech.bsvservice` | 18 | 1238 | 8,463 |
| `android.support.v4.view` | 41 | 1816 | 8,008 |
| `android.support.v7.app` | 18 | 1693 | 7,557 |
| `android.support.constraint.solver.widgets` | 10 | 1123 | 5,812 |
| `android.support.v7.view.menu` | 26 | 1304 | 5,646 |
| `android.support.graphics.drawable` | 10 | 698 | 3,778 |
| `android.support.v4.util` | 20 | 943 | 3,594 |
| `android.support.constraint` | 5 | 500 | 3,024 |
| `android.support.v7.graphics.drawable` | 5 | 546 | 2,662 |
| `android.support.v4.graphics` | 13 | 336 | 2,231 |
| `android.support.v4.content` | 13 | 448 | 2,186 |
| `android.support.v4.view.accessibility` | 6 | 541 | 2,133 |
| `android.support.design.widget` | 1 | 490 | 2,025 |
| `android.support.v4.graphics.drawable` | 10 | 415 | 1,905 |
| `androidx.versionedparcelable` | 11 | 520 | 1,836 |
| `android.support.constraint.solver` | 7 | 371 | 1,713 |
| `android.support.v7.appcompat` | 1 | 13 | 1,669 |
| `android.arch.lifecycle` | 29 | 344 | 1,653 |
| `android.support.v4.provider` | 8 | 294 | 1,548 |
| `android.support.v7.view` | 9 | 263 | 1,377 |
| `android.support.v4.text` | 7 | 286 | 1,354 |
| `android.support.v4.os` | 17 | 287 | 1,314 |
| `android.support.v4.content.res` | 8 | 226 | 1,145 |
| `com.yftech.bsvservice.avm` | 4 | 194 | 993 |
| `com.yftech.bsvservice.util` | 7 | 173 | 904 |
| `android.support.annotation` | 51 | 30 | 807 |
| `com.yftech.bsvservice.windowutil` | 5 | 121 | 648 |
| `android.support.v4.text.util` | 2 | 129 | 576 |
| `com.yftech.bsvservice.activity` | 3 | 134 | 554 |
| `android.support.v4.print` | 1 | 85 | 502 |
| `com.yftech.bsvservice.common` | 7 | 54 | 381 |
| `android.arch.core.internal` | 2 | 72 | 367 |
| `android.support.v13.view.inputmethod` | 3 | 65 | 355 |
| `android.support.v4.content.pm` | 5 | 57 | 330 |
| `android.support.v4.net` | 3 | 52 | 243 |
| `android.support.fragment` | 1 | 11 | 237 |
| `android.support.coordinatorlayout` | 1 | 11 | 237 |
| `android.support.coreui` | 1 | 11 | 237 |
| `android.support.loader` | 1 | 11 | 209 |
| `android.support.v7.viewpager` | 1 | 11 | 209 |
| `android.support.asynclayoutinflater` | 1 | 11 | 209 |
| `android.support.coreutils` | 1 | 11 | 209 |
| `android.support.swiperefreshlayout` | 1 | 11 | 209 |
| `android.support.drawerlayout` | 1 | 11 | 209 |
| `android.support.slidingpanelayout` | 1 | 11 | 209 |
| `android.support.customview` | 1 | 11 | 209 |
| `android.support.compat` | 1 | 11 | 209 |
| `android.support.v4.view.animation` | 6 | 37 | 189 |
| `android.support.v4.hardware.fingerprint` | 1 | 40 | 186 |
| `android.arch.core.executor` | 3 | 26 | 147 |
| `android.support.v7.content.res` | 1 | 20 | 122 |
| `android.support.v13.view` | 2 | 17 | 116 |
| `android.support.v4.internal.view` | 3 | 24 | 115 |
| `android.support.v4.accessibilityservice` | 1 | 20 | 114 |
| `android.support.v4.hardware.display` | 1 | 15 | 66 |
| `com.yftech.bsvservice.constant` | 1 | 0 | 61 |
| `android.support.v4.database` | 2 | 13 | 57 |
| `androidx.core.graphics.drawable` | 1 | 2 | 36 |
| `android.support.v7.text` | 1 | 4 | 31 |
| `android.support.v4.math` | 1 | 4 | 20 |
| `android.support.v4.database.sqlite` | 1 | 3 | 18 |
| `android.support.print` | 1 | 1 | 8 |
| `android.support.cursoradapter` | 1 | 1 | 8 |
| `android.support.documentfile` | 1 | 1 | 8 |
| `android.support.localbroadcastmanager` | 1 | 1 | 8 |
| `android.support.interpolator` | 1 | 1 | 8 |
| `android.arch.lifecycle.viewmodel` | 1 | 1 | 8 |
| `android.arch.lifecycle.livedata` | 1 | 1 | 8 |
| `android.arch.lifecycle.livedata.core` | 1 | 1 | 8 |
| `android.arch.core` | 1 | 1 | 8 |
| `android.arch.core.util` | 1 | 1 | 7 |
| `?` | 1 | 0 | 6 |
| **TOTAL** | **589** | **27,063** | **131,108** |

## 7. Class and function catalogue

Every decompiled class with its declared functions. Methods are listed by name; see the `.java` files under `sources/` for full signatures and bodies.

### Package `com.yftech.bsvservice`  (18 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `App` | class | Application | 28 | 4 |
| `BackcarSurfaceCallback` | class | SurfaceHolder.Callback | 33 | 4 |
| `BootCompletedReceiver` | class | BroadcastReceiver | 32 | 4 |
| `BsvService` | class | Service | 433 | 84 |
| `BsvServiceImpl` | class | IBsvService.Stub implements CameraStateMachine.StateMachineCallback | 650 | 152 |
| `BuildConfig` | class | — | 12 | 0 |
| `CameraOperation` | class | TimerTask | 1,530 | 323 |
| `CameraStateMachine` | class | StateMachine | 1,449 | 258 |
| `HomeReadyReceiver` | class | BroadcastReceiver | 23 | 2 |
| `IBsvService` | class | IInterface | 661 | 79 |
| `IBsvServiceCallback` | class | IInterface | 139 | 22 |
| `IState` | class | — | 18 | 4 |
| `PermissionsManager` | class | — | 95 | 15 |
| `R` | class | — | 2,079 | 0 |
| `Resolution` | class | Parcelable | 62 | 11 |
| `State` | class | IState | 26 | 4 |
| `StateMachine` | class | Handler | 1,170 | 269 |
| `WrappedSurface` | class | — | 23 | 3 |

<details>
<summary><b>Function list for <code>com.yftech.bsvservice</code></b> (click to expand)</summary>

- **`App`** — 4 function(s): `add()`, `remove()`, `exitActivity()`, `while()`
- **`BackcarSurfaceCallback`** — 4 function(s): `BackcarSurfaceCallback()`, `surfaceCreated()`, `surfaceChanged()`, `surfaceDestroyed()`
- **`BootCompletedReceiver`** — 2 function(s): `onReceive()`, `if()`
- **`BsvService`** — 40 function(s): `onEvent()`, `if()`, `onAudioFocusChange()`, `onForegroundProfileSwitch()`, `onLockedBootComplete()`, `onUserSwitching()`, `onUserSwitchComplete()`, `run()`, `while()`, `onReceive()`, `getInstance()`, `startUserPreview()`, `stopUserPreview()`, `startBackCar()`, `stopBackCar()`, `isPreviewStarted()`, `requestBackcarAudioFocusForArm2()`, `abandonAudioFocusWhenArm2Exit()`, `getBackcarCameraId()`, `isRVCMode()`, `setUncaughtExceptionHandler()`, `uncaughtException()`, `onCreate()`, `startForegroundNotification()`, `registerMountUnmountReceiver()`, `registerQBReceiver()`, `Thread()`, `onStartCommand()`, `onDestroy()`, `unRegisterMountUnmountReceiver()`, `unregisterQBReceiver()`, `stopForeground()`, `onBind()`, `onConfigurationChanged()`, `getResources()`, `getCameraId()`, `initChannel()`, `startForeground()`, `registerReceiver()`, `unregisterReceiver()`
- **`BsvServiceImpl`** — 66 function(s): `release()`, `updateBackcarUi()`, `getInstance()`, `cameraready()`, `if()`, `BsvServiceImpl()`, `getWindowInfo()`, `initBarcarView()`, `initAlertDialog()`, `initCameraStateMachines()`, `setCameraMonitorListener()`, `getCameraStateMachine()`, `updateDisplayInfoFromMetazone()`, `onClick()`, `sendMediaMountedAndEjectedMessage()`, `while()`, `sendQBMessage()`, `notifyExitArm2()`, `startPreview()`, `stopPreview()`, `isPreviewStarted()`, `startRecord()`, `stopRecord()`, `isNormalRecordStarted()`, `isUrgentRecordStarted()`, `snapShot()`, `setMicState()`, `getMicState()`, `setResolution()`, `getResolutions()`, `for()`, `setDuration()`, `getDuration()`, `return()`, `resetSettings()`, `setWatermarkState()`, `setWatermarkStartX()`, `setWatermarkStartY()`, `setWatermarkWidth()`, `setWatermarkHeight()`, `getWatermarkState()`, `isArm2Exit()`, `registerBsvServiceCallback()`, `updateStatus()`, `unregisterBsvServiceCallback()`, `TouchInputFilterView()`, `super()`, `onTouchEvent()`, `showTouchInputFilterView()`, `cancelTouchInputFilterView()`, `startUserPreview()`, `stopUserPreview()`, `isBackCar()`, `startBackcar()`, `enableBackcarAudio()`, `stopBackcar()`, `disableBackcarAudio()`, `disableStatusBarExpand()`, `collapsePanels()`, `updateError()`, `showBackcarInfo()`, `switch()`, `filterRecordTooSlowMsg()`, `onOperationSuccess()`, `onOperationFail()`, `linkToDeath()`
- **`CameraOperation`** — 86 function(s): `onClosed()`, `onOpened()`, `onDisconnected()`, `onError()`, `if()`, `onCaptureProgressed()`, `onCaptureCompleted()`, `BackCar()`, `run()`, `MoveUrgentFileTask()`, `onImageAvailable()`, `onInfo()`, `onOperationFailed()`, `onOperationSuccess()`, `getWatermarkState()`, `CameraOperation()`, `getAtcCaptureKeys()`, `getCameraId()`, `notifyOperationCallback()`, `open()`, `close()`, `stopRecordAndRecycle()`, `closePreviewSession()`, `createCaptureSession()`, `setupNewImageReader()`, `onConfigured()`, `onConfigureFailed()`, `startPreview()`, `updatePreviewAndRecord()`, `hasPendingPreviewSurface()`, `stopPreviewWhileQbOff()`, `isNeedRestoreCamera()`, `return()`, `restoreCamera()`, `stopPreview()`, `recreateCaptureSession()`, `updateRequest()`, `setUpCaptureRequestBuilder()`, `startRecordAfterSetRepeatingRequest()`, `getMetazoneInfo()`, `restartRecord()`, `startRecord()`, `startNewRecycleTask()`, `stopRecycleTask()`, `prepareRecorderSurface()`, `prepareMediaRecorder()`, `stopRecord()`, `snapshot()`, `onCaptureFailed()`, `while()`, `getSupportResolutions()`, `getMaximumResolution()`, `for()`, `checkIfResolutionSupported()`, `getFPS()`, `checkAndUpdateResolution()`, `updateCameraCharacter()`, `setMediaRecorderSyncFlag()`, `getOutputFile()`, `setPreviewSurface()`, `getBackcarState()`, `setResolution()`, `getCurrentResolution()`, `setVideoDuration()`, `setMicOnOff()`, `setWatermarkOnOff()`, `setWatermarkStart()`, `setWatermarkSize()`, `resetSettings()`, `setHue()`, `setBrightness()`, `setSaturation()`, `setContrast()`, `isPreviewing()`, `isRecording()`, `isPreviewRequest()`, `isRecordRequest()`, `getResolutions()`, `ArrayList()`, `getDuration()`, `getMicState()`, `registerCameraOperationCallback()`, `unregisterCameraOperationCallback()`, `goOnRecording()`, `RecycleTask()`, `doInBackground()`
- **`CameraStateMachine`** — 60 function(s): `onOperationFail()`, `onOperationSuccess()`, `CameraStateMachine()`, `super()`, `switch()`, `onOperationFailed()`, `handleMessage()`, `if()`, `initStates()`, `addState()`, `setInitialState()`, `handleSetParamMessage()`, `ClosedState()`, `enter()`, `processMessage()`, `OpeningState()`, `OpenedState()`, `ClosingState()`, `RecordingState()`, `PreviewingState()`, `PreviewingAndRecordingState()`, `QBOffState()`, `getCameraOperation()`, `while()`, `removeTheSameMessages()`, `removeMessages()`, `removeDeferredMessages()`, `removeTheOppositeMessages()`, `hasTheOppositeMessage()`, `hasTheSameMessage()`, `hasMessages()`, `hasPendingStateMessage()`, `startPreview()`, `sendMessage()`, `stopPreview()`, `startRecord()`, `stopRecord()`, `snapshot()`, `setResolution()`, `setDuration()`, `setMic()`, `setWaterMark()`, `setWatermarkStartX()`, `setWatermarkStartY()`, `setWatermarkWidth()`, `resetSettings()`, `setWatermarkHeight()`, `setHue()`, `setBrightness()`, `setSaturation()`, `setContrast()`, `getPreviewState()`, `getRecordingState()`, `getResolutions()`, `getMicState()`, `getWatermarkState()`, `getDuration()`, `getCurrentResolution()`, `registerCallback()`, `unregisterCallback()`
- **`HomeReadyReceiver`** — 2 function(s): `onReceive()`, `if()`
- **`IBsvService`** — 34 function(s): `getDuration()`, `getMicState()`, `getResolutions()`, `getWatermarkState()`, `isArm2Exit()`, `isNormalRecordStarted()`, `isPreviewStarted()`, `isUrgentRecordStarted()`, `registerBsvServiceCallback()`, `resetSettings()`, `setDuration()`, `setMicState()`, `setResolution()`, `setWatermarkHeight()`, `setWatermarkStartX()`, `setWatermarkStartY()`, `setWatermarkState()`, `setWatermarkWidth()`, `snapShot()`, `startPreview()`, `startRecord()`, `stopPreview()`, `stopRecord()`, `unregisterBsvServiceCallback()`, `asBinder()`, `Stub()`, `attachInterface()`, `asInterface()`, `if()`, `return()`, `Proxy()`, `onTransact()`, `switch()`, `getInterfaceDescriptor()`
- **`IBsvServiceCallback`** — 13 function(s): `getCameraId()`, `onErrorOccurred()`, `onStatusChanged()`, `asBinder()`, `Stub()`, `attachInterface()`, `asInterface()`, `if()`, `return()`, `Proxy()`, `onTransact()`, `switch()`, `getInterfaceDescriptor()`
- **`IState`** — 4 function(s): `enter()`, `exit()`, `getName()`, `processMessage()`
- **`PermissionsManager`** — 8 function(s): `requestCameraPermission()`, `requesetExtCardPermission()`, `for()`, `if()`, `requestVideoRecordPermission()`, `checkCameraPermission()`, `checkVideoRecordPermission()`, `hasPermissionGranted()`
- **`Resolution`** — 9 function(s): `createFromParcel()`, `Resolution()`, `newArray()`, `describeContents()`, `getWidth()`, `getHeight()`, `toString()`, `writeToParcel()`, `readFromParcel()`
- **`State`** — 4 function(s): `enter()`, `exit()`, `processMessage()`, `getName()`
- **`StateMachine`** — 92 function(s): `getLogRecString()`, `getWhatToString()`, `haltedProcessMessage()`, `onHalting()`, `onPostHandleMessage()`, `onPreHandleMessage()`, `onQuitting()`, `recordLogRec()`, `LogRec()`, `update()`, `getTime()`, `getWhat()`, `getInfo()`, `getState()`, `getDestState()`, `getOriginalState()`, `toString()`, `if()`, `LogRecords()`, `setSize()`, `setLogOnlyTransitions()`, `logOnlyTransitions()`, `size()`, `count()`, `cleanup()`, `get()`, `add()`, `StateInfo()`, `HaltingState()`, `processMessage()`, `QuittingState()`, `handleMessage()`, `invokeEnterMethods()`, `RuntimeException()`, `performTransitions()`, `while()`, `invokeExitMethods()`, `moveDeferredMessageAtFrontOfQueue()`, `cleanupAfterQuitting()`, `getLooper()`, `completeConstruction()`, `for()`, `setupInitialStateStack()`, `sendMessageAtFrontOfQueue()`, `processMsg()`, `transitionTo()`, `moveTempStateStackToStateStack()`, `setupTempStateStackWithStatesToEnter()`, `getCurrentMessage()`, `getCurrentState()`, `addState()`, `removeState()`, `test()`, `SmHandler()`, `super()`, `setInitialState()`, `deferMessage()`, `quit()`, `sendMessage()`, `quitNow()`, `isQuit()`, `isDbg()`, `setDbg()`, `initStateMachine()`, `StateMachine()`, `transitionToHaltingState()`, `unhandledMessage()`, `loge()`, `getName()`, `setLogRecSize()`, `getLogRecSize()`, `getLogRecMaxSize()`, `getLogRecCount()`, `getLogRec()`, `copyLogRecs()`, `addLogRec()`, `getHandler()`, `obtainMessage()`, `sendMessageDelayed()`, `clearDeferredMessages()`, `removeMessages()`, `removeDeferredMessages()`, `hasDeferredMessages()`, `hasMessages()`, `start()`, `dump()`, `logAndAddLogRec()`, `log()`, `logd()`, `logv()`, `logi()`, `logw()`
- **`WrappedSurface`** — 3 function(s): `WrappedSurface()`, `isValid()`, `toString()`

</details>

### Package `com.yftech.bsvservice.activity`  (3 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `MIPIDVRActivity` | class | Activity implements View.OnClickListener | 89 | 16 |
| `RecordSettingsView` | class | FrameLayout | 131 | 25 |
| `WatermarkSettingsView` | class | FrameLayout implements View.OnClickListener | 334 | 93 |

<details>
<summary><b>Function list for <code>com.yftech.bsvservice.activity</code></b> (click to expand)</summary>

- **`MIPIDVRActivity`** — 16 function(s): `onCreate()`, `requestWindowFeature()`, `getWindow()`, `setContentView()`, `onPause()`, `onStart()`, `onStop()`, `onResume()`, `onDestroy()`, `onConfigurationChanged()`, `getResources()`, `sendHXBroadCast()`, `if()`, `for()`, `sendBroadcastAsUser()`, `onClick()`
- **`RecordSettingsView`** — 15 function(s): `onDurationChanged()`, `onResolutionChanged()`, `RecordSettingsView()`, `this()`, `super()`, `initView()`, `onItemSelected()`, `if()`, `onNothingSelected()`, `getResolutionStr()`, `for()`, `getMaximumResolution()`, `updateResolution()`, `registerRecordSettingsListener()`, `unregisterRecordSettingsListener()`
- **`WatermarkSettingsView`** — 22 function(s): `onHeightChanged()`, `onStartXChanged()`, `onStartYChanged()`, `onStateChanged()`, `onWidthChanged()`, `WatermarkSettingsView()`, `this()`, `super()`, `initView()`, `findViewById()`, `getEditTextNumber()`, `if()`, `addForEditText()`, `minusForEditText()`, `doMinus()`, `notify()`, `doAdd()`, `doSwitchWatermark()`, `switch()`, `onClick()`, `registerWatermarkSettingsListener()`, `unregisterWatermarkSettingsListener()`

</details>

### Package `com.yftech.bsvservice.avm`  (4 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AVMMonitor` | class | — | 21 | 6 |
| `AudioFocus` | class | CarDataManager.CarDataCallback | 341 | 54 |
| `AvmControl` | class | ICameraControl.ICameraControlListener, AVMMonitor.ICameraMonitorListener | 596 | 129 |
| `StaticBroadcastReceiver` | class | BroadcastReceiver | 35 | 5 |

<details>
<summary><b>Function list for <code>com.yftech.bsvservice.avm</code></b> (click to expand)</summary>

- **`AVMMonitor`** — 6 function(s): `onCameraMonitorLoading()`, `onCameraMonitorNoSignal()`, `onCameraMonitorReady()`, `onCameraMonitorReqHide()`, `onCameraMonitorReqShow()`, `onCameraMonitorResumeSignal()`
- **`AudioFocus`** — 21 function(s): `onAudioFocusChange()`, `switch()`, `getKeepMuteWarning()`, `if()`, `InterruptMediaType()`, `SingletonFactory()`, `getInstance()`, `MyCarDataCallback()`, `onCarDataChanged()`, `MyCarIcmListener()`, `onKeepMuteWarningStateChanged()`, `AudioFocus()`, `requestCanActiveFocus()`, `abandonCanActiveFocus()`, `isCarplayCertificate()`, `requestAvmFocus()`, `abondAvmFocus()`, `requestRvcFocus()`, `abondRvcFocus()`, `requestRadarFocus()`, `abandonRadarFocus()`
- **`AvmControl`** — 65 function(s): `canShow()`, `getAvmHardwareState()`, `getAvmMode()`, `getAvmSignal()`, `getCarSpeed()`, `setAvmMode()`, `isAvmSignalOk()`, `onBackcarChange()`, `isBackCar()`, `onCameraReqShow()`, `if()`, `setAvmReqOnOff()`, `onCameraMonitorReqShow()`, `onCameraMonitorReady()`, `onCameraReqHide()`, `onCameraMonitorReqHide()`, `onCameraSystemErr()`, `onCameraCommTimeOut()`, `onCameraOpStateErr()`, `onSteerWheelAngel()`, `isReverseWindowShow()`, `onDisplayState()`, `onGearStateChange()`, `playReverseEffect()`, `onAPADrvReq()`, `getAPADrvReq()`, `isAvmDisplay()`, `showAvm()`, `hideAvm()`, `onCameraMonitorLoading()`, `onCameraMonitorNoSignal()`, `onCameraMonitorResumeSignal()`, `isShowLoading()`, `isAvmSignalErr()`, `isCarTrunkOpen()`, `AvmControl()`, `run()`, `getDevice()`, `getRadar()`, `isRvcMode()`, `getBackCarCameraID()`, `SingletonFactory()`, `getInstance()`, `readResolve()`, `getMainHandler()`, `init()`, `setAvmServiceRun()`, `isAvmServiceRun()`, `avmInit()`, `getWindow()`, `windowInit()`, `getSurface()`, `dispSurfaceInit()`, `dispSurfaceRelease()`, `getDeviceType()`, `getRadarType()`, `getCarType()`, `userRequestShowAvm()`, `userRequestHideAvm()`, `sourceStart()`, `sourcePause()`, `sourceResume()`, `sourceStop()`, `getAvmReqOnOff()`, `postDelayHandler()`
- **`StaticBroadcastReceiver`** — 2 function(s): `onReceive()`, `if()`

</details>

### Package `com.yftech.bsvservice.common`  (7 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `Archiver` | class | — | 34 | 5 |
| `BaseActivity` | class | Activity | 96 | 16 |
| `CameraDataDef` | class | — | 147 | 0 |
| `ICameraControl` | class | — | 43 | 16 |
| `IMcuCommListener` | class | — | 9 | 1 |
| `IRadarControl` | class | — | 25 | 7 |
| `ISAVMControl` | class | ICameraControl | 27 | 9 |

<details>
<summary><b>Function list for <code>com.yftech.bsvservice.common</code></b> (click to expand)</summary>

- **`Archiver`** — 5 function(s): `Archiver()`, `encodeIntForKey()`, `if()`, `isContains()`, `decodeIntForKey()`
- **`BaseActivity`** — 8 function(s): `onCreate()`, `if()`, `onPause()`, `onDestroy()`, `runOnUiThread()`, `removeFromUiThread()`, `queueEvent()`, `removeEvent()`
- **`ICameraControl`** — 16 function(s): `onAPADrvReq()`, `onCameraCommTimeOut()`, `onCameraOpStateErr()`, `onCameraReqHide()`, `onCameraReqShow()`, `onCameraSystemErr()`, `onDisplayState()`, `onGearStateChange()`, `onSteerWheelAngel()`, `getSteerWheelAngle()`, `isCameraOpErr()`, `isCommTimeOut()`, `requestCanSync()`, `requestHide()`, `requestShow()`, `setCameraControlListener()`
- **`IMcuCommListener`** — 1 function(s): `onMcuMessageCallBack()`
- **`IRadarControl`** — 7 function(s): `onRadarInfo()`, `getRadarInfo()`, `isFrontRadarErr()`, `isRearRadarErr()`, `requestRadarClose()`, `requestRadarOpen()`, `setRadarListener()`
- **`ISAVMControl`** — 9 function(s): `onSAvmCameraInputErr()`, `onSAvmEOLTestModeChange()`, `onSAvmGuideLineChange()`, `onSAvmGuideLineErr()`, `onSAvmRadarErr()`, `onSAvmSingleViewChange()`, `replyAPAShowState()`, `sendTouchToAVM()`, `setSAVMControlListener()`

</details>

### Package `com.yftech.bsvservice.constant`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `Constant` | class | — | 61 | 0 |

<details>
<summary><b>Function list for <code>com.yftech.bsvservice.constant</code></b> (click to expand)</summary>


</details>

### Package `com.yftech.bsvservice.util`  (7 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AudioTrackManager` | class | — | 123 | 21 |
| `DVRConst` | class | — | 102 | 0 |
| `DistributedHandler` | class | Handler | 56 | 12 |
| `HandlerThreadHandler` | class | Handler | 39 | 12 |
| `LogUtil` | class | — | 62 | 18 |
| `StorageUtil` | class | Comparator<FileWithLastModifiedTime> | 500 | 107 |
| `ToastUtil` | class | — | 22 | 3 |

<details>
<summary><b>Function list for <code>com.yftech.bsvservice.util</code></b> (click to expand)</summary>

- **`AudioTrackManager`** — 11 function(s): `run()`, `while()`, `if()`, `AudioTrackManager()`, `getInstance()`, `synchronized()`, `destroyThread()`, `startThread()`, `setPath()`, `startPlay()`, `stopPlay()`
- **`DistributedHandler`** — 8 function(s): `dispatchHandleMessage()`, `DistributedHandler()`, `super()`, `handleMessage()`, `for()`, `if()`, `addHandlerPart()`, `removeHandlerPart()`
- **`HandlerThreadHandler`** — 3 function(s): `createHandler()`, `HandlerThreadHandler()`, `super()`
- **`LogUtil`** — 8 function(s): `LogUtil()`, `v()`, `println()`, `d()`, `i()`, `w()`, `e()`, `if()`
- **`StorageUtil`** — 34 function(s): `enoughSpaceAfterReuse()`, `ensureFileNumWithinLimits()`, `StorageUtil()`, `setNormalPolicy()`, `if()`, `setUrgentPolicy()`, `setImagePolicy()`, `getSpaceReusePolicy()`, `isVolumeMounted()`, `for()`, `toPublicPath()`, `toPrivatePath()`, `getDirSize()`, `getRootDir()`, `NoUdiskMountedException()`, `NoSDCardMountedException()`, `FileAlreadyExistException()`, `getOutputFile()`, `createFile()`, `SpaceNotEnoughException()`, `updateFileWithMediaScanner()`, `getAllFilesOfDir()`, `reuseStorageSpace()`, `deleteOldFiles()`, `FileComparator()`, `compare()`, `moveUrgentFileFromNormal()`, `moveUrgentFilesInCertainTime()`, `DefaultNormalReusePolicy()`, `DefaultUrgentReusePolicy()`, `DefaultImageReusePolicy()`, `return()`, `super()`, `FileWithLastModifiedTime()`
- **`ToastUtil`** — 2 function(s): `showToast()`, `if()`

</details>

### Package `com.yftech.bsvservice.windowutil`  (5 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `BSVWindow` | class | BaseWindow implements View.OnClickListener, View.OnTouchListener | 232 | 36 |
| `BaseWindow` | class | DistributedHandler.HandlerPart | 292 | 63 |
| `CameraPreview` | class | SurfaceView implements SurfaceHolder.Callback | 49 | 7 |
| `CameraSelView` | class | View | 27 | 3 |
| `CustomRelativeLayout` | class | RelativeLayout | 48 | 12 |

<details>
<summary><b>Function list for <code>com.yftech.bsvservice.windowutil</code></b> (click to expand)</summary>

- **`BSVWindow`** — 20 function(s): `MyCarDeviceListener()`, `onBSVDisplayStateChanged()`, `BSVWindow()`, `super()`, `initView()`, `getSurface()`, `updateWindow()`, `if()`, `showWindow()`, `openScreenBackLight()`, `BroadcastWindow()`, `setWindowVisibility()`, `hideWindow()`, `restoreScreenBackLight()`, `onClick()`, `setUpWindowPara()`, `dispatchHandleMessage()`, `onTouch()`, `switch()`, `sendTouchToAVM()`
- **`BaseWindow`** — 18 function(s): `run()`, `if()`, `BaseWindow()`, `getAvmControl()`, `showWindow()`, `hideWindow()`, `isShow()`, `setWindowVisibility()`, `updateWindow()`, `openScreenBackLight()`, `restoreScreenBackLight()`, `setCameraState()`, `onAvmHideWindow()`, `dispatchHandleMessage()`, `switch()`, `sendHXBroadCast()`, `for()`, `BroadcastWindow()`
- **`CameraPreview`** — 7 function(s): `CameraPreview()`, `super()`, `surfaceCreated()`, `surfaceDestroyed()`, `surfaceChanged()`, `onConfigurationChanged()`, `setFixedSize()`
- **`CameraSelView`** — 3 function(s): `CameraSelView()`, `super()`, `onDraw()`
- **`CustomRelativeLayout`** — 5 function(s): `dispatchKeyEvent()`, `setOnKeyEventListener()`, `CustomRelativeLayout()`, `super()`, `if()`

</details>

### Package `android.arch.core`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.arch.core</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.arch.core.executor`  (3 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ArchTaskExecutor` | class | TaskExecutor | 83 | 14 |
| `DefaultTaskExecutor` | class | TaskExecutor | 41 | 6 |
| `TaskExecutor` | class | — | 23 | 6 |

<details>
<summary><b>Function list for <code>android.arch.core.executor</code></b> (click to expand)</summary>

- **`ArchTaskExecutor`** — 11 function(s): `execute()`, `ArchTaskExecutor()`, `getInstance()`, `if()`, `synchronized()`, `setDelegate()`, `executeOnDiskIO()`, `postToMainThread()`, `getMainThreadExecutor()`, `getIOThreadExecutor()`, `isMainThread()`
- **`DefaultTaskExecutor`** — 5 function(s): `executeOnDiskIO()`, `postToMainThread()`, `if()`, `synchronized()`, `isMainThread()`
- **`TaskExecutor`** — 5 function(s): `executeOnDiskIO()`, `isMainThread()`, `postToMainThread()`, `executeOnMainThread()`, `if()`

</details>

### Package `android.arch.core.internal`  (2 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `FastSafeIterableMap` | class | SafeIterableMap<K, V> | 47 | 7 |
| `SafeIterableMap` | class | Iterable<Map.Entry<K, V>> | 320 | 65 |

<details>
<summary><b>Function list for <code>android.arch.core.internal</code></b> (click to expand)</summary>

- **`FastSafeIterableMap`** — 6 function(s): `get()`, `putIfAbsent()`, `if()`, `remove()`, `contains()`, `ceil()`
- **`SafeIterableMap`** — 31 function(s): `supportRemove()`, `get()`, `while()`, `putIfAbsent()`, `if()`, `put()`, `remove()`, `size()`, `iterator()`, `descendingIterator()`, `iteratorWithAdditions()`, `eldest()`, `newest()`, `equals()`, `return()`, `toString()`, `backward()`, `forward()`, `ListIterator()`, `hasNext()`, `nextNode()`, `next()`, `AscendingIterator()`, `super()`, `DescendingIterator()`, `IteratorWithAdditions()`, `Entry()`, `getKey()`, `getValue()`, `setValue()`, `UnsupportedOperationException()`

</details>

### Package `android.arch.core.util`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `Function` | class | — | 7 | 1 |

<details>
<summary><b>Function list for <code>android.arch.core.util</code></b> (click to expand)</summary>

- **`Function`** — 1 function(s): `apply()`

</details>

### Package `android.arch.lifecycle`  (29 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AndroidViewModel` | class | ViewModel | 22 | 3 |
| `ClassesInfoCache` | class | — | 202 | 50 |
| `CompositeGeneratedAdaptersObserver` | class | GenericLifecycleObserver | 27 | 4 |
| `ComputableLiveData` | class | — | 94 | 14 |
| `FullLifecycleObserver` | class | LifecycleObserver | 17 | 6 |
| `FullLifecycleObserverAdapter` | class | GenericLifecycleObserver | 43 | 4 |
| `GeneratedAdapter` | class | — | 11 | 1 |
| `GenericLifecycleObserver` | class | LifecycleObserver | 11 | 1 |
| `Lifecycle` | class | — | 43 | 5 |
| `LifecycleObserver` | class | — | 6 | 0 |
| `LifecycleOwner` | class | — | 10 | 1 |
| `LifecycleRegistry` | class | Lifecycle | 231 | 58 |
| `LifecycleRegistryOwner` | class | LifecycleOwner | 12 | 1 |
| `Lifecycling` | class | — | 138 | 34 |
| `LiveData` | class | LiveData<T>.ObserverWrapper implements GenericLifecycleObserver | 272 | 66 |
| `MediatorLiveData` | class | MutableLiveData<T> | 81 | 15 |
| `MethodCallsLogger` | class | — | 21 | 1 |
| `MutableLiveData` | class | LiveData<T> | 15 | 2 |
| `Observer` | class | — | 9 | 1 |
| `OnLifecycleEvent` | class | — | 15 | 1 |
| `R` | class | — | 8 | 1 |
| `ReflectiveGenericLifecycleObserver` | class | GenericLifecycleObserver | 23 | 2 |
| `ReportFragment` | class | Fragment | 113 | 32 |
| `SingleGeneratedAdapterObserver` | class | GenericLifecycleObserver | 22 | 2 |
| `Transformations` | class | — | 54 | 9 |
| `ViewModel` | class | — | 9 | 1 |
| `ViewModelProvider` | class | Factory | 103 | 23 |
| `ViewModelStore` | class | — | 31 | 5 |
| `ViewModelStoreOwner` | class | — | 10 | 1 |

<details>
<summary><b>Function list for <code>android.arch.lifecycle</code></b> (click to expand)</summary>

- **`AndroidViewModel`** — 3 function(s): `AndroidViewModel()`, `getApplication()`, `return()`
- **`ClassesInfoCache`** — 18 function(s): `hasLifecycleMethods()`, `if()`, `for()`, `createInfo()`, `getDeclaredMethods()`, `IllegalArgumentException()`, `getInfo()`, `verifyAndPutHandler()`, `CallbackInfo()`, `invokeCallbacks()`, `invokeMethodsForEvent()`, `MethodReference()`, `invokeCallback()`, `switch()`, `RuntimeException()`, `equals()`, `hashCode()`, `return()`
- **`CompositeGeneratedAdaptersObserver`** — 3 function(s): `CompositeGeneratedAdaptersObserver()`, `onStateChanged()`, `for()`
- **`ComputableLiveData`** — 9 function(s): `compute()`, `ComputableLiveData()`, `this()`, `run()`, `if()`, `while()`, `onActive()`, `getLiveData()`, `invalidate()`
- **`FullLifecycleObserver`** — 6 function(s): `onCreate()`, `onDestroy()`, `onPause()`, `onResume()`, `onStart()`, `onStop()`
- **`FullLifecycleObserverAdapter`** — 4 function(s): `FullLifecycleObserverAdapter()`, `onStateChanged()`, `switch()`, `IllegalArgumentException()`
- **`GeneratedAdapter`** — 1 function(s): `callMethods()`
- **`GenericLifecycleObserver`** — 1 function(s): `onStateChanged()`
- **`Lifecycle`** — 5 function(s): `addObserver()`, `getCurrentState()`, `removeObserver()`, `isAtLeast()`, `compareTo()`
- **`LifecycleOwner`** — 1 function(s): `getLifecycle()`
- **`LifecycleRegistry`** — 26 function(s): `LifecycleRegistry()`, `markState()`, `moveToState()`, `handleLifecycleEvent()`, `if()`, `sync()`, `isSynced()`, `calculateTargetState()`, `min()`, `addObserver()`, `while()`, `pushParentState()`, `popParentState()`, `removeObserver()`, `getObserverCount()`, `getCurrentState()`, `getStateAfter()`, `switch()`, `IllegalArgumentException()`, `downEvent()`, `upEvent()`, `forwardPass()`, `backwardPass()`, `return()`, `ObserverWithState()`, `dispatchEvent()`
- **`LifecycleRegistryOwner`** — 1 function(s): `getLifecycle()`
- **`Lifecycling`** — 14 function(s): `getCallback()`, `if()`, `FullLifecycleObserverAdapter()`, `return()`, `SingleGeneratedAdapterObserver()`, `for()`, `CompositeGeneratedAdaptersObserver()`, `ReflectiveGenericLifecycleObserver()`, `createGeneratedAdapter()`, `RuntimeException()`, `getObserverConstructorType()`, `resolveObserverCallbackType()`, `isLifecycleParent()`, `getAdapterName()`
- **`LiveData`** — 30 function(s): `run()`, `synchronized()`, `onActive()`, `onInactive()`, `considerNotify()`, `if()`, `dispatchingValue()`, `while()`, `observe()`, `IllegalArgumentException()`, `observeForever()`, `removeObserver()`, `assertMainThread()`, `removeObservers()`, `postValue()`, `setValue()`, `getValue()`, `getVersion()`, `hasObservers()`, `hasActiveObservers()`, `LifecycleBoundObserver()`, `super()`, `shouldBeActive()`, `onStateChanged()`, `activeStateChanged()`, `isAttachedTo()`, `detachObserver()`, `ObserverWrapper()`, `AlwaysActiveObserver()`, `IllegalStateException()`
- **`MediatorLiveData`** — 11 function(s): `addSource()`, `if()`, `IllegalArgumentException()`, `removeSource()`, `onActive()`, `while()`, `onInactive()`, `Source()`, `plug()`, `unplug()`, `onChanged()`
- **`MethodCallsLogger`** — 1 function(s): `approveCall()`
- **`MutableLiveData`** — 2 function(s): `postValue()`, `setValue()`
- **`Observer`** — 1 function(s): `onChanged()`
- **`OnLifecycleEvent`** — 1 function(s): `value()`
- **`R`** — 1 function(s): `R()`
- **`ReflectiveGenericLifecycleObserver`** — 2 function(s): `ReflectiveGenericLifecycleObserver()`, `onStateChanged()`
- **`ReportFragment`** — 16 function(s): `onCreate()`, `onResume()`, `onStart()`, `injectIfNeededIn()`, `if()`, `get()`, `return()`, `dispatchCreate()`, `dispatchStart()`, `dispatchResume()`, `onActivityCreated()`, `dispatch()`, `onPause()`, `onStop()`, `onDestroy()`, `setProcessListener()`
- **`SingleGeneratedAdapterObserver`** — 2 function(s): `SingleGeneratedAdapterObserver()`, `onStateChanged()`
- **`Transformations`** — 5 function(s): `Transformations()`, `map()`, `onChanged()`, `switchMap()`, `if()`
- **`ViewModel`** — 1 function(s): `onCleared()`
- **`ViewModelProvider`** — 10 function(s): `create()`, `ViewModelProvider()`, `this()`, `get()`, `if()`, `IllegalArgumentException()`, `return()`, `RuntimeException()`, `getInstance()`, `AndroidViewModelFactory()`
- **`ViewModelStore`** — 5 function(s): `put()`, `if()`, `get()`, `clear()`, `while()`
- **`ViewModelStoreOwner`** — 1 function(s): `getViewModelStore()`

</details>

### Package `android.arch.lifecycle.livedata`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.arch.lifecycle.livedata</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.arch.lifecycle.livedata.core`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.arch.lifecycle.livedata.core</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.arch.lifecycle.viewmodel`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.arch.lifecycle.viewmodel</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.support.annotation`  (51 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AnimRes` | class | — | 15 | 0 |
| `AnimatorRes` | class | — | 15 | 0 |
| `AnyRes` | class | — | 15 | 0 |
| `AnyThread` | class | — | 15 | 0 |
| `ArrayRes` | class | — | 15 | 0 |
| `AttrRes` | class | — | 15 | 0 |
| `BinderThread` | class | — | 15 | 0 |
| `BoolRes` | class | — | 15 | 0 |
| `CallSuper` | class | — | 15 | 0 |
| `CheckResult` | class | — | 16 | 1 |
| `ColorInt` | class | — | 13 | 0 |
| `ColorLong` | class | — | 13 | 0 |
| `ColorRes` | class | — | 15 | 0 |
| `DimenRes` | class | — | 15 | 0 |
| `Dimension` | class | — | 20 | 1 |
| `DrawableRes` | class | — | 15 | 0 |
| `FloatRange` | class | — | 20 | 4 |
| `FontRes` | class | — | 15 | 0 |
| `FractionRes` | class | — | 15 | 0 |
| `GuardedBy` | class | — | 14 | 1 |
| `HalfFloat` | class | — | 13 | 0 |
| `IdRes` | class | — | 15 | 0 |
| `IntDef` | class | — | 16 | 2 |
| `IntRange` | class | — | 16 | 2 |
| `IntegerRes` | class | — | 15 | 0 |
| `InterpolatorRes` | class | — | 15 | 0 |
| `Keep` | class | — | 13 | 0 |
| `LayoutRes` | class | — | 15 | 0 |
| `LongDef` | class | — | 16 | 2 |
| `MainThread` | class | — | 15 | 0 |
| `MenuRes` | class | — | 15 | 0 |
| `NavigationRes` | class | — | 15 | 0 |
| `NonNull` | class | — | 15 | 0 |
| `Nullable` | class | — | 15 | 0 |
| `PluralsRes` | class | — | 15 | 0 |
| `Px` | class | — | 16 | 0 |
| `RawRes` | class | — | 15 | 0 |
| `RequiresApi` | class | — | 18 | 2 |
| `RequiresFeature` | class | — | 16 | 2 |
| `RequiresPermission` | class | — | 33 | 6 |
| `RestrictTo` | class | — | 24 | 1 |
| `Size` | class | — | 20 | 4 |
| `StringDef` | class | — | 14 | 1 |
| `StringRes` | class | — | 15 | 0 |
| `StyleRes` | class | — | 15 | 0 |
| `StyleableRes` | class | — | 15 | 0 |
| `TransitionRes` | class | — | 15 | 0 |
| `UiThread` | class | — | 15 | 0 |
| `VisibleForTesting` | class | — | 16 | 1 |
| `WorkerThread` | class | — | 15 | 0 |
| `XmlRes` | class | — | 15 | 0 |

<details>
<summary><b>Function list for <code>android.support.annotation</code></b> (click to expand)</summary>

- **`CheckResult`** — 1 function(s): `suggest()`
- **`Dimension`** — 1 function(s): `unit()`
- **`FloatRange`** — 4 function(s): `from()`, `fromInclusive()`, `to()`, `toInclusive()`
- **`GuardedBy`** — 1 function(s): `value()`
- **`IntDef`** — 2 function(s): `flag()`, `value()`
- **`IntRange`** — 2 function(s): `from()`, `to()`
- **`LongDef`** — 2 function(s): `flag()`, `value()`
- **`RequiresApi`** — 2 function(s): `api()`, `value()`
- **`RequiresFeature`** — 2 function(s): `enforcement()`, `name()`
- **`RequiresPermission`** — 4 function(s): `value()`, `allOf()`, `anyOf()`, `conditional()`
- **`RestrictTo`** — 1 function(s): `value()`
- **`Size`** — 4 function(s): `max()`, `min()`, `multiple()`, `value()`
- **`StringDef`** — 1 function(s): `value()`
- **`VisibleForTesting`** — 1 function(s): `otherwise()`

</details>

### Package `android.support.asynclayoutinflater`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.asynclayoutinflater</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.compat`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.compat</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.constraint`  (5 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `BuildConfig` | class | — | 12 | 0 |
| `ConstraintLayout` | class | ViewGroup | 1,275 | 198 |
| `ConstraintSet` | class | — | 1,495 | 286 |
| `Guideline` | class | View | 43 | 12 |
| `R` | class | — | 199 | 4 |

<details>
<summary><b>Function list for <code>android.support.constraint</code></b> (click to expand)</summary>

- **`ConstraintLayout`** — 40 function(s): `ConstraintLayout()`, `super()`, `init()`, `setId()`, `if()`, `for()`, `addView()`, `onViewAdded()`, `removeView()`, `onViewRemoved()`, `setMinWidth()`, `requestLayout()`, `setMinHeight()`, `getMinWidth()`, `getMinHeight()`, `setMaxWidth()`, `setMaxHeight()`, `getMaxWidth()`, `getMaxHeight()`, `updateHierarchy()`, `while()`, `setChildrenConstraints()`, `getTargetWidget()`, `return()`, `getViewWidget()`, `internalMeasureChildren()`, `onMeasure()`, `setSelfDimensionBehaviour()`, `solveLinearSystem()`, `setMeasuredDimension()`, `getLayoutParams()`, `onLayout()`, `setOptimizationLevel()`, `generateLayoutParams()`, `LayoutParams()`, `generateDefaultLayoutParams()`, `checkLayoutParams()`, `setConstraintSet()`, `validate()`, `resolveLayoutDirection()`
- **`ConstraintSet`** — 68 function(s): `sideToString()`, `switch()`, `Constraint()`, `m0clone()`, `fillFrom()`, `if()`, `applyTo()`, `clone()`, `for()`, `applyToInternal()`, `while()`, `center()`, `IllegalArgumentException()`, `connect()`, `centerHorizontally()`, `centerHorizontallyRtl()`, `centerVertically()`, `createVerticalChain()`, `get()`, `createHorizontalChain()`, `createHorizontalChainRtl()`, `clear()`, `setMargin()`, `setGoneMargin()`, `setHorizontalBias()`, `setVerticalBias()`, `setDimensionRatio()`, `setVisibility()`, `setAlpha()`, `getApplyElevation()`, `setApplyElevation()`, `setElevation()`, `setRotationX()`, `setRotationY()`, `setScaleX()`, `setScaleY()`, `setTransformPivotX()`, `setTransformPivotY()`, `setTransformPivot()`, `setTranslationX()`, `setTranslationY()`, `setTranslation()`, `setTranslationZ()`, `constrainHeight()`, `constrainWidth()`, `constrainMaxHeight()`, `constrainMaxWidth()`, `constrainMinHeight()`, `constrainMinWidth()`, `constrainDefaultHeight()`, `constrainDefaultWidth()`, `setHorizontalWeight()`, `setVerticalWeight()`, `setHorizontalChainStyle()`, `setVerticalChainStyle()`, `addToHorizontalChain()`, `addToHorizontalChainRTL()`, `addToVerticalChain()`, `removeFromVerticalChain()`, `removeFromHorizontalChain()`, `create()`, `setGuidelineBegin()`, `setGuidelineEnd()`, `setGuidelinePercent()`, `load()`, `lookupID()`, `fillFromAttributeList()`, `populateConstraint()`
- **`Guideline`** — 6 function(s): `draw()`, `setVisibility()`, `Guideline()`, `super()`, `onMeasure()`, `setMeasuredDimension()`
- **`R`** — 4 function(s): `R()`, `attr()`, `id()`, `styleable()`

</details>

### Package `android.support.constraint.solver`  (7 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ArrayLinkedVariables` | class | — | 471 | 106 |
| `ArrayRow` | class | — | 295 | 53 |
| `Cache` | class | — | 11 | 0 |
| `Goal` | class | — | 82 | 19 |
| `LinearSystem` | class | — | 633 | 154 |
| `Pools` | class | Pool<T> | 78 | 18 |
| `SolverVariable` | class | — | 143 | 21 |

<details>
<summary><b>Function list for <code>android.support.constraint.solver</code></b> (click to expand)</summary>

- **`ArrayLinkedVariables`** — 24 function(s): `ArrayLinkedVariables()`, `put()`, `if()`, `remove()`, `for()`, `while()`, `add()`, `clear()`, `containsKey()`, `hasAtLeastOnePositiveVariable()`, `invert()`, `divideByAmount()`, `updateClientEquations()`, `pickPivotCandidate()`, `updateFromRow()`, `updateFromSystem()`, `getPivotCandidate()`, `getVariable()`, `getVariableValue()`, `get()`, `sizeInBytes()`, `return()`, `display()`, `toString()`
- **`ArrayRow`** — 26 function(s): `ArrayRow()`, `updateClientEquations()`, `hasAtLeastOnePositiveVariable()`, `hasKeyVariable()`, `toString()`, `toReadableString()`, `if()`, `for()`, `reset()`, `hasVariable()`, `createRowDefinition()`, `createRowEquals()`, `addSingleError()`, `createRowGreaterThan()`, `createRowLowerThan()`, `createRowEqualDimension()`, `createRowCentering()`, `addError()`, `createRowDimensionPercent()`, `createRowDimensionRatio()`, `sizeInBytes()`, `return()`, `updateRowWithEquation()`, `ensurePositiveConstant()`, `pickRowVariable()`, `pivot()`
- **`Goal`** — 6 function(s): `getPivotCandidate()`, `for()`, `if()`, `initFromSystemErrors()`, `updateFromSystem()`, `toString()`
- **`LinearSystem`** — 49 function(s): `LinearSystem()`, `releaseRows()`, `increaseTableSize()`, `for()`, `if()`, `reset()`, `createObjectVariable()`, `createRow()`, `ArrayRow()`, `createSlackVariable()`, `addError()`, `addSingleError()`, `createVariable()`, `createErrorVariable()`, `acquireSolverVariable()`, `getGoal()`, `getRow()`, `getValueFor()`, `getObjectVariableValue()`, `return()`, `getVariable()`, `rebuildGoalFromErrors()`, `minimize()`, `minimizeGoal()`, `enforceBFS()`, `optimize()`, `computeValues()`, `updateRowFromVariables()`, `addConstraint()`, `while()`, `displayRows()`, `displaySolverVariables()`, `displayReadableRows()`, `displayVariablesReadableRows()`, `getMemoryUsed()`, `getNumEquations()`, `getNumVariables()`, `displaySystemInformations()`, `getDisplaySize()`, `getCache()`, `addGreaterThan()`, `addLowerThan()`, `addCentering()`, `addEquality()`, `createRowEquals()`, `createRowDimensionPercent()`, `createRowGreaterThan()`, `createRowLowerThan()`, `createRowCentering()`
- **`Pools`** — 9 function(s): `acquire()`, `release()`, `releaseAll()`, `Pools()`, `SimplePool()`, `if()`, `IllegalArgumentException()`, `for()`, `isInPool()`
- **`SolverVariable`** — 14 function(s): `getUniqueName()`, `switch()`, `SolverVariable()`, `clearStrengths()`, `for()`, `strengthsToString()`, `addClientEquation()`, `if()`, `removeClientEquation()`, `reset()`, `getName()`, `setName()`, `setType()`, `toString()`

</details>

### Package `android.support.constraint.solver.widgets`  (10 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ConstraintAnchor` | class | — | 434 | 75 |
| `ConstraintHorizontalLayout` | class | ConstraintWidgetContainer | 71 | 12 |
| `ConstraintTableLayout` | class | ConstraintWidgetContainer | 426 | 93 |
| `ConstraintWidget` | class | — | 1,890 | 373 |
| `ConstraintWidgetContainer` | class | WidgetContainer | 1,926 | 369 |
| `Guideline` | class | ConstraintWidget | 254 | 71 |
| `Optimizer` | class | — | 485 | 68 |
| `Rectangle` | class | — | 42 | 8 |
| `Snapshot` | class | — | 85 | 10 |
| `WidgetContainer` | class | ConstraintWidget | 199 | 44 |

<details>
<summary><b>Function list for <code>android.support.constraint.solver.widgets</code></b> (click to expand)</summary>

- **`ConstraintAnchor`** — 35 function(s): `ConstraintAnchor()`, `getSolverVariable()`, `resetSolverVariable()`, `if()`, `setGroup()`, `getGroup()`, `getOwner()`, `getType()`, `getMargin()`, `getStrength()`, `getTarget()`, `getConnectionType()`, `setConnectionType()`, `getConnectionCreator()`, `setConnectionCreator()`, `reset()`, `connect()`, `isConnected()`, `isValidConnection()`, `switch()`, `return()`, `isSideAnchor()`, `isSimilarDimensionConnection()`, `setStrength()`, `setMargin()`, `setGoneMargin()`, `isVerticalAnchor()`, `toString()`, `getSnapPriorityLevel()`, `getPriorityLevel()`, `isSnapCompatibleWith()`, `isConnectionAllowed()`, `isConnectionToMe()`, `for()`, `getOpposite()`
- **`ConstraintHorizontalLayout`** — 5 function(s): `ConstraintHorizontalLayout()`, `super()`, `addToSolver()`, `if()`, `while()`
- **`ConstraintTableLayout`** — 33 function(s): `getType()`, `handlesInternalConstraints()`, `HorizontalSlice()`, `VerticalSlice()`, `ConstraintTableLayout()`, `super()`, `getNumRows()`, `getNumCols()`, `getPadding()`, `getColumnsAlignmentRepresentation()`, `for()`, `if()`, `getColumnAlignmentRepresentation()`, `setNumCols()`, `setVerticalSlices()`, `setTableDimensions()`, `setNumRows()`, `setHorizontalSlices()`, `isVerticalGrowth()`, `setVerticalGrowth()`, `setPadding()`, `setColumnAlignment()`, `setChildrenConnections()`, `cycleColumnAlignment()`, `switch()`, `getVerticalGuidelines()`, `getHorizontalGuidelines()`, `addToSolver()`, `while()`, `setDebugSolverName()`, `updateDebugSolverNames()`, `updateFromSolver()`, `computeGuidelinesPercentPositions()`
- **`ConstraintWidget`** — 117 function(s): `connectedTo()`, `reset()`, `ConstraintWidget()`, `addAnchors()`, `forceUpdateDrawPosition()`, `this()`, `resetSolverVariables()`, `resetGroups()`, `for()`, `isRoot()`, `isRootContainer()`, `return()`, `isInsideConstraintLayout()`, `if()`, `while()`, `hasAncestor()`, `getRootWidgetContainer()`, `getParent()`, `setParent()`, `getType()`, `setType()`, `setVisibility()`, `getVisibility()`, `getDebugName()`, `setDebugName()`, `setDebugSolverName()`, `toString()`, `getInternalDrawX()`, `getInternalDrawY()`, `getInternalDrawRight()`, `getInternalDrawBottom()`, `getX()`, `getY()`, `getWidth()`, `getOptimizerWrapWidth()`, `getOptimizerWrapHeight()`, `getWrapWidth()`, `getHeight()`, `getWrapHeight()`, `getDrawX()`, `getDrawY()`, `getDrawWidth()`, `getDrawHeight()`, `getDrawBottom()`, `getDrawRight()`, `getRootX()`, `getRootY()`, `getMinWidth()`, `getMinHeight()`, `getLeft()`, `getTop()`, `getRight()`, `getBottom()`, `getHorizontalBiasPercent()`, `getVerticalBiasPercent()`, `hasBaseline()`, `getBaselineDistance()`, `getCompanionWidget()`, `getAnchors()`, `setX()`, `setY()`, `setOrigin()`, `setOffset()`, `setGoneMargin()`, `switch()`, `updateDrawPosition()`, `setDrawOrigin()`, `setDrawX()`, `setDrawY()`, `setDrawWidth()`, `setDrawHeight()`, `setWidth()`, `setHeight()`, `setHorizontalMatchStyle()`, `setVerticalMatchStyle()`, `setDimensionRatio()`, `getDimensionRatio()`, `getDimensionRatioSide()`, `setHorizontalBiasPercent()`, `setVerticalBiasPercent()`, `setMinWidth()`, `setMinHeight()`, `setWrapWidth()`, `setWrapHeight()`, `setDimension()`, `setFrame()`, `setHorizontalDimension()`, `setVerticalDimension()`, `setBaselineDistance()`, `setCompanionWidget()`, `setContainerItemSkip()`, `getContainerItemSkip()`, `setHorizontalWeight()`, `setVerticalWeight()`, `setHorizontalChainStyle()`, `getHorizontalChainStyle()`, `setVerticalChainStyle()`, `getVerticalChainStyle()`, `immediateConnect()`, `getAnchor()`, `connect()`, `resetAllConstraints()`, `resetAnchors()`, `setHorizontalDimensionBehaviour()`, `setVerticalDimensionBehaviour()`, `resetAnchor()`, `disconnectWidget()`, `disconnectUnlockedWidget()`, `getHorizontalDimensionBehaviour()`, `getVerticalDimensionBehaviour()`, `isInHorizontalChain()`, `getHorizontalChainControlWidget()`, `isInVerticalChain()`, `getVerticalChainControlWidget()`, `addToSolver()`, `applyConstraints()`, `updateFromSolver()`
- **`ConstraintWidgetContainer`** — 44 function(s): `getType()`, `handlesInternalConstraints()`, `ConstraintWidgetContainer()`, `super()`, `setOptimizationLevel()`, `reset()`, `isWidthMeasuredTooSmall()`, `isHeightMeasuredTooSmall()`, `createContainer()`, `if()`, `for()`, `addChildrenToSolver()`, `addToSolver()`, `applyHorizontalChain()`, `applyVerticalChain()`, `optimize()`, `while()`, `updateChildrenFromSolver()`, `updateFromSolver()`, `setPadding()`, `layout()`, `setX()`, `setY()`, `resetAnchors()`, `resetSolverVariables()`, `findWrapSize()`, `setWidth()`, `setHeight()`, `resetChains()`, `updateDrawPosition()`, `setGroup()`, `layoutFindGroupsSimple()`, `findHorizontalWrapRecursive()`, `findVerticalWrapRecursive()`, `layoutFindGroups()`, `switch()`, `layoutWithGroup()`, `getVerticalGuidelines()`, `getHorizontalGuidelines()`, `getSystem()`, `addChain()`, `addHorizontalChain()`, `addVerticalChain()`, `countMatchConstraintsChainedWidgets()`
- **`Guideline`** — 29 function(s): `getType()`, `Guideline()`, `getRelativeBehaviour()`, `if()`, `getHead()`, `setOrientation()`, `getAnchor()`, `getOrientation()`, `setMinimumPosition()`, `setPositionRelaxed()`, `switch()`, `getAnchors()`, `setGuidePercent()`, `setGuideBegin()`, `setGuideEnd()`, `getRelativePercent()`, `getRelativeBegin()`, `getRelativeEnd()`, `addToSolver()`, `updateFromSolver()`, `setX()`, `setY()`, `setHeight()`, `setWidth()`, `setDrawOrigin()`, `inferRelativePercentPosition()`, `inferRelativeBeginPosition()`, `inferRelativeEndPosition()`, `cyclePosition()`
- **`Optimizer`** — 7 function(s): `applyDirectResolutionHorizontalChain()`, `while()`, `if()`, `applyDirectResolutionVerticalChain()`, `checkMatchParent()`, `checkHorizontalSimpleDependency()`, `checkVerticalSimpleDependency()`
- **`Rectangle`** — 7 function(s): `setBounds()`, `grow()`, `intersects()`, `contains()`, `getCenterX()`, `return()`, `getCenterY()`
- **`Snapshot`** — 6 function(s): `Connection()`, `updateFrom()`, `if()`, `applyTo()`, `Snapshot()`, `for()`
- **`WidgetContainer`** — 19 function(s): `WidgetContainer()`, `super()`, `reset()`, `add()`, `if()`, `remove()`, `getChildren()`, `getRootConstraintContainer()`, `while()`, `findWidget()`, `findWidgets()`, `for()`, `getBounds()`, `setOffset()`, `updateDrawPosition()`, `layout()`, `resetSolverVariables()`, `resetGroups()`, `removeAllChildren()`

</details>

### Package `android.support.coordinatorlayout`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 237 | 11 |

<details>
<summary><b>Function list for <code>android.support.coordinatorlayout</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.coreui`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 237 | 11 |

<details>
<summary><b>Function list for <code>android.support.coreui</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.coreutils`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.coreutils</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.cursoradapter`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.support.cursoradapter</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.support.customview`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.customview</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.design.widget`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `CoordinatorLayout` | class | ViewGroup implements NestedScrollingParent2 | 2,025 | 490 |

<details>
<summary><b>Function list for <code>android.support.design.widget</code></b> (click to expand)</summary>

- **`CoordinatorLayout`** — 143 function(s): `getBehavior()`, `clamp()`, `resolveAnchoredChildGravity()`, `if()`, `resolveGravity()`, `return()`, `resolveKeylineGravity()`, `acquireTempRect()`, `releaseTempRect()`, `CoordinatorLayout()`, `this()`, `super()`, `for()`, `setupForInsets()`, `setOnHierarchyChangeListener()`, `onAttachedToWindow()`, `resetTouchBehaviors()`, `getViewTreeObserver()`, `onDetachedFromWindow()`, `onStopNestedScroll()`, `setStatusBarBackground()`, `getStatusBarBackground()`, `drawableStateChanged()`, `invalidate()`, `verifyDrawable()`, `setVisibility()`, `setStatusBarBackgroundResource()`, `setStatusBarBackgroundColor()`, `setWindowInsets()`, `setWillNotDraw()`, `requestLayout()`, `getLastWindowInsets()`, `getTopSortedChildren()`, `performIntercept()`, `switch()`, `onInterceptTouchEvent()`, `onTouchEvent()`, `requestDisallowInterceptTouchEvent()`, `getKeyline()`, `parseBehavior()`, `RuntimeException()`, `getResolvedLayoutParams()`, `prepareChildren()`, `getDescendantRect()`, `getSuggestedMinimumWidth()`, `getSuggestedMinimumHeight()`, `onMeasureChild()`, `measureChildWithMargins()`, `onMeasure()`, `ensurePreDrawListener()`, `while()`, `setMeasuredDimension()`, `dispatchApplyWindowInsetsToBehaviors()`, `onLayoutChild()`, `IllegalStateException()`, `layoutChildWithAnchor()`, `layoutChildWithKeyline()`, `layoutChild()`, `onLayout()`, `onDraw()`, `setFitsSystemWindows()`, `recordLastChildRect()`, `getLastChildRect()`, `getChildRect()`, `getDesiredAnchoredChildRectWithoutConstraints()`, `constrainChildRect()`, `getDesiredAnchoredChildRect()`, `drawChild()`, `onChildViewsChanged()`, `offsetChildToAnchor()`, `offsetChildByInset()`, `IllegalArgumentException()`, `setInsetOffsetY()`, `setInsetOffsetX()`, `dispatchDependentViewsChanged()`, `getDependencies()`, `getDependents()`, `getDependencySortedChildren()`, `addPreDrawListener()`, `removePreDrawListener()`, `hasDependencies()`, `isPointInChildBounds()`, `doViewsOverlap()`, `generateLayoutParams()`, `LayoutParams()`, `generateDefaultLayoutParams()`, `checkLayoutParams()`, `onStartNestedScroll()`, `onNestedScrollAccepted()`, `onNestedScroll()`, `onNestedPreScroll()`, `onNestedFling()`, `onNestedPreFling()`, `getNestedScrollAxes()`, `OnPreDrawListener()`, `onPreDraw()`, `ViewElevationComparator()`, `compare()`, `getInsetDodgeRect()`, `getScrimColor()`, `getScrimOpacity()`, `layoutDependsOn()`, `onApplyWindowInsets()`, `onAttachedToLayoutParams()`, `onDependentViewChanged()`, `onDependentViewRemoved()`, `onDetachedFromLayoutParams()`, `onRequestChildRectangleOnScreen()`, `onRestoreInstanceState()`, `Behavior()`, `blocksInteractionBelow()`, `setTag()`, `getTag()`, `onSaveInstanceState()`, `getAnchorId()`, `setAnchorId()`, `invalidateAnchor()`, `setBehavior()`, `setLastChildRect()`, `checkAnchorChanged()`, `didBlockInteraction()`, `isBlockingInteractionBelow()`, `resetTouchBehaviorTracking()`, `resetNestedScroll()`, `setNestedScrollAccepted()`, `isNestedScrollAccepted()`, `getChangedAfterNestedScroll()`, `setChangedAfterNestedScroll()`, `resetChangedAfterNestedScroll()`, `dependsOn()`, `findAnchorView()`, `resolveAnchorView()`, `verifyAnchorView()`, `shouldDodge()`, `HierarchyChangeListener()`, `onChildViewAdded()`, `onChildViewRemoved()`, `requestChildRectangleOnScreen()`, `setSystemUiVisibility()`, `createFromParcel()`, `SavedState()`, `newArray()`, `writeToParcel()`

</details>

### Package `android.support.documentfile`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.support.documentfile</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.support.drawerlayout`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.drawerlayout</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.fragment`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 237 | 11 |

<details>
<summary><b>Function list for <code>android.support.fragment</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.graphics.drawable`  (10 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AndroidResources` | class | — | 92 | 1 |
| `Animatable2Compat` | class | Animatable | 47 | 9 |
| `AnimatedVectorDrawableCompat` | class | VectorDrawableCommon implements Animatable2Compat | 726 | 152 |
| `AnimationUtilsCompat` | class | — | 133 | 18 |
| `AnimatorInflaterCompat` | class | — | 627 | 126 |
| `ArgbEvaluator` | class | TypeEvaluator | 32 | 2 |
| `PathInterpolatorCompat` | class | Interpolator | 156 | 40 |
| `R` | class | — | 237 | 11 |
| `VectorDrawableCommon` | class | Drawable implements TintAwareDrawable | 159 | 36 |
| `VectorDrawableCompat` | class | VectorDrawableCommon | 1,569 | 303 |

<details>
<summary><b>Function list for <code>android.support.graphics.drawable</code></b> (click to expand)</summary>

- **`AndroidResources`** — 1 function(s): `AndroidResources()`
- **`Animatable2Compat`** — 7 function(s): `clearAnimationCallbacks()`, `registerAnimationCallback()`, `unregisterAnimationCallback()`, `onAnimationEnd()`, `onAnimationStart()`, `getPlatformCallback()`, `if()`
- **`AnimatedVectorDrawableCompat`** — 54 function(s): `this()`, `AnimatedVectorDrawableCompat()`, `invalidateDrawable()`, `scheduleDrawable()`, `unscheduleDrawable()`, `if()`, `mutate()`, `create()`, `XmlPullParserException()`, `createFromXmlInner()`, `getConstantState()`, `AnimatedVectorDrawableDelegateState()`, `getChangingConfigurations()`, `draw()`, `invalidateSelf()`, `onBoundsChange()`, `onStateChange()`, `onLevelChange()`, `getAlpha()`, `setAlpha()`, `setColorFilter()`, `setTint()`, `setTintList()`, `setTintMode()`, `setVisible()`, `isStateful()`, `getOpacity()`, `getIntrinsicWidth()`, `getIntrinsicHeight()`, `isAutoMirrored()`, `setAutoMirrored()`, `inflate()`, `while()`, `setupAnimatorsForTarget()`, `IllegalStateException()`, `applyTheme()`, `canApplyTheme()`, `newDrawable()`, `AnimatedVectorDrawableCompatState()`, `for()`, `setupAnimatorSet()`, `setupColorAnimator()`, `isRunning()`, `return()`, `start()`, `stop()`, `unregisterPlatformCallback()`, `registerAnimationCallback()`, `registerPlatformCallback()`, `onAnimationStart()`, `onAnimationEnd()`, `removeAnimatorSetListener()`, `unregisterAnimationCallback()`, `clearAnimationCallbacks()`
- **`AnimationUtilsCompat`** — 9 function(s): `loadInterpolator()`, `if()`, `FastOutLinearInInterpolator()`, `FastOutSlowInInterpolator()`, `LinearOutSlowInInterpolator()`, `createInterpolatorFromXml()`, `while()`, `RuntimeException()`, `AnimationUtilsCompat()`
- **`AnimatorInflaterCompat`** — 27 function(s): `isColorType()`, `loadAnimator()`, `if()`, `PathDataEvaluator()`, `evaluate()`, `IllegalArgumentException()`, `for()`, `getPVH()`, `InflateException()`, `parseAnimatorFromTypeArray()`, `setupObjectAnimator()`, `setupPathMotion()`, `while()`, `createAnimatorFromXml()`, `RuntimeException()`, `loadValues()`, `inferValueTypeOfKeyframe()`, `inferValueTypeFromValues()`, `return()`, `dumpKeyframes()`, `loadPvh()`, `distributeKeyframes()`, `createNewKeyframe()`, `loadKeyframe()`, `switch()`, `loadObjectAnimator()`, `AnimatorInflaterCompat()`
- **`ArgbEvaluator`** — 2 function(s): `getInstance()`, `evaluate()`
- **`PathInterpolatorCompat`** — 12 function(s): `PathInterpolatorCompat()`, `this()`, `parseInterpolatorFromTypeArray()`, `if()`, `InflateException()`, `initPath()`, `initQuad()`, `initCubic()`, `IllegalArgumentException()`, `for()`, `while()`, `getInterpolation()`
- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`
- **`VectorDrawableCommon`** — 19 function(s): `setColorFilter()`, `if()`, `getColorFilter()`, `onLevelChange()`, `onBoundsChange()`, `setHotspot()`, `setHotspotBounds()`, `setFilterBitmap()`, `jumpToCurrentState()`, `applyTheme()`, `clearColorFilter()`, `getCurrent()`, `getMinimumWidth()`, `getMinimumHeight()`, `getPadding()`, `getState()`, `getTransparentRegion()`, `setChangingConfigurations()`, `setState()`
- **`VectorDrawableCompat`** — 114 function(s): `mutate()`, `if()`, `getTargetByName()`, `getConstantState()`, `VectorDrawableDelegateState()`, `draw()`, `copyBounds()`, `getAlpha()`, `setAlpha()`, `invalidateSelf()`, `setColorFilter()`, `updateTintFilter()`, `PorterDuffColorFilter()`, `setTint()`, `setTintList()`, `setTintMode()`, `isStateful()`, `onStateChange()`, `getOpacity()`, `getIntrinsicWidth()`, `return()`, `getIntrinsicHeight()`, `canApplyTheme()`, `isAutoMirrored()`, `setAutoMirrored()`, `getPixelSize()`, `create()`, `XmlPullParserException()`, `createFromXmlInner()`, `applyAlpha()`, `inflate()`, `updateStateFromTypedArray()`, `inflateInternal()`, `parseTintModeCompat()`, `switch()`, `while()`, `printGroupTree()`, `for()`, `setAllowCaching()`, `needMirroring()`, `onBoundsChange()`, `getChangingConfigurations()`, `scheduleSelf()`, `setVisible()`, `unscheduleSelf()`, `newDrawable()`, `VectorDrawableCompatState()`, `drawCachedBitmapWithRootAlpha()`, `hasTranslucentRoot()`, `getPaint()`, `updateCachedBitmap()`, `createCachedBitmapIfNeeded()`, `canReuseBitmap()`, `canReuseCache()`, `updateCacheStates()`, `VectorDrawableCompat()`, `onStateChanged()`, `cross()`, `VPathRenderer()`, `setRootAlpha()`, `getRootAlpha()`, `drawGroupTree()`, `drawPath()`, `getMatrixScale()`, `VObject()`, `VGroup()`, `super()`, `IllegalStateException()`, `getGroupName()`, `getLocalMatrix()`, `updateLocalMatrix()`, `getRotation()`, `setRotation()`, `getPivotX()`, `setPivotX()`, `getPivotY()`, `setPivotY()`, `getScaleX()`, `setScaleX()`, `getScaleY()`, `setScaleY()`, `getTranslateX()`, `setTranslateX()`, `getTranslateY()`, `setTranslateY()`, `applyTheme()`, `isClipPath()`, `VPath()`, `printVPath()`, `nodesToString()`, `toPath()`, `getPathName()`, `getPathData()`, `setPathData()`, `VClipPath()`, `VFullPath()`, `getStrokeLineCap()`, `getStrokeLineJoin()`, `getStrokeColor()`, `setStrokeColor()`, `getStrokeWidth()`, `setStrokeWidth()`, `getStrokeAlpha()`, `setStrokeAlpha()`, `getFillColor()`, `setFillColor()`, `getFillAlpha()`, `setFillAlpha()`, `getTrimPathStart()`, `setTrimPathStart()`, `getTrimPathEnd()`, `setTrimPathEnd()`, `getTrimPathOffset()`, `setTrimPathOffset()`

</details>

### Package `android.support.interpolator`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.support.interpolator</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.support.loader`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.loader</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.localbroadcastmanager`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.support.localbroadcastmanager</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.support.print`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 8 | 1 |

<details>
<summary><b>Function list for <code>android.support.print</code></b> (click to expand)</summary>

- **`R`** — 1 function(s): `R()`

</details>

### Package `android.support.slidingpanelayout`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.slidingpanelayout</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.swiperefreshlayout`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.swiperefreshlayout</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.v13.view`  (2 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `DragAndDropPermissionsCompat` | class | — | 34 | 6 |
| `DragStartHelper` | class | — | 82 | 11 |

<details>
<summary><b>Function list for <code>android.support.v13.view</code></b> (click to expand)</summary>

- **`DragAndDropPermissionsCompat`** — 4 function(s): `DragAndDropPermissionsCompat()`, `request()`, `if()`, `release()`
- **`DragStartHelper`** — 9 function(s): `onLongClick()`, `onTouch()`, `onDragStart()`, `DragStartHelper()`, `attach()`, `detach()`, `switch()`, `if()`, `getTouchPosition()`

</details>

### Package `android.support.v13.view.inputmethod`  (3 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `EditorInfoCompat` | class | — | 44 | 7 |
| `InputConnectionCompat` | class | — | 128 | 25 |
| `InputContentInfoCompat` | class | InputContentInfoCompatImpl | 183 | 33 |

<details>
<summary><b>Function list for <code>android.support.v13.view.inputmethod</code></b> (click to expand)</summary>

- **`EditorInfoCompat`** — 4 function(s): `setContentMimeTypes()`, `if()`, `getContentMimeTypes()`, `EditorInfoCompat()`
- **`InputConnectionCompat`** — 10 function(s): `onCommitContent()`, `handlePerformPrivateCommand()`, `if()`, `commitContent()`, `while()`, `createWrapper()`, `IllegalArgumentException()`, `InputConnectionWrapper()`, `performPrivateCommand()`, `InputConnectionCompat()`
- **`InputContentInfoCompat`** — 12 function(s): `getContentUri()`, `getDescription()`, `getInputContentInfo()`, `getLinkUri()`, `releasePermission()`, `requestPermission()`, `InputContentInfoCompatBaseImpl()`, `InputContentInfoCompatApi25Impl()`, `InputContentInfoCompat()`, `if()`, `wrap()`, `unwrap()`

</details>

### Package `android.support.v4.accessibilityservice`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AccessibilityServiceInfoCompat` | class | — | 114 | 20 |

<details>
<summary><b>Function list for <code>android.support.v4.accessibilityservice</code></b> (click to expand)</summary>

- **`AccessibilityServiceInfoCompat`** — 9 function(s): `capabilityToString()`, `if()`, `switch()`, `flagToString()`, `AccessibilityServiceInfoCompat()`, `loadDescription()`, `feedbackTypeToString()`, `while()`, `getCapabilities()`

</details>

### Package `android.support.v4.app`  (53 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ActionBarDrawerToggle` | class | DrawerLayout.DrawerListener | 349 | 71 |
| `ActivityCompat` | class | ContextCompat | 245 | 52 |
| `ActivityManagerCompat` | class | — | 19 | 3 |
| `ActivityOptionsCompat` | class | ActivityOptionsCompat | 159 | 49 |
| `AlarmManagerCompat` | class | — | 45 | 11 |
| `AppComponentFactory` | class | android.app.AppComponentFactory | 87 | 25 |
| `AppLaunchChecker` | class | — | 34 | 5 |
| `AppOpsManagerCompat` | class | — | 55 | 15 |
| `BackStackRecord` | class | FragmentTransaction implements FragmentManager.BackStackEntry, FragmentManagerImpl.OpGe... | 848 | 176 |
| `BackStackState` | class | Parcelable | 162 | 14 |
| `BundleCompat` | class | — | 87 | 13 |
| `CoreComponentFactory` | class | android.app.AppComponentFactory | 55 | 13 |
| `DialogFragment` | class | Fragment implements DialogInterface.OnCancelListener, DialogInterface.OnDismissListener | 286 | 63 |
| `Fragment` | class | ComponentCallbacks, View.OnCreateContextMenuListener, LifecycleOwner, ViewModelStoreOwner | 1,602 | 418 |
| `FragmentActivity` | class | SupportActivity implements ViewModelStoreOwner, ActivityCompat.OnRequestPermissionsResu... | 668 | 142 |
| `FragmentContainer` | class | — | 20 | 3 |
| `FragmentController` | class | — | 198 | 45 |
| `FragmentHostCallback` | class | FragmentContainer | 137 | 28 |
| `FragmentManager` | class | — | 156 | 48 |
| `FragmentManagerImpl` | class | FragmentManager implements LayoutInflater.Factory2 | 3,010 | 828 |
| `FragmentManagerNonConfig` | class | — | 34 | 4 |
| `FragmentManagerState` | class | Parcelable | 56 | 7 |
| `FragmentPagerAdapter` | class | PagerAdapter | 104 | 22 |
| `FragmentState` | class | Parcelable | 121 | 12 |
| `FragmentStatePagerAdapter` | class | PagerAdapter | 157 | 33 |
| `FragmentTabHost` | class | TabHost implements TabHost.OnTabChangeListener | 300 | 64 |
| `FragmentTransaction` | class | — | 109 | 31 |
| `FragmentTransition` | class | — | 852 | 185 |
| `FragmentTransitionCompat21` | class | FragmentTransitionImpl | 269 | 66 |
| `FragmentTransitionImpl` | class | — | 214 | 59 |
| `FrameMetricsAggregator` | class | FrameMetricsBaseImpl | 228 | 42 |
| `INotificationSideChannel` | class | IInterface | 134 | 24 |
| `JobIntentService` | class | Service | 450 | 103 |
| `ListFragment` | class | Fragment | 229 | 51 |
| `LoaderManager` | class | — | 61 | 13 |
| `LoaderManagerImpl` | class | LoaderManager | 465 | 101 |
| `NavUtils` | class | — | 122 | 30 |
| `NotificationBuilderWithBuilderAccessor` | class | — | 11 | 1 |
| `NotificationCompat` | class | Style | 2,673 | 531 |
| `NotificationCompatBuilder` | class | NotificationBuilderWithBuilderAccessor | 290 | 77 |
| `NotificationCompatExtras` | class | — | 15 | 1 |
| `NotificationCompatJellybean` | class | — | 289 | 48 |
| `NotificationCompatSideChannelService` | class | Service | 75 | 17 |
| `NotificationManagerCompat` | class | Handler.Callback, ServiceConnection | 471 | 99 |
| `OneShotPreDrawListener` | class | ViewTreeObserver.OnPreDrawListener, View.OnAttachStateChangeListener | 51 | 9 |
| `Person` | class | — | 179 | 24 |
| `RemoteInput` | class | — | 281 | 62 |
| `ServiceCompat` | class | — | 33 | 3 |
| `ShareCompat` | class | — | 449 | 105 |
| `SharedElementCallback` | class | — | 138 | 21 |
| `SuperNotCalledException` | class | AndroidRuntimeException | 11 | 2 |
| `SupportActivity` | class | Activity implements LifecycleOwner, KeyEventDispatcher.Component | 84 | 11 |
| `TaskStackBuilder` | class | Iterable<Intent> | 170 | 43 |

<details>
<summary><b>Function list for <code>android.support.v4.app</code></b> (click to expand)</summary>

- **`ActionBarDrawerToggle`** — 27 function(s): `getThemeUpIndicator()`, `setActionBarDescription()`, `setActionBarUpIndicator()`, `getDrawerToggleDelegate()`, `onDrawerStateChanged()`, `ActionBarDrawerToggle()`, `this()`, `assumeMaterial()`, `if()`, `syncState()`, `setHomeAsUpIndicator()`, `setDrawerIndicatorEnabled()`, `isDrawerIndicatorEnabled()`, `onConfigurationChanged()`, `onOptionsItemSelected()`, `onDrawerSlide()`, `onDrawerOpened()`, `onDrawerClosed()`, `SetIndicatorInfo()`, `SlideDrawable()`, `super()`, `setPosition()`, `invalidateSelf()`, `getPosition()`, `setOffset()`, `draw()`, `copyBounds()`
- **`ActivityCompat`** — 35 function(s): `onRequestPermissionsResult()`, `onActivityResult()`, `requestPermissions()`, `validateRequestPermissionsRequestCode()`, `ActivityCompat()`, `setPermissionCompatDelegate()`, `getPermissionCompatDelegate()`, `invalidateOptionsMenu()`, `startActivityForResult()`, `if()`, `startIntentSenderForResult()`, `finishAffinity()`, `finishAfterTransition()`, `getReferrer()`, `requireViewById()`, `return()`, `IllegalArgumentException()`, `setEnterSharedElementCallback()`, `setExitSharedElementCallback()`, `postponeEnterTransition()`, `startPostponedEnterTransition()`, `Handler()`, `run()`, `for()`, `shouldShowRequestPermissionRationale()`, `requestDragAndDropPermissions()`, `SharedElementCallback21Impl()`, `onSharedElementStart()`, `onSharedElementEnd()`, `onRejectSharedElements()`, `onMapSharedElements()`, `onCaptureSharedElementSnapshot()`, `onCreateSnapshotView()`, `onSharedElementsArrived()`, `onSharedElementsReady()`
- **`ActivityManagerCompat`** — 3 function(s): `ActivityManagerCompat()`, `isLowRamDevice()`, `if()`
- **`ActivityOptionsCompat`** — 16 function(s): `getLaunchBounds()`, `requestUsageTimeReport()`, `setLaunchBounds()`, `toBundle()`, `update()`, `makeCustomAnimation()`, `if()`, `ActivityOptionsCompatImpl()`, `ActivityOptionsCompat()`, `makeScaleUpAnimation()`, `makeClipRevealAnimation()`, `makeThumbnailScaleUpAnimation()`, `makeSceneTransitionAnimation()`, `for()`, `makeTaskLaunchBehind()`, `makeBasic()`
- **`AlarmManagerCompat`** — 6 function(s): `setAlarmClock()`, `if()`, `setExact()`, `setAndAllowWhileIdle()`, `setExactAndAllowWhileIdle()`, `AlarmManagerCompat()`
- **`AppComponentFactory`** — 12 function(s): `instantiateActivity()`, `return()`, `instantiateApplication()`, `instantiateReceiver()`, `instantiateProvider()`, `instantiateService()`, `instantiateApplicationCompat()`, `RuntimeException()`, `instantiateActivityCompat()`, `instantiateReceiverCompat()`, `instantiateServiceCompat()`, `instantiateProviderCompat()`
- **`AppLaunchChecker`** — 4 function(s): `hasStartedFromLauncher()`, `onActivityCreate()`, `if()`, `AppLaunchChecker()`
- **`AppOpsManagerCompat`** — 8 function(s): `AppOpsManagerCompat()`, `permissionToOp()`, `if()`, `noteOp()`, `return()`, `noteOpNoThrow()`, `noteProxyOp()`, `noteProxyOpNoThrow()`
- **`BackStackRecord`** — 58 function(s): `Op()`, `toString()`, `if()`, `dump()`, `for()`, `switch()`, `BackStackRecord()`, `getId()`, `getBreadCrumbTitleRes()`, `getBreadCrumbShortTitleRes()`, `getBreadCrumbTitle()`, `getBreadCrumbShortTitle()`, `addOp()`, `add()`, `doAddOp()`, `IllegalStateException()`, `IllegalArgumentException()`, `replace()`, `remove()`, `hide()`, `show()`, `detach()`, `attach()`, `setPrimaryNavigationFragment()`, `setCustomAnimations()`, `setTransition()`, `addSharedElement()`, `setTransitionStyle()`, `addToBackStack()`, `isAddToBackStackAllowed()`, `disallowAddToBackStack()`, `setBreadCrumbTitle()`, `setBreadCrumbShortTitle()`, `bumpBackStackNesting()`, `runOnCommit()`, `runOnCommitRunnables()`, `commit()`, `commitInternal()`, `commitAllowingStateLoss()`, `commitNow()`, `commitNowAllowingStateLoss()`, `setReorderingAllowed()`, `setAllowOptimization()`, `generateOps()`, `interactsWith()`, `executeOps()`, `executePopOps()`, `expandOps()`, `while()`, `trackAddedFragmentsInPop()`, `isPostponed()`, `setOnStartPostponedListener()`, `isFragmentPostponed()`, `return()`, `getName()`, `getTransition()`, `getTransitionStyle()`, `isEmpty()`
- **`BackStackState`** — 9 function(s): `createFromParcel()`, `BackStackState()`, `newArray()`, `describeContents()`, `if()`, `IllegalStateException()`, `while()`, `instantiate()`, `writeToParcel()`
- **`BundleCompat`** — 6 function(s): `BundleCompatBaseImpl()`, `getBinder()`, `if()`, `return()`, `putBinder()`, `BundleCompat()`
- **`CoreComponentFactory`** — 8 function(s): `getWrapper()`, `instantiateActivity()`, `return()`, `instantiateApplication()`, `instantiateReceiver()`, `instantiateProvider()`, `instantiateService()`, `checkCompatWrapper()`
- **`DialogFragment`** — 31 function(s): `onCancel()`, `setStyle()`, `if()`, `show()`, `showNow()`, `dismiss()`, `dismissInternal()`, `dismissAllowingStateLoss()`, `getFragmentManager()`, `getDialog()`, `getTheme()`, `setCancelable()`, `isCancelable()`, `setShowsDialog()`, `getShowsDialog()`, `onAttach()`, `onDetach()`, `onCreate()`, `onGetLayoutInflater()`, `setupDialog()`, `return()`, `switch()`, `onCreateDialog()`, `Dialog()`, `onDismiss()`, `onActivityCreated()`, `IllegalStateException()`, `onStart()`, `onSaveInstanceState()`, `onStop()`, `onDestroyView()`
- **`Fragment`** — 178 function(s): `onStartEnterTransition()`, `startListening()`, `onActivityResult()`, `onAttachFragment()`, `onContextItemSelected()`, `onCreateAnimation()`, `onCreateAnimator()`, `onCreateOptionsMenu()`, `onCreateView()`, `onDestroyOptionsMenu()`, `onHiddenChanged()`, `onMultiWindowModeChanged()`, `onOptionsItemSelected()`, `onOptionsMenuClosed()`, `onPictureInPictureModeChanged()`, `onPrepareOptionsMenu()`, `onRequestPermissionsResult()`, `onSaveInstanceState()`, `onViewCreated()`, `getLifecycle()`, `getViewLifecycleOwner()`, `if()`, `IllegalStateException()`, `getViewLifecycleOwnerLiveData()`, `getViewModelStore()`, `createFromParcel()`, `SavedState()`, `newArray()`, `describeContents()`, `writeToParcel()`, `InstantiationException()`, `super()`, `instantiate()`, `isSupportFragmentClass()`, `restoreViewState()`, `onViewStateRestored()`, `SuperNotCalledException()`, `setIndex()`, `isInBackStack()`, `equals()`, `hashCode()`, `toString()`, `getId()`, `getTag()`, `setArguments()`, `getArguments()`, `isStateSaved()`, `setInitialSavedState()`, `setTargetFragment()`, `IllegalArgumentException()`, `for()`, `getTargetFragment()`, `getTargetRequestCode()`, `getContext()`, `requireContext()`, `getActivity()`, `return()`, `requireActivity()`, `getHost()`, `requireHost()`, `getResources()`, `getText()`, `getString()`, `getFragmentManager()`, `requireFragmentManager()`, `getChildFragmentManager()`, `instantiateChildFragmentManager()`, `peekChildFragmentManager()`, `getParentFragment()`, `isAdded()`, `isDetached()`, `isRemoving()`, `isInLayout()`, `isResumed()`, `isVisible()`, `isHidden()`, `hasOptionsMenu()`, `isMenuVisible()`, `setRetainInstance()`, `getRetainInstance()`, `setHasOptionsMenu()`, `setMenuVisibility()`, `setUserVisibleHint()`, `getUserVisibleHint()`, `getLoaderManager()`, `startActivity()`, `startActivityForResult()`, `startIntentSenderForResult()`, `requestPermissions()`, `shouldShowRequestPermissionRationale()`, `onGetLayoutInflater()`, `getLayoutInflater()`, `performGetLayoutInflater()`, `onInflate()`, `onAttach()`, `onCreate()`, `restoreChildFragmentState()`, `getView()`, `onActivityCreated()`, `onStart()`, `onResume()`, `onConfigurationChanged()`, `onPause()`, `onStop()`, `onLowMemory()`, `onDestroyView()`, `onDestroy()`, `initState()`, `onDetach()`, `onCreateContextMenu()`, `registerForContextMenu()`, `unregisterForContextMenu()`, `setEnterSharedElementCallback()`, `ensureAnimationInfo()`, `setExitSharedElementCallback()`, `setEnterTransition()`, `getEnterTransition()`, `setReturnTransition()`, `getReturnTransition()`, `setExitTransition()`, `getExitTransition()`, `setReenterTransition()`, `getReenterTransition()`, `setSharedElementEnterTransition()`, `getSharedElementEnterTransition()`, `setSharedElementReturnTransition()`, `getSharedElementReturnTransition()`, `setAllowEnterTransitionOverlap()`, `getAllowEnterTransitionOverlap()`, `setAllowReturnTransitionOverlap()`, `getAllowReturnTransitionOverlap()`, `postponeEnterTransition()`, `startPostponedEnterTransition()`, `run()`, `callStartTransitionListener()`, `dump()`, `findFragmentByWho()`, `onFindViewById()`, `onHasView()`, `performCreate()`, `performCreateView()`, `performActivityCreated()`, `performStart()`, `performResume()`, `noteStateNotSaved()`, `performMultiWindowModeChanged()`, `performPictureInPictureModeChanged()`, `performConfigurationChanged()`, `performLowMemory()`, `performCreateOptionsMenu()`, `performPrepareOptionsMenu()`, `performOptionsItemSelected()`, `performContextItemSelected()`, `performOptionsMenuClosed()`, `performSaveInstanceState()`, `performPause()`, `performStop()`, `performDestroyView()`, `performDestroy()`, `performDetach()`, `setOnStartEnterTransitionListener()`, `getNextAnim()`, `setNextAnim()`, `getNextTransition()`, `setNextTransition()`, `getNextTransitionStyle()`, `getEnterTransitionCallback()`, `getExitTransitionCallback()`, `getAnimatingAway()`, `setAnimatingAway()`, `setAnimator()`, `getAnimator()`, `getStateAfterAnimating()`, `setStateAfterAnimating()`, `isPostponed()`, `isHideReplaced()`, `setHideReplaced()`, `AnimationInfo()`
- **`FragmentActivity`** — 74 function(s): `handleMessage()`, `if()`, `onAttachFragment()`, `onRetainCustomNonConfigurationInstance()`, `NonConfigurationInstances()`, `onActivityResult()`, `onBackPressed()`, `supportFinishAfterTransition()`, `setEnterSharedElementCallback()`, `setExitSharedElementCallback()`, `supportPostponeEnterTransition()`, `supportStartPostponedEnterTransition()`, `onMultiWindowModeChanged()`, `onPictureInPictureModeChanged()`, `onConfigurationChanged()`, `getViewModelStore()`, `IllegalStateException()`, `getLifecycle()`, `onCreate()`, `for()`, `onCreatePanelMenu()`, `onCreateView()`, `dispatchFragmentsOnCreateView()`, `onDestroy()`, `onLowMemory()`, `onMenuItemSelected()`, `onPanelClosed()`, `onPause()`, `onResumeFragments()`, `onNewIntent()`, `onStateNotSaved()`, `onResume()`, `onPostResume()`, `onPreparePanel()`, `onPrepareOptionsPanel()`, `onRetainNonConfigurationInstance()`, `onSaveInstanceState()`, `markFragmentsCreated()`, `onStart()`, `onStop()`, `getLastCustomNonConfigurationInstance()`, `supportInvalidateOptionsMenu()`, `invalidateOptionsMenu()`, `dump()`, `getSupportFragmentManager()`, `getSupportLoaderManager()`, `startActivityForResult()`, `checkForValidRequestCode()`, `startIntentSenderForResult()`, `IllegalArgumentException()`, `validateRequestPermissionsRequestCode()`, `onRequestPermissionsResult()`, `startActivityFromFragment()`, `startIntentSenderFromFragment()`, `allocateRequestIndex()`, `while()`, `requestPermissionsFromFragment()`, `HostCallbacks()`, `super()`, `onDump()`, `onShouldSaveFragmentState()`, `onGetLayoutInflater()`, `onGetHost()`, `onSupportInvalidateOptionsMenu()`, `onStartActivityFromFragment()`, `onStartIntentSenderFromFragment()`, `onRequestPermissionsFromFragment()`, `onShouldShowRequestPermissionRationale()`, `onHasWindowAnimations()`, `onGetWindowAnimations()`, `onFindViewById()`, `onHasView()`, `return()`, `markState()`
- **`FragmentContainer`** — 3 function(s): `onFindViewById()`, `onHasView()`, `instantiate()`
- **`FragmentController`** — 43 function(s): `dispatchReallyStop()`, `doLoaderDestroy()`, `doLoaderRetain()`, `doLoaderStart()`, `doLoaderStop()`, `dumpLoaders()`, `reportLoaderStart()`, `restoreLoaderNonConfig()`, `retainLoaderNonConfig()`, `createController()`, `FragmentController()`, `getSupportFragmentManager()`, `getSupportLoaderManager()`, `UnsupportedOperationException()`, `findFragmentByWho()`, `getActiveFragmentsCount()`, `getActiveFragments()`, `attachHost()`, `onCreateView()`, `noteStateNotSaved()`, `saveAllState()`, `restoreAllState()`, `retainNonConfig()`, `if()`, `retainNestedNonConfig()`, `dispatchCreate()`, `dispatchActivityCreated()`, `dispatchStart()`, `dispatchResume()`, `dispatchPause()`, `dispatchStop()`, `dispatchDestroyView()`, `dispatchDestroy()`, `dispatchMultiWindowModeChanged()`, `dispatchPictureInPictureModeChanged()`, `dispatchConfigurationChanged()`, `dispatchLowMemory()`, `dispatchCreateOptionsMenu()`, `dispatchPrepareOptionsMenu()`, `dispatchOptionsItemSelected()`, `dispatchContextItemSelected()`, `dispatchOptionsMenuClosed()`, `execPendingActions()`
- **`FragmentHostCallback`** — 22 function(s): `onAttachFragment()`, `onDump()`, `onFindViewById()`, `onGetHost()`, `onHasView()`, `onHasWindowAnimations()`, `onRequestPermissionsFromFragment()`, `onShouldSaveFragmentState()`, `onShouldShowRequestPermissionRationale()`, `onSupportInvalidateOptionsMenu()`, `FragmentHostCallback()`, `this()`, `onGetLayoutInflater()`, `onStartActivityFromFragment()`, `if()`, `IllegalStateException()`, `onStartIntentSenderFromFragment()`, `onGetWindowAnimations()`, `getActivity()`, `getContext()`, `getHandler()`, `getFragmentManagerImpl()`
- **`FragmentManager`** — 43 function(s): `getBreadCrumbShortTitle()`, `getBreadCrumbShortTitleRes()`, `getBreadCrumbTitle()`, `getBreadCrumbTitleRes()`, `getId()`, `getName()`, `onFragmentActivityCreated()`, `onFragmentAttached()`, `onFragmentCreated()`, `onFragmentDestroyed()`, `onFragmentDetached()`, `onFragmentPaused()`, `onFragmentPreAttached()`, `onFragmentPreCreated()`, `onFragmentResumed()`, `onFragmentSaveInstanceState()`, `onFragmentStarted()`, `onFragmentStopped()`, `onFragmentViewCreated()`, `onFragmentViewDestroyed()`, `onBackStackChanged()`, `addOnBackStackChangedListener()`, `beginTransaction()`, `dump()`, `executePendingTransactions()`, `findFragmentById()`, `findFragmentByTag()`, `getBackStackEntryAt()`, `getBackStackEntryCount()`, `getFragment()`, `getFragments()`, `getPrimaryNavigationFragment()`, `isDestroyed()`, `isStateSaved()`, `popBackStack()`, `popBackStackImmediate()`, `putFragment()`, `registerFragmentLifecycleCallbacks()`, `removeOnBackStackChangedListener()`, `saveFragmentInstanceState()`, `unregisterFragmentLifecycleCallbacks()`, `openTransaction()`, `enableDebugLogging()`
- **`FragmentManagerImpl`** — 153 function(s): `run()`, `generateOps()`, `reverseTransit()`, `if()`, `transitToStyleIndex()`, `getLayoutInflaterFactory()`, `FragmentLifecycleCallbacksHolder()`, `modifiesAlpha()`, `for()`, `shouldRunOnHWLayer()`, `throwException()`, `dump()`, `beginTransaction()`, `BackStackRecord()`, `executePendingTransactions()`, `forcePostponedTransactions()`, `popBackStack()`, `enqueueAction()`, `popBackStackImmediate()`, `checkStateLoss()`, `IllegalArgumentException()`, `execPendingActions()`, `ensureExecReady()`, `removeRedundantOperationsAndExecute()`, `cleanupExec()`, `doPendingDeferredStart()`, `burpActive()`, `getBackStackEntryCount()`, `getBackStackEntryAt()`, `addOnBackStackChangedListener()`, `removeOnBackStackChangedListener()`, `putFragment()`, `getFragment()`, `getFragments()`, `synchronized()`, `getActiveFragments()`, `getActiveFragmentCount()`, `saveFragmentInstanceState()`, `isDestroyed()`, `toString()`, `makeOpenCloseAnimation()`, `AnimationOrAnimator()`, `makeFadeAnimation()`, `loadAnimation()`, `switch()`, `performPendingDeferredStart()`, `moveToState()`, `setHWLayerAnimListenerIfAlpha()`, `getAnimationListener()`, `return()`, `isStateAtLeast()`, `IllegalStateException()`, `dispatchOnFragmentPreAttached()`, `SuperNotCalledException()`, `dispatchOnFragmentAttached()`, `dispatchOnFragmentPreCreated()`, `dispatchOnFragmentCreated()`, `ensureInflatedFragmentView()`, `dispatchOnFragmentViewCreated()`, `dispatchOnFragmentActivityCreated()`, `dispatchOnFragmentStarted()`, `dispatchOnFragmentResumed()`, `dispatchOnFragmentPaused()`, `dispatchOnFragmentStopped()`, `saveFragmentViewState()`, `dispatchOnFragmentViewDestroyed()`, `animateRemoveFragment()`, `dispatchOnFragmentDestroyed()`, `dispatchOnFragmentDetached()`, `makeInactive()`, `onAnimationEnd()`, `completeShowHideFragment()`, `moveFragmentToExpectedState()`, `startPendingDeferredFragments()`, `makeActive()`, `addFragment()`, `removeFragment()`, `hideFragment()`, `showFragment()`, `detachFragment()`, `attachFragment()`, `findFragmentById()`, `findFragmentByTag()`, `findFragmentByWho()`, `isStateSaved()`, `scheduleCommit()`, `allocBackStackIndex()`, `setBackStackIndex()`, `while()`, `freeBackStackIndex()`, `executePostponedTransaction()`, `execSingleAction()`, `executeOpsTogether()`, `executeOps()`, `addAddedFragments()`, `makeRemovedFragmentsInvisible()`, `reportBackStackChanged()`, `postponePostponableTransactions()`, `completeExecute()`, `findFragmentUnder()`, `endAnimatingAwayFragments()`, `generateOpsForPendingActions()`, `addBackStackState()`, `popBackStackState()`, `retainNonConfig()`, `setRetaining()`, `saveNonConfig()`, `saveFragmentBasicState()`, `dispatchOnFragmentSaveInstanceState()`, `saveAllState()`, `restoreAllState()`, `attachController()`, `noteStateNotSaved()`, `dispatchCreate()`, `dispatchStateChange()`, `dispatchActivityCreated()`, `dispatchStart()`, `dispatchResume()`, `dispatchPause()`, `dispatchStop()`, `dispatchDestroyView()`, `dispatchDestroy()`, `dispatchMultiWindowModeChanged()`, `dispatchPictureInPictureModeChanged()`, `dispatchConfigurationChanged()`, `dispatchLowMemory()`, `dispatchCreateOptionsMenu()`, `dispatchPrepareOptionsMenu()`, `dispatchOptionsItemSelected()`, `dispatchContextItemSelected()`, `dispatchOptionsMenuClosed()`, `setPrimaryNavigationFragment()`, `getPrimaryNavigationFragment()`, `registerFragmentLifecycleCallbacks()`, `unregisterFragmentLifecycleCallbacks()`, `onCreateView()`, `FragmentTag()`, `PopBackStackState()`, `StartEnterTransitionListener()`, `onStartEnterTransition()`, `startListening()`, `isReady()`, `completeTransaction()`, `cancelTransaction()`, `AnimationListenerWrapper()`, `onAnimationStart()`, `onAnimationRepeat()`, `AnimateOnHWLayerIfNeededListener()`, `super()`, `AnimatorOnHWLayerIfNeededListener()`, `EndViewTransitionAnimator()`, `addAnimation()`, `getTransformation()`
- **`FragmentManagerNonConfig`** — 4 function(s): `FragmentManagerNonConfig()`, `getFragments()`, `getChildNonConfigs()`, `getViewModelStores()`
- **`FragmentManagerState`** — 5 function(s): `createFromParcel()`, `FragmentManagerState()`, `newArray()`, `describeContents()`, `writeToParcel()`
- **`FragmentPagerAdapter`** — 15 function(s): `getItem()`, `getItemId()`, `restoreState()`, `saveState()`, `FragmentPagerAdapter()`, `startUpdate()`, `if()`, `IllegalStateException()`, `instantiateItem()`, `destroyItem()`, `setPrimaryItem()`, `finishUpdate()`, `isViewFromObject()`, `return()`, `makeFragmentName()`
- **`FragmentState`** — 7 function(s): `createFromParcel()`, `FragmentState()`, `newArray()`, `describeContents()`, `instantiate()`, `if()`, `writeToParcel()`
- **`FragmentStatePagerAdapter`** — 15 function(s): `getItem()`, `FragmentStatePagerAdapter()`, `startUpdate()`, `if()`, `IllegalStateException()`, `instantiateItem()`, `while()`, `destroyItem()`, `setPrimaryItem()`, `finishUpdate()`, `isViewFromObject()`, `return()`, `saveState()`, `for()`, `restoreState()`
- **`FragmentTabHost`** — 29 function(s): `TabInfo()`, `DummyTabFactory()`, `createTabContent()`, `createFromParcel()`, `SavedState()`, `newArray()`, `super()`, `writeToParcel()`, `toString()`, `FragmentTabHost()`, `initFragmentTabHost()`, `ensureHierarchy()`, `if()`, `addView()`, `setup()`, `IllegalStateException()`, `ensureContent()`, `setId()`, `setOnTabChangedListener()`, `addTab()`, `onAttachedToWindow()`, `for()`, `onDetachedFromWindow()`, `onSaveInstanceState()`, `onRestoreInstanceState()`, `setCurrentTabByTag()`, `onTabChanged()`, `doTabChanged()`, `getTabInfoForTag()`
- **`FragmentTransaction`** — 25 function(s): `add()`, `addSharedElement()`, `addToBackStack()`, `attach()`, `commit()`, `commitAllowingStateLoss()`, `commitNow()`, `commitNowAllowingStateLoss()`, `detach()`, `disallowAddToBackStack()`, `hide()`, `isAddToBackStackAllowed()`, `isEmpty()`, `remove()`, `replace()`, `runOnCommit()`, `setAllowOptimization()`, `setBreadCrumbShortTitle()`, `setBreadCrumbTitle()`, `setCustomAnimations()`, `setPrimaryNavigationFragment()`, `setReorderingAllowed()`, `setTransition()`, `setTransitionStyle()`, `show()`
- **`FragmentTransition`** — 38 function(s): `resolveSupportImpl()`, `return()`, `startTransitions()`, `if()`, `for()`, `calculatePopFragments()`, `calculateFragments()`, `configureTransitionsReordered()`, `configureTransitionsOrdered()`, `calculateNameOverrides()`, `setViewVisibility()`, `replaceHide()`, `run()`, `scheduleTargetChange()`, `chooseImpl()`, `IllegalArgumentException()`, `canHandleAll()`, `getSharedElementTransition()`, `getEnterTransition()`, `getExitTransition()`, `configureSharedElementsReordered()`, `addSharedElementsWithMatchingNames()`, `callSharedElementStartEnd()`, `setOutEpicenter()`, `configureSharedElementsOrdered()`, `captureOutSharedElements()`, `captureInSharedElements()`, `retainValues()`, `findKeyForValue()`, `getInEpicenterView()`, `configureEnteringExitingViews()`, `mergeTransitions()`, `addToFirstInLastOut()`, `supportsTransition()`, `switch()`, `ensureContainer()`, `FragmentContainerTransition()`, `FragmentTransition()`
- **`FragmentTransitionCompat21`** — 28 function(s): `canHandle()`, `cloneTransition()`, `if()`, `return()`, `wrapTransitionInSet()`, `setSharedElementTargets()`, `for()`, `bfsAddViewChildren()`, `addTargets()`, `setEpicenter()`, `getBoundsOnScreen()`, `onGetEpicenter()`, `while()`, `hasSimpleTarget()`, `mergeTransitionsTogether()`, `scheduleHideFragmentView()`, `onTransitionCancel()`, `onTransitionPause()`, `onTransitionResume()`, `onTransitionStart()`, `onTransitionEnd()`, `mergeTransitionsInSequence()`, `beginDelayedTransition()`, `scheduleRemoveTargets()`, `swapSharedElementTargets()`, `replaceTargets()`, `addTarget()`, `removeTarget()`
- **`FragmentTransitionImpl`** — 30 function(s): `addTarget()`, `addTargets()`, `beginDelayedTransition()`, `canHandle()`, `cloneTransition()`, `mergeTransitionsInSequence()`, `mergeTransitionsTogether()`, `removeTarget()`, `replaceTargets()`, `scheduleHideFragmentView()`, `scheduleRemoveTargets()`, `setEpicenter()`, `setSharedElementTargets()`, `swapSharedElementTargets()`, `wrapTransitionInSet()`, `getBoundsOnScreen()`, `prepareSetNameOverridesReordered()`, `for()`, `setNameOverridesReordered()`, `if()`, `while()`, `run()`, `captureTransitioningViews()`, `findNamedViews()`, `setNameOverridesOrdered()`, `scheduleNameReset()`, `bfsAddViewChildren()`, `containedBeforeIndex()`, `isNullOrEmpty()`, `findKeyForValue()`
- **`FrameMetricsAggregator`** — 14 function(s): `FrameMetricsAggregator()`, `this()`, `if()`, `add()`, `remove()`, `stop()`, `reset()`, `getMetrics()`, `FrameMetricsBaseImpl()`, `onFrameMetricsAvailable()`, `FrameMetricsApi24Impl()`, `addDurationItem()`, `for()`, `while()`
- **`INotificationSideChannel`** — 13 function(s): `cancel()`, `cancelAll()`, `notify()`, `asBinder()`, `Stub()`, `attachInterface()`, `asInterface()`, `if()`, `return()`, `Proxy()`, `onTransact()`, `switch()`, `getInterfaceDescriptor()`
- **`JobIntentService`** — 40 function(s): `compatGetBinder()`, `dequeueWork()`, `complete()`, `getIntent()`, `onHandleWork()`, `onStopCurrentWork()`, `enqueueWork()`, `serviceProcessingFinished()`, `serviceProcessingStarted()`, `serviceStartReceived()`, `WorkEnqueuer()`, `ensureJobId()`, `if()`, `IllegalArgumentException()`, `CompatWorkEnqueuer()`, `super()`, `synchronized()`, `WrapperWorkItem()`, `JobServiceEngineImpl()`, `getBinder()`, `onStartJob()`, `onStopJob()`, `JobWorkEnqueuer()`, `CompatWorkItem()`, `CommandProcessor()`, `doInBackground()`, `while()`, `onCancelled()`, `onPostExecute()`, `JobIntentService()`, `onCreate()`, `onStartCommand()`, `ensureProcessorRunningLocked()`, `onBind()`, `onDestroy()`, `getWorkEnqueuer()`, `setInterruptIfStopped()`, `isStopped()`, `doStopCurrentWork()`, `processorFinished()`
- **`ListFragment`** — 19 function(s): `run()`, `onItemClick()`, `onListItemClick()`, `onCreateView()`, `onViewCreated()`, `ensureList()`, `onDestroyView()`, `setListAdapter()`, `if()`, `setListShown()`, `setSelection()`, `getSelectedItemPosition()`, `getSelectedItemId()`, `getListView()`, `setEmptyText()`, `IllegalStateException()`, `setListShownNoAnimation()`, `getListAdapter()`, `RuntimeException()`
- **`LoaderManager`** — 13 function(s): `onCreateLoader()`, `onLoadFinished()`, `onLoaderReset()`, `destroyLoader()`, `dump()`, `getLoader()`, `hasRunningLoaders()`, `initLoader()`, `markForRedelivery()`, `restartLoader()`, `getInstance()`, `LoaderManagerImpl()`, `enableDebugLogging()`
- **`LoaderManagerImpl`** — 39 function(s): `LoaderInfo()`, `getLoader()`, `onActive()`, `if()`, `onInactive()`, `setCallback()`, `observe()`, `removeObserver()`, `markForRedelivery()`, `isCallbackWaitingForData()`, `return()`, `destroy()`, `onLoadComplete()`, `setValue()`, `postValue()`, `toString()`, `dump()`, `LoaderObserver()`, `onChanged()`, `hasDeliveredData()`, `reset()`, `create()`, `LoaderViewModel()`, `getInstance()`, `startCreatingLoader()`, `isCreatingLoader()`, `finishCreatingLoader()`, `putLoader()`, `removeLoader()`, `hasRunningLoaders()`, `for()`, `onCleared()`, `LoaderManagerImpl()`, `createAndInstallLoader()`, `IllegalArgumentException()`, `initLoader()`, `IllegalStateException()`, `restartLoader()`, `destroyLoader()`
- **`NavUtils`** — 10 function(s): `shouldUpRecreateTask()`, `if()`, `return()`, `navigateUpFromSameTask()`, `IllegalArgumentException()`, `navigateUpTo()`, `getParentActivityIntent()`, `Intent()`, `getParentActivityName()`, `NavUtils()`
- **`NotificationBuilderWithBuilderAccessor`** — 1 function(s): `getBuilder()`
- **`NotificationCompat`** — 226 function(s): `extend()`, `Builder()`, `this()`, `setWhen()`, `setShowWhen()`, `setUsesChronometer()`, `setSmallIcon()`, `setContentTitle()`, `setContentText()`, `setSubText()`, `setRemoteInputHistory()`, `setNumber()`, `setContentInfo()`, `setProgress()`, `setContent()`, `setContentIntent()`, `setDeleteIntent()`, `setFullScreenIntent()`, `setFlag()`, `setTicker()`, `setLargeIcon()`, `reduceLargeIconSize()`, `if()`, `setSound()`, `setVibrate()`, `setLights()`, `setOngoing()`, `setColorized()`, `setOnlyAlertOnce()`, `setAutoCancel()`, `setLocalOnly()`, `setCategory()`, `setDefaults()`, `setPriority()`, `addPerson()`, `setGroup()`, `setGroupSummary()`, `setSortKey()`, `addExtras()`, `setExtras()`, `getExtras()`, `addAction()`, `addInvisibleAction()`, `setStyle()`, `setColor()`, `setVisibility()`, `setPublicVersion()`, `setCustomContentView()`, `setCustomBigContentView()`, `setCustomHeadsUpContentView()`, `setChannelId()`, `setTimeoutAfter()`, `setShortcutId()`, `setBadgeIconType()`, `setGroupAlertBehavior()`, `getNotification()`, `build()`, `NotificationCompatBuilder()`, `limitCharSequenceLength()`, `return()`, `getContentView()`, `getBigContentView()`, `getHeadsUpContentView()`, `getWhenIfShowing()`, `getPriority()`, `getColor()`, `constrain()`, `addCompatExtras()`, `apply()`, `makeBigContentView()`, `makeContentView()`, `makeHeadsUpContentView()`, `restoreFromCompatExtras()`, `setBuilder()`, `applyStandardTemplate()`, `createColoredBitmap()`, `createIconWithBackground()`, `buildIntoRemoteViews()`, `hideNormalContent()`, `calculateTopPadding()`, `BigPictureStyle()`, `setBigContentTitle()`, `setSummaryText()`, `bigPicture()`, `bigLargeIcon()`, `BigTextStyle()`, `bigText()`, `MessagingStyle()`, `IllegalArgumentException()`, `getUserDisplayName()`, `getUser()`, `setConversationTitle()`, `getConversationTitle()`, `addMessage()`, `getMessages()`, `setGroupConversation()`, `isGroupConversation()`, `extractMessagingStyleFromNotification()`, `for()`, `findLatestIncomingMessage()`, `hasMessagesWithoutSender()`, `makeMessageLine()`, `makeFontColorSpan()`, `TextAppearanceSpan()`, `Message()`, `setData()`, `getText()`, `getTimestamp()`, `getSender()`, `getPerson()`, `getDataMimeType()`, `getDataUri()`, `toBundle()`, `getBundleArrayForMessages()`, `getMessagesFromBundleArray()`, `getMessageFromBundle()`, `InboxStyle()`, `addLine()`, `while()`, `createRemoteViews()`, `generateActionButton()`, `Action()`, `getIcon()`, `getTitle()`, `getActionIntent()`, `getAllowGeneratedReplies()`, `getRemoteInputs()`, `getSemanticAction()`, `getDataOnlyRemoteInputs()`, `getShowsUserInterface()`, `addRemoteInput()`, `setAllowGeneratedReplies()`, `setSemanticAction()`, `setShowsUserInterface()`, `WearableExtender()`, `m1clone()`, `setAvailableOffline()`, `isAvailableOffline()`, `setInProgressLabel()`, `getInProgressLabel()`, `setConfirmLabel()`, `getConfirmLabel()`, `setCancelLabel()`, `getCancelLabel()`, `setHintLaunchesActivity()`, `getHintLaunchesActivity()`, `setHintDisplayActionInline()`, `getHintDisplayActionInline()`, `getActionFromActionCompat()`, `m2clone()`, `addActions()`, `clearActions()`, `getActions()`, `setDisplayIntent()`, `getDisplayIntent()`, `addPage()`, `addPages()`, `clearPages()`, `getPages()`, `setBackground()`, `getBackground()`, `setContentIcon()`, `getContentIcon()`, `setContentIconGravity()`, `getContentIconGravity()`, `setContentAction()`, `getContentAction()`, `setGravity()`, `getGravity()`, `setCustomSizePreset()`, `getCustomSizePreset()`, `setCustomContentHeight()`, `getCustomContentHeight()`, `setStartScrollBottom()`, `getStartScrollBottom()`, `setContentIntentAvailableOffline()`, `getContentIntentAvailableOffline()`, `setHintHideIcon()`, `getHintHideIcon()`, `setHintShowBackgroundOnly()`, `getHintShowBackgroundOnly()`, `setHintAvoidBackgroundClipping()`, `getHintAvoidBackgroundClipping()`, `setHintScreenTimeout()`, `getHintScreenTimeout()`, `setHintAmbientBigPicture()`, `getHintAmbientBigPicture()`, `setHintContentIntentLaunchesActivity()`, `getHintContentIntentLaunchesActivity()`, `setDismissalId()`, `getDismissalId()`, `setBridgeTag()`, `getBridgeTag()`, `CarExtender()`, `getUnreadConversationFromBundle()`, `UnreadConversation()`, `getBundleForUnreadConversation()`, `getLargeIcon()`, `setUnreadConversation()`, `getUnreadConversation()`, `getRemoteInput()`, `getReplyPendingIntent()`, `getReadPendingIntent()`, `getParticipants()`, `getParticipant()`, `getLatestTimestamp()`, `setReplyAction()`, `setReadPendingIntent()`, `setLatestTimestamp()`, `getNotificationArrayFromBundle()`, `getActionCount()`, `getAction()`, `getActionCompatFromAction()`, `getInvisibleActions()`, `getContentTitle()`, `getCategory()`, `getLocalOnly()`, `getGroup()`, `isGroupSummary()`, `getSortKey()`, `getChannelId()`, `getTimeoutAfter()`, `getBadgeIconType()`, `getShortcutId()`, `getGroupAlertBehavior()`, `NotificationCompat()`
- **`NotificationCompatBuilder`** — 9 function(s): `NotificationCompatBuilder()`, `if()`, `while()`, `addAction()`, `for()`, `getBuilder()`, `build()`, `buildInternal()`, `removeSoundAndVibration()`
- **`NotificationCompatExtras`** — 1 function(s): `NotificationCompatExtras()`
- **`NotificationCompatJellybean`** — 22 function(s): `buildActionExtrasMap()`, `for()`, `if()`, `getExtras()`, `synchronized()`, `readAction()`, `writeActionAndGetExtras()`, `getActionCount()`, `getAction()`, `getActionObjectsLocked()`, `return()`, `ensureActionReflectionReadyLocked()`, `getActionFromBundle()`, `getBundleForAction()`, `fromBundle()`, `while()`, `RemoteInput()`, `toBundle()`, `fromBundleArray()`, `toBundleArray()`, `getBundleArrayFromBundle()`, `NotificationCompatJellybean()`
- **`NotificationCompatSideChannelService`** — 10 function(s): `cancel()`, `cancelAll()`, `notify()`, `onBind()`, `if()`, `NotificationSideChannelStub()`, `restoreCallingIdentity()`, `checkPermission()`, `for()`, `SecurityException()`
- **`NotificationManagerCompat`** — 36 function(s): `send()`, `from()`, `NotificationManagerCompat()`, `cancel()`, `if()`, `pushSideChannelQueue()`, `cancelAll()`, `notify()`, `areNotificationsEnabled()`, `return()`, `getImportance()`, `getEnabledListenerPackages()`, `synchronized()`, `for()`, `useSideChannelForNotification()`, `SideChannelManager()`, `queueTask()`, `handleMessage()`, `switch()`, `handleQueueTask()`, `handleServiceConnected()`, `handleServiceDisconnected()`, `handleRetryListenerQueue()`, `updateListenerMap()`, `processListenerQueue()`, `ensureServiceUnbound()`, `onServiceConnected()`, `onServiceDisconnected()`, `while()`, `ensureServiceBound()`, `scheduleListenerRetry()`, `ListenerRecord()`, `ServiceConnectedEvent()`, `NotifyTask()`, `toString()`, `CancelTask()`
- **`OneShotPreDrawListener`** — 7 function(s): `OneShotPreDrawListener()`, `add()`, `onPreDraw()`, `removeListener()`, `if()`, `onViewAttachedToWindow()`, `onViewDetachedFromWindow()`
- **`Person`** — 20 function(s): `fromBundle()`, `Builder()`, `fromAndroidPerson()`, `toBundle()`, `toBuilder()`, `toAndroidPerson()`, `getName()`, `getIcon()`, `getUri()`, `getKey()`, `isBot()`, `isImportant()`, `setName()`, `setIcon()`, `setUri()`, `setKey()`, `setBot()`, `setImportant()`, `build()`, `Person()`
- **`RemoteInput`** — 26 function(s): `RemoteInput()`, `getResultKey()`, `getLabel()`, `getChoices()`, `getAllowedDataTypes()`, `isDataOnly()`, `return()`, `getAllowFreeFormInput()`, `getExtras()`, `Builder()`, `if()`, `IllegalArgumentException()`, `setLabel()`, `setChoices()`, `setAllowDataType()`, `setAllowFreeFormInput()`, `addExtras()`, `build()`, `getDataResultsFromIntent()`, `for()`, `getResultsFromIntent()`, `addResultsToIntent()`, `addDataResultToIntent()`, `getExtraResultsKeyForData()`, `fromCompat()`, `getClipDataIntentFromIntent()`
- **`ServiceCompat`** — 3 function(s): `ServiceCompat()`, `stopForeground()`, `if()`
- **`ShareCompat`** — 46 function(s): `ShareCompat()`, `getCallingPackage()`, `getCallingActivity()`, `configureMenuItem()`, `if()`, `IllegalArgumentException()`, `from()`, `IntentBuilder()`, `getIntent()`, `combineArrayExtra()`, `getActivity()`, `createChooserIntent()`, `startChooser()`, `setChooserTitle()`, `setType()`, `setText()`, `setHtmlText()`, `setStream()`, `addStream()`, `setEmailTo()`, `addEmailTo()`, `setEmailCc()`, `addEmailCc()`, `setEmailBcc()`, `addEmailBcc()`, `setSubject()`, `IntentReader()`, `isShareIntent()`, `isSingleShare()`, `isMultipleShare()`, `getType()`, `getText()`, `getHtmlText()`, `withinStyle()`, `while()`, `getStream()`, `return()`, `IndexOutOfBoundsException()`, `getStreamCount()`, `getEmailTo()`, `getEmailCc()`, `getEmailBcc()`, `getSubject()`, `getCallingActivityIcon()`, `getCallingApplicationIcon()`, `getCallingApplicationLabel()`
- **`SharedElementCallback`** — 11 function(s): `onSharedElementsReady()`, `onMapSharedElements()`, `onRejectSharedElements()`, `onSharedElementEnd()`, `onSharedElementStart()`, `onCaptureSharedElementSnapshot()`, `if()`, `createDrawableBitmap()`, `return()`, `onCreateSnapshotView()`, `onSharedElementsArrived()`
- **`SuperNotCalledException`** — 2 function(s): `SuperNotCalledException()`, `super()`
- **`SupportActivity`** — 10 function(s): `putExtraData()`, `onCreate()`, `onSaveInstanceState()`, `getExtraData()`, `return()`, `getLifecycle()`, `superDispatchKeyEvent()`, `dispatchKeyShortcutEvent()`, `if()`, `dispatchKeyEvent()`
- **`TaskStackBuilder`** — 19 function(s): `getSupportParentActivityIntent()`, `TaskStackBuilder()`, `create()`, `from()`, `addNextIntent()`, `addNextIntentWithParentStack()`, `if()`, `addParentStack()`, `while()`, `IllegalArgumentException()`, `getIntentCount()`, `getIntent()`, `editIntentAt()`, `iterator()`, `startActivities()`, `IllegalStateException()`, `getPendingIntent()`, `getIntents()`, `for()`

</details>

### Package `android.support.v4.content`  (13 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AsyncTaskLoader` | class | Loader<D> | 234 | 54 |
| `ContentResolverCompat` | class | — | 38 | 6 |
| `ContextCompat` | class | — | 334 | 61 |
| `CursorLoader` | class | AsyncTaskLoader<Cursor> | 209 | 42 |
| `FileProvider` | class | ContentProvider | 310 | 68 |
| `IntentCompat` | class | — | 26 | 3 |
| `Loader` | class | ContentObserver | 265 | 63 |
| `LocalBroadcastManager` | class | — | 273 | 49 |
| `MimeTypeFilter` | class | — | 78 | 24 |
| `ModernAsyncTask` | class | Handler | 253 | 50 |
| `PermissionChecker` | class | — | 61 | 13 |
| `SharedPreferencesCompat` | class | — | 50 | 7 |
| `WakefulBroadcastReceiver` | class | BroadcastReceiver | 55 | 8 |

<details>
<summary><b>Function list for <code>android.support.v4.content</code></b> (click to expand)</summary>

- **`AsyncTaskLoader`** — 28 function(s): `cancelLoadInBackground()`, `loadInBackground()`, `onCanceled()`, `LoadTask()`, `doInBackground()`, `return()`, `if()`, `onPostExecute()`, `onCancelled()`, `run()`, `waitForLoader()`, `AsyncTaskLoader()`, `this()`, `super()`, `setUpdateThrottle()`, `onForceLoad()`, `cancelLoad()`, `executePendingTask()`, `onCancelLoad()`, `dispatchOnCancelled()`, `rollbackContentChanged()`, `deliverCancellation()`, `dispatchOnLoadComplete()`, `commitContentChanged()`, `deliverResult()`, `onLoadInBackground()`, `isLoadInBackgroundCanceled()`, `dump()`
- **`ContentResolverCompat`** — 3 function(s): `ContentResolverCompat()`, `query()`, `if()`
- **`ContextCompat`** — 26 function(s): `startActivities()`, `if()`, `startActivity()`, `getDataDir()`, `File()`, `getObbDirs()`, `getExternalFilesDirs()`, `getExternalCacheDirs()`, `buildPath()`, `for()`, `getDrawable()`, `synchronized()`, `getColorStateList()`, `getColor()`, `checkSelfPermission()`, `IllegalArgumentException()`, `getNoBackupFilesDir()`, `createFilesDir()`, `getCodeCacheDir()`, `createDeviceProtectedStorageContext()`, `isDeviceProtectedStorage()`, `startForegroundService()`, `getSystemService()`, `return()`, `getSystemServiceName()`, `LegacyServiceMapHolder()`
- **`CursorLoader`** — 25 function(s): `loadInBackground()`, `synchronized()`, `if()`, `OperationCanceledException()`, `cancelLoadInBackground()`, `deliverResult()`, `CursorLoader()`, `super()`, `onStartLoading()`, `forceLoad()`, `onStopLoading()`, `cancelLoad()`, `onCanceled()`, `onReset()`, `getUri()`, `setUri()`, `getProjection()`, `setProjection()`, `getSelection()`, `setSelection()`, `getSelectionArgs()`, `setSelectionArgs()`, `getSortOrder()`, `setSortOrder()`, `dump()`
- **`FileProvider`** — 24 function(s): `getFileForUri()`, `getUriForFile()`, `onCreate()`, `attachInfo()`, `if()`, `SecurityException()`, `getPathStrategy()`, `query()`, `for()`, `getType()`, `insert()`, `UnsupportedOperationException()`, `update()`, `delete()`, `openFile()`, `synchronized()`, `IllegalArgumentException()`, `parsePathStrategy()`, `while()`, `SimplePathStrategy()`, `addRoot()`, `modeToMode()`, `buildPath()`, `copyOf()`
- **`IntentCompat`** — 3 function(s): `IntentCompat()`, `makeMainSelectorActivity()`, `if()`
- **`Loader`** — 40 function(s): `onLoadCanceled()`, `onLoadComplete()`, `onAbandon()`, `onCancelLoad()`, `onForceLoad()`, `onReset()`, `onStartLoading()`, `onStopLoading()`, `deliverSelfNotifications()`, `ForceLoadContentObserver()`, `super()`, `onChange()`, `Loader()`, `deliverResult()`, `if()`, `deliverCancellation()`, `getContext()`, `getId()`, `registerListener()`, `IllegalStateException()`, `unregisterListener()`, `IllegalArgumentException()`, `registerOnLoadCanceledListener()`, `unregisterOnLoadCanceledListener()`, `isStarted()`, `isAbandoned()`, `isReset()`, `startLoading()`, `cancelLoad()`, `forceLoad()`, `stopLoading()`, `abandon()`, `reset()`, `takeContentChanged()`, `commitContentChanged()`, `rollbackContentChanged()`, `onContentChanged()`, `dataToString()`, `toString()`, `dump()`
- **`LocalBroadcastManager`** — 16 function(s): `ReceiverRecord()`, `toString()`, `if()`, `BroadcastRecord()`, `getInstance()`, `synchronized()`, `LocalBroadcastManager()`, `handleMessage()`, `registerReceiver()`, `for()`, `unregisterReceiver()`, `sendBroadcast()`, `while()`, `switch()`, `sendBroadcastSync()`, `executePendingBroadcasts()`
- **`MimeTypeFilter`** — 8 function(s): `MimeTypeFilter()`, `mimeTypeAgainstFilter()`, `if()`, `IllegalArgumentException()`, `matches()`, `for()`, `matchesMany()`, `return()`
- **`ModernAsyncTask`** — 31 function(s): `newThread()`, `Thread()`, `call()`, `done()`, `RuntimeException()`, `doInBackground()`, `onCancelled()`, `onPostExecute()`, `onPreExecute()`, `onProgressUpdate()`, `getHandler()`, `synchronized()`, `if()`, `setDefaultExecutor()`, `postResultIfNotInvoked()`, `postResult()`, `getStatus()`, `isCancelled()`, `cancel()`, `get()`, `execute()`, `executeOnExecutor()`, `switch()`, `IllegalStateException()`, `publishProgress()`, `finish()`, `InternalHandler()`, `super()`, `handleMessage()`, `WorkerRunnable()`, `AsyncTaskResult()`
- **`PermissionChecker`** — 6 function(s): `PermissionChecker()`, `checkPermission()`, `if()`, `checkSelfPermission()`, `checkCallingPermission()`, `checkCallingOrSelfPermission()`
- **`SharedPreferencesCompat`** — 6 function(s): `Helper()`, `apply()`, `EditorCompat()`, `getInstance()`, `if()`, `SharedPreferencesCompat()`
- **`WakefulBroadcastReceiver`** — 4 function(s): `startWakefulService()`, `synchronized()`, `if()`, `completeWakefulIntent()`

</details>

### Package `android.support.v4.content.pm`  (5 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ActivityInfoCompat` | class | — | 13 | 1 |
| `PackageInfoCompat` | class | — | 19 | 3 |
| `PermissionInfoCompat` | class | — | 46 | 5 |
| `ShortcutInfoCompat` | class | — | 173 | 33 |
| `ShortcutManagerCompat` | class | — | 79 | 15 |

<details>
<summary><b>Function list for <code>android.support.v4.content.pm</code></b> (click to expand)</summary>

- **`ActivityInfoCompat`** — 1 function(s): `ActivityInfoCompat()`
- **`PackageInfoCompat`** — 3 function(s): `getLongVersionCode()`, `if()`, `PackageInfoCompat()`
- **`PermissionInfoCompat`** — 4 function(s): `PermissionInfoCompat()`, `getProtection()`, `if()`, `getProtectionFlags()`
- **`ShortcutInfoCompat`** — 22 function(s): `toShortcutInfo()`, `if()`, `addToIntent()`, `getId()`, `getActivity()`, `getShortLabel()`, `getLongLabel()`, `getDisabledMessage()`, `getIntent()`, `getIntents()`, `return()`, `Builder()`, `setShortLabel()`, `setLongLabel()`, `setDisabledMessage()`, `setIntent()`, `setIntents()`, `setIcon()`, `setActivity()`, `setAlwaysBadged()`, `build()`, `IllegalArgumentException()`
- **`ShortcutManagerCompat`** — 8 function(s): `ShortcutManagerCompat()`, `isRequestPinShortcutSupported()`, `if()`, `return()`, `while()`, `requestPinShortcut()`, `onReceive()`, `createShortcutResultIntent()`

</details>

### Package `android.support.v4.content.res`  (8 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ColorStateListInflaterCompat` | class | — | 120 | 24 |
| `ComplexColorCompat` | class | — | 131 | 29 |
| `ConfigurationHelper` | class | — | 19 | 3 |
| `FontResourcesParserCompat` | class | FamilyResourceEntry | 268 | 51 |
| `GradientColorInflaterCompat` | class | — | 168 | 33 |
| `GrowingArrayUtils` | class | — | 113 | 19 |
| `ResourcesCompat` | class | — | 193 | 42 |
| `TypedArrayUtils` | class | — | 133 | 25 |

<details>
<summary><b>Function list for <code>android.support.v4.content.res</code></b> (click to expand)</summary>

- **`ColorStateListInflaterCompat`** — 12 function(s): `ColorStateListInflaterCompat()`, `createFromXml()`, `if()`, `XmlPullParserException()`, `createFromXmlInner()`, `inflate()`, `while()`, `for()`, `ColorStateList()`, `obtainAttributes()`, `modulateColorAlpha()`, `return()`
- **`ComplexColorCompat`** — 14 function(s): `ComplexColorCompat()`, `from()`, `getShader()`, `getColor()`, `setColor()`, `isGradient()`, `isStateful()`, `onStateChanged()`, `if()`, `willDraw()`, `inflate()`, `createFromXml()`, `XmlPullParserException()`, `switch()`
- **`ConfigurationHelper`** — 3 function(s): `ConfigurationHelper()`, `getDensityDpi()`, `if()`
- **`FontResourcesParserCompat`** — 27 function(s): `ProviderResourceEntry()`, `getRequest()`, `getFetchStrategy()`, `getTimeout()`, `FontFileResourceEntry()`, `getFileName()`, `getWeight()`, `isItalic()`, `getVariationSettings()`, `getTtcIndex()`, `getResourceId()`, `FontFamilyFilesResourceEntry()`, `getEntries()`, `parse()`, `if()`, `XmlPullParserException()`, `readFamilies()`, `readFamily()`, `skip()`, `while()`, `getType()`, `readCerts()`, `for()`, `toByteArrayList()`, `readFont()`, `switch()`, `FontResourcesParserCompat()`
- **`GradientColorInflaterCompat`** — 15 function(s): `GradientColorInflaterCompat()`, `createFromXml()`, `if()`, `XmlPullParserException()`, `createFromXmlInner()`, `switch()`, `RadialGradient()`, `SweepGradient()`, `LinearGradient()`, `inflateChildElements()`, `while()`, `ColorStops()`, `checkColors()`, `parseTileMode()`, `for()`
- **`GrowingArrayUtils`** — 5 function(s): `growSize()`, `if()`, `append()`, `insert()`, `GrowingArrayUtils()`
- **`ResourcesCompat`** — 13 function(s): `getDrawable()`, `if()`, `getDrawableForDensity()`, `getColor()`, `getColorStateList()`, `getFont()`, `loadFont()`, `onFontRetrievalFailed()`, `onFontRetrieved()`, `callbackSuccessAsync()`, `run()`, `callbackFailAsync()`, `ResourcesCompat()`
- **`TypedArrayUtils`** — 20 function(s): `hasAttribute()`, `getNamedFloat()`, `getNamedBoolean()`, `getNamedInt()`, `getNamedColor()`, `getNamedComplexColor()`, `if()`, `getNamedResourceId()`, `getNamedString()`, `peekNamedValue()`, `obtainAttributes()`, `getBoolean()`, `getDrawable()`, `getInt()`, `getResourceId()`, `getString()`, `getText()`, `getTextArray()`, `getAttr()`, `TypedArrayUtils()`

</details>

### Package `android.support.v4.database`  (2 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `CursorWindowCompat` | class | — | 24 | 7 |
| `DatabaseUtilsCompat` | class | — | 33 | 6 |

<details>
<summary><b>Function list for <code>android.support.v4.database</code></b> (click to expand)</summary>

- **`CursorWindowCompat`** — 4 function(s): `CursorWindowCompat()`, `create()`, `if()`, `CursorWindow()`
- **`DatabaseUtilsCompat`** — 4 function(s): `DatabaseUtilsCompat()`, `concatenateWhere()`, `if()`, `appendSelectionArgs()`

</details>

### Package `android.support.v4.database.sqlite`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `SQLiteCursorCompat` | class | — | 18 | 3 |

<details>
<summary><b>Function list for <code>android.support.v4.database.sqlite</code></b> (click to expand)</summary>

- **`SQLiteCursorCompat`** — 3 function(s): `SQLiteCursorCompat()`, `setFillWindowForwardOnly()`, `if()`

</details>

### Package `android.support.v4.graphics`  (13 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `BitmapCompat` | class | — | 32 | 7 |
| `ColorUtils` | class | — | 337 | 72 |
| `PaintCompat` | class | — | 68 | 12 |
| `PathParser` | class | — | 664 | 76 |
| `PathSegment` | class | — | 58 | 11 |
| `PathUtils` | class | — | 44 | 6 |
| `TypefaceCompat` | class | — | 91 | 13 |
| `TypefaceCompatApi21Impl` | class | TypefaceCompatBaseImpl | 123 | 12 |
| `TypefaceCompatApi24Impl` | class | TypefaceCompatBaseImpl | 122 | 18 |
| `TypefaceCompatApi26Impl` | class | TypefaceCompatApi21Impl | 265 | 53 |
| `TypefaceCompatApi28Impl` | class | TypefaceCompatApi26Impl | 37 | 4 |
| `TypefaceCompatBaseImpl` | class | — | 148 | 23 |
| `TypefaceCompatUtil` | class | — | 242 | 29 |

<details>
<summary><b>Function list for <code>android.support.v4.graphics</code></b> (click to expand)</summary>

- **`BitmapCompat`** — 5 function(s): `hasMipMap()`, `if()`, `setHasMipMap()`, `getAllocationByteCount()`, `BitmapCompat()`
- **`ColorUtils`** — 32 function(s): `constrain()`, `ColorUtils()`, `compositeColors()`, `if()`, `IllegalArgumentException()`, `for()`, `compositeAlpha()`, `compositeComponent()`, `return()`, `calculateLuminance()`, `colorToXYZ()`, `calculateContrast()`, `calculateMinimumAlpha()`, `RGBToHSL()`, `colorToHSL()`, `HSLToColor()`, `switch()`, `setAlphaComponent()`, `colorToLAB()`, `RGBToLAB()`, `RGBToXYZ()`, `XYZToLAB()`, `LABToXYZ()`, `XYZToColor()`, `LABToColor()`, `distanceEuclidean()`, `pivotXyzComponent()`, `blendARGB()`, `blendHSL()`, `blendLAB()`, `circularInterpolate()`, `getTempDouble3Array()`
- **`PaintCompat`** — 5 function(s): `hasGlyph()`, `if()`, `while()`, `obtainEmptyRects()`, `PaintCompat()`
- **`PathParser`** — 26 function(s): `copyOfRange()`, `if()`, `IllegalArgumentException()`, `ArrayIndexOutOfBoundsException()`, `createPathFromPathData()`, `RuntimeException()`, `createNodesFromPathData()`, `while()`, `addNode()`, `return()`, `deepCopyNodes()`, `for()`, `canMorph()`, `updateNodes()`, `nextStart()`, `ExtractFloatResult()`, `getFloats()`, `extract()`, `switch()`, `PathDataNode()`, `nodesToPath()`, `addCommand()`, `interpolatePathDataNode()`, `drawArc()`, `arcToBezier()`, `PathParser()`
- **`PathSegment`** — 10 function(s): `PathSegment()`, `getStart()`, `getStartFraction()`, `getEnd()`, `getEndFraction()`, `equals()`, `if()`, `hashCode()`, `return()`, `toString()`
- **`PathUtils`** — 4 function(s): `flatten()`, `for()`, `if()`, `PathUtils()`
- **`TypefaceCompat`** — 7 function(s): `if()`, `TypefaceCompat()`, `findFromCache()`, `createResourceUid()`, `createFromResourcesFamilyXml()`, `createFromResourcesFontFile()`, `createFromFontInfo()`
- **`TypefaceCompatApi21Impl`** — 4 function(s): `getFile()`, `if()`, `File()`, `createFromFontInfo()`
- **`TypefaceCompatApi24Impl`** — 10 function(s): `isUsable()`, `if()`, `newFamily()`, `RuntimeException()`, `addFontWeightStyle()`, `return()`, `createFromFamiliesWithDefault()`, `createFromFontInfo()`, `for()`, `createFromFontFamilyFilesResourceEntry()`
- **`TypefaceCompatApi26Impl`** — 22 function(s): `TypefaceCompatApi26Impl()`, `isFontFamilyPrivateAPIAvailable()`, `if()`, `newFamily()`, `RuntimeException()`, `addFontFromAssetManager()`, `return()`, `addFontFromBuffer()`, `createFromFamiliesWithDefault()`, `freeze()`, `abortCreation()`, `createFromFontFamilyFilesResourceEntry()`, `for()`, `createFromFontInfo()`, `createFromResourcesFontFile()`, `obtainFontFamily()`, `obtainFontFamilyCtor()`, `obtainAddFontFromAssetManagerMethod()`, `obtainAddFontFromBufferMethod()`, `obtainFreezeMethod()`, `obtainAbortCreationMethod()`, `obtainCreateFromFamiliesWithDefaultMethod()`
- **`TypefaceCompatApi28Impl`** — 4 function(s): `createFromFamiliesWithDefault()`, `return()`, `RuntimeException()`, `obtainCreateFromFamiliesWithDefaultMethod()`
- **`TypefaceCompatBaseImpl`** — 12 function(s): `getWeight()`, `isItalic()`, `findBestFont()`, `for()`, `if()`, `findBestInfo()`, `return()`, `createFromInputStream()`, `createFromFontInfo()`, `findBestEntry()`, `createFromFontFamilyFilesResourceEntry()`, `createFromResourcesFontFile()`
- **`TypefaceCompatUtil`** — 9 function(s): `TypefaceCompatUtil()`, `getTempFile()`, `for()`, `if()`, `mmap()`, `copyToDirectBuffer()`, `copyToFile()`, `while()`, `closeQuietly()`

</details>

### Package `android.support.v4.graphics.drawable`  (10 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `DrawableCompat` | class | — | 220 | 50 |
| `IconCompat` | class | CustomVersionedParcelable | 778 | 147 |
| `IconCompatParcelizer` | class | androidx.core.graphics.drawable.IconCompatParcelizer | 17 | 2 |
| `RoundedBitmapDrawable` | class | Drawable | 261 | 71 |
| `RoundedBitmapDrawable21` | class | RoundedBitmapDrawable | 42 | 9 |
| `RoundedBitmapDrawableFactory` | class | RoundedBitmapDrawable | 74 | 16 |
| `TintAwareDrawable` | class | — | 17 | 3 |
| `WrappedDrawable` | class | — | 13 | 2 |
| `WrappedDrawableApi14` | class | Drawable implements Drawable.Callback, WrappedDrawable, TintAwareDrawable | 338 | 83 |
| `WrappedDrawableApi21` | class | WrappedDrawableApi14 | 145 | 32 |

<details>
<summary><b>Function list for <code>android.support.v4.graphics.drawable</code></b> (click to expand)</summary>

- **`DrawableCompat`** — 22 function(s): `jumpToCurrentState()`, `setAutoMirrored()`, `if()`, `isAutoMirrored()`, `setHotspot()`, `setHotspotBounds()`, `setTint()`, `setTintList()`, `setTintMode()`, `getAlpha()`, `applyTheme()`, `canApplyTheme()`, `getColorFilter()`, `clearColorFilter()`, `for()`, `inflate()`, `wrap()`, `unwrap()`, `setLayoutDirection()`, `getLayoutDirection()`, `return()`, `DrawableCompat()`
- **`IconCompat`** — 33 function(s): `typeToString()`, `switch()`, `createWithResource()`, `if()`, `IllegalArgumentException()`, `createWithBitmap()`, `createWithAdaptiveBitmap()`, `createWithData()`, `createWithContentUri()`, `IconCompat()`, `getType()`, `getResPackage()`, `IllegalStateException()`, `return()`, `getResId()`, `getUri()`, `setTint()`, `setTintList()`, `setTintMode()`, `toIcon()`, `checkResource()`, `loadDrawable()`, `loadDrawableInner()`, `BitmapDrawable()`, `getResources()`, `addToShortcutIntent()`, `toBundle()`, `toString()`, `onPreParceling()`, `onPostParceling()`, `createFromBundle()`, `createFromIcon()`, `createLegacyIconFromAdaptiveIcon()`
- **`IconCompatParcelizer`** — 2 function(s): `read()`, `write()`
- **`RoundedBitmapDrawable`** — 34 function(s): `isGreaterThanZero()`, `getPaint()`, `getBitmap()`, `computeBitmapSize()`, `setTargetDensity()`, `if()`, `invalidateSelf()`, `getGravity()`, `setGravity()`, `setMipMap()`, `UnsupportedOperationException()`, `hasMipMap()`, `setAntiAlias()`, `hasAntiAlias()`, `setFilterBitmap()`, `setDither()`, `gravityCompatApply()`, `updateDstRect()`, `draw()`, `setAlpha()`, `getAlpha()`, `setColorFilter()`, `getColorFilter()`, `setCircular()`, `updateCircularCornerRadius()`, `setCornerRadius()`, `isCircular()`, `onBoundsChange()`, `getCornerRadius()`, `getIntrinsicWidth()`, `getIntrinsicHeight()`, `getOpacity()`, `return()`, `RoundedBitmapDrawable()`
- **`RoundedBitmapDrawable21`** — 9 function(s): `RoundedBitmapDrawable21()`, `super()`, `getOutline()`, `updateDstRect()`, `setMipMap()`, `if()`, `invalidateSelf()`, `hasMipMap()`, `gravityCompatApply()`
- **`RoundedBitmapDrawableFactory`** — 10 function(s): `DefaultRoundedBitmapDrawable()`, `super()`, `setMipMap()`, `if()`, `invalidateSelf()`, `hasMipMap()`, `gravityCompatApply()`, `create()`, `RoundedBitmapDrawable21()`, `RoundedBitmapDrawableFactory()`
- **`TintAwareDrawable`** — 3 function(s): `setTint()`, `setTintList()`, `setTintMode()`
- **`WrappedDrawable`** — 2 function(s): `getWrappedDrawable()`, `setWrappedDrawable()`
- **`WrappedDrawableApi14`** — 52 function(s): `isCompatTintEnabled()`, `WrappedDrawableApi14()`, `updateLocalState()`, `setWrappedDrawable()`, `if()`, `jumpToCurrentState()`, `draw()`, `onBoundsChange()`, `setChangingConfigurations()`, `getChangingConfigurations()`, `setDither()`, `setFilterBitmap()`, `setAlpha()`, `setColorFilter()`, `isStateful()`, `return()`, `setState()`, `updateTint()`, `getState()`, `getCurrent()`, `setVisible()`, `getOpacity()`, `getTransparentRegion()`, `getIntrinsicWidth()`, `getIntrinsicHeight()`, `getMinimumWidth()`, `getMinimumHeight()`, `getPadding()`, `setAutoMirrored()`, `isAutoMirrored()`, `getConstantState()`, `mutate()`, `mutateConstantState()`, `DrawableWrapperStateBase()`, `invalidateDrawable()`, `invalidateSelf()`, `scheduleDrawable()`, `scheduleSelf()`, `unscheduleDrawable()`, `unscheduleSelf()`, `onLevelChange()`, `setTint()`, `setTintList()`, `setTintMode()`, `clearColorFilter()`, `getWrappedDrawable()`, `setLevel()`, `setBounds()`, `newDrawable()`, `DrawableWrapperState()`, `canConstantState()`, `super()`
- **`WrappedDrawableApi21`** — 19 function(s): `WrappedDrawableApi21()`, `super()`, `findAndCacheIsProjectedDrawableMethod()`, `setHotspot()`, `setHotspotBounds()`, `getOutline()`, `getDirtyBounds()`, `setTintList()`, `if()`, `setTint()`, `setTintMode()`, `setState()`, `invalidateSelf()`, `isCompatTintEnabled()`, `return()`, `isProjected()`, `mutateConstantState()`, `DrawableWrapperStateLollipop()`, `newDrawable()`

</details>

### Package `android.support.v4.hardware.display`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `DisplayManagerCompat` | class | — | 66 | 15 |

<details>
<summary><b>Function list for <code>android.support.v4.hardware.display</code></b> (click to expand)</summary>

- **`DisplayManagerCompat`** — 7 function(s): `DisplayManagerCompat()`, `getInstance()`, `synchronized()`, `if()`, `getDisplay()`, `return()`, `getDisplays()`

</details>

### Package `android.support.v4.hardware.fingerprint`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `FingerprintManagerCompat` | class | — | 186 | 40 |

<details>
<summary><b>Function list for <code>android.support.v4.hardware.fingerprint</code></b> (click to expand)</summary>

- **`FingerprintManagerCompat`** — 21 function(s): `onAuthenticationError()`, `onAuthenticationFailed()`, `onAuthenticationHelp()`, `onAuthenticationSucceeded()`, `from()`, `FingerprintManagerCompat()`, `hasEnrolledFingerprints()`, `isHardwareDetected()`, `authenticate()`, `if()`, `getFingerprintManagerOrNull()`, `return()`, `wrapCryptoObject()`, `unwrapCryptoObject()`, `CryptoObject()`, `wrapCallback()`, `getSignature()`, `getCipher()`, `getMac()`, `AuthenticationResult()`, `getCryptoObject()`

</details>

### Package `android.support.v4.internal.view`  (3 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `SupportMenu` | class | Menu | 19 | 1 |
| `SupportMenuItem` | class | MenuItem | 86 | 23 |
| `SupportSubMenu` | class | SupportMenu, SubMenu | 10 | 0 |

<details>
<summary><b>Function list for <code>android.support.v4.internal.view</code></b> (click to expand)</summary>

- **`SupportMenu`** — 1 function(s): `setGroupDividerEnabled()`
- **`SupportMenuItem`** — 22 function(s): `collapseActionView()`, `expandActionView()`, `getActionView()`, `getAlphabeticModifiers()`, `getContentDescription()`, `getIconTintList()`, `getIconTintMode()`, `getNumericModifiers()`, `getSupportActionProvider()`, `getTooltipText()`, `isActionViewExpanded()`, `setActionView()`, `setAlphabeticShortcut()`, `setContentDescription()`, `setIconTintList()`, `setIconTintMode()`, `setNumericShortcut()`, `setShortcut()`, `setShowAsAction()`, `setShowAsActionFlags()`, `setSupportActionProvider()`, `setTooltipText()`

</details>

### Package `android.support.v4.math`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `MathUtils` | class | — | 20 | 4 |

<details>
<summary><b>Function list for <code>android.support.v4.math</code></b> (click to expand)</summary>

- **`MathUtils`** — 2 function(s): `clamp()`, `MathUtils()`

</details>

### Package `android.support.v4.net`  (3 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ConnectivityManagerCompat` | class | — | 73 | 9 |
| `DatagramSocketWrapper` | class | Socket | 99 | 31 |
| `TrafficStatsCompat` | class | — | 71 | 12 |

<details>
<summary><b>Function list for <code>android.support.v4.net</code></b> (click to expand)</summary>

- **`ConnectivityManagerCompat`** — 6 function(s): `isActiveNetworkMetered()`, `if()`, `switch()`, `getNetworkInfoFromBroadcast()`, `getRestrictBackgroundStatus()`, `ConnectivityManagerCompat()`
- **`DatagramSocketWrapper`** — 16 function(s): `DatagramSocketWrapper()`, `super()`, `DatagramSocketImplWrapper()`, `accept()`, `UnsupportedOperationException()`, `available()`, `bind()`, `close()`, `connect()`, `create()`, `getInputStream()`, `getOutputStream()`, `listen()`, `sendUrgentData()`, `getOption()`, `setOption()`
- **`TrafficStatsCompat`** — 10 function(s): `clearThreadStatsTag()`, `getThreadStatsTag()`, `incrementOperationCount()`, `setThreadStatsTag()`, `tagSocket()`, `untagSocket()`, `tagDatagramSocket()`, `if()`, `untagDatagramSocket()`, `TrafficStatsCompat()`

</details>

### Package `android.support.v4.os`  (17 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `BuildCompat` | class | — | 39 | 7 |
| `CancellationSignal` | class | — | 100 | 28 |
| `ConfigurationCompat` | class | — | 15 | 2 |
| `EnvironmentCompat` | class | — | 29 | 3 |
| `HandlerCompat` | class | — | 23 | 3 |
| `IResultReceiver` | class | IInterface | 90 | 18 |
| `LocaleHelper` | class | — | 54 | 19 |
| `LocaleListCompat` | class | LocaleListInterface | 280 | 53 |
| `LocaleListHelper` | class | — | 412 | 99 |
| `LocaleListInterface` | class | — | 37 | 11 |
| `OperationCanceledException` | class | RuntimeException | 13 | 4 |
| `ParcelCompat` | class | — | 18 | 3 |
| `ParcelableCompat` | class | Parcelable.ClassLoaderCreator<T> | 41 | 7 |
| `ParcelableCompatCreatorCallbacks` | class | — | 12 | 2 |
| `ResultReceiver` | class | Parcelable | 109 | 19 |
| `TraceCompat` | class | — | 23 | 5 |
| `UserManagerCompat` | class | — | 19 | 4 |

<details>
<summary><b>Function list for <code>android.support.v4.os</code></b> (click to expand)</summary>

- **`BuildCompat`** — 7 function(s): `BuildCompat()`, `isAtLeastN()`, `isAtLeastNMR1()`, `isAtLeastO()`, `isAtLeastOMR1()`, `isAtLeastP()`, `isAtLeastQ()`
- **`CancellationSignal`** — 13 function(s): `onCancel()`, `isCanceled()`, `synchronized()`, `throwIfCanceled()`, `if()`, `OperationCanceledException()`, `cancel()`, `notifyAll()`, `setOnCancelListener()`, `waitForCancelFinishedLocked()`, `getCancellationSignalObject()`, `while()`, `wait()`
- **`ConfigurationCompat`** — 2 function(s): `ConfigurationCompat()`, `getLocales()`
- **`EnvironmentCompat`** — 3 function(s): `getStorageState()`, `if()`, `EnvironmentCompat()`
- **`HandlerCompat`** — 3 function(s): `postDelayed()`, `if()`, `HandlerCompat()`
- **`IResultReceiver`** — 10 function(s): `send()`, `asBinder()`, `Stub()`, `attachInterface()`, `asInterface()`, `if()`, `return()`, `Proxy()`, `onTransact()`, `getInterfaceDescriptor()`
- **`LocaleHelper`** — 6 function(s): `forLanguageTag()`, `if()`, `Locale()`, `IllegalArgumentException()`, `toLanguageTag()`, `LocaleHelper()`
- **`LocaleListCompat`** — 24 function(s): `if()`, `LocaleListCompatBaseImpl()`, `setLocaleList()`, `getLocaleList()`, `get()`, `isEmpty()`, `size()`, `indexOf()`, `equals()`, `hashCode()`, `toString()`, `toLanguageTags()`, `getFirstMatch()`, `LocaleListCompatApi24Impl()`, `LocaleListCompat()`, `wrap()`, `unwrap()`, `create()`, `getEmptyLocaleList()`, `forLanguageTags()`, `for()`, `getAdjustedDefault()`, `getDefault()`, `setLocaleListArray()`
- **`LocaleListHelper`** — 32 function(s): `get()`, `if()`, `isEmpty()`, `size()`, `indexOf()`, `for()`, `equals()`, `hashCode()`, `toString()`, `toLanguageTags()`, `LocaleListHelper()`, `NullPointerException()`, `IllegalArgumentException()`, `while()`, `getEmptyLocaleList()`, `forLanguageTags()`, `getLikelyScript()`, `isPseudoLocale()`, `matchScore()`, `return()`, `findFirstMatchIndex()`, `computeFirstMatchIndex()`, `computeFirstMatch()`, `getFirstMatch()`, `getFirstMatchIndex()`, `getFirstMatchWithEnglishSupported()`, `getFirstMatchIndexWithEnglishSupported()`, `isPseudoLocalesOnly()`, `getDefault()`, `synchronized()`, `getAdjustedDefault()`, `setDefault()`
- **`LocaleListInterface`** — 11 function(s): `equals()`, `get()`, `getFirstMatch()`, `getLocaleList()`, `hashCode()`, `indexOf()`, `isEmpty()`, `setLocaleList()`, `size()`, `toLanguageTags()`, `toString()`
- **`OperationCanceledException`** — 3 function(s): `OperationCanceledException()`, `this()`, `super()`
- **`ParcelCompat`** — 3 function(s): `readBoolean()`, `writeBoolean()`, `ParcelCompat()`
- **`ParcelableCompat`** — 5 function(s): `newCreator()`, `ParcelableCompatCreatorHoneycombMR2()`, `createFromParcel()`, `newArray()`, `ParcelableCompat()`
- **`ParcelableCompatCreatorCallbacks`** — 2 function(s): `createFromParcel()`, `newArray()`
- **`ResultReceiver`** — 12 function(s): `createFromParcel()`, `ResultReceiver()`, `newArray()`, `describeContents()`, `onReceiveResult()`, `MyRunnable()`, `run()`, `MyResultReceiver()`, `send()`, `if()`, `writeToParcel()`, `synchronized()`
- **`TraceCompat`** — 4 function(s): `beginSection()`, `if()`, `endSection()`, `TraceCompat()`
- **`UserManagerCompat`** — 4 function(s): `UserManagerCompat()`, `isUserUnlocked()`, `if()`, `return()`

</details>

### Package `android.support.v4.print`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `PrintHelper` | class | PrintDocumentAdapter | 502 | 85 |

<details>
<summary><b>Function list for <code>android.support.v4.print</code></b> (click to expand)</summary>

- **`PrintHelper`** — 32 function(s): `onFinish()`, `systemSupportsPrint()`, `PrintHelper()`, `setScaleMode()`, `getScaleMode()`, `setColorMode()`, `getColorMode()`, `setOrientation()`, `getOrientation()`, `if()`, `printBitmap()`, `PrintBitmapAdapter()`, `onLayout()`, `onWrite()`, `PrintUriAdapter()`, `synchronized()`, `onPreExecute()`, `onCancel()`, `cancel()`, `doInBackground()`, `onPostExecute()`, `onCancelled()`, `cancelLoad()`, `isPortrait()`, `copyAttributes()`, `getMatrix()`, `writeBitmap()`, `loadConstrainedBitmap()`, `IllegalArgumentException()`, `loadBitmap()`, `while()`, `convertBitmapForColorMode()`

</details>

### Package `android.support.v4.provider`  (8 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `DocumentFile` | class | — | 104 | 31 |
| `DocumentsContractApi19` | class | — | 201 | 44 |
| `FontRequest` | class | — | 87 | 11 |
| `FontsContractCompat` | class | BaseColumns | 517 | 90 |
| `RawDocumentFile` | class | DocumentFile | 162 | 36 |
| `SelfDestructiveThread` | class | — | 174 | 28 |
| `SingleDocumentFile` | class | DocumentFile | 108 | 22 |
| `TreeDocumentFile` | class | DocumentFile | 195 | 32 |

<details>
<summary><b>Function list for <code>android.support.v4.provider</code></b> (click to expand)</summary>

- **`DocumentFile`** — 28 function(s): `canRead()`, `canWrite()`, `createDirectory()`, `createFile()`, `delete()`, `exists()`, `getName()`, `getType()`, `getUri()`, `isDirectory()`, `isFile()`, `isVirtual()`, `lastModified()`, `length()`, `listFiles()`, `renameTo()`, `DocumentFile()`, `fromFile()`, `RawDocumentFile()`, `fromSingleUri()`, `if()`, `SingleDocumentFile()`, `fromTreeUri()`, `TreeDocumentFile()`, `isDocumentUri()`, `getParentFile()`, `findFile()`, `for()`
- **`DocumentsContractApi19`** — 19 function(s): `isVirtual()`, `getName()`, `queryForString()`, `getRawType()`, `getType()`, `if()`, `getFlags()`, `queryForLong()`, `isDirectory()`, `isFile()`, `return()`, `lastModified()`, `length()`, `canRead()`, `canWrite()`, `exists()`, `closeQuietly()`, `queryForInt()`, `DocumentsContractApi19()`
- **`FontRequest`** — 9 function(s): `FontRequest()`, `getProviderAuthority()`, `getProviderPackage()`, `getQuery()`, `getCertificates()`, `getCertificatesArrayResId()`, `getIdentifier()`, `toString()`, `for()`
- **`FontsContractCompat`** — 35 function(s): `compare()`, `if()`, `for()`, `onTypefaceRequestFailed()`, `onTypefaceRetrieved()`, `FontsContractCompat()`, `getFontInternal()`, `TypefaceResult()`, `resetCache()`, `getFontSync()`, `call()`, `return()`, `onReply()`, `synchronized()`, `FontInfo()`, `getUri()`, `getTtcIndex()`, `getWeight()`, `isItalic()`, `getResultCode()`, `FontFamilyResult()`, `getStatusCode()`, `getFonts()`, `requestFont()`, `run()`, `switch()`, `buildTypeface()`, `prepareFontData()`, `fetchFonts()`, `getProvider()`, `getCertificates()`, `equalsByteArrayList()`, `convertToByteArrayList()`, `getFontFromProvider()`, `while()`
- **`RawDocumentFile`** — 23 function(s): `isVirtual()`, `RawDocumentFile()`, `super()`, `createFile()`, `if()`, `createDirectory()`, `getUri()`, `getName()`, `getType()`, `getTypeForName()`, `isDirectory()`, `isFile()`, `lastModified()`, `length()`, `canRead()`, `canWrite()`, `delete()`, `deleteContents()`, `exists()`, `listFiles()`, `for()`, `return()`, `renameTo()`
- **`SelfDestructiveThread`** — 16 function(s): `handleMessage()`, `switch()`, `onReply()`, `SelfDestructiveThread()`, `isRunning()`, `synchronized()`, `getGeneration()`, `post()`, `if()`, `postAndReply()`, `run()`, `postAndWait()`, `return()`, `InterruptedException()`, `onInvokeRunnable()`, `onDestruction()`
- **`SingleDocumentFile`** — 19 function(s): `SingleDocumentFile()`, `super()`, `createFile()`, `UnsupportedOperationException()`, `createDirectory()`, `getUri()`, `getName()`, `getType()`, `isDirectory()`, `isFile()`, `isVirtual()`, `lastModified()`, `length()`, `canRead()`, `canWrite()`, `delete()`, `exists()`, `listFiles()`, `renameTo()`
- **`TreeDocumentFile`** — 22 function(s): `TreeDocumentFile()`, `super()`, `createFile()`, `if()`, `createDirectory()`, `getUri()`, `getName()`, `getType()`, `isDirectory()`, `isFile()`, `isVirtual()`, `lastModified()`, `length()`, `canRead()`, `canWrite()`, `delete()`, `exists()`, `listFiles()`, `while()`, `closeQuietly()`, `for()`, `renameTo()`

</details>

### Package `android.support.v4.text`  (7 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `BidiFormatter` | class | — | 494 | 122 |
| `HtmlCompat` | class | — | 52 | 7 |
| `ICUCompat` | class | — | 88 | 15 |
| `PrecomputedTextCompat` | class | Spannable | 445 | 88 |
| `TextDirectionHeuristicCompat` | class | — | 9 | 2 |
| `TextDirectionHeuristicsCompat` | class | TextDirectionHeuristicCompat | 189 | 36 |
| `TextUtilsCompat` | class | — | 77 | 16 |

<details>
<summary><b>Function list for <code>android.support.v4.text</code></b> (click to expand)</summary>

- **`BidiFormatter`** — 30 function(s): `Builder()`, `initialize()`, `stereoReset()`, `if()`, `setTextDirectionHeuristic()`, `getDefaultInstanceFromContext()`, `build()`, `BidiFormatter()`, `getInstance()`, `isRtlContext()`, `getStereoReset()`, `return()`, `markAfter()`, `markBefore()`, `isRtl()`, `unicodeWrap()`, `isRtlLocale()`, `getExitDir()`, `DirectionalityEstimator()`, `getEntryDir()`, `for()`, `while()`, `switch()`, `getCachedDirectionality()`, `dirTypeForward()`, `skipTagForward()`, `dirTypeBackward()`, `skipTagBackward()`, `skipEntityForward()`, `skipEntityBackward()`
- **`HtmlCompat`** — 4 function(s): `fromHtml()`, `if()`, `toHtml()`, `HtmlCompat()`
- **`ICUCompat`** — 7 function(s): `if()`, `IllegalStateException()`, `maximizeAndGetScript()`, `return()`, `getScript()`, `addLikelySubtags()`, `ICUCompat()`
- **`PrecomputedTextCompat`** — 44 function(s): `Builder()`, `if()`, `setBreakStrategy()`, `setHyphenationFrequency()`, `setTextDirection()`, `build()`, `Params()`, `getTextPaint()`, `getTextDirection()`, `getBreakStrategy()`, `getHyphenationFrequency()`, `equals()`, `hashCode()`, `toString()`, `create()`, `PrecomputedTextCompat()`, `while()`, `for()`, `StaticLayout()`, `getPrecomputedText()`, `return()`, `getParams()`, `getParagraphCount()`, `getParagraphStart()`, `getParagraphEnd()`, `findParaIndex()`, `IndexOutOfBoundsException()`, `PrecomputedTextCallback()`, `call()`, `PrecomputedTextFutureTask()`, `super()`, `getTextFuture()`, `synchronized()`, `setSpan()`, `IllegalArgumentException()`, `removeSpan()`, `getSpans()`, `getSpanStart()`, `getSpanEnd()`, `getSpanFlags()`, `nextSpanTransition()`, `length()`, `charAt()`, `subSequence()`
- **`TextDirectionHeuristicCompat`** — 1 function(s): `isRtl()`
- **`TextDirectionHeuristicsCompat`** — 17 function(s): `checkRtl()`, `isRtlText()`, `switch()`, `isRtlTextOrFormat()`, `defaultIsRtl()`, `TextDirectionHeuristicImpl()`, `isRtl()`, `if()`, `IllegalArgumentException()`, `doCheck()`, `TextDirectionHeuristicInternal()`, `super()`, `while()`, `FirstStrong()`, `AnyStrong()`, `TextDirectionHeuristicLocale()`, `TextDirectionHeuristicsCompat()`
- **`TextUtilsCompat`** — 8 function(s): `htmlEncode()`, `if()`, `for()`, `switch()`, `getLayoutDirectionFromLocale()`, `getLayoutDirectionFromFirstChar()`, `return()`, `TextUtilsCompat()`

</details>

### Package `android.support.v4.text.util`  (2 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `FindAddress` | class | — | 247 | 50 |
| `LinkifyCompat` | class | — | 329 | 79 |

<details>
<summary><b>Function list for <code>android.support.v4.text.util</code></b> (click to expand)</summary>

- **`FindAddress`** — 15 function(s): `ZipRange()`, `matches()`, `return()`, `checkHouseNumber()`, `for()`, `if()`, `switch()`, `matchHouseNumber()`, `matchState()`, `isValidZipCode()`, `while()`, `isValidLocationName()`, `attemptMatch()`, `findAddress()`, `FindAddress()`
- **`LinkifyCompat`** — 15 function(s): `compare()`, `if()`, `addLinks()`, `for()`, `gatherLinks()`, `gatherMapLinks()`, `pruneOverlaps()`, `while()`, `applyLink()`, `addLinkMovementMethod()`, `shouldAddLinksFallbackToFramework()`, `makeUrl()`, `findAddress()`, `LinkifyCompat()`, `LinkSpec()`

</details>

### Package `android.support.v4.util`  (20 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ArrayMap` | class | SimpleArrayMap<K, V> implements Map<K, V> | 113 | 29 |
| `ArraySet` | class | Collection<E>, Set<E> | 531 | 135 |
| `AtomicFile` | class | — | 124 | 26 |
| `CircularArray` | class | — | 161 | 50 |
| `CircularIntArray` | class | — | 130 | 42 |
| `Consumer` | class | — | 7 | 1 |
| `ContainerHelpers` | class | — | 72 | 17 |
| `DebugUtils` | class | — | 27 | 4 |
| `LogWriter` | class | Writer | 46 | 11 |
| `LongSparseArray` | class | Cloneable | 250 | 70 |
| `LruCache` | class | — | 204 | 58 |
| `MapCollections` | class | Iterator<T> | 567 | 148 |
| `ObjectsCompat` | class | — | 34 | 7 |
| `Pair` | class | — | 41 | 7 |
| `PatternsCompat` | class | — | 68 | 1 |
| `Pools` | class | Pool<T> | 95 | 21 |
| `Preconditions` | class | — | 213 | 90 |
| `SimpleArrayMap` | class | — | 493 | 125 |
| `SparseArrayCompat` | class | Cloneable | 258 | 73 |
| `TimeUtils` | class | — | 160 | 28 |

<details>
<summary><b>Function list for <code>android.support.v4.util</code></b> (click to expand)</summary>

- **`ArrayMap`** — 23 function(s): `ArrayMap()`, `super()`, `getCollection()`, `if()`, `colGetSize()`, `colGetEntry()`, `colIndexOfKey()`, `colIndexOfValue()`, `colGetMap()`, `colPut()`, `colSetValue()`, `colRemoveAt()`, `colClear()`, `containsAll()`, `putAll()`, `ensureCapacity()`, `for()`, `put()`, `removeAll()`, `retainAll()`, `entrySet()`, `keySet()`, `values()`
- **`ArraySet`** — 42 function(s): `indexOf()`, `if()`, `while()`, `for()`, `indexOfNull()`, `allocArrays()`, `synchronized()`, `freeArrays()`, `ArraySet()`, `this()`, `addAll()`, `clear()`, `ensureCapacity()`, `contains()`, `valueAt()`, `return()`, `isEmpty()`, `add()`, `append()`, `IllegalStateException()`, `remove()`, `removeAt()`, `removeAll()`, `size()`, `toArray()`, `equals()`, `hashCode()`, `toString()`, `getCollection()`, `colGetSize()`, `colGetEntry()`, `colIndexOfKey()`, `colIndexOfValue()`, `colGetMap()`, `UnsupportedOperationException()`, `colPut()`, `colSetValue()`, `colRemoveAt()`, `colClear()`, `iterator()`, `containsAll()`, `retainAll()`
- **`AtomicFile`** — 14 function(s): `AtomicFile()`, `getBaseFile()`, `delete()`, `startWrite()`, `if()`, `FileOutputStream()`, `IOException()`, `finishWrite()`, `sync()`, `failWrite()`, `openRead()`, `FileInputStream()`, `readFully()`, `while()`
- **`CircularArray`** — 20 function(s): `doubleCapacity()`, `if()`, `RuntimeException()`, `CircularArray()`, `this()`, `IllegalArgumentException()`, `addFirst()`, `addLast()`, `popFirst()`, `ArrayIndexOutOfBoundsException()`, `popLast()`, `clear()`, `removeFromStart()`, `for()`, `removeFromEnd()`, `getFirst()`, `getLast()`, `get()`, `size()`, `isEmpty()`
- **`CircularIntArray`** — 19 function(s): `doubleCapacity()`, `if()`, `RuntimeException()`, `CircularIntArray()`, `this()`, `IllegalArgumentException()`, `addFirst()`, `addLast()`, `popFirst()`, `ArrayIndexOutOfBoundsException()`, `popLast()`, `clear()`, `removeFromStart()`, `removeFromEnd()`, `getFirst()`, `getLast()`, `get()`, `size()`, `isEmpty()`
- **`Consumer`** — 1 function(s): `accept()`
- **`ContainerHelpers`** — 9 function(s): `idealByteArraySize()`, `for()`, `if()`, `idealIntArraySize()`, `idealLongArraySize()`, `equal()`, `binarySearch()`, `while()`, `ContainerHelpers()`
- **`DebugUtils`** — 3 function(s): `buildShortClassTag()`, `if()`, `DebugUtils()`
- **`LogWriter`** — 7 function(s): `LogWriter()`, `close()`, `flushBuilder()`, `flush()`, `write()`, `for()`, `if()`
- **`LongSparseArray`** — 26 function(s): `LongSparseArray()`, `this()`, `if()`, `m3clone()`, `AssertionError()`, `get()`, `return()`, `delete()`, `remove()`, `removeAt()`, `gc()`, `for()`, `put()`, `putAll()`, `size()`, `isEmpty()`, `keyAt()`, `valueAt()`, `setValueAt()`, `indexOfKey()`, `indexOfValue()`, `containsKey()`, `containsValue()`, `clear()`, `append()`, `toString()`
- **`LruCache`** — 27 function(s): `create()`, `entryRemoved()`, `sizeOf()`, `LruCache()`, `if()`, `IllegalArgumentException()`, `resize()`, `synchronized()`, `trimToSize()`, `get()`, `NullPointerException()`, `put()`, `while()`, `remove()`, `safeSizeOf()`, `IllegalStateException()`, `evictAll()`, `size()`, `maxSize()`, `hitCount()`, `missCount()`, `createCount()`, `putCount()`, `evictionCount()`, `snapshot()`, `LinkedHashMap()`, `toString()`
- **`MapCollections`** — 49 function(s): `colClear()`, `colGetEntry()`, `colGetMap()`, `colGetSize()`, `colIndexOfKey()`, `colIndexOfValue()`, `colPut()`, `colRemoveAt()`, `colSetValue()`, `ArrayIterator()`, `hasNext()`, `next()`, `if()`, `NoSuchElementException()`, `remove()`, `IllegalStateException()`, `MapIterator()`, `getKey()`, `return()`, `getValue()`, `setValue()`, `equals()`, `hashCode()`, `toString()`, `EntrySet()`, `add()`, `UnsupportedOperationException()`, `addAll()`, `for()`, `clear()`, `contains()`, `containsAll()`, `while()`, `isEmpty()`, `iterator()`, `removeAll()`, `retainAll()`, `size()`, `toArray()`, `KeySet()`, `ValuesCollection()`, `containsAllHelper()`, `removeAllHelper()`, `retainAllHelper()`, `toArrayHelper()`, `equalsSetHelper()`, `getEntrySet()`, `getKeySet()`, `getValues()`
- **`ObjectsCompat`** — 5 function(s): `ObjectsCompat()`, `equals()`, `if()`, `hashCode()`, `hash()`
- **`Pair`** — 7 function(s): `Pair()`, `equals()`, `if()`, `hashCode()`, `return()`, `toString()`, `create()`
- **`PatternsCompat`** — 1 function(s): `PatternsCompat()`
- **`Pools`** — 12 function(s): `acquire()`, `release()`, `Pools()`, `SimplePool()`, `if()`, `IllegalArgumentException()`, `IllegalStateException()`, `isInPool()`, `for()`, `SynchronizedPool()`, `super()`, `synchronized()`
- **`Preconditions`** — 20 function(s): `checkArgument()`, `if()`, `IllegalArgumentException()`, `checkStringNotEmpty()`, `checkNotNull()`, `NullPointerException()`, `checkState()`, `IllegalStateException()`, `checkFlagsArgument()`, `checkArgumentNonnegative()`, `checkArgumentPositive()`, `checkArgumentFinite()`, `checkArgumentInRange()`, `checkArrayElementsNotNull()`, `for()`, `checkCollectionElementsNotNull()`, `while()`, `checkCollectionNotEmpty()`, `checkArrayElementsInRange()`, `Preconditions()`
- **`SimpleArrayMap`** — 32 function(s): `binarySearchHashes()`, `ConcurrentModificationException()`, `indexOf()`, `if()`, `while()`, `for()`, `indexOfNull()`, `allocArrays()`, `synchronized()`, `freeArrays()`, `SimpleArrayMap()`, `this()`, `putAll()`, `clear()`, `ensureCapacity()`, `containsKey()`, `indexOfKey()`, `indexOfValue()`, `containsValue()`, `get()`, `return()`, `keyAt()`, `valueAt()`, `setValueAt()`, `isEmpty()`, `put()`, `remove()`, `removeAt()`, `size()`, `equals()`, `hashCode()`, `toString()`
- **`SparseArrayCompat`** — 28 function(s): `SparseArrayCompat()`, `this()`, `if()`, `m4clone()`, `AssertionError()`, `get()`, `return()`, `delete()`, `remove()`, `removeAt()`, `removeAtRange()`, `while()`, `gc()`, `for()`, `put()`, `putAll()`, `size()`, `isEmpty()`, `keyAt()`, `valueAt()`, `setValueAt()`, `indexOfKey()`, `indexOfValue()`, `containsKey()`, `containsValue()`, `clear()`, `append()`, `toString()`
- **`TimeUtils`** — 9 function(s): `accumField()`, `if()`, `printField()`, `formatDurationLocked()`, `while()`, `for()`, `formatDuration()`, `synchronized()`, `TimeUtils()`

</details>

### Package `android.support.v4.view`  (41 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AbsSavedState` | class | Parcelable | 71 | 16 |
| `AccessibilityDelegateCompat` | class | View.AccessibilityDelegate | 126 | 25 |
| `ActionProvider` | class | — | 93 | 20 |
| `AsyncLayoutInflater` | class | LayoutInflater | 162 | 25 |
| `DisplayCutoutCompat` | class | — | 88 | 28 |
| `GestureDetectorCompat` | class | GestureDetectorCompatImpl | 432 | 75 |
| `GravityCompat` | class | — | 45 | 8 |
| `InputDeviceCompat` | class | — | 30 | 1 |
| `KeyEventDispatcher` | class | — | 125 | 28 |
| `LayoutInflaterCompat` | class | LayoutInflater.Factory2 | 100 | 22 |
| `LayoutInflaterFactory` | class | — | 12 | 1 |
| `MarginLayoutParamsCompat` | class | — | 68 | 17 |
| `MenuCompat` | class | — | 28 | 4 |
| `MenuItemCompat` | class | — | 223 | 57 |
| `MotionEventCompat` | class | — | 229 | 14 |
| `NestedScrollingChild` | class | — | 25 | 9 |
| `NestedScrollingChild2` | class | NestedScrollingChild | 17 | 5 |
| `NestedScrollingChildHelper` | class | — | 202 | 51 |
| `NestedScrollingParent` | class | — | 24 | 8 |
| `NestedScrollingParent2` | class | NestedScrollingParent | 18 | 5 |
| `NestedScrollingParentHelper` | class | — | 36 | 8 |
| `OnApplyWindowInsetsListener` | class | — | 9 | 1 |
| `PagerAdapter` | class | — | 111 | 31 |
| `PagerTabStrip` | class | PagerTitleStrip | 229 | 39 |
| `PagerTitleStrip` | class | ViewGroup | 378 | 71 |
| `PointerIconCompat` | class | — | 67 | 14 |
| `ScaleGestureDetectorCompat` | class | — | 34 | 9 |
| `ScrollingView` | class | — | 17 | 6 |
| `TintableBackgroundView` | class | — | 19 | 4 |
| `VelocityTrackerCompat` | class | — | 21 | 3 |
| `ViewCompat` | class | View.OnUnhandledKeyEventListener | 1,609 | 395 |
| `ViewConfigurationCompat` | class | — | 86 | 18 |
| `ViewGroupCompat` | class | — | 68 | 16 |
| `ViewPager` | class | ViewGroup | 2,339 | 550 |
| `ViewParentCompat` | class | — | 182 | 49 |
| `ViewPropertyAnimatorCompat` | class | ViewPropertyAnimatorListener | 425 | 103 |
| `ViewPropertyAnimatorListener` | class | — | 13 | 3 |
| `ViewPropertyAnimatorListenerAdapter` | class | ViewPropertyAnimatorListener | 19 | 3 |
| `ViewPropertyAnimatorUpdateListener` | class | — | 9 | 1 |
| `WindowCompat` | class | — | 30 | 6 |
| `WindowInsetsCompat` | class | — | 189 | 67 |

<details>
<summary><b>Function list for <code>android.support.v4.view</code></b> (click to expand)</summary>

- **`AbsSavedState`** — 10 function(s): `createFromParcel()`, `if()`, `IllegalStateException()`, `newArray()`, `describeContents()`, `AbsSavedState()`, `IllegalArgumentException()`, `this()`, `getSuperState()`, `writeToParcel()`
- **`AccessibilityDelegateCompat`** — 14 function(s): `AccessibilityDelegateAdapter()`, `dispatchPopulateAccessibilityEvent()`, `onInitializeAccessibilityEvent()`, `onInitializeAccessibilityNodeInfo()`, `onPopulateAccessibilityEvent()`, `onRequestSendAccessibilityEvent()`, `sendAccessibilityEvent()`, `sendAccessibilityEventUnchecked()`, `getAccessibilityNodeProvider()`, `if()`, `return()`, `performAccessibilityAction()`, `getBridge()`, `AccessibilityNodeProviderCompat()`
- **`ActionProvider`** — 16 function(s): `onSubUiVisibilityChanged()`, `onActionProviderVisibilityChanged()`, `hasSubMenu()`, `isVisible()`, `onCreateActionView()`, `onPerformDefaultAction()`, `onPrepareSubMenu()`, `overridesItemVisibility()`, `ActionProvider()`, `getContext()`, `refreshVisibility()`, `if()`, `subUiVisibilityChanged()`, `setSubUiVisibilityListener()`, `setVisibilityListener()`, `reset()`
- **`AsyncLayoutInflater`** — 21 function(s): `handleMessage()`, `if()`, `onInflateFinished()`, `AsyncLayoutInflater()`, `inflate()`, `NullPointerException()`, `InflateRequest()`, `BasicInflater()`, `super()`, `cloneInContext()`, `onCreateView()`, `for()`, `InflateThread()`, `getInstance()`, `runInner()`, `run()`, `while()`, `obtainRequest()`, `releaseRequest()`, `enqueue()`, `RuntimeException()`
- **`DisplayCutoutCompat`** — 13 function(s): `DisplayCutoutCompat()`, `this()`, `getSafeInsetTop()`, `if()`, `return()`, `getSafeInsetBottom()`, `getSafeInsetLeft()`, `getSafeInsetRight()`, `getBoundingRects()`, `equals()`, `hashCode()`, `toString()`, `wrap()`
- **`GestureDetectorCompat`** — 22 function(s): `isLongpressEnabled()`, `onTouchEvent()`, `setIsLongpressEnabled()`, `setOnDoubleTapListener()`, `GestureHandler()`, `super()`, `handleMessage()`, `switch()`, `if()`, `RuntimeException()`, `GestureDetectorCompatImplBase()`, `init()`, `IllegalArgumentException()`, `for()`, `cancel()`, `cancelTaps()`, `isConsideredDoubleTap()`, `return()`, `dispatchLongPress()`, `GestureDetectorCompatImplJellybeanMr2()`, `GestureDetectorCompat()`, `this()`
- **`GravityCompat`** — 5 function(s): `apply()`, `if()`, `applyDisplay()`, `getAbsoluteGravity()`, `GravityCompat()`
- **`InputDeviceCompat`** — 1 function(s): `InputDeviceCompat()`
- **`KeyEventDispatcher`** — 10 function(s): `superDispatchKeyEvent()`, `KeyEventDispatcher()`, `dispatchBeforeHierarchy()`, `dispatchKeyEvent()`, `if()`, `activitySuperDispatchKeyEventPre28()`, `dialogSuperDispatchKeyEventPre28()`, `return()`, `actionBarOnMenuKeyEventPre28()`, `getDialogKeyListenerPre28()`
- **`LayoutInflaterCompat`** — 11 function(s): `Factory2Wrapper()`, `onCreateView()`, `toString()`, `getClass()`, `forceSetFactory2()`, `if()`, `LayoutInflaterCompat()`, `setFactory()`, `setFactory2()`, `getFactory()`, `return()`
- **`LayoutInflaterFactory`** — 1 function(s): `onCreateView()`
- **`MarginLayoutParamsCompat`** — 10 function(s): `getMarginStart()`, `if()`, `getMarginEnd()`, `setMarginStart()`, `setMarginEnd()`, `isMarginRelative()`, `getLayoutDirection()`, `setLayoutDirection()`, `resolveLayoutDirection()`, `MarginLayoutParamsCompat()`
- **`MenuCompat`** — 4 function(s): `setShowAsAction()`, `setGroupDividerEnabled()`, `if()`, `MenuCompat()`
- **`MenuItemCompat`** — 27 function(s): `onMenuItemActionCollapse()`, `onMenuItemActionExpand()`, `setShowAsAction()`, `setActionView()`, `getActionView()`, `setActionProvider()`, `if()`, `return()`, `getActionProvider()`, `expandActionView()`, `collapseActionView()`, `isActionViewExpanded()`, `setOnActionExpandListener()`, `setContentDescription()`, `getContentDescription()`, `setTooltipText()`, `getTooltipText()`, `setShortcut()`, `setNumericShortcut()`, `getNumericModifiers()`, `setAlphabeticShortcut()`, `getAlphabeticModifiers()`, `setIconTintList()`, `getIconTintList()`, `setIconTintMode()`, `getIconTintMode()`, `MenuItemCompat()`
- **`MotionEventCompat`** — 13 function(s): `getActionMasked()`, `getActionIndex()`, `findPointerIndex()`, `getPointerId()`, `getX()`, `getY()`, `getPointerCount()`, `getSource()`, `isFromSource()`, `return()`, `getAxisValue()`, `getButtonState()`, `MotionEventCompat()`
- **`NestedScrollingChild`** — 9 function(s): `dispatchNestedFling()`, `dispatchNestedPreFling()`, `dispatchNestedPreScroll()`, `dispatchNestedScroll()`, `hasNestedScrollingParent()`, `isNestedScrollingEnabled()`, `setNestedScrollingEnabled()`, `startNestedScroll()`, `stopNestedScroll()`
- **`NestedScrollingChild2`** — 5 function(s): `dispatchNestedPreScroll()`, `dispatchNestedScroll()`, `hasNestedScrollingParent()`, `startNestedScroll()`, `stopNestedScroll()`
- **`NestedScrollingChildHelper`** — 18 function(s): `NestedScrollingChildHelper()`, `setNestedScrollingEnabled()`, `if()`, `isNestedScrollingEnabled()`, `hasNestedScrollingParent()`, `getNestedScrollingParentForType()`, `startNestedScroll()`, `for()`, `setNestedScrollingParentForType()`, `stopNestedScroll()`, `dispatchNestedScroll()`, `dispatchNestedPreScroll()`, `return()`, `dispatchNestedFling()`, `dispatchNestedPreFling()`, `onDetachedFromWindow()`, `onStopNestedScroll()`, `switch()`
- **`NestedScrollingParent`** — 8 function(s): `getNestedScrollAxes()`, `onNestedFling()`, `onNestedPreFling()`, `onNestedPreScroll()`, `onNestedScroll()`, `onNestedScrollAccepted()`, `onStartNestedScroll()`, `onStopNestedScroll()`
- **`NestedScrollingParent2`** — 5 function(s): `onNestedPreScroll()`, `onNestedScroll()`, `onNestedScrollAccepted()`, `onStartNestedScroll()`, `onStopNestedScroll()`
- **`NestedScrollingParentHelper`** — 4 function(s): `NestedScrollingParentHelper()`, `onNestedScrollAccepted()`, `getNestedScrollAxes()`, `onStopNestedScroll()`
- **`OnApplyWindowInsetsListener`** — 1 function(s): `onApplyWindowInsets()`
- **`PagerAdapter`** — 19 function(s): `finishUpdate()`, `getCount()`, `getItemPosition()`, `getPageTitle()`, `getPageWidth()`, `isViewFromObject()`, `restoreState()`, `saveState()`, `setPrimaryItem()`, `startUpdate()`, `instantiateItem()`, `destroyItem()`, `UnsupportedOperationException()`, `notifyDataSetChanged()`, `synchronized()`, `if()`, `registerDataSetObserver()`, `unregisterDataSetObserver()`, `setViewPagerObserver()`
- **`PagerTabStrip`** — 22 function(s): `PagerTabStrip()`, `this()`, `super()`, `setPadding()`, `setTextSpacing()`, `setWillNotDraw()`, `onClick()`, `if()`, `setTabIndicatorColor()`, `invalidate()`, `setTabIndicatorColorResource()`, `getTabIndicatorColor()`, `setBackgroundDrawable()`, `setBackgroundColor()`, `setBackgroundResource()`, `setDrawFullUnderline()`, `getDrawFullUnderline()`, `getMinHeight()`, `onTouchEvent()`, `switch()`, `onDraw()`, `updateTextPositions()`
- **`PagerTitleStrip`** — 31 function(s): `SingleLineAllCapsTransform()`, `getTransformation()`, `if()`, `setSingleLineAllCaps()`, `PagerTitleStrip()`, `this()`, `super()`, `addView()`, `setTextSize()`, `setNonPrimaryAlpha()`, `setTextSpacing()`, `requestLayout()`, `getTextSpacing()`, `setTextColor()`, `setGravity()`, `onAttachedToWindow()`, `IllegalStateException()`, `updateAdapter()`, `onDetachedFromWindow()`, `updateText()`, `updateTextPositions()`, `onMeasure()`, `setMeasuredDimension()`, `onLayout()`, `getMinHeight()`, `PageListener()`, `onPageScrolled()`, `onPageSelected()`, `onPageScrollStateChanged()`, `onAdapterChanged()`, `onChanged()`
- **`PointerIconCompat`** — 6 function(s): `PointerIconCompat()`, `getPointerIcon()`, `getSystemIcon()`, `if()`, `create()`, `load()`
- **`ScaleGestureDetectorCompat`** — 4 function(s): `ScaleGestureDetectorCompat()`, `setQuickScaleEnabled()`, `if()`, `isQuickScaleEnabled()`
- **`ScrollingView`** — 6 function(s): `computeHorizontalScrollExtent()`, `computeHorizontalScrollOffset()`, `computeHorizontalScrollRange()`, `computeVerticalScrollExtent()`, `computeVerticalScrollOffset()`, `computeVerticalScrollRange()`
- **`TintableBackgroundView`** — 4 function(s): `getSupportBackgroundTintList()`, `getSupportBackgroundTintMode()`, `setSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`
- **`VelocityTrackerCompat`** — 3 function(s): `getXVelocity()`, `getYVelocity()`, `VelocityTrackerCompat()`
- **`ViewCompat`** — 164 function(s): `onUnhandledKeyEvent()`, `getEmptyTempRect()`, `if()`, `canScrollHorizontally()`, `canScrollVertically()`, `getOverScrollMode()`, `setOverScrollMode()`, `onPopulateAccessibilityEvent()`, `onInitializeAccessibilityEvent()`, `onInitializeAccessibilityNodeInfo()`, `setAccessibilityDelegate()`, `setAutofillHints()`, `getImportantForAutofill()`, `setImportantForAutofill()`, `isImportantForAutofill()`, `hasAccessibilityDelegate()`, `hasTransientState()`, `setHasTransientState()`, `postInvalidateOnAnimation()`, `postOnAnimation()`, `postOnAnimationDelayed()`, `getImportantForAccessibility()`, `setImportantForAccessibility()`, `isImportantForAccessibility()`, `performAccessibilityAction()`, `getAccessibilityNodeProvider()`, `AccessibilityNodeProviderCompat()`, `getAlpha()`, `setLayerType()`, `getLayerType()`, `getLabelFor()`, `setLabelFor()`, `setLayerPaint()`, `getLayoutDirection()`, `setLayoutDirection()`, `getParentForAccessibility()`, `requireViewById()`, `return()`, `IllegalArgumentException()`, `isOpaque()`, `resolveSizeAndState()`, `getMeasuredWidthAndState()`, `getMeasuredHeightAndState()`, `getMeasuredState()`, `combineMeasuredStates()`, `getAccessibilityLiveRegion()`, `setAccessibilityLiveRegion()`, `getPaddingStart()`, `getPaddingEnd()`, `setPaddingRelative()`, `bindTempDetach()`, `dispatchStartTemporaryDetach()`, `dispatchFinishTemporaryDetach()`, `getTranslationX()`, `getTranslationY()`, `getMatrix()`, `getMinimumWidth()`, `getMinimumHeight()`, `animate()`, `setTranslationX()`, `setTranslationY()`, `setAlpha()`, `setX()`, `setY()`, `setRotation()`, `setRotationX()`, `setRotationY()`, `setScaleX()`, `setScaleY()`, `getPivotX()`, `setPivotX()`, `getPivotY()`, `setPivotY()`, `getRotation()`, `getRotationX()`, `getRotationY()`, `getScaleX()`, `getScaleY()`, `getX()`, `getY()`, `setElevation()`, `getElevation()`, `setTranslationZ()`, `getTranslationZ()`, `setTransitionName()`, `getTransitionName()`, `getWindowSystemUiVisibility()`, `requestApplyInsets()`, `setChildrenDrawingOrderEnabled()`, `getFitsSystemWindows()`, `setFitsSystemWindows()`, `jumpDrawablesToCurrentState()`, `setOnApplyWindowInsetsListener()`, `onApplyWindowInsets()`, `dispatchApplyWindowInsets()`, `setSaveFromParentEnabled()`, `setActivated()`, `hasOverlappingRendering()`, `isPaddingRelative()`, `setBackground()`, `getBackgroundTintList()`, `setBackgroundTintList()`, `getBackgroundTintMode()`, `setBackgroundTintMode()`, `setNestedScrollingEnabled()`, `isNestedScrollingEnabled()`, `startNestedScroll()`, `stopNestedScroll()`, `hasNestedScrollingParent()`, `dispatchNestedScroll()`, `dispatchNestedPreScroll()`, `dispatchNestedFling()`, `dispatchNestedPreFling()`, `isInLayout()`, `isLaidOut()`, `isLayoutDirectionResolved()`, `getZ()`, `setZ()`, `offsetTopAndBottom()`, `compatOffsetTopAndBottom()`, `tickleInvalidationFlag()`, `offsetLeftAndRight()`, `compatOffsetLeftAndRight()`, `setClipBounds()`, `getClipBounds()`, `isAttachedToWindow()`, `hasOnClickListeners()`, `setScrollIndicators()`, `getScrollIndicators()`, `setPointerIcon()`, `getDisplay()`, `setTooltipText()`, `startDragAndDrop()`, `cancelDragAndDrop()`, `updateDragShadow()`, `getNextClusterForwardId()`, `setNextClusterForwardId()`, `isKeyboardNavigationCluster()`, `setKeyboardNavigationCluster()`, `isFocusedByDefault()`, `setFocusedByDefault()`, `keyboardNavigationClusterSearch()`, `addKeyboardNavigationClusters()`, `restoreDefaultFocus()`, `hasExplicitFocusable()`, `generateViewId()`, `addOnUnhandledKeyEventListener()`, `removeOnUnhandledKeyEventListener()`, `ViewCompat()`, `OnUnhandledKeyEventListenerWrapper()`, `dispatchUnhandledKeyEventBeforeHierarchy()`, `dispatchUnhandledKeyEventBeforeCallback()`, `UnhandledKeyEventManager()`, `getCapturedKeys()`, `at()`, `dispatch()`, `recalcViewsWithUnhandled()`, `dispatchInOrder()`, `for()`, `preDispatch()`, `registerListeningView()`, `synchronized()`, `while()`, `unregisterListeningView()`
- **`ViewConfigurationCompat`** — 10 function(s): `if()`, `getScaledPagingTouchSlop()`, `hasPermanentMenuKey()`, `getScaledHorizontalScrollFactor()`, `getLegacyScrollFactor()`, `getScaledVerticalScrollFactor()`, `return()`, `getScaledHoverSlop()`, `shouldShowMenuShortcutsWhenKeyboardPresent()`, `ViewConfigurationCompat()`
- **`ViewGroupCompat`** — 10 function(s): `ViewGroupCompat()`, `onRequestSendAccessibilityEvent()`, `setMotionEventSplittingEnabled()`, `getLayoutMode()`, `if()`, `setLayoutMode()`, `setTransitionGroup()`, `isTransitionGroup()`, `return()`, `getNestedScrollAxes()`
- **`ViewPager`** — 133 function(s): `compare()`, `getInterpolation()`, `return()`, `onAdapterChanged()`, `onPageScrollStateChanged()`, `onPageScrolled()`, `onPageSelected()`, `transformPage()`, `ItemInfo()`, `ViewPager()`, `super()`, `run()`, `initViewPager()`, `setWillNotDraw()`, `setDescendantFocusability()`, `setFocusable()`, `if()`, `onApplyWindowInsets()`, `for()`, `onDetachedFromWindow()`, `removeCallbacks()`, `setScrollState()`, `enableLayers()`, `dispatchOnScrollStateChanged()`, `setAdapter()`, `removeNonDecorViews()`, `scrollTo()`, `setCurrentItemInternal()`, `populate()`, `requestLayout()`, `while()`, `removeViewAt()`, `getAdapter()`, `addOnAdapterChangeListener()`, `removeOnAdapterChangeListener()`, `getClientWidth()`, `setCurrentItem()`, `getCurrentItem()`, `setScrollingCacheEnabled()`, `dispatchOnPageSelected()`, `scrollToItem()`, `smoothScrollTo()`, `completeScroll()`, `pageScrolled()`, `setOnPageChangeListener()`, `addOnPageChangeListener()`, `removeOnPageChangeListener()`, `clearOnPageChangeListeners()`, `setPageTransformer()`, `setChildrenDrawingOrderEnabled()`, `getChildDrawingOrder()`, `setInternalPageChangeListener()`, `getOffscreenPageLimit()`, `setOffscreenPageLimit()`, `setPageMargin()`, `recomputeScrollPosition()`, `getPageMargin()`, `setPageMarginDrawable()`, `refreshDrawableState()`, `invalidate()`, `verifyDrawable()`, `drawableStateChanged()`, `distanceInfluenceForSnapDuration()`, `addNewItem()`, `dataSetChanged()`, `sortChildDrawingOrder()`, `IllegalStateException()`, `calculatePageOffsets()`, `createFromParcel()`, `SavedState()`, `newArray()`, `writeToParcel()`, `toString()`, `onSaveInstanceState()`, `onRestoreInstanceState()`, `addView()`, `addViewInLayout()`, `isDecorView()`, `removeView()`, `removeViewInLayout()`, `infoForChild()`, `infoForAnyChild()`, `infoForPosition()`, `onAttachedToWindow()`, `onMeasure()`, `setMeasuredDimension()`, `onSizeChanged()`, `onLayout()`, `computeScroll()`, `dispatchOnPageScrolled()`, `isGutterDrag()`, `getChildAt()`, `onInterceptTouchEvent()`, `resetTouch()`, `requestParentDisallowInterceptTouchEvent()`, `onSecondaryPointerUp()`, `onTouchEvent()`, `switch()`, `endDrag()`, `performDrag()`, `infoForCurrentScrollPosition()`, `determineTargetPage()`, `draw()`, `onDraw()`, `beginFakeDrag()`, `endFakeDrag()`, `fakeDragBy()`, `isFakeDragging()`, `canScrollHorizontally()`, `canScroll()`, `dispatchKeyEvent()`, `executeKeyEvent()`, `pageLeft()`, `arrowScroll()`, `pageRight()`, `playSoundEffect()`, `getChildRectInPagerCoordinates()`, `addFocusables()`, `addTouchables()`, `onRequestFocusInDescendants()`, `dispatchPopulateAccessibilityEvent()`, `generateDefaultLayoutParams()`, `LayoutParams()`, `generateLayoutParams()`, `checkLayoutParams()`, `MyAccessibilityDelegate()`, `onInitializeAccessibilityEvent()`, `onInitializeAccessibilityNodeInfo()`, `performAccessibilityAction()`, `PagerObserver()`, `onChanged()`, `onInvalidated()`, `ViewPositionComparator()`
- **`ViewParentCompat`** — 12 function(s): `ViewParentCompat()`, `requestSendAccessibilityEvent()`, `onStartNestedScroll()`, `onNestedScrollAccepted()`, `onStopNestedScroll()`, `onNestedScroll()`, `onNestedPreScroll()`, `if()`, `return()`, `onNestedFling()`, `onNestedPreFling()`, `notifySubtreeAccessibilityStateChanged()`
- **`ViewPropertyAnimatorCompat`** — 46 function(s): `ViewPropertyAnimatorCompat()`, `ViewPropertyAnimatorListenerApi14()`, `onAnimationStart()`, `if()`, `onAnimationEnd()`, `onAnimationCancel()`, `setDuration()`, `alpha()`, `alphaBy()`, `translationX()`, `translationY()`, `withEndAction()`, `setListenerInternal()`, `getDuration()`, `setInterpolator()`, `getInterpolator()`, `return()`, `setStartDelay()`, `getStartDelay()`, `rotation()`, `rotationBy()`, `rotationX()`, `rotationXBy()`, `rotationY()`, `rotationYBy()`, `scaleX()`, `scaleXBy()`, `scaleY()`, `scaleYBy()`, `cancel()`, `x()`, `xBy()`, `y()`, `yBy()`, `translationXBy()`, `translationYBy()`, `translationZBy()`, `translationZ()`, `z()`, `zBy()`, `start()`, `withLayer()`, `withStartAction()`, `setListener()`, `setUpdateListener()`, `onAnimationUpdate()`
- **`ViewPropertyAnimatorListener`** — 3 function(s): `onAnimationCancel()`, `onAnimationEnd()`, `onAnimationStart()`
- **`ViewPropertyAnimatorListenerAdapter`** — 3 function(s): `onAnimationCancel()`, `onAnimationEnd()`, `onAnimationStart()`
- **`ViewPropertyAnimatorUpdateListener`** — 1 function(s): `onAnimationUpdate()`
- **`WindowCompat`** — 5 function(s): `WindowCompat()`, `requireViewById()`, `if()`, `return()`, `IllegalArgumentException()`
- **`WindowInsetsCompat`** — 25 function(s): `WindowInsetsCompat()`, `if()`, `getSystemWindowInsetLeft()`, `return()`, `getSystemWindowInsetTop()`, `getSystemWindowInsetRight()`, `getSystemWindowInsetBottom()`, `hasSystemWindowInsets()`, `hasInsets()`, `isConsumed()`, `isRound()`, `consumeSystemWindowInsets()`, `replaceSystemWindowInsets()`, `getStableInsetTop()`, `getStableInsetLeft()`, `getStableInsetRight()`, `getStableInsetBottom()`, `hasStableInsets()`, `consumeStableInsets()`, `getDisplayCutout()`, `consumeDisplayCutout()`, `equals()`, `hashCode()`, `wrap()`, `unwrap()`

</details>

### Package `android.support.v4.view.accessibility`  (6 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AccessibilityEventCompat` | class | — | 109 | 19 |
| `AccessibilityManagerCompat` | class | AccessibilityStateChangeListener | 135 | 26 |
| `AccessibilityNodeInfoCompat` | class | — | 1,263 | 346 |
| `AccessibilityNodeProviderCompat` | class | AccessibilityNodeProvider | 109 | 19 |
| `AccessibilityRecordCompat` | class | — | 313 | 72 |
| `AccessibilityWindowInfoCompat` | class | — | 204 | 59 |

<details>
<summary><b>Function list for <code>android.support.v4.view.accessibility</code></b> (click to expand)</summary>

- **`AccessibilityEventCompat`** — 13 function(s): `AccessibilityEventCompat()`, `getRecordCount()`, `appendRecord()`, `getRecord()`, `AccessibilityRecordCompat()`, `asRecord()`, `setContentChangeTypes()`, `if()`, `getContentChangeTypes()`, `setMovementGranularity()`, `getMovementGranularity()`, `setAction()`, `getAction()`
- **`AccessibilityManagerCompat`** — 15 function(s): `onAccessibilityStateChanged()`, `onTouchExplorationStateChanged()`, `addAccessibilityStateChangeListener()`, `if()`, `removeAccessibilityStateChangeListener()`, `AccessibilityStateChangeListenerWrapper()`, `hashCode()`, `equals()`, `getInstalledAccessibilityServiceList()`, `getEnabledAccessibilityServiceList()`, `isTouchExplorationEnabled()`, `addTouchExplorationStateChangeListener()`, `removeTouchExplorationStateChangeListener()`, `TouchExplorationStateChangeListenerWrapper()`, `AccessibilityManagerCompat()`
- **`AccessibilityNodeInfoCompat`** — 153 function(s): `getActionSymbolicName()`, `switch()`, `AccessibilityActionCompat()`, `this()`, `getId()`, `if()`, `return()`, `getLabel()`, `obtain()`, `CollectionInfoCompat()`, `getColumnCount()`, `getRowCount()`, `isHierarchical()`, `getSelectionMode()`, `CollectionItemInfoCompat()`, `getColumnIndex()`, `getColumnSpan()`, `getRowIndex()`, `getRowSpan()`, `isHeading()`, `isSelected()`, `RangeInfoCompat()`, `getCurrent()`, `getMax()`, `getMin()`, `getType()`, `wrapNonNullInstance()`, `AccessibilityNodeInfoCompat()`, `wrap()`, `unwrap()`, `getInfo()`, `setSource()`, `findFocus()`, `focusSearch()`, `getWindowId()`, `getChildCount()`, `getChild()`, `addChild()`, `removeChild()`, `getActions()`, `addAction()`, `removeAction()`, `performAction()`, `setMovementGranularities()`, `getMovementGranularities()`, `findAccessibilityNodeInfosByText()`, `for()`, `getParent()`, `setParent()`, `getBoundsInParent()`, `setBoundsInParent()`, `getBoundsInScreen()`, `setBoundsInScreen()`, `isCheckable()`, `setCheckable()`, `isChecked()`, `setChecked()`, `isFocusable()`, `setFocusable()`, `isFocused()`, `setFocused()`, `isVisibleToUser()`, `setVisibleToUser()`, `isAccessibilityFocused()`, `setAccessibilityFocused()`, `setSelected()`, `isClickable()`, `setClickable()`, `isLongClickable()`, `setLongClickable()`, `isEnabled()`, `setEnabled()`, `isPassword()`, `setPassword()`, `isScrollable()`, `setScrollable()`, `isImportantForAccessibility()`, `setImportantForAccessibility()`, `getPackageName()`, `setPackageName()`, `getClassName()`, `setClassName()`, `getText()`, `setText()`, `getContentDescription()`, `setContentDescription()`, `recycle()`, `setViewIdResourceName()`, `getViewIdResourceName()`, `getLiveRegion()`, `setLiveRegion()`, `getDrawingOrder()`, `setDrawingOrder()`, `getCollectionInfo()`, `setCollectionInfo()`, `setCollectionItemInfo()`, `getCollectionItemInfo()`, `getRangeInfo()`, `setRangeInfo()`, `getActionList()`, `setContentInvalid()`, `isContentInvalid()`, `isContextClickable()`, `setContextClickable()`, `getHintText()`, `setHintText()`, `setError()`, `getError()`, `setLabelFor()`, `getLabelFor()`, `setLabeledBy()`, `getLabeledBy()`, `canOpenPopup()`, `setCanOpenPopup()`, `findAccessibilityNodeInfosByViewId()`, `while()`, `getExtras()`, `Bundle()`, `getInputType()`, `setInputType()`, `setMaxTextLength()`, `getMaxTextLength()`, `setTextSelection()`, `getTextSelectionStart()`, `getTextSelectionEnd()`, `getTraversalBefore()`, `setTraversalBefore()`, `getTraversalAfter()`, `setTraversalAfter()`, `getWindow()`, `isDismissable()`, `setDismissable()`, `isEditable()`, `setEditable()`, `isMultiLine()`, `setMultiLine()`, `getTooltipText()`, `setTooltipText()`, `setPaneTitle()`, `getPaneTitle()`, `isScreenReaderFocusable()`, `getBooleanProperty()`, `setScreenReaderFocusable()`, `setBooleanProperty()`, `isShowingHintText()`, `setShowingHintText()`, `setHeading()`, `refresh()`, `getRoleDescription()`, `setRoleDescription()`, `hashCode()`, `equals()`, `toString()`
- **`AccessibilityNodeProviderCompat`** — 11 function(s): `createAccessibilityNodeInfo()`, `findAccessibilityNodeInfosByText()`, `findFocus()`, `performAction()`, `AccessibilityNodeProviderApi16()`, `if()`, `for()`, `AccessibilityNodeProviderApi19()`, `super()`, `AccessibilityNodeProviderCompat()`, `getProvider()`
- **`AccessibilityRecordCompat`** — 49 function(s): `AccessibilityRecordCompat()`, `getImpl()`, `obtain()`, `setSource()`, `if()`, `getSource()`, `getWindowId()`, `isChecked()`, `setChecked()`, `isEnabled()`, `setEnabled()`, `isPassword()`, `setPassword()`, `isFullScreen()`, `setFullScreen()`, `isScrollable()`, `setScrollable()`, `getItemCount()`, `setItemCount()`, `getCurrentItemIndex()`, `setCurrentItemIndex()`, `getFromIndex()`, `setFromIndex()`, `getToIndex()`, `setToIndex()`, `getScrollX()`, `setScrollX()`, `getScrollY()`, `setScrollY()`, `getMaxScrollX()`, `setMaxScrollX()`, `getMaxScrollY()`, `setMaxScrollY()`, `getAddedCount()`, `setAddedCount()`, `getRemovedCount()`, `setRemovedCount()`, `getClassName()`, `setClassName()`, `getText()`, `getBeforeText()`, `setBeforeText()`, `getContentDescription()`, `setContentDescription()`, `getParcelableData()`, `setParcelableData()`, `recycle()`, `hashCode()`, `equals()`
- **`AccessibilityWindowInfoCompat`** — 24 function(s): `typeToString()`, `switch()`, `wrapNonNullInstance()`, `if()`, `AccessibilityWindowInfoCompat()`, `getType()`, `return()`, `getLayer()`, `getRoot()`, `getParent()`, `getId()`, `getBoundsInScreen()`, `isActive()`, `isFocused()`, `isAccessibilityFocused()`, `getChildCount()`, `getChild()`, `getTitle()`, `getAnchor()`, `obtain()`, `recycle()`, `hashCode()`, `equals()`, `toString()`

</details>

### Package `android.support.v4.view.animation`  (6 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `FastOutLinearInInterpolator` | class | LookupTableInterpolator | 16 | 2 |
| `FastOutSlowInInterpolator` | class | LookupTableInterpolator | 16 | 2 |
| `LinearOutSlowInInterpolator` | class | LookupTableInterpolator | 16 | 2 |
| `LookupTableInterpolator` | class | Interpolator | 28 | 4 |
| `PathInterpolatorApi14` | class | Interpolator | 79 | 14 |
| `PathInterpolatorCompat` | class | — | 34 | 13 |

<details>
<summary><b>Function list for <code>android.support.v4.view.animation</code></b> (click to expand)</summary>

- **`FastOutLinearInInterpolator`** — 2 function(s): `FastOutLinearInInterpolator()`, `super()`
- **`FastOutSlowInInterpolator`** — 2 function(s): `FastOutSlowInInterpolator()`, `super()`
- **`LinearOutSlowInInterpolator`** — 2 function(s): `LinearOutSlowInInterpolator()`, `super()`
- **`LookupTableInterpolator`** — 3 function(s): `LookupTableInterpolator()`, `getInterpolation()`, `if()`
- **`PathInterpolatorApi14`** — 8 function(s): `PathInterpolatorApi14()`, `for()`, `this()`, `getInterpolation()`, `if()`, `while()`, `createQuad()`, `createCubic()`
- **`PathInterpolatorCompat`** — 5 function(s): `PathInterpolatorCompat()`, `create()`, `if()`, `PathInterpolator()`, `PathInterpolatorApi14()`

</details>

### Package `android.support.v4.widget`  (31 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AutoScrollHelper` | class | View.OnTouchListener | 412 | 89 |
| `AutoSizeableTextView` | class | — | 34 | 8 |
| `CircleImageView` | class | ImageView | 126 | 24 |
| `CircularProgressDrawable` | class | Drawable implements Animatable | 595 | 127 |
| `CompoundButtonCompat` | class | — | 89 | 18 |
| `ContentLoadingProgressBar` | class | ProgressBar | 93 | 24 |
| `CursorAdapter` | class | BaseAdapter implements Filterable, CursorFilter.CursorFilterClient | 282 | 65 |
| `CursorFilter` | class | Filter | 54 | 10 |
| `DirectedAcyclicGraph` | class | — | 131 | 32 |
| `DrawerLayout` | class | ViewGroup | 1,684 | 415 |
| `EdgeEffectCompat` | class | — | 70 | 12 |
| `ExploreByTouchHelper` | class | AccessibilityDelegateCompat | 555 | 160 |
| `FocusStrategy` | class | Comparator<T> | 266 | 81 |
| `ImageViewCompat` | class | — | 86 | 21 |
| `ListPopupWindowCompat` | class | — | 27 | 5 |
| `ListViewAutoScrollHelper` | class | AutoScrollHelper | 50 | 10 |
| `ListViewCompat` | class | — | 41 | 8 |
| `NestedScrollView` | class | FrameLayout implements NestedScrollingParent2, NestedScrollingChild2, ScrollingView | 1,445 | 362 |
| `PopupMenuCompat` | class | — | 22 | 4 |
| `PopupWindowCompat` | class | — | 131 | 24 |
| `ResourceCursorAdapter` | class | CursorAdapter | 56 | 10 |
| `ScrollerCompat` | class | — | 106 | 20 |
| `SimpleCursorAdapter` | class | ResourceCursorAdapter | 153 | 36 |
| `SlidingPaneLayout` | class | ViewGroup | 1,204 | 257 |
| `Space` | class | View | 53 | 14 |
| `SwipeRefreshLayout` | class | ViewGroup implements NestedScrollingParent, NestedScrollingChild | 853 | 199 |
| `TextViewCompat` | class | ActionMode.Callback | 554 | 123 |
| `TintableCompoundButton` | class | — | 19 | 4 |
| `TintableImageSourceView` | class | — | 21 | 4 |
| `ViewDragHelper` | class | — | 860 | 217 |
| `ViewGroupUtils` | class | — | 57 | 11 |

<details>
<summary><b>Function list for <code>android.support.v4.widget</code></b> (click to expand)</summary>

- **`AutoScrollHelper`** — 43 function(s): `constrain()`, `canTargetScrollHorizontally()`, `canTargetScrollVertically()`, `scrollTargetBy()`, `AutoScrollHelper()`, `setMaximumVelocity()`, `setMinimumVelocity()`, `setEdgeType()`, `setMaximumEdges()`, `setRelativeEdges()`, `setRelativeVelocity()`, `setActivationDelay()`, `setRampUpDuration()`, `setRampDownDuration()`, `setEnabled()`, `if()`, `requestStop()`, `isEnabled()`, `setExclusive()`, `isExclusive()`, `onTouch()`, `switch()`, `startAnimating()`, `shouldAnimate()`, `return()`, `computeTargetVelocity()`, `getEdgeValue()`, `constrainEdgeValue()`, `cancelTargetTouch()`, `ScrollAnimationRunnable()`, `run()`, `interpolateValue()`, `ClampedScroller()`, `start()`, `isFinished()`, `getValueAt()`, `computeScrollDelta()`, `RuntimeException()`, `setTargetVelocity()`, `getHorizontalDirection()`, `getVerticalDirection()`, `getDeltaX()`, `getDeltaY()`
- **`AutoSizeableTextView`** — 8 function(s): `getAutoSizeMaxTextSize()`, `getAutoSizeMinTextSize()`, `getAutoSizeStepGranularity()`, `getAutoSizeTextAvailableSizes()`, `getAutoSizeTextType()`, `setAutoSizeTextTypeUniformWithConfiguration()`, `setAutoSizeTextTypeUniformWithPresetSizes()`, `setAutoSizeTextTypeWithDefaults()`
- **`CircleImageView`** — 17 function(s): `CircleImageView()`, `super()`, `if()`, `setLayerType()`, `setPadding()`, `elevationSupported()`, `onMeasure()`, `setMeasuredDimension()`, `setAnimationListener()`, `onAnimationStart()`, `onAnimationEnd()`, `setBackgroundColorRes()`, `setBackgroundColor()`, `OvalShadow()`, `updateRadialGradient()`, `onResize()`, `draw()`
- **`CircularProgressDrawable`** — 67 function(s): `evaluateColorChange()`, `return()`, `getOpacity()`, `CircularProgressDrawable()`, `setStrokeWidth()`, `setupAnimators()`, `setSizeParameters()`, `setStyle()`, `if()`, `invalidateSelf()`, `getStrokeWidth()`, `getCenterRadius()`, `setCenterRadius()`, `setStrokeCap()`, `getStrokeCap()`, `getArrowWidth()`, `getArrowHeight()`, `setArrowDimensions()`, `getArrowEnabled()`, `setArrowEnabled()`, `getArrowScale()`, `setArrowScale()`, `getStartTrim()`, `getEndTrim()`, `setStartEndTrim()`, `getProgressRotation()`, `setProgressRotation()`, `getBackgroundColor()`, `setBackgroundColor()`, `getColorSchemeColors()`, `setColorSchemeColors()`, `draw()`, `setAlpha()`, `getAlpha()`, `setColorFilter()`, `setRotation()`, `getRotation()`, `isRunning()`, `start()`, `stop()`, `updateRingColor()`, `applyFinishTranslation()`, `applyTransformation()`, `onAnimationUpdate()`, `onAnimationCancel()`, `onAnimationEnd()`, `onAnimationStart()`, `onAnimationRepeat()`, `Ring()`, `drawTriangle()`, `setColors()`, `setColorIndex()`, `getColors()`, `setColor()`, `getNextColor()`, `getNextColorIndex()`, `goToNextColor()`, `setStartTrim()`, `getStartingStartTrim()`, `getStartingEndTrim()`, `getStartingColor()`, `setEndTrim()`, `setShowArrow()`, `getShowArrow()`, `getStartingRotation()`, `storeOriginals()`, `resetOriginals()`
- **`CompoundButtonCompat`** — 8 function(s): `CompoundButtonCompat()`, `setButtonTintList()`, `if()`, `getButtonTintList()`, `return()`, `setButtonTintMode()`, `getButtonTintMode()`, `getButtonDrawable()`
- **`ContentLoadingProgressBar`** — 12 function(s): `ContentLoadingProgressBar()`, `this()`, `super()`, `run()`, `if()`, `onAttachedToWindow()`, `removeCallbacks()`, `onDetachedFromWindow()`, `hide()`, `postDelayed()`, `setVisibility()`, `show()`
- **`CursorAdapter`** — 31 function(s): `bindView()`, `hasStableIds()`, `newView()`, `CursorAdapter()`, `init()`, `if()`, `getCursor()`, `getCount()`, `getItem()`, `getItemId()`, `getView()`, `IllegalStateException()`, `getDropDownView()`, `newDropDownView()`, `changeCursor()`, `swapCursor()`, `notifyDataSetChanged()`, `notifyDataSetInvalidated()`, `convertToString()`, `runQueryOnBackgroundThread()`, `getFilter()`, `getFilterQueryProvider()`, `setFilterQueryProvider()`, `onContentChanged()`, `deliverSelfNotifications()`, `ChangeObserver()`, `super()`, `onChange()`, `MyDataSetObserver()`, `onChanged()`, `onInvalidated()`
- **`CursorFilter`** — 9 function(s): `changeCursor()`, `convertToString()`, `getCursor()`, `runQueryOnBackgroundThread()`, `CursorFilter()`, `convertResultToString()`, `performFiltering()`, `if()`, `publishResults()`
- **`DirectedAcyclicGraph`** — 16 function(s): `addNode()`, `if()`, `contains()`, `addEdge()`, `IllegalArgumentException()`, `getIncomingEdges()`, `getOutgoingEdges()`, `for()`, `hasOutgoingEdges()`, `clear()`, `poolList()`, `getSortedList()`, `dfs()`, `RuntimeException()`, `size()`, `getEmptyList()`
- **`DrawerLayout`** — 125 function(s): `onDrawerClosed()`, `onDrawerOpened()`, `onDrawerSlide()`, `onDrawerStateChanged()`, `DrawerLayout()`, `this()`, `super()`, `setDescendantFocusability()`, `setFocusableInTouchMode()`, `setMotionEventSplittingEnabled()`, `if()`, `setOnApplyWindowInsetsListener()`, `onApplyWindowInsets()`, `setSystemUiVisibility()`, `setDrawerElevation()`, `for()`, `getDrawerElevation()`, `setChildInsets()`, `setWillNotDraw()`, `requestLayout()`, `setDrawerShadow()`, `resolveShadowDrawables()`, `invalidate()`, `setScrimColor()`, `setDrawerListener()`, `removeDrawerListener()`, `addDrawerListener()`, `setDrawerLockMode()`, `switch()`, `closeDrawer()`, `openDrawer()`, `IllegalArgumentException()`, `getDrawerLockMode()`, `setDrawerTitle()`, `getDrawerTitle()`, `isInBoundsOfChild()`, `dispatchTransformedGenericPointerEvent()`, `getTransformedMotionEvent()`, `updateDrawerState()`, `dispatchOnDrawerClosed()`, `dispatchOnDrawerOpened()`, `updateChildrenImportantForAccessibility()`, `sendAccessibilityEvent()`, `dispatchOnDrawerSlide()`, `setDrawerViewOffset()`, `getDrawerViewOffset()`, `return()`, `getDrawerViewAbsoluteGravity()`, `checkDrawerViewAbsoluteGravity()`, `findOpenDrawer()`, `moveDrawerToOffset()`, `findDrawerWithGravity()`, `gravityToString()`, `onDetachedFromWindow()`, `onAttachedToWindow()`, `onMeasure()`, `setMeasuredDimension()`, `while()`, `IllegalStateException()`, `resolveLeftShadow()`, `mirror()`, `resolveRightShadow()`, `onLayout()`, `computeScroll()`, `hasOpaqueBackground()`, `setStatusBarBackground()`, `getStatusBarBackgroundDrawable()`, `setStatusBarBackgroundColor()`, `onRtlPropertiesChanged()`, `onDraw()`, `drawChild()`, `isContentView()`, `isDrawerView()`, `onInterceptTouchEvent()`, `closeDrawers()`, `dispatchGenericMotionEvent()`, `onTouchEvent()`, `requestDisallowInterceptTouchEvent()`, `isDrawerOpen()`, `isDrawerVisible()`, `hasPeekingDrawer()`, `generateDefaultLayoutParams()`, `LayoutParams()`, `generateLayoutParams()`, `checkLayoutParams()`, `addFocusables()`, `hasVisibleDrawer()`, `findVisibleDrawer()`, `cancelChildViewTouch()`, `getChildAt()`, `onKeyDown()`, `onKeyUp()`, `onRestoreInstanceState()`, `onSaveInstanceState()`, `addView()`, `includeChildForAccessibility()`, `createFromParcel()`, `SavedState()`, `newArray()`, `writeToParcel()`, `run()`, `onEdgeLock()`, `ViewDragCallback()`, `setDragger()`, `removeCallbacks()`, `tryCaptureView()`, `onViewDragStateChanged()`, `onViewPositionChanged()`, `onViewCaptured()`, `closeOtherDrawer()`, `onViewReleased()`, `onEdgeTouched()`, `peekDrawer()`, `onEdgeDragStarted()`, `getViewHorizontalDragRange()`, `clampViewPositionHorizontal()`, `clampViewPositionVertical()`, `AccessibilityDelegate()`, `onInitializeAccessibilityNodeInfo()`, `copyNodeInfoNoChildren()`, `addChildrenForAccessibility()`, `onInitializeAccessibilityEvent()`, `dispatchPopulateAccessibilityEvent()`, `onRequestSendAccessibilityEvent()`, `ChildAccessibilityDelegate()`
- **`EdgeEffectCompat`** — 9 function(s): `EdgeEffectCompat()`, `setSize()`, `isFinished()`, `finish()`, `onPull()`, `if()`, `onRelease()`, `onAbsorb()`, `draw()`
- **`ExploreByTouchHelper`** — 54 function(s): `obtainBounds()`, `get()`, `size()`, `keyToDirection()`, `switch()`, `getVirtualViewAt()`, `getVisibleVirtualViews()`, `onPerformActionForVirtualView()`, `onPopulateEventForHost()`, `onPopulateEventForVirtualView()`, `onPopulateNodeForHost()`, `onPopulateNodeForVirtualView()`, `onVirtualViewKeyboardFocusChanged()`, `ExploreByTouchHelper()`, `if()`, `IllegalArgumentException()`, `getAccessibilityNodeProvider()`, `dispatchHoverEvent()`, `updateHoveredVirtualView()`, `dispatchKeyEvent()`, `while()`, `clickKeyboardFocusedVirtualView()`, `moveFocus()`, `onFocusChanged()`, `clearKeyboardFocusForVirtualView()`, `getAccessibilityFocusedVirtualViewId()`, `getKeyboardFocusedVirtualViewId()`, `getBoundsInParent()`, `obtainAccessibilityNodeInfo()`, `guessPreviouslyFocusedRect()`, `requestKeyboardFocusForVirtualView()`, `getAllNodes()`, `for()`, `sendEventForVirtualView()`, `invalidateRoot()`, `invalidateVirtualView()`, `getFocusedVirtualView()`, `createEvent()`, `createEventForHost()`, `createEventForChild()`, `onInitializeAccessibilityEvent()`, `RuntimeException()`, `createNodeForHost()`, `createNodeForChild()`, `onInitializeAccessibilityNodeInfo()`, `performAction()`, `performActionForHost()`, `performActionForChild()`, `requestAccessibilityFocus()`, `clearAccessibilityFocus()`, `isVisibleToUser()`, `MyNodeProvider()`, `createAccessibilityNodeInfo()`, `findFocus()`
- **`FocusStrategy`** — 26 function(s): `obtainBounds()`, `get()`, `size()`, `getWeightedDistanceFor()`, `return()`, `findNextFocusInRelativeDirection()`, `for()`, `switch()`, `IllegalArgumentException()`, `getNextFocusable()`, `if()`, `getPreviousFocusable()`, `SequentialComparator()`, `compare()`, `findNextFocusInAbsoluteDirection()`, `isBetterCandidate()`, `beamBeats()`, `isCandidate()`, `beamsOverlap()`, `isToDirectionOf()`, `majorAxisDistance()`, `majorAxisDistanceRaw()`, `majorAxisDistanceToFarEdge()`, `majorAxisDistanceToFarEdgeRaw()`, `minorAxisDistance()`, `FocusStrategy()`
- **`ImageViewCompat`** — 7 function(s): `getImageTintList()`, `if()`, `return()`, `setImageTintList()`, `getImageTintMode()`, `setImageTintMode()`, `ImageViewCompat()`
- **`ListPopupWindowCompat`** — 3 function(s): `ListPopupWindowCompat()`, `createDragToOpenListener()`, `if()`
- **`ListViewAutoScrollHelper`** — 6 function(s): `canTargetScrollHorizontally()`, `ListViewAutoScrollHelper()`, `super()`, `scrollTargetBy()`, `canTargetScrollVertically()`, `if()`
- **`ListViewCompat`** — 4 function(s): `scrollListBy()`, `if()`, `canScrollList()`, `ListViewCompat()`
- **`NestedScrollView`** — 109 function(s): `onScrollChange()`, `clamp()`, `if()`, `onStartNestedScroll()`, `return()`, `shouldDelayChildPressedState()`, `NestedScrollView()`, `this()`, `super()`, `initScrollView()`, `setFillViewport()`, `setNestedScrollingEnabled()`, `startNestedScroll()`, `stopNestedScroll()`, `hasNestedScrollingParent()`, `dispatchNestedScroll()`, `dispatchNestedPreScroll()`, `isNestedScrollingEnabled()`, `dispatchNestedFling()`, `dispatchNestedPreFling()`, `onNestedScrollAccepted()`, `onStopNestedScroll()`, `onNestedScroll()`, `scrollBy()`, `onNestedPreScroll()`, `onNestedFling()`, `flingWithNestedDispatch()`, `onNestedPreFling()`, `getNestedScrollAxes()`, `getTopFadingEdgeStrength()`, `getBottomFadingEdgeStrength()`, `getMaxScrollAmount()`, `setFocusable()`, `setDescendantFocusability()`, `setWillNotDraw()`, `addView()`, `IllegalStateException()`, `setOnScrollChangeListener()`, `canScroll()`, `isFillViewport()`, `requestLayout()`, `isSmoothScrollingEnabled()`, `setSmoothScrollingEnabled()`, `onScrollChanged()`, `onMeasure()`, `dispatchKeyEvent()`, `executeKeyEvent()`, `switch()`, `arrowScroll()`, `fullScroll()`, `pageScroll()`, `inChild()`, `initOrResetVelocityTracker()`, `initVelocityTrackerIfNotExists()`, `recycleVelocityTracker()`, `requestDisallowInterceptTouchEvent()`, `onInterceptTouchEvent()`, `onSecondaryPointerUp()`, `onTouchEvent()`, `endDrag()`, `ensureGlows()`, `onGenericMotionEvent()`, `getVerticalScrollFactorCompat()`, `onOverScrolled()`, `overScrollByCompat()`, `getScrollRange()`, `findFocusableViewInBounds()`, `for()`, `scrollAndFocus()`, `doScrollY()`, `offsetDescendantRectToMyCoords()`, `requestFocus()`, `isOffScreen()`, `isWithinDeltaOfScreen()`, `smoothScrollBy()`, `smoothScrollTo()`, `computeVerticalScrollRange()`, `computeVerticalScrollOffset()`, `computeVerticalScrollExtent()`, `computeHorizontalScrollRange()`, `computeHorizontalScrollOffset()`, `computeHorizontalScrollExtent()`, `measureChild()`, `measureChildWithMargins()`, `computeScroll()`, `scrollToChild()`, `scrollToChildRect()`, `computeScrollDeltaToGetChildRectOnScreen()`, `requestChildFocus()`, `onRequestFocusInDescendants()`, `requestChildRectangleOnScreen()`, `onLayout()`, `scrollTo()`, `onAttachedToWindow()`, `onSizeChanged()`, `isViewDescendantOf()`, `fling()`, `draw()`, `onRestoreInstanceState()`, `onSaveInstanceState()`, `createFromParcel()`, `SavedState()`, `newArray()`, `writeToParcel()`, `toString()`, `AccessibilityDelegate()`, `performAccessibilityAction()`, `onInitializeAccessibilityNodeInfo()`, `onInitializeAccessibilityEvent()`
- **`PopupMenuCompat`** — 4 function(s): `PopupMenuCompat()`, `getDragToOpenListener()`, `if()`, `return()`
- **`PopupWindowCompat`** — 8 function(s): `PopupWindowCompat()`, `showAsDropDown()`, `if()`, `setOverlapAnchor()`, `getOverlapAnchor()`, `return()`, `setWindowLayoutType()`, `getWindowLayoutType()`
- **`ResourceCursorAdapter`** — 6 function(s): `ResourceCursorAdapter()`, `super()`, `newView()`, `newDropDownView()`, `setViewResource()`, `setDropDownViewResource()`
- **`ScrollerCompat`** — 16 function(s): `create()`, `ScrollerCompat()`, `isFinished()`, `getCurrX()`, `getCurrY()`, `getFinalX()`, `getFinalY()`, `getCurrVelocity()`, `computeScrollOffset()`, `startScroll()`, `fling()`, `springBack()`, `abortAnimation()`, `notifyHorizontalEdgeReached()`, `notifyVerticalEdgeReached()`, `isOverScrolled()`
- **`SimpleCursorAdapter`** — 19 function(s): `convertToString()`, `setViewValue()`, `SimpleCursorAdapter()`, `super()`, `findColumns()`, `bindView()`, `for()`, `if()`, `setViewText()`, `setViewImage()`, `IllegalStateException()`, `getViewBinder()`, `setViewBinder()`, `getStringConversionColumn()`, `setStringConversionColumn()`, `getCursorToStringConverter()`, `setCursorToStringConverter()`, `swapCursor()`, `changeCursorAndColumns()`
- **`SlidingPaneLayout`** — 89 function(s): `onPanelClosed()`, `onPanelOpened()`, `onPanelSlide()`, `SlidingPaneLayout()`, `this()`, `super()`, `setWillNotDraw()`, `setParallaxDistance()`, `requestLayout()`, `getParallaxDistance()`, `setSliderFadeColor()`, `getSliderFadeColor()`, `setCoveredFadeColor()`, `getCoveredFadeColor()`, `setPanelSlideListener()`, `dispatchOnPanelSlide()`, `if()`, `dispatchOnPanelOpened()`, `sendAccessibilityEvent()`, `dispatchOnPanelClosed()`, `updateObscuredViewsVisibility()`, `while()`, `setAllChildrenVisible()`, `for()`, `viewIsOpaque()`, `onAttachedToWindow()`, `onDetachedFromWindow()`, `onMeasure()`, `IllegalStateException()`, `setMeasuredDimension()`, `onLayout()`, `parallaxOtherViews()`, `dimChildView()`, `onSizeChanged()`, `requestChildFocus()`, `onInterceptTouchEvent()`, `onTouchEvent()`, `switch()`, `closePane()`, `openPane()`, `smoothSlideOpen()`, `smoothSlideClosed()`, `isOpen()`, `canSlide()`, `isSlideable()`, `onPanelDragged()`, `invalidateChildRegion()`, `drawChild()`, `smoothSlideTo()`, `computeScroll()`, `setShadowDrawable()`, `setShadowDrawableLeft()`, `setShadowDrawableRight()`, `setShadowResource()`, `setShadowResourceLeft()`, `setShadowResourceRight()`, `draw()`, `canScroll()`, `isDimmed()`, `generateDefaultLayoutParams()`, `LayoutParams()`, `generateLayoutParams()`, `checkLayoutParams()`, `return()`, `onSaveInstanceState()`, `onRestoreInstanceState()`, `DragHelperCallback()`, `tryCaptureView()`, `onViewDragStateChanged()`, `onViewCaptured()`, `onViewPositionChanged()`, `onViewReleased()`, `getViewHorizontalDragRange()`, `clampViewPositionHorizontal()`, `clampViewPositionVertical()`, `onEdgeDragStarted()`, `createFromParcel()`, `SavedState()`, `newArray()`, `writeToParcel()`, `AccessibilityDelegate()`, `onInitializeAccessibilityNodeInfo()`, `copyNodeInfoNoChildren()`, `onInitializeAccessibilityEvent()`, `onRequestSendAccessibilityEvent()`, `filter()`, `DisableLayerRunnable()`, `run()`, `isLayoutRtlSupport()`
- **`Space`** — 10 function(s): `draw()`, `Space()`, `super()`, `if()`, `setVisibility()`, `this()`, `getDefaultSize2()`, `return()`, `onMeasure()`, `setMeasuredDimension()`
- **`SwipeRefreshLayout`** — 79 function(s): `canChildScrollUp()`, `onRefresh()`, `reset()`, `setColorViewAlpha()`, `if()`, `setAnimationProgress()`, `setTargetOffsetTopAndBottom()`, `setEnabled()`, `onDetachedFromWindow()`, `setProgressViewOffset()`, `getProgressViewStartOffset()`, `getProgressViewEndOffset()`, `setProgressViewEndTarget()`, `setSlingshotDistance()`, `setSize()`, `SwipeRefreshLayout()`, `this()`, `super()`, `onAnimationRepeat()`, `onAnimationStart()`, `onAnimationEnd()`, `applyTransformation()`, `setWillNotDraw()`, `createProgressView()`, `setChildrenDrawingOrderEnabled()`, `setNestedScrollingEnabled()`, `moveToStart()`, `getChildDrawingOrder()`, `addView()`, `setOnRefreshListener()`, `setRefreshing()`, `startScaleUpAnimation()`, `ensureTarget()`, `animateOffsetToCorrectPosition()`, `startScaleDownAnimation()`, `startProgressAlphaStartAnimation()`, `startProgressAlphaMaxAnimation()`, `startAlphaAnimation()`, `setProgressBackgroundColor()`, `setProgressBackgroundColorSchemeResource()`, `setProgressBackgroundColorSchemeColor()`, `setColorScheme()`, `setColorSchemeResources()`, `for()`, `setColorSchemeColors()`, `isRefreshing()`, `setDistanceToTriggerSync()`, `onLayout()`, `onMeasure()`, `getProgressCircleDiameter()`, `setOnChildScrollUpCallback()`, `onInterceptTouchEvent()`, `switch()`, `startDragging()`, `onSecondaryPointerUp()`, `requestDisallowInterceptTouchEvent()`, `onStartNestedScroll()`, `return()`, `onNestedScrollAccepted()`, `startNestedScroll()`, `onNestedPreScroll()`, `moveSpinner()`, `getNestedScrollAxes()`, `onStopNestedScroll()`, `finishSpinner()`, `stopNestedScroll()`, `onNestedScroll()`, `dispatchNestedScroll()`, `isNestedScrollingEnabled()`, `hasNestedScrollingParent()`, `dispatchNestedPreScroll()`, `onNestedPreFling()`, `dispatchNestedPreFling()`, `onNestedFling()`, `dispatchNestedFling()`, `isAnimationRunning()`, `animateOffsetToStartPosition()`, `onTouchEvent()`, `startScaleDownReturnToStartAnimation()`
- **`TextViewCompat`** — 46 function(s): `TextViewCompat()`, `retrieveField()`, `retrieveIntFromField()`, `setCompoundDrawablesRelative()`, `if()`, `setCompoundDrawablesRelativeWithIntrinsicBounds()`, `getMaxLines()`, `getMinLines()`, `setTextAppearance()`, `getCompoundDrawablesRelative()`, `setAutoSizeTextTypeWithDefaults()`, `setAutoSizeTextTypeUniformWithConfiguration()`, `setAutoSizeTextTypeUniformWithPresetSizes()`, `getAutoSizeTextType()`, `return()`, `getAutoSizeStepGranularity()`, `getAutoSizeMinTextSize()`, `getAutoSizeMaxTextSize()`, `getAutoSizeTextAvailableSizes()`, `setCustomSelectionActionModeCallback()`, `wrapCustomSelectionActionModeCallback()`, `OreoCallback()`, `onCreateActionMode()`, `onPrepareActionMode()`, `recomputeProcessTextMenuItems()`, `onActionItemClicked()`, `onDestroyActionMode()`, `for()`, `getSupportedActivities()`, `isSupportedActivity()`, `createProcessTextIntentForResolveInfo()`, `createProcessTextIntent()`, `isEditable()`, `Intent()`, `setFirstBaselineToTopHeight()`, `setLastBaselineToBottomHeight()`, `getFirstBaselineToTopHeight()`, `getLastBaselineToBottomHeight()`, `setLineHeight()`, `getTextMetricsParams()`, `setTextMetricsParams()`, `setPrecomputedText()`, `IllegalArgumentException()`, `getTextDirectionHeuristic()`, `switch()`, `getTextDirection()`
- **`TintableCompoundButton`** — 4 function(s): `getSupportButtonTintList()`, `getSupportButtonTintMode()`, `setSupportButtonTintList()`, `setSupportButtonTintMode()`
- **`TintableImageSourceView`** — 4 function(s): `getSupportImageTintList()`, `getSupportImageTintMode()`, `setSupportImageTintList()`, `setSupportImageTintMode()`
- **`ViewDragHelper`** — 66 function(s): `getInterpolation()`, `return()`, `run()`, `clampViewPositionHorizontal()`, `clampViewPositionVertical()`, `getOrderedChildIndex()`, `getViewHorizontalDragRange()`, `getViewVerticalDragRange()`, `onEdgeDragStarted()`, `onEdgeLock()`, `onEdgeTouched()`, `onViewCaptured()`, `onViewDragStateChanged()`, `onViewPositionChanged()`, `onViewReleased()`, `tryCaptureView()`, `create()`, `ViewDragHelper()`, `if()`, `IllegalArgumentException()`, `setMinVelocity()`, `getMinVelocity()`, `getViewDragState()`, `setEdgeTrackingEnabled()`, `getEdgeSize()`, `captureChildView()`, `setDragState()`, `getCapturedView()`, `getActivePointerId()`, `getTouchSlop()`, `cancel()`, `clearMotionHistory()`, `abort()`, `smoothSlideViewTo()`, `settleCapturedViewAt()`, `IllegalStateException()`, `forceSettleCapturedViewAt()`, `computeSettleDuration()`, `computeAxisDuration()`, `clampMag()`, `distanceInfluenceForSnapDuration()`, `flingCapturedView()`, `continueSettling()`, `dispatchViewReleased()`, `ensureMotionHistorySizeForId()`, `saveInitialMotion()`, `saveLastMotion()`, `for()`, `isPointerDown()`, `tryCaptureViewForDrag()`, `canScroll()`, `shouldInterceptTouchEvent()`, `switch()`, `reportNewEdgeDrags()`, `processTouchEvent()`, `releaseViewForPointerUp()`, `dragTo()`, `while()`, `checkNewEdgeDrag()`, `checkTouchSlop()`, `isEdgeTouched()`, `isCapturedViewUnder()`, `isViewUnder()`, `findTopChildUnder()`, `getEdgesTouched()`, `isValidPointerForActionMove()`
- **`ViewGroupUtils`** — 5 function(s): `offsetDescendantRect()`, `if()`, `offsetDescendantMatrix()`, `getDescendantRect()`, `ViewGroupUtils()`

</details>

### Package `android.support.v7.app`  (18 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ActionBar` | class | ViewGroup.MarginLayoutParams | 392 | 116 |
| `ActionBarDrawerToggle` | class | DrawerLayout.DrawerListener | 355 | 89 |
| `ActionBarDrawerToggleHoneycomb` | class | — | 93 | 12 |
| `AlertController` | class | Handler | 849 | 159 |
| `AlertDialog` | class | AppCompatDialog implements DialogInterface | 423 | 76 |
| `AppCompatActivity` | class | FragmentActivity implements AppCompatCallback, TaskStackBuilder.SupportParentable, Acti... | 343 | 93 |
| `AppCompatCallback` | class | — | 15 | 3 |
| `AppCompatDelegate` | class | — | 143 | 39 |
| `AppCompatDelegateImpl` | class | AppCompatDelegate implements MenuBuilder.Callback, LayoutInflater.Factory2 | 2,124 | 476 |
| `AppCompatDialog` | class | Dialog implements AppCompatCallback | 155 | 44 |
| `AppCompatDialogFragment` | class | DialogFragment | 36 | 5 |
| `AppCompatViewInflater` | class | View.OnClickListener | 401 | 90 |
| `NavItemSelectedListener` | class | AdapterView.OnItemSelectedListener | 26 | 4 |
| `ResourcesFlusher` | class | — | 193 | 32 |
| `ToolbarActionBar` | class | ActionBar | 555 | 130 |
| `TwilightCalculator` | class | — | 60 | 6 |
| `TwilightManager` | class | — | 124 | 16 |
| `WindowDecorActionBar` | class | ActionBar implements ActionBarOverlayLayout.ActionBarVisibilityCallback | 1,270 | 303 |

<details>
<summary><b>Function list for <code>android.support.v7.app</code></b> (click to expand)</summary>

- **`ActionBar`** — 84 function(s): `onMenuVisibilityChanged()`, `onNavigationItemSelected()`, `getContentDescription()`, `getCustomView()`, `getIcon()`, `getPosition()`, `getTag()`, `getText()`, `select()`, `setContentDescription()`, `setCustomView()`, `setIcon()`, `setTabListener()`, `setTag()`, `setText()`, `onTabReselected()`, `onTabSelected()`, `onTabUnselected()`, `addOnMenuVisibilityListener()`, `addTab()`, `closeOptionsMenu()`, `collapseActionView()`, `dispatchMenuVisibilityChanged()`, `getDisplayOptions()`, `getElevation()`, `getHeight()`, `getHideOffset()`, `getNavigationItemCount()`, `getNavigationMode()`, `getSelectedNavigationIndex()`, `getSelectedTab()`, `getSubtitle()`, `getTabAt()`, `getTabCount()`, `getThemedContext()`, `getTitle()`, `hide()`, `invalidateOptionsMenu()`, `isHideOnContentScrollEnabled()`, `isShowing()`, `isTitleTruncated()`, `newTab()`, `onConfigurationChanged()`, `onDestroy()`, `onKeyShortcut()`, `onMenuKeyEvent()`, `openOptionsMenu()`, `removeAllTabs()`, `removeOnMenuVisibilityListener()`, `removeTab()`, `removeTabAt()`, `requestFocus()`, `selectTab()`, `setBackgroundDrawable()`, `setDefaultDisplayHomeAsUpEnabled()`, `setDisplayHomeAsUpEnabled()`, `setDisplayOptions()`, `setDisplayShowCustomEnabled()`, `setDisplayShowHomeEnabled()`, `setDisplayShowTitleEnabled()`, `setDisplayUseLogoEnabled()`, `setHomeActionContentDescription()`, `setHomeAsUpIndicator()`, `setHomeButtonEnabled()`, `setListNavigationCallbacks()`, `setLogo()`, `setNavigationMode()`, `setSelectedNavigationItem()`, `setShowHideAnimationEnabled()`, `setSplitBackgroundDrawable()`, `setStackedBackgroundDrawable()`, `setSubtitle()`, `setTitle()`, `setWindowTitle()`, `show()`, `startActionMode()`, `setHideOnContentScrollEnabled()`, `if()`, `UnsupportedOperationException()`, `setHideOffset()`, `setElevation()`, `LayoutParams()`, `super()`, `this()`
- **`ActionBarDrawerToggle`** — 31 function(s): `getActionBarThemedContext()`, `getThemeUpIndicator()`, `isNavigationVisible()`, `setActionBarDescription()`, `setActionBarUpIndicator()`, `getDrawerToggleDelegate()`, `onDrawerStateChanged()`, `ActionBarDrawerToggle()`, `this()`, `if()`, `onClick()`, `syncState()`, `setPosition()`, `onConfigurationChanged()`, `onOptionsItemSelected()`, `toggle()`, `setHomeAsUpIndicator()`, `isDrawerIndicatorEnabled()`, `setDrawerIndicatorEnabled()`, `getDrawerArrowDrawable()`, `setDrawerArrowDrawable()`, `setDrawerSlideAnimationEnabled()`, `isDrawerSlideAnimationEnabled()`, `onDrawerSlide()`, `onDrawerOpened()`, `onDrawerClosed()`, `getToolbarNavigationClickListener()`, `setToolbarNavigationClickListener()`, `FrameworkActionBarDelegate()`, `return()`, `ToolbarCompatDelegate()`
- **`ActionBarDrawerToggleHoneycomb`** — 6 function(s): `setActionBarUpIndicator()`, `if()`, `setActionBarDescription()`, `getThemeUpIndicator()`, `SetIndicatorInfo()`, `ActionBarDrawerToggleHoneycomb()`
- **`AlertController`** — 54 function(s): `onClick()`, `if()`, `ButtonHandler()`, `handleMessage()`, `switch()`, `shouldCenterSingleButton()`, `AlertController()`, `canTextInput()`, `while()`, `installContent()`, `setupView()`, `selectContentView()`, `setTitle()`, `setCustomTitle()`, `setMessage()`, `setView()`, `setButtonPanelLayoutHint()`, `setButton()`, `IllegalArgumentException()`, `setIcon()`, `getIconAttributeResId()`, `getListView()`, `getButton()`, `onKeyDown()`, `onKeyUp()`, `resolvePanel()`, `return()`, `setupCustomContent()`, `setupContent()`, `setupButtons()`, `setupTitle()`, `setScrollIndicators()`, `onScrollChange()`, `run()`, `onScrollStateChanged()`, `onScroll()`, `manageScrollIndicators()`, `centerButton()`, `RecycleListView()`, `this()`, `super()`, `setHasDecor()`, `setPadding()`, `onPrepareListView()`, `AlertParams()`, `apply()`, `createListView()`, `getView()`, `bindView()`, `newView()`, `onItemClick()`, `getItemId()`, `hasStableIds()`, `CheckedItemAdapter()`
- **`AlertDialog`** — 40 function(s): `AlertDialog()`, `this()`, `super()`, `setCancelable()`, `setOnCancelListener()`, `resolveDialogTheme()`, `if()`, `getButton()`, `getListView()`, `setTitle()`, `setCustomTitle()`, `setMessage()`, `setView()`, `setButtonPanelLayoutHint()`, `setButton()`, `setIcon()`, `setIconAttribute()`, `getContext()`, `onCreate()`, `onKeyDown()`, `onKeyUp()`, `Builder()`, `setPositiveButton()`, `setPositiveButtonIcon()`, `setNegativeButton()`, `setNegativeButtonIcon()`, `setNeutralButton()`, `setNeutralButtonIcon()`, `setOnDismissListener()`, `setOnKeyListener()`, `setItems()`, `setAdapter()`, `setCursor()`, `setMultiChoiceItems()`, `setSingleChoiceItems()`, `setOnItemSelectedListener()`, `setInverseBackgroundForced()`, `setRecycleOnMeasureEnabled()`, `create()`, `show()`
- **`AppCompatActivity`** — 50 function(s): `onPrepareSupportNavigateUpTaskStack()`, `onSupportActionModeFinished()`, `onSupportActionModeStarted()`, `onSupportContentChanged()`, `onWindowStartingSupportActionMode()`, `setSupportProgress()`, `setSupportProgressBarIndeterminate()`, `setSupportProgressBarIndeterminateVisibility()`, `setSupportProgressBarVisibility()`, `onCreate()`, `if()`, `onApplyThemeResource()`, `setTheme()`, `onPostCreate()`, `getDelegate()`, `getSupportActionBar()`, `setSupportActionBar()`, `getMenuInflater()`, `setContentView()`, `addContentView()`, `onConfigurationChanged()`, `onPostResume()`, `onStart()`, `onStop()`, `findViewById()`, `return()`, `onMenuItemSelected()`, `onSupportNavigateUp()`, `onDestroy()`, `onTitleChanged()`, `supportRequestWindowFeature()`, `supportInvalidateOptionsMenu()`, `invalidateOptionsMenu()`, `startSupportActionMode()`, `onCreateSupportNavigateUpTaskStack()`, `finish()`, `supportNavigateUpTo()`, `getSupportParentActivityIntent()`, `supportShouldUpRecreateTask()`, `onContentChanged()`, `getDrawerToggleDelegate()`, `onMenuOpened()`, `onPanelClosed()`, `onSaveInstanceState()`, `dispatchKeyEvent()`, `getResources()`, `performMenuItemShortcut()`, `onKeyDown()`, `openOptionsMenu()`, `closeOptionsMenu()`
- **`AppCompatCallback`** — 3 function(s): `onSupportActionModeFinished()`, `onSupportActionModeStarted()`, `onWindowStartingSupportActionMode()`
- **`AppCompatDelegate`** — 33 function(s): `addContentView()`, `applyDayNight()`, `createView()`, `findViewById()`, `getDrawerToggleDelegate()`, `getMenuInflater()`, `getSupportActionBar()`, `hasWindowFeature()`, `installViewFactory()`, `invalidateOptionsMenu()`, `isHandleNativeActionModesEnabled()`, `onConfigurationChanged()`, `onCreate()`, `onDestroy()`, `onPostCreate()`, `onPostResume()`, `onSaveInstanceState()`, `onStart()`, `onStop()`, `requestWindowFeature()`, `setContentView()`, `setHandleNativeActionModesEnabled()`, `setLocalNightMode()`, `setSupportActionBar()`, `setTitle()`, `startSupportActionMode()`, `create()`, `AppCompatDelegateImpl()`, `setDefaultNightMode()`, `switch()`, `getDefaultNightMode()`, `setCompatVectorFromResourcesEnabled()`, `isCompatVectorFromResourcesEnabled()`
- **`AppCompatDelegateImpl`** — 142 function(s): `run()`, `if()`, `onSubDecorInstalled()`, `uncaughtException()`, `shouldWrapException()`, `AppCompatDelegateImpl()`, `IllegalStateException()`, `onCreate()`, `onPostCreate()`, `ensureSubDecor()`, `getSupportActionBar()`, `initWindowDecorActionBar()`, `peekSupportActionBar()`, `getWindowCallback()`, `setSupportActionBar()`, `invalidateOptionsMenu()`, `getActionBarThemedContext()`, `getMenuInflater()`, `findViewById()`, `return()`, `onConfigurationChanged()`, `applyDayNight()`, `onStart()`, `onStop()`, `onPostResume()`, `setContentView()`, `addContentView()`, `onSaveInstanceState()`, `onDestroy()`, `applyFixedSizeWindow()`, `invalidatePanelMenu()`, `createSubDecor()`, `requestWindowFeature()`, `onApplyWindowInsets()`, `onFitSystemWindows()`, `IllegalArgumentException()`, `while()`, `onAttachedFromWindow()`, `onDetachedFromWindow()`, `switch()`, `throwFeatureRequestIfSubDecorInstalled()`, `hasWindowFeature()`, `setTitle()`, `getTitle()`, `onPanelClosed()`, `closePanel()`, `onMenuOpened()`, `onMenuItemSelected()`, `onMenuModeChange()`, `reopenMenu()`, `startSupportActionMode()`, `startSupportActionModeFromWindow()`, `endOnGoingFadeAnimation()`, `onAnimationStart()`, `onAnimationEnd()`, `shouldAnimateActionModeView()`, `setHandleNativeActionModesEnabled()`, `isHandleNativeActionModesEnabled()`, `onBackPressed()`, `onKeyShortcut()`, `preparePanel()`, `dispatchKeyEvent()`, `onKeyUp()`, `onKeyUpPanel()`, `onKeyDown()`, `onKeyDownPanel()`, `createView()`, `shouldInheritContext()`, `installViewFactory()`, `onCreateView()`, `openPanel()`, `initializePanelDecor()`, `initializePanelMenu()`, `initializePanelContent()`, `checkCloseActionMenu()`, `callOnPanelClosed()`, `findMenuPanel()`, `for()`, `getPanelState()`, `performPanelShortcut()`, `doInvalidatePanelMenu()`, `updateStatusGuard()`, `AndroidRuntimeException()`, `sanitizeWindowFeatureId()`, `getSubDecor()`, `dismissPopups()`, `ensureAutoNightModeManager()`, `setLocalNightMode()`, `mapNightMode()`, `getNightMode()`, `updateForNightMode()`, `getAutoNightModeManager()`, `shouldRecreateOnNightModeChange()`, `ActionModeCallbackWrapperV9()`, `onCreateActionMode()`, `onPrepareActionMode()`, `onActionItemClicked()`, `onDestroyActionMode()`, `PanelMenuPresenterCallback()`, `onCloseMenu()`, `onOpenSubMenu()`, `ActionMenuPresenterCallback()`, `PanelFeatureState()`, `hasPanelItems()`, `clearMenuPresenters()`, `setStyle()`, `setMenu()`, `getListMenuView()`, `onRestoreInstanceState()`, `applyFrozenState()`, `createFromParcel()`, `newArray()`, `describeContents()`, `SavedState()`, `writeToParcel()`, `readFromParcel()`, `ListMenuDecorView()`, `super()`, `onInterceptTouchEvent()`, `setBackgroundResource()`, `setBackgroundDrawable()`, `isOutOfBounds()`, `onContentChanged()`, `AppCompatWindowCallback()`, `dispatchKeyShortcutEvent()`, `onCreatePanelMenu()`, `onPreparePanel()`, `onWindowStartingActionMode()`, `startAsSupportActionMode()`, `onProvideKeyboardShortcuts()`, `AutoNightModeManager()`, `getApplyableNightMode()`, `dispatchTimeChanged()`, `setup()`, `cleanup()`, `onReceive()`, `getDrawerToggleDelegate()`, `ActionBarDrawableToggleImpl()`, `getThemeUpIndicator()`, `isNavigationVisible()`, `setActionBarUpIndicator()`, `setActionBarDescription()`
- **`AppCompatDialog`** — 21 function(s): `onSupportActionModeFinished()`, `onSupportActionModeStarted()`, `onWindowStartingSupportActionMode()`, `AppCompatDialog()`, `this()`, `super()`, `superDispatchKeyEvent()`, `getDelegate()`, `onCreate()`, `getSupportActionBar()`, `setContentView()`, `findViewById()`, `return()`, `setTitle()`, `addContentView()`, `onStop()`, `supportRequestWindowFeature()`, `invalidateOptionsMenu()`, `if()`, `getThemeResId()`, `dispatchKeyEvent()`
- **`AppCompatDialogFragment`** — 5 function(s): `onCreateDialog()`, `AppCompatDialog()`, `setupDialog()`, `if()`, `switch()`
- **`AppCompatViewInflater`** — 40 function(s): `createView()`, `if()`, `switch()`, `verifyNotNull()`, `checkOnClickListener()`, `createTextView()`, `AppCompatTextView()`, `createImageView()`, `AppCompatImageView()`, `createButton()`, `AppCompatButton()`, `createEditText()`, `AppCompatEditText()`, `createSpinner()`, `AppCompatSpinner()`, `createImageButton()`, `AppCompatImageButton()`, `createCheckBox()`, `AppCompatCheckBox()`, `createRadioButton()`, `AppCompatRadioButton()`, `createCheckedTextView()`, `AppCompatCheckedTextView()`, `createAutoCompleteTextView()`, `AppCompatAutoCompleteTextView()`, `createMultiAutoCompleteTextView()`, `AppCompatMultiAutoCompleteTextView()`, `createRatingBar()`, `AppCompatRatingBar()`, `createSeekBar()`, `AppCompatSeekBar()`, `IllegalStateException()`, `createViewFromTag()`, `createViewByPrefix()`, `for()`, `themifyContext()`, `DeclaredOnClickListener()`, `onClick()`, `resolveMethod()`, `while()`
- **`NavItemSelectedListener`** — 4 function(s): `onNothingSelected()`, `NavItemSelectedListener()`, `onItemSelected()`, `if()`
- **`ResourcesFlusher`** — 7 function(s): `flush()`, `if()`, `flushNougats()`, `flushMarshmallows()`, `flushLollipops()`, `flushThemedResourcesCache()`, `ResourcesFlusher()`
- **`ToolbarActionBar`** — 81 function(s): `run()`, `onMenuItemClick()`, `getNavigationItemCount()`, `getNavigationMode()`, `getSelectedNavigationIndex()`, `getTabCount()`, `setDefaultDisplayHomeAsUpEnabled()`, `setHomeButtonEnabled()`, `setShowHideAnimationEnabled()`, `setSplitBackgroundDrawable()`, `setStackedBackgroundDrawable()`, `ToolbarActionBar()`, `getWrappedWindowCallback()`, `setCustomView()`, `if()`, `setIcon()`, `setLogo()`, `setElevation()`, `getElevation()`, `getThemedContext()`, `isTitleTruncated()`, `setHomeAsUpIndicator()`, `setHomeActionContentDescription()`, `onConfigurationChanged()`, `setListNavigationCallbacks()`, `setSelectedNavigationItem()`, `IllegalStateException()`, `setTitle()`, `setWindowTitle()`, `requestFocus()`, `setSubtitle()`, `setDisplayOptions()`, `setDisplayUseLogoEnabled()`, `setDisplayShowHomeEnabled()`, `setDisplayHomeAsUpEnabled()`, `setDisplayShowTitleEnabled()`, `setDisplayShowCustomEnabled()`, `setBackgroundDrawable()`, `getCustomView()`, `getTitle()`, `getSubtitle()`, `setNavigationMode()`, `IllegalArgumentException()`, `getDisplayOptions()`, `newTab()`, `UnsupportedOperationException()`, `addTab()`, `removeTab()`, `removeTabAt()`, `removeAllTabs()`, `selectTab()`, `getSelectedTab()`, `getTabAt()`, `getHeight()`, `show()`, `hide()`, `isShowing()`, `openOptionsMenu()`, `closeOptionsMenu()`, `invalidateOptionsMenu()`, `collapseActionView()`, `populateOptionsMenu()`, `onMenuKeyEvent()`, `onKeyShortcut()`, `onDestroy()`, `addOnMenuVisibilityListener()`, `removeOnMenuVisibilityListener()`, `dispatchMenuVisibilityChanged()`, `for()`, `ToolbarCallbackWrapper()`, `super()`, `onPreparePanel()`, `onCreatePanelView()`, `View()`, `getMenu()`, `ActionMenuPresenterCallback()`, `onOpenSubMenu()`, `onCloseMenu()`, `onMenuItemSelected()`, `MenuBuilderCallback()`, `onMenuModeChange()`
- **`TwilightCalculator`** — 3 function(s): `getInstance()`, `if()`, `calculateTwilight()`
- **`TwilightManager`** — 11 function(s): `getInstance()`, `if()`, `setInstance()`, `TwilightManager()`, `isNight()`, `updateState()`, `getLastKnownLocation()`, `return()`, `getLastKnownLocationForProvider()`, `isStateValid()`, `TwilightState()`
- **`WindowDecorActionBar`** — 119 function(s): `onAnimationEnd()`, `if()`, `onAnimationUpdate()`, `checkShowingFlags()`, `return()`, `onContentScrollStopped()`, `setSplitBackgroundDrawable()`, `WindowDecorActionBar()`, `init()`, `IllegalStateException()`, `setHomeButtonEnabled()`, `setHasEmbeddedTabs()`, `setHideOnContentScrollEnabled()`, `setElevation()`, `getDecorToolbar()`, `getElevation()`, `onConfigurationChanged()`, `ensureTabsExist()`, `completeDeferredDestroyActionMode()`, `onWindowVisibilityChanged()`, `setShowHideAnimationEnabled()`, `addOnMenuVisibilityListener()`, `removeOnMenuVisibilityListener()`, `dispatchMenuVisibilityChanged()`, `for()`, `setCustomView()`, `setDisplayUseLogoEnabled()`, `setDisplayOptions()`, `setDisplayShowHomeEnabled()`, `setDisplayHomeAsUpEnabled()`, `setDisplayShowTitleEnabled()`, `setDisplayShowCustomEnabled()`, `setTitle()`, `setSubtitle()`, `setSelectedNavigationItem()`, `switch()`, `selectTab()`, `removeAllTabs()`, `cleanupTabs()`, `setWindowTitle()`, `requestFocus()`, `setBackgroundDrawable()`, `setStackedBackgroundDrawable()`, `getCustomView()`, `getTitle()`, `getSubtitle()`, `getNavigationMode()`, `getDisplayOptions()`, `startActionMode()`, `animateToMode()`, `configureTab()`, `while()`, `addTab()`, `newTab()`, `TabImpl()`, `removeTab()`, `removeTabAt()`, `getSelectedTab()`, `getHeight()`, `enableContentAnimations()`, `show()`, `updateVisibility()`, `showForActionMode()`, `showForSystem()`, `hide()`, `hideForActionMode()`, `hideForSystem()`, `isHideOnContentScrollEnabled()`, `getHideOffset()`, `setHideOffset()`, `doShow()`, `doHide()`, `isShowing()`, `shouldAnimateContextView()`, `getThemedContext()`, `isTitleTruncated()`, `setHomeAsUpIndicator()`, `setHomeActionContentDescription()`, `onContentScrollStarted()`, `collapseActionView()`, `onCloseMenu()`, `onCloseSubMenu()`, `ActionModeImpl()`, `getMenuInflater()`, `SupportMenuInflater()`, `getMenu()`, `finish()`, `invalidate()`, `dispatchOnCreate()`, `setTitleOptionalHint()`, `isTitleOptional()`, `onMenuItemSelected()`, `onSubMenuSelected()`, `MenuPopupHelper()`, `onMenuModeChange()`, `getTag()`, `setTag()`, `getCallback()`, `setTabListener()`, `getIcon()`, `getPosition()`, `setPosition()`, `getText()`, `setIcon()`, `setText()`, `select()`, `setContentDescription()`, `getContentDescription()`, `setListNavigationCallbacks()`, `getSelectedNavigationIndex()`, `getNavigationItemCount()`, `getTabCount()`, `setNavigationMode()`, `getTabAt()`, `hasIcon()`, `setLogo()`, `hasLogo()`, `setDefaultDisplayHomeAsUpEnabled()`, `onKeyShortcut()`

</details>

### Package `android.support.v7.appcompat`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 1,669 | 13 |

<details>
<summary><b>Function list for <code>android.support.v7.appcompat</code></b> (click to expand)</summary>

- **`R`** — 13 function(s): `R()`, `anim()`, `attr()`, `bool()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.v7.content.res`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AppCompatResources` | class | — | 122 | 20 |

<details>
<summary><b>Function list for <code>android.support.v7.content.res</code></b> (click to expand)</summary>

- **`AppCompatResources`** — 11 function(s): `AppCompatResources()`, `getColorStateList()`, `if()`, `addColorStateListToCache()`, `getDrawable()`, `inflateColorStateList()`, `getCachedColorStateList()`, `synchronized()`, `isColorInt()`, `getTypedValue()`, `ColorStateListCacheEntry()`

</details>

### Package `android.support.v7.graphics.drawable`  (5 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AnimatedStateListDrawableCompat` | class | StateListDrawable | 811 | 130 |
| `DrawableContainer` | class | Drawable implements Drawable.Callback | 1,100 | 253 |
| `DrawableWrapper` | class | Drawable implements Drawable.Callback | 196 | 41 |
| `DrawerArrowDrawable` | class | Drawable | 261 | 60 |
| `StateListDrawable` | class | DrawableContainer | 294 | 62 |

<details>
<summary><b>Function list for <code>android.support.v7.graphics.drawable</code></b> (click to expand)</summary>

- **`AnimatedStateListDrawableCompat`** — 52 function(s): `isStateful()`, `AnimatedStateListDrawableCompat()`, `this()`, `super()`, `setConstantState()`, `onStateChange()`, `jumpToCurrentState()`, `create()`, `if()`, `XmlPullParserException()`, `createFromXmlInner()`, `inflate()`, `setVisible()`, `updateStateFromTypedArray()`, `updateDensity()`, `inflateChildElements()`, `init()`, `addState()`, `IllegalArgumentException()`, `addTransition()`, `selectDrawable()`, `selectTransition()`, `canReverse()`, `reverse()`, `start()`, `stop()`, `Transition()`, `AnimatableTransition()`, `AnimationDrawableTransition()`, `AnimatedVectorDrawableTransition()`, `setDither()`, `while()`, `parseItem()`, `parseTransition()`, `mutate()`, `cloneConstantState()`, `AnimatedStateListState()`, `clearMutated()`, `generateTransitionKey()`, `addStateSet()`, `indexOfKeyframe()`, `getKeyframeIdAt()`, `indexOfTransition()`, `return()`, `isTransitionReversed()`, `transitionHasReversibleFlag()`, `newDrawable()`, `FrameInterpolator()`, `updateFrames()`, `for()`, `getTotalDuration()`, `getInterpolation()`
- **`DrawableContainer`** — 81 function(s): `draw()`, `if()`, `getChangingConfigurations()`, `needsMirroring()`, `isAutoMirrored()`, `getPadding()`, `getOutline()`, `setAlpha()`, `animate()`, `getAlpha()`, `setDither()`, `setColorFilter()`, `setTintList()`, `setTintMode()`, `setEnterFadeDuration()`, `setExitFadeDuration()`, `onBoundsChange()`, `isStateful()`, `setAutoMirrored()`, `jumpToCurrentState()`, `invalidateSelf()`, `setHotspot()`, `setHotspotBounds()`, `getHotspotBounds()`, `onStateChange()`, `onLevelChange()`, `onLayoutDirectionChanged()`, `getIntrinsicWidth()`, `getIntrinsicHeight()`, `getMinimumWidth()`, `getMinimumHeight()`, `invalidateDrawable()`, `getCallback()`, `scheduleDrawable()`, `unscheduleDrawable()`, `setVisible()`, `getOpacity()`, `setCurrentIndex()`, `selectDrawable()`, `getCurrentIndex()`, `initializeDrawableForDisplay()`, `run()`, `unscheduleSelf()`, `scheduleSelf()`, `getCurrent()`, `updateDensity()`, `applyTheme()`, `canApplyTheme()`, `getConstantState()`, `mutate()`, `setConstantState()`, `cloneConstantState()`, `clearMutated()`, `DrawableContainerState()`, `for()`, `addChild()`, `growArray()`, `invalidateCache()`, `getCapacity()`, `createAllFutures()`, `prepareDrawable()`, `getChildCount()`, `getChild()`, `setLayoutDirection()`, `setVariablePadding()`, `getConstantPadding()`, `setConstantSize()`, `isConstantSize()`, `getConstantWidth()`, `computeConstantSize()`, `getConstantHeight()`, `getConstantMinimumWidth()`, `getConstantMinimumHeight()`, `getEnterFadeDuration()`, `getExitFadeDuration()`, `while()`, `canConstantState()`, `BlockInvalidateCallback()`, `wrap()`, `unwrap()`, `resolveDensity()`
- **`DrawableWrapper`** — 39 function(s): `DrawableWrapper()`, `setWrappedDrawable()`, `draw()`, `onBoundsChange()`, `setChangingConfigurations()`, `getChangingConfigurations()`, `setDither()`, `setFilterBitmap()`, `setAlpha()`, `setColorFilter()`, `isStateful()`, `setState()`, `getState()`, `jumpToCurrentState()`, `getCurrent()`, `setVisible()`, `getOpacity()`, `getTransparentRegion()`, `getIntrinsicWidth()`, `getIntrinsicHeight()`, `getMinimumWidth()`, `getMinimumHeight()`, `getPadding()`, `invalidateDrawable()`, `invalidateSelf()`, `scheduleDrawable()`, `scheduleSelf()`, `unscheduleDrawable()`, `unscheduleSelf()`, `onLevelChange()`, `setAutoMirrored()`, `isAutoMirrored()`, `setTint()`, `setTintList()`, `setTintMode()`, `setHotspot()`, `setHotspotBounds()`, `getWrappedDrawable()`, `if()`
- **`DrawerArrowDrawable`** — 31 function(s): `lerp()`, `getOpacity()`, `DrawerArrowDrawable()`, `setColor()`, `setBarThickness()`, `setSpinEnabled()`, `setGapSize()`, `setArrowHeadLength()`, `if()`, `invalidateSelf()`, `getArrowHeadLength()`, `setArrowShaftLength()`, `getArrowShaftLength()`, `getBarLength()`, `setBarLength()`, `getColor()`, `getBarThickness()`, `getGapSize()`, `setDirection()`, `isSpinEnabled()`, `getDirection()`, `setVerticalMirror()`, `draw()`, `switch()`, `setAlpha()`, `setColorFilter()`, `getIntrinsicHeight()`, `getIntrinsicWidth()`, `getProgress()`, `setProgress()`, `getPaint()`
- **`StateListDrawable`** — 31 function(s): `isStateful()`, `this()`, `addState()`, `if()`, `onStateChange()`, `selectDrawable()`, `inflate()`, `setVisible()`, `updateStateFromTypedArray()`, `updateDensity()`, `inflateChildElements()`, `while()`, `extractStateSet()`, `for()`, `getStateListState()`, `getStateCount()`, `getStateSet()`, `getStateDrawable()`, `getStateDrawableIndex()`, `mutate()`, `cloneConstantState()`, `StateListState()`, `clearMutated()`, `super()`, `addStateSet()`, `indexOfStateSet()`, `newDrawable()`, `StateListDrawable()`, `growArray()`, `applyTheme()`, `setConstantState()`

</details>

### Package `android.support.v7.text`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AllCapsTransformationMethod` | class | TransformationMethod | 31 | 4 |

<details>
<summary><b>Function list for <code>android.support.v7.text</code></b> (click to expand)</summary>

- **`AllCapsTransformationMethod`** — 4 function(s): `onFocusChanged()`, `AllCapsTransformationMethod()`, `getTransformation()`, `if()`

</details>

### Package `android.support.v7.view`  (9 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ActionBarPolicy` | class | — | 84 | 18 |
| `ActionMode` | class | — | 74 | 22 |
| `CollapsibleActionView` | class | — | 9 | 2 |
| `ContextThemeWrapper` | class | ContextWrapper | 122 | 36 |
| `StandaloneActionMode` | class | ActionMode implements MenuBuilder.Callback | 146 | 29 |
| `SupportActionModeWrapper` | class | android.view.ActionMode | 170 | 28 |
| `SupportMenuInflater` | class | MenuInflater | 489 | 73 |
| `ViewPropertyAnimatorCompatSet` | class | — | 124 | 27 |
| `WindowCallbackWrapper` | class | Window.Callback | 159 | 28 |

<details>
<summary><b>Function list for <code>android.support.v7.view</code></b> (click to expand)</summary>

- **`ActionBarPolicy`** — 10 function(s): `get()`, `ActionBarPolicy()`, `getMaxActionButtons()`, `if()`, `showsOverflowMenuButton()`, `getEmbeddedMenuWidthLimit()`, `hasEmbeddedTabs()`, `getTabContainerHeight()`, `enableHomeButtonByDefault()`, `getStackedTabMaxWidth()`
- **`ActionMode`** — 20 function(s): `onActionItemClicked()`, `onCreateActionMode()`, `onDestroyActionMode()`, `onPrepareActionMode()`, `finish()`, `getCustomView()`, `getMenu()`, `getMenuInflater()`, `getSubtitle()`, `getTitle()`, `invalidate()`, `isTitleOptional()`, `isUiFocusable()`, `setCustomView()`, `setSubtitle()`, `setTitle()`, `setTag()`, `getTag()`, `setTitleOptionalHint()`, `getTitleOptionalHint()`
- **`CollapsibleActionView`** — 2 function(s): `onActionViewCollapsed()`, `onActionViewExpanded()`
- **`ContextThemeWrapper`** — 16 function(s): `ContextThemeWrapper()`, `super()`, `attachBaseContext()`, `applyOverrideConfiguration()`, `if()`, `IllegalStateException()`, `getResources()`, `getResourcesInternal()`, `setTheme()`, `initializeTheme()`, `getThemeResId()`, `getTheme()`, `getSystemService()`, `getBaseContext()`, `onApplyThemeResource()`, `getAssets()`
- **`StandaloneActionMode`** — 22 function(s): `onCloseMenu()`, `onCloseSubMenu()`, `StandaloneActionMode()`, `setTitle()`, `setSubtitle()`, `setTitleOptionalHint()`, `isTitleOptional()`, `setCustomView()`, `invalidate()`, `finish()`, `if()`, `getMenu()`, `getTitle()`, `getSubtitle()`, `getCustomView()`, `getMenuInflater()`, `SupportMenuInflater()`, `onMenuItemSelected()`, `onSubMenuSelected()`, `MenuPopupHelper()`, `onMenuModeChange()`, `isUiFocusable()`
- **`SupportActionModeWrapper`** — 25 function(s): `SupportActionModeWrapper()`, `getTag()`, `setTag()`, `setTitle()`, `setSubtitle()`, `invalidate()`, `finish()`, `getMenu()`, `getTitle()`, `getSubtitle()`, `getCustomView()`, `setCustomView()`, `getMenuInflater()`, `getTitleOptionalHint()`, `setTitleOptionalHint()`, `isTitleOptional()`, `CallbackWrapper()`, `onCreateActionMode()`, `onPrepareActionMode()`, `onActionItemClicked()`, `onDestroyActionMode()`, `getMenuWrapper()`, `if()`, `getActionModeWrapper()`, `for()`
- **`SupportMenuInflater`** — 25 function(s): `SupportMenuInflater()`, `super()`, `inflate()`, `if()`, `parseMenu()`, `InflateException()`, `switch()`, `while()`, `RuntimeException()`, `getRealOwner()`, `findRealOwner()`, `return()`, `InflatedOnMenuItemClickListener()`, `onMenuItemClick()`, `MenuState()`, `resetGroup()`, `readGroup()`, `readItem()`, `getShortcut()`, `setItem()`, `IllegalStateException()`, `addItem()`, `addSubMenuItem()`, `hasAddedItem()`, `newInstance()`
- **`ViewPropertyAnimatorCompatSet`** — 13 function(s): `onAnimationStart()`, `if()`, `onEnd()`, `onAnimationEnd()`, `play()`, `playSequentially()`, `start()`, `while()`, `onAnimationsEnded()`, `cancel()`, `setDuration()`, `setInterpolator()`, `setListener()`
- **`WindowCallbackWrapper`** — 26 function(s): `WindowCallbackWrapper()`, `if()`, `IllegalArgumentException()`, `dispatchKeyEvent()`, `dispatchKeyShortcutEvent()`, `dispatchTouchEvent()`, `dispatchTrackballEvent()`, `dispatchGenericMotionEvent()`, `dispatchPopulateAccessibilityEvent()`, `onCreatePanelView()`, `onCreatePanelMenu()`, `onPreparePanel()`, `onMenuOpened()`, `onMenuItemSelected()`, `onWindowAttributesChanged()`, `onContentChanged()`, `onWindowFocusChanged()`, `onAttachedToWindow()`, `onDetachedFromWindow()`, `onPanelClosed()`, `onSearchRequested()`, `onWindowStartingActionMode()`, `onActionModeStarted()`, `onActionModeFinished()`, `onProvideKeyboardShortcuts()`, `onPointerCaptureChanged()`

</details>

### Package `android.support.v7.view.menu`  (26 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `ActionMenuItem` | class | SupportMenuItem | 407 | 81 |
| `ActionMenuItemView` | class | AppCompatTextView implements MenuView.ItemView, View.OnClickListener, ActionMenuView.Ac... | 267 | 65 |
| `BaseMenuPresenter` | class | MenuPresenter | 172 | 37 |
| `BaseMenuWrapper` | class | BaseWrapper<T> | 97 | 21 |
| `BaseWrapper` | class | — | 19 | 4 |
| `CascadingMenuPopup` | class | MenuPopup implements MenuPresenter, View.OnKeyListener, PopupWindow.OnDismissListener | 563 | 103 |
| `ExpandedMenuView` | class | ListView implements MenuBuilder.ItemInvoker, MenuView, AdapterView.OnItemClickListener | 63 | 16 |
| `ListMenuItemView` | class | LinearLayout implements MenuView.ItemView, AbsListView.SelectionBoundsAdjuster | 291 | 75 |
| `ListMenuPresenter` | class | MenuPresenter, AdapterView.OnItemClickListener | 247 | 54 |
| `MenuAdapter` | class | BaseAdapter | 102 | 19 |
| `MenuBuilder` | class | SupportMenu | 970 | 266 |
| `MenuDialogHelper` | class | DialogInterface.OnKeyListener, DialogInterface.OnClickListener, DialogInterface.OnDismi... | 111 | 19 |
| `MenuHelper` | class | — | 11 | 2 |
| `MenuItemImpl` | class | SupportMenuItem | 703 | 150 |
| `MenuItemWrapperICS` | class | BaseMenuWrapper<SupportMenuItem> implements MenuItem | 439 | 113 |
| `MenuItemWrapperJB` | class | MenuItemWrapperICS | 74 | 14 |
| `MenuPopup` | class | ShowableListMenu, MenuPresenter, AdapterView.OnItemClickListener | 130 | 32 |
| `MenuPopupHelper` | class | MenuHelper | 202 | 45 |
| `MenuPresenter` | class | — | 43 | 14 |
| `MenuView` | class | — | 37 | 12 |
| `MenuWrapperFactory` | class | — | 34 | 9 |
| `MenuWrapperICS` | class | BaseMenuWrapper<SupportMenu> implements Menu | 151 | 46 |
| `ShowableListMenu` | class | — | 17 | 4 |
| `StandardMenuPopup` | class | MenuPopup implements PopupWindow.OnDismissListener, AdapterView.OnItemClickListener, Me... | 284 | 52 |
| `SubMenuBuilder` | class | MenuBuilder implements SubMenu | 135 | 29 |
| `SubMenuWrapperICS` | class | MenuWrapperICS implements SubMenu | 77 | 22 |

<details>
<summary><b>Function list for <code>android.support.v7.view.menu</code></b> (click to expand)</summary>

- **`ActionMenuItem`** — 57 function(s): `collapseActionView()`, `expandActionView()`, `getActionView()`, `getMenuInfo()`, `getSubMenu()`, `getSupportActionProvider()`, `hasSubMenu()`, `isActionViewExpanded()`, `setShowAsAction()`, `ActionMenuItem()`, `getAlphabeticShortcut()`, `getAlphabeticModifiers()`, `getGroupId()`, `getIcon()`, `getIntent()`, `getItemId()`, `getNumericShortcut()`, `getNumericModifiers()`, `getOrder()`, `getTitle()`, `getTitleCondensed()`, `isCheckable()`, `return()`, `isChecked()`, `isEnabled()`, `isVisible()`, `setAlphabeticShortcut()`, `setCheckable()`, `setExclusiveCheckable()`, `setChecked()`, `setEnabled()`, `setIcon()`, `applyIconTint()`, `setIntent()`, `setNumericShortcut()`, `setOnMenuItemClickListener()`, `setShortcut()`, `setTitle()`, `setTitleCondensed()`, `setVisible()`, `invoke()`, `if()`, `setActionView()`, `UnsupportedOperationException()`, `setActionProvider()`, `getActionProvider()`, `setSupportActionProvider()`, `setShowAsActionFlags()`, `setOnActionExpandListener()`, `setContentDescription()`, `getContentDescription()`, `setTooltipText()`, `getTooltipText()`, `setIconTintList()`, `getIconTintList()`, `setIconTintMode()`, `getIconTintMode()`
- **`ActionMenuItemView`** — 38 function(s): `getPopup()`, `prefersCondensedTitle()`, `setCheckable()`, `setChecked()`, `setShortcut()`, `showsIcon()`, `ActionMenuItemView()`, `this()`, `super()`, `setOnClickListener()`, `setSaveEnabled()`, `onConfigurationChanged()`, `updateTextButtonVisibility()`, `shouldAllowTextWithIcon()`, `setPadding()`, `getItemData()`, `initialize()`, `setIcon()`, `setTitle()`, `setId()`, `setVisibility()`, `setEnabled()`, `if()`, `onTouchEvent()`, `onClick()`, `setItemInvoker()`, `setPopupCallback()`, `setExpandedFormat()`, `setText()`, `setContentDescription()`, `setCompoundDrawables()`, `hasText()`, `needsDividerBefore()`, `needsDividerAfter()`, `onMeasure()`, `ActionMenuItemForwardingListener()`, `onForwardingStarted()`, `onRestoreInstanceState()`
- **`BaseMenuPresenter`** — 23 function(s): `bindItemView()`, `collapseItemActionView()`, `expandItemActionView()`, `flagActionItems()`, `shouldIncludeItem()`, `BaseMenuPresenter()`, `initForMenu()`, `getMenuView()`, `if()`, `updateMenuView()`, `for()`, `addItemView()`, `while()`, `filterLeftoverView()`, `setCallback()`, `getCallback()`, `createItemView()`, `return()`, `getItemView()`, `onCloseMenu()`, `onSubMenuSelected()`, `getId()`, `setId()`
- **`BaseMenuWrapper`** — 9 function(s): `BaseMenuWrapper()`, `super()`, `getMenuItemWrapper()`, `if()`, `getSubMenuWrapper()`, `internalClear()`, `internalRemoveGroup()`, `while()`, `internalRemoveItem()`
- **`BaseWrapper`** — 4 function(s): `BaseWrapper()`, `if()`, `IllegalArgumentException()`, `getWrappedObject()`
- **`CascadingMenuPopup`** — 41 function(s): `onGlobalLayout()`, `if()`, `while()`, `onViewAttachedToWindow()`, `onViewDetachedFromWindow()`, `onItemHoverExit()`, `onItemHoverEnter()`, `run()`, `closeMenuOnSubMenuOpened()`, `flagActionItems()`, `onRestoreInstanceState()`, `onSaveInstanceState()`, `CascadingMenuPopup()`, `setForceShowIcon()`, `createPopupWindow()`, `show()`, `showMenu()`, `dismiss()`, `for()`, `onKey()`, `getInitialMenuPosition()`, `getNextMenuPosition()`, `addMenu()`, `findMenuItemForSubmenu()`, `findParentViewForSubmenu()`, `isShowing()`, `onDismiss()`, `updateMenuView()`, `toMenuAdapter()`, `setCallback()`, `onSubMenuSelected()`, `findIndexOfAddedMenu()`, `onCloseMenu()`, `setGravity()`, `setAnchorView()`, `setOnDismissListener()`, `getListView()`, `setHorizontalOffset()`, `setVerticalOffset()`, `setShowTitle()`, `CascadingMenuInfo()`
- **`ExpandedMenuView`** — 13 function(s): `ExpandedMenuView()`, `this()`, `super()`, `setOnItemClickListener()`, `if()`, `setBackgroundDrawable()`, `setDivider()`, `initialize()`, `onDetachedFromWindow()`, `setChildrenDrawingCacheEnabled()`, `invokeItem()`, `onItemClick()`, `getWindowAnimations()`
- **`ListMenuItemView`** — 28 function(s): `prefersCondensedTitle()`, `ListMenuItemView()`, `this()`, `super()`, `onFinishInflate()`, `if()`, `initialize()`, `setVisibility()`, `setTitle()`, `setCheckable()`, `setShortcut()`, `setIcon()`, `setEnabled()`, `setSubMenuArrowVisible()`, `setContentDescription()`, `addContentView()`, `addView()`, `setForceShowIcon()`, `getItemData()`, `insertRadioButton()`, `insertCheckBox()`, `setChecked()`, `insertIconView()`, `onMeasure()`, `showsIcon()`, `getInflater()`, `setGroupDividerEnabled()`, `adjustListItemSelectionBounds()`
- **`ListMenuPresenter`** — 31 function(s): `collapseItemActionView()`, `expandItemActionView()`, `flagActionItems()`, `ListMenuPresenter()`, `this()`, `initForMenu()`, `if()`, `getMenuView()`, `getAdapter()`, `updateMenuView()`, `setCallback()`, `onSubMenuSelected()`, `MenuDialogHelper()`, `onCloseMenu()`, `getItemIndexOffset()`, `setItemIndexOffset()`, `onItemClick()`, `saveHierarchyState()`, `restoreHierarchyState()`, `setId()`, `getId()`, `onSaveInstanceState()`, `onRestoreInstanceState()`, `getItemId()`, `MenuAdapter()`, `findExpandedIndex()`, `getCount()`, `getItem()`, `getView()`, `for()`, `notifyDataSetChanged()`
- **`MenuAdapter`** — 12 function(s): `getItemId()`, `MenuAdapter()`, `findExpandedIndex()`, `getForceShowIcon()`, `setForceShowIcon()`, `getCount()`, `if()`, `getAdapterMenu()`, `getItem()`, `getView()`, `for()`, `notifyDataSetChanged()`
- **`MenuBuilder`** — 89 function(s): `onMenuItemSelected()`, `onMenuModeChange()`, `invokeItem()`, `getActionViewStatesKey()`, `getRootMenu()`, `MenuBuilder()`, `setShortcutsVisibleInner()`, `setDefaultShowAsAction()`, `addMenuPresenter()`, `removeMenuPresenter()`, `while()`, `if()`, `dispatchPresenterUpdate()`, `stopDispatchingItemsChanged()`, `startDispatchingItemsChanged()`, `dispatchSubMenuSelected()`, `dispatchSaveInstanceState()`, `dispatchRestoreInstanceState()`, `savePresenterStates()`, `restorePresenterStates()`, `saveActionViewStates()`, `for()`, `restoreActionViewStates()`, `setCallback()`, `addInternal()`, `onItemsChanged()`, `createNewMenuItem()`, `MenuItemImpl()`, `add()`, `addSubMenu()`, `setGroupDividerEnabled()`, `isGroupDividerEnabled()`, `addIntentOptions()`, `removeGroup()`, `removeItem()`, `removeItemAtInt()`, `removeItemAt()`, `clearAll()`, `clear()`, `clearHeader()`, `collapseItemActionView()`, `setExclusiveItemChecked()`, `setGroupCheckable()`, `setGroupVisible()`, `setGroupEnabled()`, `hasVisibleItems()`, `findItem()`, `findItemIndex()`, `findGroupIndex()`, `size()`, `getItem()`, `isShortcutKey()`, `findItemWithShortcutForKey()`, `setQwertyMode()`, `getOrdering()`, `IllegalArgumentException()`, `return()`, `isQwertyMode()`, `setShortcutsVisible()`, `isShortcutsVisible()`, `getResources()`, `getContext()`, `dispatchMenuItemSelected()`, `changeMenuMode()`, `findInsertIndex()`, `performShortcut()`, `close()`, `findItemsWithShortcutForKey()`, `performIdentifierAction()`, `performItemAction()`, `onItemVisibleChanged()`, `onItemActionRequestChanged()`, `getVisibleItems()`, `flagActionItems()`, `getActionItems()`, `getNonActionItems()`, `setHeaderInternal()`, `setHeaderTitleInt()`, `setHeaderIconInt()`, `setHeaderViewInt()`, `getHeaderTitle()`, `getHeaderIcon()`, `getHeaderView()`, `setCurrentMenuInfo()`, `setOptionalIconsVisible()`, `getOptionalIconsVisible()`, `expandItemActionView()`, `getExpandedItem()`, `setOverrideVisibleItems()`
- **`MenuDialogHelper`** — 10 function(s): `MenuDialogHelper()`, `show()`, `if()`, `onKey()`, `setPresenterCallback()`, `dismiss()`, `onDismiss()`, `onCloseMenu()`, `onOpenSubMenu()`, `onClick()`
- **`MenuHelper`** — 2 function(s): `dismiss()`, `setPresenterCallback()`
- **`MenuItemImpl`** — 83 function(s): `MenuItemImpl()`, `invoke()`, `if()`, `isEnabled()`, `return()`, `setEnabled()`, `getGroupId()`, `getItemId()`, `getOrder()`, `getOrdering()`, `getIntent()`, `setIntent()`, `getCallback()`, `setCallback()`, `getAlphabeticShortcut()`, `setAlphabeticShortcut()`, `getAlphabeticModifiers()`, `getNumericShortcut()`, `getNumericModifiers()`, `setNumericShortcut()`, `setShortcut()`, `getShortcut()`, `getShortcutLabel()`, `appendModifier()`, `shouldShowShortcut()`, `getSubMenu()`, `hasSubMenu()`, `setSubMenu()`, `getTitle()`, `getTitleForItemView()`, `getTitleCondensed()`, `setTitle()`, `setTitleCondensed()`, `getIcon()`, `applyIconTintIfNecessary()`, `setIcon()`, `setIconTintList()`, `getIconTintList()`, `setIconTintMode()`, `getIconTintMode()`, `isCheckable()`, `setCheckable()`, `setExclusiveCheckable()`, `isExclusiveCheckable()`, `isChecked()`, `setChecked()`, `setCheckedInt()`, `isVisible()`, `setVisibleInt()`, `setVisible()`, `setOnMenuItemClickListener()`, `toString()`, `setMenuInfo()`, `getMenuInfo()`, `actionFormatChanged()`, `shouldShowIcon()`, `isActionButton()`, `requestsActionButton()`, `requiresActionButton()`, `setIsActionButton()`, `showsTextAsAction()`, `setShowAsAction()`, `switch()`, `IllegalArgumentException()`, `setActionView()`, `getActionView()`, `setActionProvider()`, `UnsupportedOperationException()`, `getActionProvider()`, `getSupportActionProvider()`, `setSupportActionProvider()`, `onActionProviderVisibilityChanged()`, `setShowAsActionFlags()`, `expandActionView()`, `collapseActionView()`, `hasCollapsibleActionView()`, `setActionViewExpanded()`, `isActionViewExpanded()`, `setOnActionExpandListener()`, `setContentDescription()`, `getContentDescription()`, `setTooltipText()`, `getTooltipText()`
- **`MenuItemWrapperICS`** — 69 function(s): `MenuItemWrapperICS()`, `super()`, `getItemId()`, `return()`, `getGroupId()`, `getOrder()`, `setTitle()`, `getTitle()`, `setTitleCondensed()`, `getTitleCondensed()`, `setIcon()`, `getIcon()`, `setIntent()`, `getIntent()`, `setShortcut()`, `setNumericShortcut()`, `getNumericShortcut()`, `getNumericModifiers()`, `setAlphabeticShortcut()`, `getAlphabeticShortcut()`, `getAlphabeticModifiers()`, `setCheckable()`, `isCheckable()`, `setChecked()`, `isChecked()`, `setVisible()`, `isVisible()`, `setEnabled()`, `isEnabled()`, `hasSubMenu()`, `getSubMenu()`, `getSubMenuWrapper()`, `setOnMenuItemClickListener()`, `getMenuInfo()`, `setShowAsAction()`, `setShowAsActionFlags()`, `setActionView()`, `if()`, `getActionView()`, `setActionProvider()`, `getActionProvider()`, `expandActionView()`, `collapseActionView()`, `isActionViewExpanded()`, `setOnActionExpandListener()`, `setContentDescription()`, `getContentDescription()`, `setTooltipText()`, `getTooltipText()`, `setIconTintList()`, `getIconTintList()`, `setIconTintMode()`, `getIconTintMode()`, `setExclusiveCheckable()`, `createActionProviderWrapper()`, `ActionProviderWrapper()`, `OnMenuItemClickListenerWrapper()`, `onMenuItemClick()`, `OnActionExpandListenerWrapper()`, `onMenuItemActionExpand()`, `onMenuItemActionCollapse()`, `onCreateActionView()`, `onPerformDefaultAction()`, `onPrepareSubMenu()`, `CollapsibleActionViewWrapper()`, `addView()`, `onActionViewExpanded()`, `onActionViewCollapsed()`, `getWrappedView()`
- **`MenuItemWrapperJB`** — 11 function(s): `MenuItemWrapperJB()`, `super()`, `createActionProviderWrapper()`, `ActionProviderWrapperJB()`, `onCreateActionView()`, `overridesItemVisibility()`, `isVisible()`, `refreshVisibility()`, `setVisibilityListener()`, `if()`, `onActionProviderVisibilityChanged()`
- **`MenuPopup`** — 24 function(s): `addMenu()`, `closeMenuOnSubMenuOpened()`, `collapseItemActionView()`, `expandItemActionView()`, `getId()`, `initForMenu()`, `setAnchorView()`, `setForceShowIcon()`, `setGravity()`, `setHorizontalOffset()`, `setOnDismissListener()`, `setShowTitle()`, `setVerticalOffset()`, `setEpicenterBounds()`, `getEpicenterBounds()`, `getMenuView()`, `UnsupportedOperationException()`, `onItemClick()`, `toMenuAdapter()`, `measureIndividualMenuWidth()`, `for()`, `if()`, `return()`, `shouldPreserveIconSpacing()`
- **`MenuPopupHelper`** — 19 function(s): `MenuPopupHelper()`, `this()`, `onDismiss()`, `setOnDismissListener()`, `setAnchorView()`, `setForceShowIcon()`, `if()`, `setGravity()`, `getGravity()`, `show()`, `IllegalStateException()`, `getPopup()`, `tryShow()`, `showPopup()`, `createPopup()`, `dismiss()`, `isShowing()`, `setPresenterCallback()`, `getListView()`
- **`MenuPresenter`** — 13 function(s): `onCloseMenu()`, `onOpenSubMenu()`, `collapseItemActionView()`, `expandItemActionView()`, `flagActionItems()`, `getId()`, `getMenuView()`, `initForMenu()`, `onRestoreInstanceState()`, `onSaveInstanceState()`, `onSubMenuSelected()`, `setCallback()`, `updateMenuView()`
- **`MenuView`** — 11 function(s): `getItemData()`, `initialize()`, `prefersCondensedTitle()`, `setCheckable()`, `setChecked()`, `setEnabled()`, `setIcon()`, `setShortcut()`, `setTitle()`, `showsIcon()`, `getWindowAnimations()`
- **`MenuWrapperFactory`** — 9 function(s): `MenuWrapperFactory()`, `wrapSupportMenu()`, `MenuWrapperICS()`, `wrapSupportMenuItem()`, `if()`, `MenuItemWrapperJB()`, `MenuItemWrapperICS()`, `wrapSupportSubMenu()`, `SubMenuWrapperICS()`
- **`MenuWrapperICS`** — 28 function(s): `MenuWrapperICS()`, `super()`, `add()`, `getMenuItemWrapper()`, `addSubMenu()`, `getSubMenuWrapper()`, `addIntentOptions()`, `if()`, `for()`, `removeItem()`, `internalRemoveItem()`, `removeGroup()`, `internalRemoveGroup()`, `clear()`, `internalClear()`, `setGroupCheckable()`, `setGroupVisible()`, `setGroupEnabled()`, `hasVisibleItems()`, `return()`, `findItem()`, `size()`, `getItem()`, `close()`, `performShortcut()`, `isShortcutKey()`, `performIdentifierAction()`, `setQwertyMode()`
- **`ShowableListMenu`** — 4 function(s): `dismiss()`, `getListView()`, `isShowing()`, `show()`
- **`StandardMenuPopup`** — 28 function(s): `onGlobalLayout()`, `if()`, `onViewAttachedToWindow()`, `onViewDetachedFromWindow()`, `addMenu()`, `flagActionItems()`, `onRestoreInstanceState()`, `onSaveInstanceState()`, `StandardMenuPopup()`, `setForceShowIcon()`, `setGravity()`, `tryShow()`, `show()`, `IllegalStateException()`, `dismiss()`, `isShowing()`, `onDismiss()`, `updateMenuView()`, `setCallback()`, `onSubMenuSelected()`, `onCloseMenu()`, `setAnchorView()`, `onKey()`, `setOnDismissListener()`, `getListView()`, `setHorizontalOffset()`, `setVerticalOffset()`, `setShowTitle()`
- **`SubMenuBuilder`** — 22 function(s): `SubMenuBuilder()`, `super()`, `setQwertyMode()`, `isQwertyMode()`, `setShortcutsVisible()`, `isShortcutsVisible()`, `getParentMenu()`, `getItem()`, `setCallback()`, `getRootMenu()`, `dispatchMenuItemSelected()`, `setIcon()`, `setHeaderIcon()`, `return()`, `setHeaderTitle()`, `setHeaderView()`, `expandItemActionView()`, `collapseItemActionView()`, `getActionViewStatesKey()`, `if()`, `setGroupDividerEnabled()`, `isGroupDividerEnabled()`
- **`SubMenuWrapperICS`** — 11 function(s): `SubMenuWrapperICS()`, `super()`, `getWrappedObject()`, `return()`, `setHeaderTitle()`, `setHeaderIcon()`, `setHeaderView()`, `clearHeader()`, `setIcon()`, `getItem()`, `getMenuItemWrapper()`

</details>

### Package `android.support.v7.viewpager`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `R` | class | — | 209 | 11 |

<details>
<summary><b>Function list for <code>android.support.v7.viewpager</code></b> (click to expand)</summary>

- **`R`** — 11 function(s): `R()`, `attr()`, `color()`, `dimen()`, `drawable()`, `id()`, `integer()`, `layout()`, `string()`, `style()`, `styleable()`

</details>

### Package `android.support.v7.widget`  (71 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `AbsActionBarView` | class | ViewGroup | 257 | 60 |
| `ActionBarBackgroundDrawable` | class | Drawable | 60 | 12 |
| `ActionBarContainer` | class | FrameLayout | 292 | 77 |
| `ActionBarContextView` | class | AbsActionBarView | 377 | 81 |
| `ActionBarOverlayLayout` | class | ViewGroup implements DecorContentParent, NestedScrollingParent | 638 | 177 |
| `ActionMenuPresenter` | class | BaseMenuPresenter implements ActionProvider.SubUiVisibilityListener | 740 | 149 |
| `ActionMenuView` | class | LinearLayoutCompat implements MenuBuilder.ItemInvoker, MenuView | 755 | 136 |
| `ActivityChooserModel` | class | DataSetObservable | 557 | 128 |
| `ActivityChooserView` | class | ViewGroup implements ActivityChooserModel.ActivityChooserModelClient | 589 | 128 |
| `AlertDialogLayout` | class | LinearLayoutCompat | 206 | 41 |
| `AppCompatAutoCompleteTextView` | class | AutoCompleteTextView implements TintableBackgroundView | 134 | 29 |
| `AppCompatBackgroundHelper` | class | — | 155 | 37 |
| `AppCompatButton` | class | Button implements TintableBackgroundView, AutoSizeableTextView | 253 | 55 |
| `AppCompatCheckBox` | class | CheckBox implements TintableCompoundButton | 89 | 19 |
| `AppCompatCheckedTextView` | class | CheckedTextView | 68 | 15 |
| `AppCompatCompoundButtonHelper` | class | — | 113 | 23 |
| `AppCompatDrawableManager` | class | LruCache<Integer, PorterDuffColorFilter> | 587 | 137 |
| `AppCompatEditText` | class | EditText implements TintableBackgroundView | 133 | 27 |
| `AppCompatHintHelper` | class | — | 31 | 6 |
| `AppCompatImageButton` | class | ImageButton implements TintableBackgroundView, TintableImageSourceView | 172 | 37 |
| `AppCompatImageHelper` | class | — | 163 | 36 |
| `AppCompatImageView` | class | ImageView implements TintableBackgroundView, TintableImageSourceView | 173 | 38 |
| `AppCompatMultiAutoCompleteTextView` | class | MultiAutoCompleteTextView implements TintableBackgroundView | 127 | 28 |
| `AppCompatPopupWindow` | class | PopupWindow | 75 | 18 |
| `AppCompatProgressBarHelper` | class | — | 108 | 18 |
| `AppCompatRadioButton` | class | RadioButton implements TintableCompoundButton | 92 | 19 |
| `AppCompatRatingBar` | class | RatingBar | 37 | 9 |
| `AppCompatSeekBar` | class | SeekBar | 45 | 9 |
| `AppCompatSeekBarHelper` | class | AppCompatProgressBarHelper | 152 | 34 |
| `AppCompatSpinner` | class | Spinner implements TintableBackgroundView | 650 | 150 |
| `AppCompatTextHelper` | class | — | 368 | 83 |
| `AppCompatTextView` | class | TextView implements TintableBackgroundView, AutoSizeableTextView | 324 | 70 |
| `AppCompatTextViewAutoSizeHelper` | class | — | 459 | 104 |
| `ButtonBarLayout` | class | LinearLayout | 120 | 33 |
| `ContentFrameLayout` | class | FrameLayout | 224 | 54 |
| `DecorContentParent` | class | — | 54 | 20 |
| `DecorToolbar` | class | — | 135 | 57 |
| `DialogTitle` | class | TextView | 52 | 13 |
| `DrawableUtils` | class | — | 192 | 43 |
| `DropDownListView` | class | ListView | 500 | 117 |
| `FitWindowsFrameLayout` | class | FrameLayout implements FitWindowsViewGroup | 36 | 7 |
| `FitWindowsLinearLayout` | class | LinearLayout implements FitWindowsViewGroup | 36 | 7 |
| `FitWindowsViewGroup` | class | — | 17 | 2 |
| `ForwardingListener` | class | View.OnTouchListener, View.OnAttachStateChangeListener | 202 | 38 |
| `LinearLayoutCompat` | class | ViewGroup | 1,413 | 267 |
| `ListPopupWindow` | class | ShowableListMenu | 835 | 168 |
| `MenuItemHoverListener` | class | — | 15 | 2 |
| `MenuPopupWindow` | class | ListPopupWindow implements MenuItemHoverListener | 216 | 33 |
| `PopupMenu` | class | — | 150 | 30 |
| `ResourcesWrapper` | class | Resources | 256 | 47 |
| `RtlSpacingHelper` | class | — | 82 | 16 |
| `ScrollingTabContainerView` | class | HorizontalScrollView implements AdapterView.OnItemSelectedListener | 529 | 134 |
| `SearchView` | class | LinearLayoutCompat implements CollapsibleActionView | 1,330 | 319 |
| `ShareActionProvider` | class | ActionProvider | 155 | 30 |
| `SuggestionsAdapter` | class | ResourceCursorAdapter implements View.OnClickListener | 509 | 100 |
| `SwitchCompat` | class | CompoundButton | 921 | 207 |
| `ThemeUtils` | class | — | 76 | 11 |
| `ThemedSpinnerAdapter` | class | SpinnerAdapter | 53 | 8 |
| `TintContextWrapper` | class | ContextWrapper | 92 | 18 |
| `TintInfo` | class | — | 21 | 1 |
| `TintResources` | class | ResourcesWrapper | 29 | 4 |
| `TintTypedArray` | class | — | 193 | 45 |
| `Toolbar` | class | ViewGroup | 1,735 | 431 |
| `ToolbarWidgetWrapper` | class | DecorToolbar | 619 | 147 |
| `TooltipCompat` | class | — | 21 | 3 |
| `TooltipCompatHandler` | class | View.OnLongClickListener, View.OnHoverListener, View.OnAttachStateChangeListener | 181 | 42 |
| `TooltipPopup` | class | — | 140 | 21 |
| `VectorEnabledTintResources` | class | Resources | 49 | 9 |
| `ViewStubCompat` | class | View | 138 | 34 |
| `ViewUtils` | class | — | 67 | 9 |
| `WithHint` | class | — | 12 | 1 |

<details>
<summary><b>Function list for <code>android.support.v7.widget</code></b> (click to expand)</summary>

- **`AbsActionBarView`** — 34 function(s): `next()`, `this()`, `AbsActionBarView()`, `super()`, `if()`, `onConfigurationChanged()`, `setContentHeight()`, `onTouchEvent()`, `onHoverEvent()`, `requestLayout()`, `getContentHeight()`, `getAnimatedVisibility()`, `getVisibility()`, `setupAnimatorToVisibility()`, `setAlpha()`, `animateToVisibility()`, `setVisibility()`, `showOverflowMenu()`, `postShowOverflowMenu()`, `post()`, `run()`, `hideOverflowMenu()`, `isOverflowMenuShowing()`, `isOverflowMenuShowPending()`, `isOverflowReserved()`, `canShowOverflowMenu()`, `dismissPopupMenus()`, `measureChildView()`, `positionChild()`, `VisibilityAnimListener()`, `withFinalVisibility()`, `onAnimationStart()`, `onAnimationEnd()`, `onAnimationCancel()`
- **`ActionBarBackgroundDrawable`** — 7 function(s): `getOpacity()`, `setAlpha()`, `setColorFilter()`, `ActionBarBackgroundDrawable()`, `draw()`, `if()`, `getOutline()`
- **`ActionBarContainer`** — 31 function(s): `startActionModeForChild()`, `ActionBarContainer()`, `this()`, `super()`, `if()`, `setWillNotDraw()`, `onFinishInflate()`, `setPrimaryBackground()`, `unscheduleDrawable()`, `invalidate()`, `setStackedBackground()`, `setSplitBackground()`, `setVisibility()`, `verifyDrawable()`, `return()`, `drawableStateChanged()`, `jumpDrawablesToCurrentState()`, `setTransitioning()`, `setDescendantFocusability()`, `onInterceptTouchEvent()`, `onTouchEvent()`, `onHoverEvent()`, `setTabContainer()`, `removeView()`, `addView()`, `getTabContainer()`, `isCollapsed()`, `getMeasuredHeightWithMargins()`, `onMeasure()`, `setMeasuredDimension()`, `onLayout()`
- **`ActionBarContextView`** — 35 function(s): `shouldDelayChildPressedState()`, `ActionBarContextView()`, `this()`, `super()`, `onDetachedFromWindow()`, `if()`, `setContentHeight()`, `setCustomView()`, `removeView()`, `addView()`, `requestLayout()`, `setTitle()`, `initTitle()`, `setSubtitle()`, `getTitle()`, `getSubtitle()`, `initForMode()`, `onClick()`, `closeMode()`, `killMode()`, `removeAllViews()`, `showOverflowMenu()`, `hideOverflowMenu()`, `isOverflowMenuShowing()`, `generateDefaultLayoutParams()`, `generateLayoutParams()`, `onMeasure()`, `IllegalStateException()`, `for()`, `setMeasuredDimension()`, `onLayout()`, `positionChild()`, `onInitializeAccessibilityEvent()`, `setTitleOptional()`, `isTitleOptional()`
- **`ActionBarOverlayLayout`** — 82 function(s): `enableContentAnimations()`, `hideForSystem()`, `onContentScrollStarted()`, `onContentScrollStopped()`, `onWindowVisibilityChanged()`, `showForSystem()`, `onNestedPreFling()`, `onNestedPreScroll()`, `setShowingForActionMode()`, `setUiOptions()`, `shouldDelayChildPressedState()`, `ActionBarOverlayLayout()`, `this()`, `super()`, `onAnimationEnd()`, `onAnimationCancel()`, `run()`, `init()`, `setWillNotDraw()`, `onDetachedFromWindow()`, `haltActionBarHideOffsetAnimations()`, `setActionBarVisibilityCallback()`, `if()`, `onWindowSystemUiVisibilityChanged()`, `setOverlayMode()`, `isInOverlayMode()`, `setHasNonEmbeddedTabs()`, `onConfigurationChanged()`, `pullChildren()`, `applyInsets()`, `fitSystemWindows()`, `requestLayout()`, `generateDefaultLayoutParams()`, `LayoutParams()`, `generateLayoutParams()`, `checkLayoutParams()`, `onMeasure()`, `measureChildWithMargins()`, `setMeasuredDimension()`, `onLayout()`, `getPaddingRight()`, `getPaddingBottom()`, `for()`, `draw()`, `onStartNestedScroll()`, `onNestedScrollAccepted()`, `onNestedScroll()`, `setActionBarHideOffset()`, `onStopNestedScroll()`, `postRemoveActionBarHideOffset()`, `postAddActionBarHideOffset()`, `onNestedFling()`, `addActionBarHideOffset()`, `removeActionBarHideOffset()`, `getNestedScrollAxes()`, `getDecorToolbar()`, `return()`, `IllegalStateException()`, `setHideOnContentScrollEnabled()`, `isHideOnContentScrollEnabled()`, `getActionBarHideOffset()`, `removeCallbacks()`, `postDelayed()`, `shouldHideActionBarOnFling()`, `setWindowCallback()`, `setWindowTitle()`, `getTitle()`, `initFeature()`, `hasIcon()`, `hasLogo()`, `setIcon()`, `setLogo()`, `canShowOverflowMenu()`, `isOverflowMenuShowing()`, `isOverflowMenuShowPending()`, `showOverflowMenu()`, `hideOverflowMenu()`, `setMenuPrepared()`, `setMenu()`, `saveToolbarHierarchyState()`, `restoreToolbarHierarchyState()`, `dismissPopups()`
- **`ActionMenuPresenter`** — 64 function(s): `ActionMenuPresenter()`, `super()`, `initForMenu()`, `if()`, `onConfigurationChanged()`, `setWidthLimit()`, `setReserveOverflow()`, `setItemLimit()`, `setExpandedActionViewsExclusive()`, `setOverflowIcon()`, `getOverflowIcon()`, `getMenuView()`, `getItemView()`, `bindItemView()`, `shouldIncludeItem()`, `updateMenuView()`, `for()`, `filterLeftoverView()`, `onSubMenuSelected()`, `while()`, `findViewForItem()`, `showOverflowMenu()`, `hideOverflowMenu()`, `dismissPopupMenus()`, `hideSubMenus()`, `isOverflowMenuShowing()`, `isOverflowMenuShowPending()`, `isOverflowReserved()`, `flagActionItems()`, `onCloseMenu()`, `onSaveInstanceState()`, `onRestoreInstanceState()`, `onSubUiVisibilityChanged()`, `setMenuView()`, `createFromParcel()`, `SavedState()`, `newArray()`, `describeContents()`, `writeToParcel()`, `needsDividerAfter()`, `needsDividerBefore()`, `OverflowMenuButton()`, `setClickable()`, `setFocusable()`, `setVisibility()`, `setEnabled()`, `setOnTouchListener()`, `getPopup()`, `onForwardingStarted()`, `onForwardingStopped()`, `performClick()`, `playSoundEffect()`, `setFrame()`, `OverflowPopup()`, `setGravity()`, `setPresenterCallback()`, `onDismiss()`, `ActionButtonSubmenu()`, `setAnchorView()`, `PopupPresenterCallback()`, `onOpenSubMenu()`, `OpenOverflowRunnable()`, `run()`, `ActionMenuPopupCallback()`
- **`ActionMenuView`** — 51 function(s): `needsDividerAfter()`, `needsDividerBefore()`, `onMenuItemClick()`, `dispatchPopulateAccessibilityEvent()`, `getWindowAnimations()`, `ActionMenuView()`, `this()`, `super()`, `setBaselineAligned()`, `setPopupTheme()`, `if()`, `getPopupTheme()`, `setPresenter()`, `onConfigurationChanged()`, `setOnMenuItemClickListener()`, `onMeasure()`, `onMeasureExactFormat()`, `for()`, `setMeasuredDimension()`, `while()`, `measureChildForCells()`, `onLayout()`, `hasSupportDividerBeforeChildAt()`, `onDetachedFromWindow()`, `dismissPopupMenus()`, `setOverflowIcon()`, `getMenu()`, `getOverflowIcon()`, `isOverflowReserved()`, `setOverflowReserved()`, `generateDefaultLayoutParams()`, `generateLayoutParams()`, `LayoutParams()`, `checkLayoutParams()`, `generateOverflowButtonLayoutParams()`, `invokeItem()`, `initialize()`, `setMenuCallbacks()`, `peekMenu()`, `showOverflowMenu()`, `hideOverflowMenu()`, `isOverflowMenuShowing()`, `isOverflowMenuShowPending()`, `return()`, `setExpandedActionViewsExclusive()`, `MenuBuilderCallback()`, `onMenuItemSelected()`, `onMenuModeChange()`, `onCloseMenu()`, `onOpenSubMenu()`, `ActionMenuPresenterCallback()`
- **`ActivityChooserModel`** — 44 function(s): `setActivityChooserModel()`, `sort()`, `onChooseActivity()`, `get()`, `synchronized()`, `if()`, `ActivityChooserModel()`, `setIntent()`, `ensureConsistentState()`, `getIntent()`, `getActivityCount()`, `getActivity()`, `getActivityIndex()`, `for()`, `chooseActivity()`, `addHistoricalRecord()`, `setOnChooseActivityListener()`, `getDefaultActivity()`, `setDefaultActivity()`, `persistHistoricalDataIfNeeded()`, `IllegalStateException()`, `PersistHistoryAsyncTask()`, `setActivitySorter()`, `notifyChanged()`, `setHistoryMaxSize()`, `pruneExcessiveHistoricalRecordsIfNeeded()`, `getHistoryMaxSize()`, `getHistorySize()`, `sortActivitiesIfNeeded()`, `loadActivitiesIfNeeded()`, `readHistoricalDataIfNeeded()`, `readHistoricalDataImpl()`, `HistoricalRecord()`, `this()`, `hashCode()`, `return()`, `equals()`, `toString()`, `ActivityResolveInfo()`, `compareTo()`, `DefaultSorter()`, `XmlPullParserException()`, `while()`, `doInBackground()`
- **`ActivityChooserView`** — 62 function(s): `ActivityChooserView()`, `this()`, `super()`, `onChanged()`, `onInvalidated()`, `onGlobalLayout()`, `if()`, `onInitializeAccessibilityNodeInfo()`, `getPopup()`, `onForwardingStarted()`, `onForwardingStopped()`, `setActivityChooserModel()`, `dismissPopup()`, `showPopup()`, `setExpandActivityOverflowButtonDrawable()`, `setExpandActivityOverflowButtonContentDescription()`, `setProvider()`, `showPopupUnchecked()`, `IllegalStateException()`, `getViewTreeObserver()`, `getListPopupWindow()`, `isShowingPopup()`, `onAttachedToWindow()`, `onDetachedFromWindow()`, `onMeasure()`, `measureChild()`, `setMeasuredDimension()`, `onLayout()`, `getDataModel()`, `setOnDismissListener()`, `setInitialActivityCount()`, `setDefaultActionButtonContentDescription()`, `updateAppearance()`, `Callbacks()`, `onItemClick()`, `switch()`, `IllegalArgumentException()`, `onClick()`, `onLongClick()`, `onDismiss()`, `notifyOnDismissListener()`, `getItemId()`, `getViewTypeCount()`, `ActivityChooserViewAdapter()`, `setDataModel()`, `notifyDataSetChanged()`, `getItemViewType()`, `return()`, `getCount()`, `getItem()`, `getView()`, `measureContentWidth()`, `for()`, `setMaxActivityCount()`, `getDefaultActivity()`, `setShowFooterView()`, `getActivityCount()`, `getHistorySize()`, `setShowDefaultActivity()`, `getShowDefaultActivity()`, `InnerLayout()`, `setBackgroundDrawable()`
- **`AlertDialogLayout`** — 12 function(s): `AlertDialogLayout()`, `super()`, `onMeasure()`, `if()`, `tryOnMeasure()`, `for()`, `setMeasuredDimension()`, `forceUniformWidth()`, `measureChildWithMargins()`, `resolveMinimumHeight()`, `onLayout()`, `setChildFrame()`
- **`AppCompatAutoCompleteTextView`** — 16 function(s): `AppCompatAutoCompleteTextView()`, `this()`, `super()`, `if()`, `setDropDownBackgroundDrawable()`, `setDropDownBackgroundResource()`, `setBackgroundResource()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `drawableStateChanged()`, `setTextAppearance()`, `onCreateInputConnection()`, `setCustomSelectionActionModeCallback()`
- **`AppCompatBackgroundHelper`** — 13 function(s): `AppCompatBackgroundHelper()`, `loadFromAttributes()`, `if()`, `setInternalBackgroundTint()`, `onSetBackgroundResource()`, `applySupportBackgroundTint()`, `onSetBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `shouldApplyFrameworkTintUsingColorFilter()`, `applyFrameworkTintUsingColorFilter()`
- **`AppCompatButton`** — 27 function(s): `AppCompatButton()`, `this()`, `super()`, `setBackgroundResource()`, `if()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `drawableStateChanged()`, `setTextAppearance()`, `onInitializeAccessibilityEvent()`, `onInitializeAccessibilityNodeInfo()`, `onLayout()`, `setTextSize()`, `onTextChanged()`, `setAutoSizeTextTypeWithDefaults()`, `setAutoSizeTextTypeUniformWithConfiguration()`, `setAutoSizeTextTypeUniformWithPresetSizes()`, `getAutoSizeTextType()`, `getAutoSizeStepGranularity()`, `getAutoSizeMinTextSize()`, `getAutoSizeMaxTextSize()`, `getAutoSizeTextAvailableSizes()`, `setSupportAllCaps()`, `setCustomSelectionActionModeCallback()`
- **`AppCompatCheckBox`** — 10 function(s): `AppCompatCheckBox()`, `this()`, `super()`, `setButtonDrawable()`, `if()`, `getCompoundPaddingLeft()`, `setSupportButtonTintList()`, `getSupportButtonTintList()`, `setSupportButtonTintMode()`, `getSupportButtonTintMode()`
- **`AppCompatCheckedTextView`** — 9 function(s): `AppCompatCheckedTextView()`, `this()`, `super()`, `setCheckMarkDrawable()`, `setTextAppearance()`, `if()`, `drawableStateChanged()`, `onCreateInputConnection()`, `setCustomSelectionActionModeCallback()`
- **`AppCompatCompoundButtonHelper`** — 12 function(s): `setButtonDrawable()`, `AppCompatCompoundButtonHelper()`, `loadFromAttributes()`, `if()`, `setSupportButtonTintList()`, `applyButtonTint()`, `getSupportButtonTintList()`, `setSupportButtonTintMode()`, `getSupportButtonTintMode()`, `onSetButtonDrawable()`, `getCompoundPaddingLeft()`, `return()`
- **`AppCompatDrawableManager`** — 44 function(s): `createFromXmlInner()`, `get()`, `synchronized()`, `if()`, `installDefaultInflateDelegates()`, `getDrawable()`, `checkVectorDrawableSetup()`, `onConfigurationChanged()`, `createCacheKey()`, `return()`, `createDrawableIfNeeded()`, `addDrawableToCache()`, `tintDrawable()`, `setPorterDuffColorFilter()`, `loadDrawableFromDelegates()`, `XmlPullParserException()`, `getCachedDrawable()`, `onDrawableLoadedFromResources()`, `tintDrawableUsingColorFilter()`, `addDelegate()`, `removeDelegate()`, `arrayContains()`, `for()`, `getTintMode()`, `getTintList()`, `addTintListToCache()`, `getTintListFromCache()`, `createDefaultButtonColorStateList()`, `createButtonColorStateList()`, `createBorderlessButtonColorStateList()`, `createColoredButtonColorStateList()`, `ColorStateList()`, `createSwitchThumbColorStateList()`, `ColorFilterLruCache()`, `super()`, `put()`, `generateCacheKey()`, `createTintFilter()`, `getPorterDuffColorFilter()`, `IllegalStateException()`, `isVectorDrawable()`, `VdcInflateDelegate()`, `AvdcInflateDelegate()`, `AsldcInflateDelegate()`
- **`AppCompatEditText`** — 15 function(s): `AppCompatEditText()`, `this()`, `super()`, `getText()`, `if()`, `setBackgroundResource()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `drawableStateChanged()`, `setTextAppearance()`, `onCreateInputConnection()`, `setCustomSelectionActionModeCallback()`
- **`AppCompatHintHelper`** — 4 function(s): `onCreateInputConnection()`, `if()`, `while()`, `AppCompatHintHelper()`
- **`AppCompatImageButton`** — 20 function(s): `AppCompatImageButton()`, `this()`, `super()`, `setImageResource()`, `setImageDrawable()`, `if()`, `setImageBitmap()`, `setImageURI()`, `setBackgroundResource()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `setSupportImageTintList()`, `getSupportImageTintList()`, `setSupportImageTintMode()`, `getSupportImageTintMode()`, `drawableStateChanged()`, `hasOverlappingRendering()`
- **`AppCompatImageHelper`** — 13 function(s): `AppCompatImageHelper()`, `loadFromAttributes()`, `if()`, `setImageResource()`, `applySupportImageTint()`, `hasOverlappingRendering()`, `setSupportImageTintList()`, `getSupportImageTintList()`, `setSupportImageTintMode()`, `getSupportImageTintMode()`, `setInternalImageTint()`, `shouldApplyFrameworkTintUsingColorFilter()`, `applyFrameworkTintUsingColorFilter()`
- **`AppCompatImageView`** — 20 function(s): `AppCompatImageView()`, `this()`, `super()`, `setImageResource()`, `if()`, `setImageDrawable()`, `setImageBitmap()`, `setImageURI()`, `setBackgroundResource()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `setSupportImageTintList()`, `getSupportImageTintList()`, `setSupportImageTintMode()`, `getSupportImageTintMode()`, `drawableStateChanged()`, `hasOverlappingRendering()`
- **`AppCompatMultiAutoCompleteTextView`** — 15 function(s): `AppCompatMultiAutoCompleteTextView()`, `this()`, `super()`, `if()`, `setDropDownBackgroundDrawable()`, `setDropDownBackgroundResource()`, `setBackgroundResource()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `drawableStateChanged()`, `setTextAppearance()`, `onCreateInputConnection()`
- **`AppCompatPopupWindow`** — 8 function(s): `AppCompatPopupWindow()`, `super()`, `init()`, `if()`, `setSupportOverlapAnchor()`, `setBackgroundDrawable()`, `showAsDropDown()`, `update()`
- **`AppCompatProgressBarHelper`** — 9 function(s): `AppCompatProgressBarHelper()`, `loadFromAttributes()`, `if()`, `tileify()`, `for()`, `tileifyIndeterminate()`, `getDrawableShape()`, `RoundRectShape()`, `getSampleTime()`
- **`AppCompatRadioButton`** — 10 function(s): `AppCompatRadioButton()`, `this()`, `super()`, `setButtonDrawable()`, `if()`, `getCompoundPaddingLeft()`, `setSupportButtonTintList()`, `getSupportButtonTintList()`, `setSupportButtonTintMode()`, `getSupportButtonTintMode()`
- **`AppCompatRatingBar`** — 6 function(s): `AppCompatRatingBar()`, `this()`, `super()`, `onMeasure()`, `if()`, `setMeasuredDimension()`
- **`AppCompatSeekBar`** — 6 function(s): `AppCompatSeekBar()`, `this()`, `super()`, `onDraw()`, `drawableStateChanged()`, `jumpDrawablesToCurrentState()`
- **`AppCompatSeekBarHelper`** — 15 function(s): `AppCompatSeekBarHelper()`, `super()`, `loadFromAttributes()`, `if()`, `setTickMark()`, `applyTickMarkTint()`, `getTickMark()`, `setTickMarkTintList()`, `getTickMarkTintList()`, `setTickMarkTintMode()`, `getTickMarkTintMode()`, `jumpDrawablesToCurrentState()`, `drawableStateChanged()`, `drawTickMarks()`, `for()`
- **`AppCompatSpinner`** — 66 function(s): `AppCompatSpinner()`, `this()`, `if()`, `super()`, `getPopup()`, `onForwardingStarted()`, `setAdapter()`, `getPopupContext()`, `setPopupBackgroundDrawable()`, `setPopupBackgroundResource()`, `getPopupBackground()`, `setDropDownVerticalOffset()`, `getDropDownVerticalOffset()`, `setDropDownHorizontalOffset()`, `getDropDownHorizontalOffset()`, `setDropDownWidth()`, `getDropDownWidth()`, `onDetachedFromWindow()`, `onTouchEvent()`, `onMeasure()`, `setMeasuredDimension()`, `performClick()`, `setPrompt()`, `getPrompt()`, `setBackgroundResource()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `drawableStateChanged()`, `compatMeasureContentWidth()`, `for()`, `getItemViewType()`, `getViewTypeCount()`, `DropDownAdapter()`, `getCount()`, `getItem()`, `getItemId()`, `getView()`, `getDropDownView()`, `hasStableIds()`, `registerDataSetObserver()`, `unregisterDataSetObserver()`, `areAllItemsEnabled()`, `isEnabled()`, `isEmpty()`, `DropdownPopup()`, `setAnchorView()`, `setModal()`, `setPromptPosition()`, `setOnItemClickListener()`, `onItemClick()`, `getHintText()`, `setPromptText()`, `computeContentWidth()`, `setContentWidth()`, `setHorizontalOffset()`, `show()`, `setInputMethodMode()`, `getListView()`, `setSelection()`, `onGlobalLayout()`, `setOnDismissListener()`, `onDismiss()`, `isVisibleToUser()`
- **`AppCompatTextHelper`** — 26 function(s): `AppCompatTextHelper()`, `loadFromAttributes()`, `if()`, `updateTypefaceAndStyle()`, `setAllCaps()`, `onFontRetrievalFailed()`, `onFontRetrieved()`, `switch()`, `onAsyncTypefaceReceived()`, `onSetTextAppearance()`, `applyCompoundDrawablesTints()`, `applyCompoundDrawableTint()`, `createTintInfo()`, `onLayout()`, `autoSizeText()`, `setTextSize()`, `setTextSizeInternal()`, `isAutoSizeEnabled()`, `setAutoSizeTextTypeWithDefaults()`, `setAutoSizeTextTypeUniformWithConfiguration()`, `setAutoSizeTextTypeUniformWithPresetSizes()`, `getAutoSizeTextType()`, `getAutoSizeStepGranularity()`, `getAutoSizeMinTextSize()`, `getAutoSizeMaxTextSize()`, `getAutoSizeTextAvailableSizes()`
- **`AppCompatTextView`** — 38 function(s): `AppCompatTextView()`, `this()`, `super()`, `setBackgroundResource()`, `if()`, `setBackgroundDrawable()`, `setSupportBackgroundTintList()`, `getSupportBackgroundTintList()`, `setSupportBackgroundTintMode()`, `getSupportBackgroundTintMode()`, `setTextAppearance()`, `drawableStateChanged()`, `onLayout()`, `setTextSize()`, `onTextChanged()`, `setAutoSizeTextTypeWithDefaults()`, `setAutoSizeTextTypeUniformWithConfiguration()`, `setAutoSizeTextTypeUniformWithPresetSizes()`, `getAutoSizeTextType()`, `getAutoSizeStepGranularity()`, `getAutoSizeMinTextSize()`, `getAutoSizeMaxTextSize()`, `getAutoSizeTextAvailableSizes()`, `onCreateInputConnection()`, `setFirstBaselineToTopHeight()`, `setLastBaselineToBottomHeight()`, `getFirstBaselineToTopHeight()`, `getLastBaselineToBottomHeight()`, `setLineHeight()`, `setCustomSelectionActionModeCallback()`, `getTextMetricsParamsCompat()`, `setTextMetricsParamsCompat()`, `setPrecomputedText()`, `consumeTextFutureAndSetBlocking()`, `getText()`, `setTextFuture()`, `requestLayout()`, `onMeasure()`
- **`AppCompatTextViewAutoSizeHelper`** — 36 function(s): `AppCompatTextViewAutoSizeHelper()`, `loadFromAttributes()`, `if()`, `setupAutoSizeUniformPresetSizes()`, `validateAndSetAutoSizeTextTypeUniformConfiguration()`, `setupAutoSizeText()`, `setAutoSizeTextTypeWithDefaults()`, `switch()`, `clearAutoSizeConfiguration()`, `autoSizeText()`, `IllegalArgumentException()`, `setAutoSizeTextTypeUniformWithConfiguration()`, `setAutoSizeTextTypeUniformWithPresetSizes()`, `for()`, `getAutoSizeTextType()`, `getAutoSizeStepGranularity()`, `getAutoSizeMinTextSize()`, `getAutoSizeMaxTextSize()`, `getAutoSizeTextAvailableSizes()`, `setupAutoSizeUniformPresetSizesConfiguration()`, `cleanupAutoSizePresetSizes()`, `while()`, `synchronized()`, `setTextSizeInternal()`, `setRawTextSize()`, `findLargestTextSizeWhichFits()`, `IllegalStateException()`, `suggestedSizeFitsInSpace()`, `return()`, `createStaticLayoutForMeasuring()`, `createStaticLayoutForMeasuringPre23()`, `StaticLayout()`, `invokeAndReturnWithDefault()`, `getTextViewMethod()`, `isAutoSizeEnabled()`, `supportsAutoSizeText()`
- **`ButtonBarLayout`** — 17 function(s): `ButtonBarLayout()`, `super()`, `setAllowStacking()`, `if()`, `setStacked()`, `requestLayout()`, `onMeasure()`, `setMinimumHeight()`, `getNextVisibleChildIndex()`, `while()`, `getMinimumHeight()`, `setOrientation()`, `setGravity()`, `for()`, `bringChildToFront()`, `isStacked()`, `getOrientation()`
- **`ContentFrameLayout`** — 19 function(s): `onAttachedFromWindow()`, `onDetachedFromWindow()`, `ContentFrameLayout()`, `this()`, `super()`, `dispatchFitSystemWindows()`, `fitSystemWindows()`, `setAttachListener()`, `setDecorPadding()`, `if()`, `requestLayout()`, `onMeasure()`, `getMinWidthMajor()`, `getMinWidthMinor()`, `getFixedWidthMajor()`, `getFixedWidthMinor()`, `getFixedHeightMajor()`, `getFixedHeightMinor()`, `onAttachedToWindow()`
- **`DecorContentParent`** — 19 function(s): `canShowOverflowMenu()`, `dismissPopups()`, `getTitle()`, `hasIcon()`, `hasLogo()`, `hideOverflowMenu()`, `initFeature()`, `isOverflowMenuShowPending()`, `isOverflowMenuShowing()`, `restoreToolbarHierarchyState()`, `saveToolbarHierarchyState()`, `setIcon()`, `setLogo()`, `setMenu()`, `setMenuPrepared()`, `setUiOptions()`, `setWindowCallback()`, `setWindowTitle()`, `showOverflowMenu()`
- **`DecorToolbar`** — 53 function(s): `animateToVisibility()`, `canShowOverflowMenu()`, `collapseActionView()`, `dismissPopupMenus()`, `getContext()`, `getCustomView()`, `getDisplayOptions()`, `getDropdownItemCount()`, `getDropdownSelectedPosition()`, `getHeight()`, `getMenu()`, `getNavigationMode()`, `getSubtitle()`, `getTitle()`, `getViewGroup()`, `getVisibility()`, `hasEmbeddedTabs()`, `hasExpandedActionView()`, `hasIcon()`, `hasLogo()`, `hideOverflowMenu()`, `initIndeterminateProgress()`, `initProgress()`, `isOverflowMenuShowPending()`, `isOverflowMenuShowing()`, `isTitleTruncated()`, `restoreHierarchyState()`, `saveHierarchyState()`, `setBackgroundDrawable()`, `setCollapsible()`, `setCustomView()`, `setDefaultNavigationContentDescription()`, `setDefaultNavigationIcon()`, `setDisplayOptions()`, `setDropdownParams()`, `setDropdownSelectedPosition()`, `setEmbeddedTabView()`, `setHomeButtonEnabled()`, `setIcon()`, `setLogo()`, `setMenu()`, `setMenuCallbacks()`, `setMenuPrepared()`, `setNavigationContentDescription()`, `setNavigationIcon()`, `setNavigationMode()`, `setSubtitle()`, `setTitle()`, `setVisibility()`, `setWindowCallback()`, `setWindowTitle()`, `setupAnimatorToVisibility()`, `showOverflowMenu()`
- **`DialogTitle`** — 8 function(s): `DialogTitle()`, `super()`, `onMeasure()`, `if()`, `setSingleLine()`, `setMaxLines()`, `setTextSize()`, `setCustomSelectionActionModeCallback()`
- **`DrawableUtils`** — 9 function(s): `if()`, `DrawableUtils()`, `getOpticalBounds()`, `for()`, `switch()`, `fixDrawable()`, `fixVectorDrawableTinting()`, `canSafelyMutateDrawable()`, `parseTintMode()`
- **`DropDownListView`** — 51 function(s): `DropDownListView()`, `super()`, `setCacheColorHint()`, `isInTouchMode()`, `return()`, `hasWindowFocus()`, `isFocused()`, `hasFocus()`, `setSelector()`, `if()`, `drawableStateChanged()`, `setSelectorEnabled()`, `updateSelectorStateCompat()`, `dispatchDraw()`, `drawSelectorCompat()`, `onTouchEvent()`, `lookForSelectablePosition()`, `while()`, `measureHeightOfChildrenCompat()`, `getListPaddingLeft()`, `getListPaddingRight()`, `GateKeeperDrawable()`, `setEnabled()`, `setState()`, `draw()`, `setHotspot()`, `setHotspotBounds()`, `setVisible()`, `onHoverEvent()`, `setSelectionFromTop()`, `setSelection()`, `onDetachedFromWindow()`, `onForwardedEvent()`, `switch()`, `setPressedItem()`, `clickPressedItem()`, `clearPressedItem()`, `performItemClick()`, `setListSelectionHidden()`, `positionSelectorLikeTouchCompat()`, `positionSelectorLikeFocusCompat()`, `positionSelectorCompat()`, `refreshDrawableState()`, `setPressed()`, `drawableHotspotChanged()`, `layoutChildren()`, `touchModeDrawsInPressedStateCompat()`, `ResolveHoverRunnable()`, `run()`, `cancel()`, `post()`
- **`FitWindowsFrameLayout`** — 5 function(s): `FitWindowsFrameLayout()`, `super()`, `setOnFitSystemWindowsListener()`, `fitSystemWindows()`, `if()`
- **`FitWindowsLinearLayout`** — 5 function(s): `FitWindowsLinearLayout()`, `super()`, `setOnFitSystemWindowsListener()`, `fitSystemWindows()`, `if()`
- **`FitWindowsViewGroup`** — 2 function(s): `onFitSystemWindows()`, `setOnFitSystemWindowsListener()`
- **`ForwardingListener`** — 19 function(s): `getPopup()`, `onViewAttachedToWindow()`, `ForwardingListener()`, `onTouch()`, `if()`, `onViewDetachedFromWindow()`, `onForwardingStarted()`, `onForwardingStopped()`, `onTouchObserved()`, `switch()`, `clearCallbacks()`, `onLongPress()`, `onTouchForwarded()`, `toGlobalMotionEvent()`, `toLocalMotionEvent()`, `pointInView()`, `DisallowIntercept()`, `run()`, `TriggerLongPress()`
- **`LinearLayoutCompat`** — 66 function(s): `getChildrenSkipCount()`, `getLocationOffset()`, `getNextLocationOffset()`, `measureNullChild()`, `shouldDelayChildPressedState()`, `LinearLayoutCompat()`, `this()`, `super()`, `if()`, `setOrientation()`, `setGravity()`, `setBaselineAligned()`, `setDividerDrawable()`, `setShowDividers()`, `requestLayout()`, `getShowDividers()`, `getDividerDrawable()`, `setWillNotDraw()`, `setDividerPadding()`, `getDividerPadding()`, `getDividerWidth()`, `onDraw()`, `drawDividersVertical()`, `drawDividersHorizontal()`, `for()`, `drawHorizontalDivider()`, `drawVerticalDivider()`, `isBaselineAligned()`, `isMeasureWithLargestChildEnabled()`, `setMeasureWithLargestChildEnabled()`, `getBaseline()`, `RuntimeException()`, `getBaselineAlignedChildIndex()`, `setBaselineAlignedChildIndex()`, `IllegalArgumentException()`, `getVirtualChildAt()`, `getChildAt()`, `getVirtualChildCount()`, `getChildCount()`, `getWeightSum()`, `setWeightSum()`, `onMeasure()`, `measureVertical()`, `measureHorizontal()`, `hasDividerBeforeChildAt()`, `return()`, `while()`, `measureChildBeforeLayout()`, `setMeasuredDimension()`, `forceUniformWidth()`, `measureChildWithMargins()`, `forceUniformHeight()`, `onLayout()`, `layoutVertical()`, `layoutHorizontal()`, `setChildFrame()`, `getOrientation()`, `getGravity()`, `setHorizontalGravity()`, `setVerticalGravity()`, `generateLayoutParams()`, `LayoutParams()`, `generateDefaultLayoutParams()`, `checkLayoutParams()`, `onInitializeAccessibilityEvent()`, `onInitializeAccessibilityNodeInfo()`
- **`ListPopupWindow`** — 82 function(s): `isConfirmKey()`, `ListPopupWindow()`, `this()`, `if()`, `setAdapter()`, `setPromptPosition()`, `getPromptPosition()`, `setModal()`, `isModal()`, `setForceIgnoreOutsideTouch()`, `setDropDownAlwaysVisible()`, `isDropDownAlwaysVisible()`, `setSoftInputMode()`, `getSoftInputMode()`, `setListSelector()`, `getBackground()`, `setBackgroundDrawable()`, `setAnimationStyle()`, `getAnimationStyle()`, `getAnchorView()`, `setAnchorView()`, `getHorizontalOffset()`, `setHorizontalOffset()`, `getVerticalOffset()`, `setVerticalOffset()`, `setEpicenterBounds()`, `setDropDownGravity()`, `getWidth()`, `setWidth()`, `setContentWidth()`, `getHeight()`, `setHeight()`, `IllegalArgumentException()`, `setWindowLayoutType()`, `setOnItemClickListener()`, `setOnItemSelectedListener()`, `setPromptView()`, `removePromptView()`, `show()`, `postShow()`, `setPopupClipToScreenEnabled()`, `clearListSelection()`, `dismiss()`, `setOnDismissListener()`, `setInputMethodMode()`, `getInputMethodMode()`, `setSelection()`, `isShowing()`, `isInputMethodNotNeeded()`, `performItemClick()`, `getSelectedItem()`, `getSelectedItemPosition()`, `getSelectedItemId()`, `getSelectedView()`, `getListView()`, `createDropDownListView()`, `DropDownListView()`, `setListItemExpandMax()`, `onKeyDown()`, `switch()`, `onKeyUp()`, `onKeyPreIme()`, `createDragToOpenListener()`, `ForwardingListener()`, `getPopup()`, `buildDropDown()`, `run()`, `onNothingSelected()`, `onItemSelected()`, `setOverlapAnchor()`, `PopupDataSetObserver()`, `onChanged()`, `onInvalidated()`, `ListSelectorHider()`, `ResizePopupRunnable()`, `PopupTouchInterceptor()`, `onTouch()`, `onScroll()`, `PopupScrollListener()`, `onScrollStateChanged()`, `getMaxAvailableHeight()`, `return()`
- **`MenuItemHoverListener`** — 2 function(s): `onItemHoverEnter()`, `onItemHoverExit()`
- **`MenuPopupWindow`** — 16 function(s): `MenuPopupWindow()`, `super()`, `createDropDownListView()`, `setEnterTransition()`, `if()`, `setExitTransition()`, `setHoverListener()`, `setTouchModal()`, `onItemHoverEnter()`, `onItemHoverExit()`, `MenuDropDownListView()`, `clearSelection()`, `setSelection()`, `onKeyDown()`, `performItemClick()`, `onHoverEvent()`
- **`PopupMenu`** — 22 function(s): `onDismiss()`, `onMenuItemClick()`, `PopupMenu()`, `this()`, `onMenuModeChange()`, `onMenuItemSelected()`, `if()`, `setGravity()`, `getGravity()`, `getDragToOpenListener()`, `onForwardingStarted()`, `onForwardingStopped()`, `getPopup()`, `getMenu()`, `getMenuInflater()`, `SupportMenuInflater()`, `inflate()`, `show()`, `dismiss()`, `setOnMenuItemClickListener()`, `setOnDismissListener()`, `getMenuListView()`
- **`ResourcesWrapper`** — 40 function(s): `ResourcesWrapper()`, `super()`, `getText()`, `getQuantityText()`, `getString()`, `getQuantityString()`, `getTextArray()`, `getStringArray()`, `getIntArray()`, `obtainTypedArray()`, `getDimension()`, `getDimensionPixelOffset()`, `getDimensionPixelSize()`, `getFraction()`, `getDrawable()`, `getDrawableForDensity()`, `getMovie()`, `getColor()`, `getColorStateList()`, `getBoolean()`, `getInteger()`, `getLayout()`, `getAnimation()`, `getXml()`, `openRawResource()`, `openRawResourceFd()`, `getValue()`, `getValueForDensity()`, `obtainAttributes()`, `updateConfiguration()`, `if()`, `getDisplayMetrics()`, `getConfiguration()`, `getIdentifier()`, `getResourceName()`, `getResourcePackageName()`, `getResourceTypeName()`, `getResourceEntryName()`, `parseBundleExtras()`, `parseBundleExtra()`
- **`RtlSpacingHelper`** — 8 function(s): `getLeft()`, `getRight()`, `getStart()`, `getEnd()`, `setRelative()`, `if()`, `setAbsolute()`, `setDirection()`
- **`ScrollingTabContainerView`** — 58 function(s): `onNothingSelected()`, `ScrollingTabContainerView()`, `super()`, `setHorizontalScrollBarEnabled()`, `setContentHeight()`, `addView()`, `onMeasure()`, `setFillViewport()`, `if()`, `performCollapse()`, `performExpand()`, `setTabSelected()`, `isCollapsed()`, `setAllowCollapse()`, `removeView()`, `removeCallbacks()`, `while()`, `animateToTab()`, `requestLayout()`, `createTabLayout()`, `createSpinner()`, `onConfigurationChanged()`, `animateToVisibility()`, `setAlpha()`, `run()`, `post()`, `onAttachedToWindow()`, `onDetachedFromWindow()`, `createTabView()`, `addTab()`, `updateTab()`, `removeTabAt()`, `removeAllTabs()`, `onItemSelected()`, `TabView()`, `setBackgroundDrawable()`, `setGravity()`, `update()`, `bindTab()`, `setSelected()`, `sendAccessibilityEvent()`, `onInitializeAccessibilityEvent()`, `onInitializeAccessibilityNodeInfo()`, `getTab()`, `getItemId()`, `TabAdapter()`, `getCount()`, `getItem()`, `return()`, `getView()`, `TabClickListener()`, `onClick()`, `for()`, `VisibilityAnimListener()`, `withFinalVisibility()`, `onAnimationStart()`, `onAnimationEnd()`, `onAnimationCancel()`
- **`SearchView`** — 132 function(s): `onClose()`, `onQueryTextChange()`, `onQueryTextSubmit()`, `onSuggestionClick()`, `onSuggestionSelect()`, `SearchView()`, `this()`, `super()`, `run()`, `if()`, `onClick()`, `onKey()`, `onEditorAction()`, `onItemClick()`, `onNothingSelected()`, `onItemSelected()`, `afterTextChanged()`, `beforeTextChanged()`, `onTextChanged()`, `onFocusChange()`, `setIconifiedByDefault()`, `setMaxWidth()`, `setImeOptions()`, `setInputType()`, `setFocusable()`, `onLayoutChange()`, `updateViewsVisibility()`, `updateQueryHint()`, `getSuggestionRowLayout()`, `getSuggestionCommitIconResId()`, `setSearchableInfo()`, `updateSearchAutoComplete()`, `setAppSearchData()`, `getImeOptions()`, `getInputType()`, `requestFocus()`, `clearFocus()`, `setOnQueryTextListener()`, `setOnCloseListener()`, `setOnQueryTextFocusChangeListener()`, `setOnSuggestionListener()`, `setOnSearchClickListener()`, `getQuery()`, `setQuery()`, `onSubmitQuery()`, `setQueryHint()`, `getQueryHint()`, `getContext()`, `isIconfiedByDefault()`, `setIconified()`, `onCloseClicked()`, `onSearchClicked()`, `isIconified()`, `setSubmitButtonEnabled()`, `isSubmitButtonEnabled()`, `setQueryRefinementEnabled()`, `isQueryRefinementEnabled()`, `setSuggestionsAdapter()`, `getSuggestionsAdapter()`, `requestLayout()`, `getMaxWidth()`, `onMeasure()`, `onLayout()`, `getChildBoundsWithinSearchView()`, `setTouchDelegate()`, `getLocationInWindow()`, `getPreferredWidth()`, `getPreferredHeight()`, `updateSubmitButton()`, `updateCloseButton()`, `updateVoiceButton()`, `updateSubmitArea()`, `hasVoiceSearch()`, `return()`, `isSubmitAreaEnabled()`, `postUpdateFocusedState()`, `post()`, `updateFocusedState()`, `invalidate()`, `onDetachedFromWindow()`, `removeCallbacks()`, `onQueryRefine()`, `onSuggestionsKey()`, `onItemClicked()`, `getDecoratedHint()`, `launchQuerySearch()`, `dismissSuggestions()`, `onVoiceClicked()`, `onTextFocusChanged()`, `forceSuggestionQuery()`, `onWindowFocusChanged()`, `onActionViewCollapsed()`, `onActionViewExpanded()`, `createFromParcel()`, `SavedState()`, `newArray()`, `writeToParcel()`, `toString()`, `onSaveInstanceState()`, `onRestoreInstanceState()`, `adjustDropDownSizeAndPosition()`, `launchSuggestion()`, `rewriteQueryFromSuggestion()`, `launchIntent()`, `createIntent()`, `createVoiceWebSearchIntent()`, `createVoiceAppSearchIntent()`, `createIntentFromSuggestion()`, `isLandscapeMode()`, `UpdatableTouchDelegate()`, `setBounds()`, `onTouchEvent()`, `switch()`, `performCompletion()`, `replaceText()`, `SearchAutoComplete()`, `onFinishInflate()`, `setMinWidth()`, `setSearchView()`, `setThreshold()`, `isEmpty()`, `onFocusChanged()`, `enoughToFilter()`, `onKeyPreIme()`, `setImeVisibility()`, `getSearchViewTextMinWidthDp()`, `onCreateInputConnection()`, `showSoftInputIfNecessary()`, `AutoCompleteTextViewReflector()`, `doBeforeTextChanged()`, `doAfterTextChanged()`, `ensureImeVisible()`
- **`ShareActionProvider`** — 17 function(s): `onShareTargetSelected()`, `hasSubMenu()`, `ShareActionProvider()`, `super()`, `setOnShareTargetSelectedListener()`, `setActivityChooserPolicyIfNeeded()`, `onCreateActionView()`, `if()`, `onPrepareSubMenu()`, `for()`, `setShareHistoryFileName()`, `setShareIntent()`, `updateIntent()`, `ShareMenuItemOnMenuItemClickListener()`, `onMenuItemClick()`, `ShareActivityChooserModelPolicy()`, `onChooseActivity()`
- **`SuggestionsAdapter`** — 36 function(s): `hasStableIds()`, `SuggestionsAdapter()`, `super()`, `setQueryRefinement()`, `getQueryRefinement()`, `runQueryOnBackgroundThread()`, `if()`, `close()`, `changeCursor()`, `notifyDataSetChanged()`, `updateSpinnerState()`, `notifyDataSetInvalidated()`, `newView()`, `ChildViewCache()`, `bindView()`, `setViewText()`, `setViewDrawable()`, `onClick()`, `formatUrl()`, `getIcon1()`, `getIcon2()`, `getDrawableFromResourceValue()`, `convertToString()`, `getView()`, `getDropDownView()`, `storeInIconCache()`, `getDrawable()`, `getDrawableFromResourceUri()`, `FileNotFoundException()`, `checkIconCache()`, `getDefaultIcon1()`, `getActivityIconWithCache()`, `getActivityIcon()`, `getColumnString()`, `getStringOrNull()`, `getSearchManagerSuggestions()`
- **`SwitchCompat`** — 78 function(s): `get()`, `set()`, `constrain()`, `SwitchCompat()`, `this()`, `super()`, `if()`, `applyThumbTint()`, `applyTrackTint()`, `setSwitchTextAppearance()`, `refreshDrawableState()`, `setChecked()`, `requestLayout()`, `setSwitchTypefaceByIndex()`, `switch()`, `setSwitchTypeface()`, `invalidate()`, `setSwitchPadding()`, `getSwitchPadding()`, `setSwitchMinWidth()`, `getSwitchMinWidth()`, `setThumbTextPadding()`, `getThumbTextPadding()`, `setTrackDrawable()`, `setTrackResource()`, `getTrackDrawable()`, `setTrackTintList()`, `getTrackTintList()`, `setTrackTintMode()`, `getTrackTintMode()`, `setThumbDrawable()`, `setThumbResource()`, `getThumbDrawable()`, `setThumbTintList()`, `getThumbTintList()`, `setThumbTintMode()`, `getThumbTintMode()`, `setSplitTrack()`, `getSplitTrack()`, `getTextOn()`, `setTextOn()`, `getTextOff()`, `setTextOff()`, `setShowText()`, `getShowText()`, `onMeasure()`, `setMeasuredDimension()`, `onPopulateAccessibilityEvent()`, `makeLayout()`, `StaticLayout()`, `hitThumb()`, `onTouchEvent()`, `stopDrag()`, `getParent()`, `setThumbPosition()`, `cancelSuperTouch()`, `playSoundEffect()`, `animateThumbToCheckedState()`, `cancelPositionAnimator()`, `getTargetCheckedState()`, `toggle()`, `onLayout()`, `draw()`, `onDraw()`, `getCompoundPaddingLeft()`, `getCompoundPaddingRight()`, `getThumbOffset()`, `return()`, `getThumbScrollRange()`, `onCreateDrawableState()`, `mergeDrawableStates()`, `drawableStateChanged()`, `drawableHotspotChanged()`, `verifyDrawable()`, `jumpDrawablesToCurrentState()`, `onInitializeAccessibilityEvent()`, `onInitializeAccessibilityNodeInfo()`, `setCustomSelectionActionModeCallback()`
- **`ThemeUtils`** — 8 function(s): `createDisabledStateList()`, `ColorStateList()`, `getThemeAttrColor()`, `getThemeAttrColorStateList()`, `getDisabledThemeAttrColor()`, `if()`, `getTypedValue()`, `ThemeUtils()`
- **`ThemedSpinnerAdapter`** — 5 function(s): `getDropDownViewTheme()`, `setDropDownViewTheme()`, `Helper()`, `if()`, `getDropDownViewInflater()`
- **`TintContextWrapper`** — 11 function(s): `wrap()`, `if()`, `synchronized()`, `for()`, `shouldWrap()`, `TintContextWrapper()`, `super()`, `getTheme()`, `setTheme()`, `getResources()`, `getAssets()`
- **`TintInfo`** — 1 function(s): `clear()`
- **`TintResources`** — 4 function(s): `TintResources()`, `super()`, `getDrawable()`, `if()`
- **`TintTypedArray`** — 34 function(s): `obtainStyledAttributes()`, `TintTypedArray()`, `getDrawable()`, `if()`, `getDrawableIfKnown()`, `getFont()`, `length()`, `getIndexCount()`, `getIndex()`, `getResources()`, `getText()`, `getString()`, `getNonResourceString()`, `getBoolean()`, `getInt()`, `getFloat()`, `getColor()`, `getColorStateList()`, `return()`, `getInteger()`, `getDimension()`, `getDimensionPixelOffset()`, `getDimensionPixelSize()`, `getLayoutDimension()`, `getFraction()`, `getResourceId()`, `getTextArray()`, `getValue()`, `getType()`, `hasValue()`, `peekValue()`, `getPositionDescription()`, `recycle()`, `getChangingConfigurations()`
- **`Toolbar`** — 136 function(s): `onMenuItemClick()`, `Toolbar()`, `this()`, `super()`, `if()`, `run()`, `ensureContentInsets()`, `setTitle()`, `setSubtitle()`, `setPopupTheme()`, `setNavigationIcon()`, `setNavigationContentDescription()`, `setLogo()`, `setLogoDescription()`, `setTitleTextColor()`, `setSubtitleTextColor()`, `getPopupTheme()`, `setTitleMargin()`, `requestLayout()`, `getTitleMarginStart()`, `setTitleMarginStart()`, `getTitleMarginTop()`, `setTitleMarginTop()`, `getTitleMarginEnd()`, `setTitleMarginEnd()`, `getTitleMarginBottom()`, `setTitleMarginBottom()`, `onRtlPropertiesChanged()`, `canShowOverflowMenu()`, `getVisibility()`, `isOverflowMenuShowing()`, `isOverflowMenuShowPending()`, `showOverflowMenu()`, `hideOverflowMenu()`, `setMenu()`, `ensureMenuView()`, `dismissPopupMenus()`, `isTitleTruncated()`, `for()`, `ensureLogoView()`, `addSystemView()`, `removeView()`, `getLogo()`, `getLogoDescription()`, `hasExpandedActionView()`, `return()`, `collapseActionView()`, `getTitle()`, `getSubtitle()`, `setTitleTextAppearance()`, `setSubtitleTextAppearance()`, `getNavigationContentDescription()`, `ensureNavButtonView()`, `getNavigationIcon()`, `setNavigationOnClickListener()`, `getMenu()`, `ensureMenu()`, `setOverflowIcon()`, `getOverflowIcon()`, `getMenuInflater()`, `SupportMenuInflater()`, `inflateMenu()`, `setOnMenuItemClickListener()`, `setContentInsetsRelative()`, `getContentInsetStart()`, `getContentInsetEnd()`, `setContentInsetsAbsolute()`, `getContentInsetLeft()`, `getContentInsetRight()`, `getContentInsetStartWithNavigation()`, `setContentInsetStartWithNavigation()`, `getContentInsetEndWithActions()`, `setContentInsetEndWithActions()`, `getCurrentContentInsetStart()`, `getCurrentContentInsetEnd()`, `getCurrentContentInsetLeft()`, `getCurrentContentInsetRight()`, `ensureCollapseButtonView()`, `onClick()`, `addView()`, `onSaveInstanceState()`, `onRestoreInstanceState()`, `postShowOverflowMenu()`, `removeCallbacks()`, `post()`, `onDetachedFromWindow()`, `onTouchEvent()`, `onHoverEvent()`, `measureChildConstrained()`, `measureChildCollapseMargins()`, `shouldCollapse()`, `onMeasure()`, `setMeasuredDimension()`, `onLayout()`, `addCustomViewsWithGravity()`, `while()`, `getViewListMeasuredWidth()`, `layoutChildLeft()`, `layoutChildRight()`, `getChildTop()`, `getPaddingTop()`, `getChildVerticalGravity()`, `getChildHorizontalGravity()`, `shouldLayout()`, `getHorizontalMargins()`, `getVerticalMargins()`, `generateLayoutParams()`, `LayoutParams()`, `generateDefaultLayoutParams()`, `checkLayoutParams()`, `isCustomView()`, `getWrapper()`, `removeChildrenForExpandedActionView()`, `removeViewAt()`, `addChildrenForExpandedActionView()`, `isChildOrHidden()`, `setCollapsible()`, `setMenuCallbacks()`, `getOuterActionMenuPresenter()`, `getPopupContext()`, `copyMarginsFromCompat()`, `createFromParcel()`, `SavedState()`, `newArray()`, `writeToParcel()`, `flagActionItems()`, `getId()`, `getMenuView()`, `onCloseMenu()`, `onSubMenuSelected()`, `setCallback()`, `ExpandedActionViewMenuPresenter()`, `initForMenu()`, `updateMenuView()`, `collapseItemActionView()`, `expandItemActionView()`
- **`ToolbarWidgetWrapper`** — 69 function(s): `setHomeButtonEnabled()`, `ToolbarWidgetWrapper()`, `this()`, `if()`, `setTitle()`, `setSubtitle()`, `setLogo()`, `setIcon()`, `setNavigationIcon()`, `setDisplayOptions()`, `setCustomView()`, `setDefaultNavigationContentDescription()`, `onClick()`, `setNavigationContentDescription()`, `detectDisplayOptions()`, `getViewGroup()`, `getContext()`, `hasExpandedActionView()`, `collapseActionView()`, `setWindowCallback()`, `setWindowTitle()`, `setTitleInt()`, `getTitle()`, `getSubtitle()`, `initProgress()`, `initIndeterminateProgress()`, `hasIcon()`, `hasLogo()`, `updateToolbarLogo()`, `canShowOverflowMenu()`, `isOverflowMenuShowing()`, `isOverflowMenuShowPending()`, `showOverflowMenu()`, `hideOverflowMenu()`, `setMenuPrepared()`, `setMenu()`, `dismissPopupMenus()`, `getDisplayOptions()`, `updateHomeAccessibility()`, `updateNavigationIcon()`, `setEmbeddedTabView()`, `hasEmbeddedTabs()`, `isTitleTruncated()`, `setCollapsible()`, `getNavigationMode()`, `setNavigationMode()`, `switch()`, `ensureSpinner()`, `IllegalArgumentException()`, `setDropdownParams()`, `setDropdownSelectedPosition()`, `IllegalStateException()`, `getDropdownSelectedPosition()`, `getDropdownItemCount()`, `getCustomView()`, `animateToVisibility()`, `setupAnimatorToVisibility()`, `onAnimationStart()`, `onAnimationEnd()`, `onAnimationCancel()`, `setDefaultNavigationIcon()`, `saveHierarchyState()`, `restoreHierarchyState()`, `setBackgroundDrawable()`, `getHeight()`, `setVisibility()`, `getVisibility()`, `setMenuCallbacks()`, `getMenu()`
- **`TooltipCompat`** — 3 function(s): `setTooltipText()`, `if()`, `TooltipCompat()`
- **`TooltipCompatHandler`** — 15 function(s): `run()`, `onViewAttachedToWindow()`, `setTooltipText()`, `if()`, `setPendingHandler()`, `TooltipCompatHandler()`, `clearAnchorPos()`, `onLongClick()`, `show()`, `onHover()`, `hide()`, `onViewDetachedFromWindow()`, `scheduleShow()`, `cancelPendingShow()`, `updateAnchorPos()`
- **`TooltipPopup`** — 9 function(s): `TooltipPopup()`, `show()`, `if()`, `hide()`, `computePosition()`, `isShowing()`, `getAppRootView()`, `for()`, `return()`
- **`VectorEnabledTintResources`** — 8 function(s): `shouldBeUsed()`, `isCompatVectorFromResourcesEnabled()`, `VectorEnabledTintResources()`, `super()`, `getDrawable()`, `if()`, `superGetDrawable()`, `setCompatVectorFromResourcesEnabled()`
- **`ViewStubCompat`** — 22 function(s): `onInflate()`, `dispatchDraw()`, `draw()`, `ViewStubCompat()`, `this()`, `super()`, `setId()`, `setVisibility()`, `setWillNotDraw()`, `getInflatedId()`, `setInflatedId()`, `getLayoutResource()`, `setLayoutResource()`, `setLayoutInflater()`, `getLayoutInflater()`, `onMeasure()`, `setMeasuredDimension()`, `if()`, `IllegalStateException()`, `inflate()`, `IllegalArgumentException()`, `setOnInflateListener()`
- **`ViewUtils`** — 5 function(s): `if()`, `ViewUtils()`, `isLayoutRtl()`, `computeFitSystemWindows()`, `makeOptionalFitsSystemWindows()`
- **`WithHint`** — 1 function(s): `getHint()`

</details>

### Package `androidx.core.graphics.drawable`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `IconCompatParcelizer` | class | — | 36 | 2 |

<details>
<summary><b>Function list for <code>androidx.core.graphics.drawable</code></b> (click to expand)</summary>

- **`IconCompatParcelizer`** — 2 function(s): `read()`, `write()`

</details>

### Package `androidx.versionedparcelable`  (11 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `CustomVersionedParcelable` | class | VersionedParcelable | 16 | 2 |
| `NonParcelField` | class | — | 15 | 0 |
| `ParcelField` | class | — | 16 | 1 |
| `ParcelImpl` | class | Parcelable | 47 | 10 |
| `ParcelUtils` | class | — | 35 | 10 |
| `R` | class | — | 8 | 1 |
| `VersionedParcel` | class | RuntimeException | 944 | 343 |
| `VersionedParcelParcel` | class | VersionedParcel | 214 | 41 |
| `VersionedParcelStream` | class | VersionedParcel | 508 | 107 |
| `VersionedParcelable` | class | — | 9 | 0 |
| `VersionedParcelize` | class | — | 24 | 5 |

<details>
<summary><b>Function list for <code>androidx.versionedparcelable</code></b> (click to expand)</summary>

- **`CustomVersionedParcelable`** — 2 function(s): `onPostParceling()`, `onPreParceling()`
- **`ParcelField`** — 1 function(s): `value()`
- **`ParcelImpl`** — 8 function(s): `createFromParcel()`, `ParcelImpl()`, `newArray()`, `describeContents()`, `getVersionedParcel()`, `return()`, `writeToParcel()`, `VersionedParcelParcel()`
- **`ParcelUtils`** — 9 function(s): `ParcelUtils()`, `toParcelable()`, `ParcelImpl()`, `fromParcelable()`, `if()`, `IllegalArgumentException()`, `return()`, `toOutputStream()`, `fromInputStream()`
- **`R`** — 1 function(s): `R()`
- **`VersionedParcel`** — 88 function(s): `closeField()`, `createSubParcel()`, `isStream()`, `readBoolean()`, `readBundle()`, `readByteArray()`, `readDouble()`, `readField()`, `readFloat()`, `readInt()`, `readLong()`, `readParcelable()`, `readString()`, `readStrongBinder()`, `setOutputField()`, `setSerializationFlags()`, `writeBoolean()`, `writeBundle()`, `writeByteArray()`, `writeDouble()`, `writeFloat()`, `writeInt()`, `writeLong()`, `writeParcelable()`, `writeString()`, `writeStrongBinder()`, `writeStrongInterface()`, `writeByte()`, `writeSize()`, `if()`, `writeSizeF()`, `writeSparseBooleanArray()`, `for()`, `writeBooleanArray()`, `readBooleanArray()`, `writeCharArray()`, `readCharArray()`, `writeIntArray()`, `readIntArray()`, `writeLongArray()`, `readLongArray()`, `writeFloatArray()`, `readFloatArray()`, `writeDoubleArray()`, `readDoubleArray()`, `writeSet()`, `writeCollection()`, `writeList()`, `switch()`, `while()`, `writeVersionedParcelable()`, `writeSerializable()`, `writeArray()`, `getType()`, `IllegalArgumentException()`, `writeVersionedParcelableCreator()`, `writeToParcel()`, `RuntimeException()`, `writeException()`, `writeNoException()`, `throw()`, `readException()`, `return()`, `readExceptionCode()`, `createException()`, `getRootCause()`, `UnsupportedOperationException()`, `NetworkOnMainThreadException()`, `IllegalStateException()`, `NullPointerException()`, `BadParcelableException()`, `SecurityException()`, `readByte()`, `readSize()`, `Size()`, `readSizeF()`, `SizeF()`, `readSparseBooleanArray()`, `readSet()`, `readList()`, `readCollection()`, `readArray()`, `readVersionedParcelable()`, `readSerializable()`, `readFromParcel()`, `findParcelClass()`, `ParcelException()`, `super()`
- **`VersionedParcelParcel`** — 31 function(s): `VersionedParcelParcel()`, `this()`, `readUntilField()`, `while()`, `if()`, `readField()`, `setOutputField()`, `closeField()`, `writeInt()`, `createSubParcel()`, `writeByteArray()`, `writeLong()`, `writeFloat()`, `writeDouble()`, `writeString()`, `writeStrongBinder()`, `writeParcelable()`, `writeBoolean()`, `writeStrongInterface()`, `writeBundle()`, `readInt()`, `readLong()`, `readFloat()`, `readDouble()`, `readString()`, `readStrongBinder()`, `readByteArray()`, `readParcelable()`, `return()`, `readBundle()`, `readBoolean()`
- **`VersionedParcelStream`** — 46 function(s): `isStream()`, `readParcelable()`, `readStrongBinder()`, `VersionedParcelStream()`, `setSerializationFlags()`, `if()`, `RuntimeException()`, `closeField()`, `createSubParcel()`, `readField()`, `while()`, `setOutputField()`, `writeByteArray()`, `writeInt()`, `writeLong()`, `writeFloat()`, `writeDouble()`, `writeString()`, `writeBoolean()`, `writeStrongBinder()`, `writeParcelable()`, `writeStrongInterface()`, `readInt()`, `readLong()`, `readFloat()`, `readDouble()`, `readString()`, `String()`, `readByteArray()`, `readBoolean()`, `writeBundle()`, `for()`, `writeObject()`, `readBundle()`, `readObject()`, `writeArray()`, `writeBooleanArray()`, `writeDoubleArray()`, `writeIntArray()`, `writeLongArray()`, `writeFloatArray()`, `IllegalArgumentException()`, `switch()`, `FieldBuffer()`, `flushField()`, `InputBuffer()`
- **`VersionedParcelize`** — 5 function(s): `allowSerialization()`, `deprecatedIds()`, `ignoreParcelables()`, `isCustom()`, `jetifyAs()`

</details>

### Package `?`  (1 classes)

| Class | Kind | Extends / Implements | Lines | Methods |
|---|---|---|---:|---|
| `package-info` | class | — | 6 | 0 |

<details>
<summary><b>Function list for <code>?</code></b> (click to expand)</summary>


</details>

## 8. Notable constants, endpoints and data

### Network endpoints and schemes

- `http://schemas.android.com/apk/res/android` — referenced in TypedArrayUtils.java

### Native libraries (`System.loadLibrary`)

_none found_

### Reflection targets (`Class.forName`)

`android.app.Notification$Action`, `android.content.res.ThemedResourceCache`, `android.graphics.Insets`, `android.support.transition.FragmentTransitionSupport`, `com.android.internal.view.menu.MenuBuilder`, `libcore.icu.ICU`

### Cryptography used

_none found_

### SQL statements

_none found_

### Other notable literals

- `"com.autochips.camera.BACKCAR_SERVICE"  (service action)`
- `"BsvService"  (notification channel)`
- `"autochips.intent.action.PREQB_POWERON" / "PREQB_POWEROFF" / "QB_POWERON" / "QB_POWEROFF"`
- `"android.intent.action.MAIN"  (MIPIDVRActivity)`
- `1920 x 720  (BSVWindow SurfaceView size)`

## 9. Resource inventory

| Extension | Count |
|---|---:|
| `.png` | 257 |
| `.xml` | 253 |
| `.version` | 26 |
| `.bmp` | 16 |
| `.dex` | 1 |
| `.mf` | 1 |
| `.rsa` | 1 |
| `.sf` | 1 |
| `.pro` | 1 |

## 10. How this was produced

```bash
# 1. fetch the single APK file (no repo clone)
curl -L -o com.yftech.bsvservice.apk \
  https://github.com/ammisaidkaidi/yftech-apks/raw/main/com.yftech.bsvservice.apk

# 2. Java-readable decompilation
jadx -d sources -j 2 --show-bad-code com.yftech.bsvservice.apk

# 3. smali + resource decoding
apktool d -f -o smali com.yftech.bsvservice.apk
```

## License / disclaimer

This repository is an automatically generated, human-readable decompilation of a system application for research and interoperability purposes. All code remains the property of its original author(s). No original source code was published by the vendor.
