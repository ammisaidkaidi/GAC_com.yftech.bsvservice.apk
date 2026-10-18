package com.yftech.bsvservice;

import android.app.AlertDialog;
import android.app.StatusBarManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.DeadObjectException;
import android.os.Handler;
import android.os.IBinder;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.SystemProperties;
import android.util.Size;
import android.view.MotionEvent;
import android.view.Surface;
import android.view.SurfaceView;
import android.view.WindowManager;
import android.widget.TextView;
import com.autochips.atcaudiomanager.ATCAudioManager;
import com.autochips.backcar.BackCar;
import com.autochips.metazone.AtcMetazone;
import com.yftech.bsvservice.CameraStateMachine;
import com.yftech.bsvservice.IBsvService;
import com.yftech.bsvservice.avm.AVMMonitor;
import com.yftech.bsvservice.avm.AvmControl;
import com.yftech.bsvservice.util.DVRConst;
import com.yftech.bsvservice.util.LogUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* loaded from: /home/user/work/dex/classes.dex */
public class BsvServiceImpl extends IBsvService.Stub implements CameraStateMachine.StateMachineCallback {
    private static final int BRIGHTNESS_ADDR = 65560;
    private static final int CONTRAST_ADDR = 65562;
    private static final int HUE_ADDR = 65559;
    private static final int H_ADDR = 65551;
    private static final String ROTATION_OF_SCREEN = "persist.sf.hwrotation";
    private static final int SATURATION_ADDR = 65561;
    private static final String TAG = "BsvServiceImpl";
    private static final int W_ADDR = 65550;
    private static final int X_ADDR = 65548;
    private static final int Y_ADDR = 65549;
    private static BsvServiceImpl gInst;
    private AVMMonitor.ICameraMonitorListener cameraMonitorListener;
    private AlertDialog mAlertDialog;
    private ATCAudioManager mAudioManager;
    private BackCar mBackCar;
    private Rect mBackcarViewRect;
    private Map<String, CameraStateMachine> mCameraStateMachineMap;
    private Context mContext;
    private String mCurrentBackCamerId;
    private TouchInputFilterView mFilterView;
    private boolean mIsArm2Exit;
    private boolean mIsArm2RvcOn;
    private WindowManager.LayoutParams mLayoutParams;
    private int mRotation;
    private BackcarSurfaceCallback mSurfaceCallback;
    private SurfaceView mSurfaceView;
    private WindowManager mWM;
    private int mWindowHeight;
    private int mWindowWidth;
    private RemoteCallbackList<IBsvServiceCallback> mCallbacks = new RemoteCallbackList<>();
    public boolean mSignalOn = false;
    public boolean mUserPreviewOn = false;
    private Handler mHandler = new Handler();

    public void release() {
    }

    public void updateBackcarUi() {
    }

    public static BsvServiceImpl getInstance() {
        return gInst;
    }

    public void cameraready() {
        if (this.cameraMonitorListener != null) {
            this.cameraMonitorListener.onCameraMonitorReady();
        }
    }

    public BsvServiceImpl(Context context) {
        gInst = this;
        this.mContext = context;
        this.mAudioManager = new ATCAudioManager(context);
        this.mCameraStateMachineMap = new HashMap();
        this.mFilterView = new TouchInputFilterView(context);
        getWindowInfo(context);
        initBarcarView();
        initAlertDialog(context);
        initCameraStateMachines();
        AvmControl.getInstance().setAvmServiceRun(true);
        AvmControl.init(context);
        this.mSurfaceView = AvmControl.getInstance().getSurface();
        setCameraMonitorListener(AvmControl.getInstance());
    }

    private void initCameraStateMachines() {
        getCameraStateMachine(DVRConst.MIPI_CAMERA_ID_FRONT);
        getCameraStateMachine("0");
    }

    private CameraStateMachine getCameraStateMachine(String str) {
        CameraStateMachine cameraStateMachine = this.mCameraStateMachineMap.get(str);
        if (cameraStateMachine != null) {
            return cameraStateMachine;
        }
        CameraStateMachine cameraStateMachine2 = new CameraStateMachine(this.mContext, str);
        this.mCameraStateMachineMap.put(str, cameraStateMachine2);
        cameraStateMachine2.registerCallback(this);
        cameraStateMachine2.start();
        return cameraStateMachine2;
    }

    private void getWindowInfo(Context context) {
        Point point = new Point();
        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getRealSize(point);
        this.mWindowWidth = point.x;
        this.mWindowHeight = point.y;
        this.mRotation = SystemProperties.getInt(ROTATION_OF_SCREEN, 0);
        LogUtil.d(TAG, "mWindowWidth=" + this.mWindowWidth + ", mWindowHeight=" + this.mWindowHeight + ", mRotation=" + this.mRotation, new Object[0]);
    }

    private void updateDisplayInfoFromMetazone() {
        int i;
        int i2;
        int[] iArr = new int[4];
        AtcMetazone.readval(X_ADDR, iArr);
        int i3 = iArr[0];
        AtcMetazone.readval(Y_ADDR, iArr);
        int i4 = iArr[0];
        AtcMetazone.readval(W_ADDR, iArr);
        int i5 = iArr[0];
        AtcMetazone.readval(H_ADDR, iArr);
        int i6 = iArr[0];
        LogUtil.d(TAG, "x=" + i3 + ", y=" + i4 + ", w=" + i5 + ", h=" + i6, new Object[0]);
        if (i5 >= 0 && i6 >= 0 && i5 > 0 && i6 > 0 && (i = i5 + i3) <= this.mWindowWidth && (i2 = i6 + i4) <= this.mWindowHeight) {
            this.mBackcarViewRect = new Rect(i3, i4, i, i2);
        } else {
            if (this.mWindowWidth < this.mWindowHeight) {
                int i7 = this.mWindowWidth;
                int i8 = (this.mWindowWidth * this.mWindowWidth) / this.mWindowHeight;
                this.mBackcarViewRect = new Rect(0, (this.mWindowHeight - i8) / 2, i7, i8);
                return;
            }
            this.mBackcarViewRect = new Rect(0, 0, this.mWindowWidth, this.mWindowHeight);
        }
    }

    private void initBarcarView() {
        this.mWM = (WindowManager) this.mContext.getSystemService("window");
        SystemProperties.getInt(ROTATION_OF_SCREEN, 0);
    }

    private void initAlertDialog(Context context) {
        this.mAlertDialog = new AlertDialog.Builder(context).setTitle(R.string.RECORD_TOO_SLOW_TITLE).setMessage(R.string.RECORD_TOO_SLOW_MSG).setPositiveButton(R.string.CONFIRM, new DialogInterface.OnClickListener() { // from class: com.yftech.bsvservice.BsvServiceImpl.2
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (BsvServiceImpl.this.isNormalRecordStarted(DVRConst.MIPI_CAMERA_ID_FRONT) || BsvServiceImpl.this.isUrgentRecordStarted(DVRConst.MIPI_CAMERA_ID_FRONT)) {
                    BsvServiceImpl.this.stopRecord(DVRConst.MIPI_CAMERA_ID_FRONT);
                }
                if (BsvServiceImpl.this.isNormalRecordStarted("0") || BsvServiceImpl.this.isUrgentRecordStarted("0")) {
                    BsvServiceImpl.this.stopRecord("0");
                }
            }
        }).setNegativeButton(R.string.CANCEL, new DialogInterface.OnClickListener() { // from class: com.yftech.bsvservice.BsvServiceImpl.1
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
            }
        }).create();
        this.mAlertDialog.getWindow().setType(2003);
    }

    public void sendMediaMountedAndEjectedMessage(boolean z) {
        Iterator<Map.Entry<String, CameraStateMachine>> it = this.mCameraStateMachineMap.entrySet().iterator();
        while (it.hasNext()) {
            it.next().getValue().sendMessage(z ? -17 : 17);
        }
    }

    public void sendQBMessage(boolean z) {
        LogUtil.d(TAG, "sendQBMessage, isQbOn=" + z, new Object[0]);
        Iterator<Map.Entry<String, CameraStateMachine>> it = this.mCameraStateMachineMap.entrySet().iterator();
        while (it.hasNext()) {
            it.next().getValue().sendMessage(z ? 16 : -16);
        }
    }

    public void notifyExitArm2() {
        this.mIsArm2Exit = true;
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void startPreview(String str, Surface surface, boolean z) {
        LogUtil.d(TAG, "startPreview - cameraId:" + str, new Object[0]);
        if (!z && this.mSignalOn) {
            LogUtil.d(TAG, "do not start preview when backcar started", new Object[0]);
        } else {
            getCameraStateMachine(str).startPreview(str, new WrappedSurface(surface, z));
        }
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void stopPreview(String str, boolean z) {
        LogUtil.d(TAG, "stopPreview - cameraId:" + str, new Object[0]);
        getCameraStateMachine(str).stopPreview(str, z);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public boolean isPreviewStarted(String str) {
        LogUtil.d(TAG, "isPreviewStarted - cameraId:" + str, new Object[0]);
        return getCameraStateMachine(str).getPreviewState(str);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void startRecord(String str, boolean z) {
        LogUtil.d(TAG, "startRecord - cameraId:" + str, new Object[0]);
        getCameraStateMachine(str).startRecord(str, z);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void stopRecord(String str) {
        LogUtil.d(TAG, "stopRecord - cameraId:" + str, new Object[0]);
        getCameraStateMachine(str).stopRecord(str);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public boolean isNormalRecordStarted(String str) {
        LogUtil.d(TAG, "isNormalRecordStarted - cameraId:" + str, new Object[0]);
        return getCameraStateMachine(str).getRecordingState(str, false);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public boolean isUrgentRecordStarted(String str) {
        LogUtil.d(TAG, "isUrgentRecordStarted - cameraId:" + str, new Object[0]);
        return getCameraStateMachine(str).getRecordingState(str, true);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void snapShot(String str) {
        LogUtil.d(TAG, "snapShot - cameraId:" + str, new Object[0]);
        getCameraStateMachine(str).snapshot(str);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setMicState(String str, boolean z) {
        LogUtil.d(TAG, "setMicState - cameraId:" + str + " micOn:" + z, new Object[0]);
        getCameraStateMachine(str).setMic(str, z);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public boolean getMicState(String str) {
        LogUtil.d(TAG, "getMicState - cameraId:" + str, new Object[0]);
        return getCameraStateMachine(str).getMicState(str);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setResolution(String str, int i, int i2) {
        LogUtil.d(TAG, "setResolution - cameraId:" + str + " width:" + i + " height:" + i2, new Object[0]);
        getCameraStateMachine(str).setResolution(str, i, i2);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public List<Resolution> getResolutions(String str) {
        LogUtil.d(TAG, "getResolution - cameraId:" + str, new Object[0]);
        List<Size> resolutions = getCameraStateMachine(str).getResolutions(str);
        ArrayList arrayList = new ArrayList(resolutions.size());
        for (Size size : resolutions) {
            arrayList.add(new Resolution(size.getWidth(), size.getHeight()));
        }
        return arrayList;
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setDuration(String str, int i) {
        LogUtil.d(TAG, "setDuration - cameraId:" + str + " duration:" + i + "(s)", new Object[0]);
        getCameraStateMachine(str).setDuration(str, ((long) i) * 1000);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public int getDuration(String str) {
        LogUtil.d(TAG, "getDuration - cameraId:" + str, new Object[0]);
        return (int) (getCameraStateMachine(str).getDuration(str) / 1000);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void resetSettings(String str) {
        getCameraStateMachine(str).resetSettings(str);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setWatermarkState(String str, int i, boolean z) {
        LogUtil.d(TAG, "setWatermarkState - cameraId:" + str + " watermarkOn:" + z, new Object[0]);
        getCameraStateMachine(str).setWaterMark(str, i, z);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setWatermarkStartX(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkStartX - cameraId:" + str + "type = " + i + " value:" + i2, new Object[0]);
        getCameraStateMachine(str).setWatermarkStartX(str, i, i2);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setWatermarkStartY(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkStartY - cameraId:" + str + "type = " + i + " value:" + i2, new Object[0]);
        getCameraStateMachine(str).setWatermarkStartY(str, i, i2);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setWatermarkWidth(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkWidth - cameraId:" + str + "type = " + i + " value:" + i2, new Object[0]);
        getCameraStateMachine(str).setWatermarkWidth(str, i, i2);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void setWatermarkHeight(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkHeight - cameraId:" + str + "type = " + i + " value:" + i2, new Object[0]);
        getCameraStateMachine(str).setWatermarkHeight(str, i, i2);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public boolean getWatermarkState(String str) {
        LogUtil.d(TAG, "getWatermarkState - cameraId:" + str, new Object[0]);
        return getCameraStateMachine(str).getWatermarkState(str);
    }

    @Override // com.yftech.bsvservice.IBsvService
    public boolean isArm2Exit() {
        return this.mIsArm2Exit;
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void registerBsvServiceCallback(String str, IBsvServiceCallback iBsvServiceCallback) {
        LogUtil.d(TAG, "registerBsvServiceCallback - cameraId:" + str, new Object[0]);
        if (iBsvServiceCallback != null) {
            this.mCallbacks.register(iBsvServiceCallback);
            if (!this.mSignalOn) {
                updateStatus(str, 101);
            }
            if (this.mIsArm2RvcOn) {
                return;
            }
            LogUtil.d(TAG, "notify arm2 rvc exit", new Object[0]);
            updateStatus(str, 105);
        }
    }

    @Override // com.yftech.bsvservice.IBsvService
    public void unregisterBsvServiceCallback(String str, IBsvServiceCallback iBsvServiceCallback) {
        LogUtil.d(TAG, "unregisterBsvServiceCallback - cameraId:" + str, new Object[0]);
        if (iBsvServiceCallback != null) {
            this.mCallbacks.unregister(iBsvServiceCallback);
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    private static class TouchInputFilterView extends TextView {
        public TouchInputFilterView(Context context) {
            super(context);
        }

        @Override // android.widget.TextView, android.view.View
        public boolean onTouchEvent(MotionEvent motionEvent) {
            LogUtil.d(BsvServiceImpl.TAG, "on touch...", new Object[0]);
            return true;
        }
    }

    void showTouchInputFilterView() {
        LogUtil.d(TAG, "filterTouchInputForArm2", new Object[0]);
        this.mFilterView.setGravity(17);
        this.mFilterView.setTextSize(40.0f);
        this.mFilterView.setTextColor(-1);
        this.mFilterView.setText(R.string.arm2backcar);
        this.mWM.addView(this.mFilterView, this.mLayoutParams);
    }

    void cancelTouchInputFilterView() {
        LogUtil.d(TAG, "cancelTouchInputFilterView", new Object[0]);
        this.mWM.removeViewImmediate(this.mFilterView);
        this.mFilterView = null;
        Intent intent = new Intent("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.HOME");
        intent.setFlags(268435456);
        this.mContext.startActivity(intent);
    }

    public void startUserPreview(String str) {
        if (this.mSignalOn) {
            LogUtil.e(TAG, "userStartPreivew but Backcar has not stop it", new Object[0]);
            return;
        }
        this.mSignalOn = false;
        this.mUserPreviewOn = true;
        this.mCurrentBackCamerId = str;
        if (this.cameraMonitorListener != null) {
            this.cameraMonitorListener.onCameraMonitorReqShow();
        }
        LogUtil.d(TAG, "userStartPreivew, backcar camera id is " + str, new Object[0]);
        this.mSurfaceView.getHolder().removeCallback(this.mSurfaceCallback);
        if (this.mSurfaceView.getHolder().getSurface().isValid()) {
            LogUtil.d(TAG, "userStartPreivew, backcar camera id is11 " + str, new Object[0]);
            startPreview(str, this.mSurfaceView.getHolder().getSurface(), this.mSignalOn);
            return;
        }
        LogUtil.d(TAG, "userStartPreivew, backcar camera id is22 " + str, new Object[0]);
        this.mSurfaceCallback = new BackcarSurfaceCallback(str, this);
        this.mSurfaceView.getHolder().addCallback(this.mSurfaceCallback);
    }

    public void stopUserPreview(String str) {
        if (!this.mUserPreviewOn) {
            LogUtil.e(TAG, "stop user preview when has not start it", new Object[0]);
            return;
        }
        this.mUserPreviewOn = false;
        if (this.mSignalOn) {
            return;
        }
        this.mCurrentBackCamerId = null;
        LogUtil.d(TAG, "stopUserPreview, backcar camera id is " + str, new Object[0]);
        this.mSurfaceView.setOnTouchListener(null);
        this.mHandler.removeCallbacksAndMessages(null);
        if (this.mSurfaceView.getHolder().getSurface().isValid()) {
            stopPreview(str, true);
        }
        if (this.cameraMonitorListener != null) {
            this.cameraMonitorListener.onCameraMonitorReqHide();
        }
        this.mSurfaceView.getHolder().removeCallback(this.mSurfaceCallback);
    }

    public boolean isBackCar() {
        return this.mSignalOn;
    }

    public void startBackcar(String str) {
        if (this.mSignalOn) {
            LogUtil.e(TAG, "startBackcar when has not stop it", new Object[0]);
            return;
        }
        this.mSignalOn = true;
        enableBackcarAudio();
        if (this.mUserPreviewOn) {
            LogUtil.e(TAG, "startBackcar when user preview has not stop it", new Object[0]);
            updateStatus(str, 100);
            return;
        }
        this.mCurrentBackCamerId = str;
        if (this.cameraMonitorListener != null) {
            this.cameraMonitorListener.onCameraMonitorReqShow();
        }
        LogUtil.d(TAG, "startBackcar, backcar camera id is " + str, new Object[0]);
        this.mSurfaceView.getHolder().removeCallback(this.mSurfaceCallback);
        if (this.mSurfaceView.getHolder().getSurface().isValid()) {
            LogUtil.d(TAG, "startBackcar, backcar camera id is11 " + str, new Object[0]);
            startPreview(str, this.mSurfaceView.getHolder().getSurface(), true);
        } else {
            LogUtil.d(TAG, "startBackcar, backcar camera id is22 " + str, new Object[0]);
            this.mSurfaceCallback = new BackcarSurfaceCallback(str, this);
            this.mSurfaceView.getHolder().addCallback(this.mSurfaceCallback);
        }
        updateStatus(str, 100);
    }

    public void stopBackcar(String str) {
        if (!this.mSignalOn) {
            LogUtil.e(TAG, "stop backcar when has not start it", new Object[0]);
            return;
        }
        this.mSignalOn = false;
        if (this.mUserPreviewOn) {
            updateStatus(str, 101);
            return;
        }
        this.mCurrentBackCamerId = null;
        LogUtil.d(TAG, "stopBackcar, backcar camera id is " + str, new Object[0]);
        this.mSurfaceView.setOnTouchListener(null);
        this.mHandler.removeCallbacksAndMessages(null);
        this.mSurfaceView.getHolder().getSurface().isValid();
        stopPreview(str, true);
        if (this.cameraMonitorListener != null) {
            this.cameraMonitorListener.onCameraMonitorReqHide();
        }
        this.mSurfaceView.getHolder().removeCallback(this.mSurfaceCallback);
        disableBackcarAudio();
    }

    private void disableStatusBarExpand(boolean z) {
        StatusBarManager statusBarManager = (StatusBarManager) this.mContext.getSystemService("statusbar");
        if (z) {
            statusBarManager.disable(android.R.attr.theme);
        } else {
            statusBarManager.disable(0);
        }
    }

    private void collapsePanels() {
        ((StatusBarManager) this.mContext.getSystemService("statusbar")).collapsePanels();
    }

    private void enableBackcarAudio() {
        this.mAudioManager.enableBackcarVolumePolicy(true);
    }

    private void disableBackcarAudio() {
        this.mAudioManager.enableBackcarVolumePolicy(false);
    }

    private void updateStatus(String str, int i) {
        if (this.mCallbacks != null) {
            this.mCallbacks.beginBroadcast();
            int registeredCallbackCount = this.mCallbacks.getRegisteredCallbackCount();
            for (int i2 = 0; i2 < registeredCallbackCount; i2++) {
                IBsvServiceCallback iBsvServiceCallback = null;
                try {
                    try {
                        IBsvServiceCallback broadcastItem = this.mCallbacks.getBroadcastItem(i2);
                        if (broadcastItem != null && str != null) {
                            try {
                                if (broadcastItem.getCameraId().equals(str)) {
                                    broadcastItem.onStatusChanged(str, i);
                                }
                            } catch (DeadObjectException unused) {
                                iBsvServiceCallback = broadcastItem;
                                if (iBsvServiceCallback != null) {
                                    this.mCallbacks.unregister(iBsvServiceCallback);
                                }
                            }
                        }
                    } catch (RemoteException e) {
                        e.printStackTrace();
                    }
                } catch (DeadObjectException unused2) {
                }
            }
            this.mCallbacks.finishBroadcast();
            return;
        }
        LogUtil.w(TAG, "updateStatus - Callbacks map no such camera id", new Object[0]);
    }

    private void updateError(String str, int i, int i2) {
        if (this.mCallbacks != null) {
            this.mCallbacks.beginBroadcast();
            int registeredCallbackCount = this.mCallbacks.getRegisteredCallbackCount();
            for (int i3 = 0; i3 < registeredCallbackCount; i3++) {
                IBsvServiceCallback iBsvServiceCallback = null;
                try {
                    try {
                        IBsvServiceCallback broadcastItem = this.mCallbacks.getBroadcastItem(i3);
                        if (broadcastItem != null) {
                            try {
                                if (broadcastItem.getCameraId().equals(str)) {
                                    broadcastItem.onErrorOccurred(str, i, i2);
                                }
                            } catch (DeadObjectException unused) {
                                iBsvServiceCallback = broadcastItem;
                                if (iBsvServiceCallback != null) {
                                    this.mCallbacks.unregister(iBsvServiceCallback);
                                }
                            }
                        }
                    } catch (RemoteException e) {
                        e.printStackTrace();
                    }
                } catch (DeadObjectException unused2) {
                }
            }
            this.mCallbacks.finishBroadcast();
            return;
        }
        LogUtil.w(TAG, "updateError - Callbacks map no such camera id", new Object[0]);
    }

    private void showBackcarInfo(int i) {
        if (i != 18) {
            if (i != 20) {
                switch (i) {
                    case 13:
                    case 14:
                        break;
                    case 15:
                        if (this.cameraMonitorListener != null) {
                            this.cameraMonitorListener.onCameraMonitorNoSignal();
                            this.cameraMonitorListener.onCameraMonitorReady();
                            return;
                        }
                        return;
                    default:
                        return;
                }
            } else {
                return;
            }
        }
        if (this.cameraMonitorListener != null) {
            this.cameraMonitorListener.onCameraMonitorResumeSignal();
            this.cameraMonitorListener.onCameraMonitorReady();
        }
    }

    private boolean filterRecordTooSlowMsg(String str, int i, int i2) {
        if (i != 14 || i2 != 17) {
            return false;
        }
        if (this.mAlertDialog.isShowing()) {
            return true;
        }
        this.mAlertDialog.show();
        return true;
    }

    @Override // com.yftech.bsvservice.CameraStateMachine.StateMachineCallback
    public void onOperationSuccess(String str, int i) {
        LogUtil.i(TAG, "onOperationSuccess -id:" + str + " operation:" + i, new Object[0]);
        updateStatus(str, i);
    }

    @Override // com.yftech.bsvservice.CameraStateMachine.StateMachineCallback
    public void onOperationFail(String str, int i, int i2) {
        LogUtil.i(TAG, "onOperationFail -id:" + str + " operation:" + i + " error:" + i2, new Object[0]);
        if (filterRecordTooSlowMsg(str, i, i2)) {
            return;
        }
        if (i == 14 && this.mSignalOn && str.equals(this.mSurfaceCallback.mCameraId)) {
            showBackcarInfo(i2);
        } else if (i == 14 && this.mUserPreviewOn && str.equals(this.mSurfaceCallback.mCameraId)) {
            showBackcarInfo(i2);
        }
        updateError(str, i, i2);
    }

    @Override // android.os.Binder, android.os.IBinder
    public void linkToDeath(IBinder.DeathRecipient deathRecipient, int i) {
        super.linkToDeath(deathRecipient, i);
    }

    public void setCameraMonitorListener(AVMMonitor.ICameraMonitorListener iCameraMonitorListener) {
        this.cameraMonitorListener = iCameraMonitorListener;
    }
}
