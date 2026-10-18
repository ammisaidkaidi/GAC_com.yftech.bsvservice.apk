package com.yftech.bsvservice;

import android.app.ActivityManagerNative;
import android.app.IUserSwitchObserver;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Handler;
import android.os.IBinder;
import android.os.IRemoteCallback;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.support.v4.app.NotificationCompat;
import com.autochips.backcar.BackCar;
import com.autochips.metazone.AtcMetazone;
import com.yftech.bsvservice.avm.AvmControl;
import com.yftech.bsvservice.util.DVRConst;
import com.yftech.bsvservice.util.LogUtil;
import com.yftech.bsvservice.util.StorageUtil;
import java.lang.Thread;
import java.util.ArrayList;
import java.util.concurrent.TimeoutException;

/* loaded from: /home/user/work/dex/classes.dex */
public class BsvService extends Service {
    private static final String ACTION_PREQB_OFF = "autochips.intent.action.PREQB_POWEROFF";
    private static final String ACTION_PREQB_ON = "autochips.intent.action.PREQB_POWERON";
    private static final String ACTION_QB_OFF = "autochips.intent.action.QB_POWEROFF";
    private static final String ACTION_QB_ON = "autochips.intent.action.QB_POWERON";
    private static final int ADDR_RVC_CAMERA_ID = 65581;
    private static final int BC_TYPE_ADDR = 65545;
    private static final String NOTIFICATION_CHANNEL_ID_SERVICE = "BsvService";
    private static final int NOTIFICATION_ID = 105;
    private static final String TAG = "BsvService";
    private static final int TYPE_RVC = 0;
    private static BsvService gInst;
    private AudioManager mAudioManager;
    private BackCar mBackcar;
    private BsvServiceImpl mBsvServiceImpl;
    private String mCurrentBackcarCameraId;
    private boolean mHasShownTouchInputFilterView;
    private boolean mIsArm2Exited;
    private boolean mNeedStartBackcarAfterQBOn;
    private boolean mIsQBOn = true;
    private boolean mIsBackcarOn = false;
    private boolean mIsRVCMode = false;
    private int mCurrentUserId = UserHandle.myUserId();
    private final Thread.UncaughtExceptionHandler mDefaultUncaughtExceptionHandler = Thread.getDefaultUncaughtExceptionHandler();
    private Handler mHandler = new Handler();
    private boolean isMetalogoRun = false;
    private BackCar.Listener mListenerSignal = new BackCar.Listener() { // from class: com.yftech.bsvservice.BsvService.1
        public void onEvent(int i, int i2, int i3) {
            LogUtil.d("BsvService", "onSignal - event:" + i, new Object[0]);
            if (1 == i) {
                if (i2 != 0) {
                    LogUtil.i("BsvService", "onSignal():BACKCAR_START", new Object[0]);
                    if (!BsvService.this.mIsArm2Exited) {
                        BsvService.this.mHasShownTouchInputFilterView = true;
                        return;
                    }
                    if (!BsvService.this.mIsQBOn) {
                        BsvService.this.mNeedStartBackcarAfterQBOn = true;
                        LogUtil.d("BsvService", "start backcar later after qb on", new Object[0]);
                        return;
                    } else {
                        BsvService.this.mIsBackcarOn = true;
                        AvmControl.getInstance().getDeviceType();
                        AvmControl.getInstance().onBackcarChange(true);
                        return;
                    }
                }
                LogUtil.i("BsvService", "onSignal():BACKCAR_STOP", new Object[0]);
                if (BsvService.this.mNeedStartBackcarAfterQBOn) {
                    BsvService.this.mNeedStartBackcarAfterQBOn = false;
                    LogUtil.d("BsvService", "cancel stop backcar", new Object[0]);
                    return;
                } else {
                    AvmControl.getInstance().getDeviceType();
                    BsvService.this.mIsBackcarOn = false;
                    AvmControl.getInstance().onBackcarChange(false);
                    return;
                }
            }
            if (i == 0) {
                BsvService.this.mIsArm2Exited = true;
                SystemProperties.set("sys.bsvservice.run.state", "1");
                LogUtil.d("BsvService", "set sys.bsvservice.run.state 1", new Object[0]);
                if (BsvService.this.mHasShownTouchInputFilterView) {
                    BsvService.this.mHasShownTouchInputFilterView = false;
                    BsvService.this.mAudioFocusChangeListener = null;
                    BsvService.this.mAudioManager = null;
                }
                BsvService.this.mBsvServiceImpl.notifyExitArm2();
                if (AvmControl.getInstance().getDeviceType() == 2) {
                    AvmControl.getInstance().onCameraReqShow();
                }
                LogUtil.i("BsvService", "exit arm2 backcar", new Object[0]);
                return;
            }
            if (3 == i) {
                LogUtil.i("BsvService", "param2 =" + i3, new Object[0]);
                if (i3 != 0) {
                    LogUtil.i("BsvService", "handle ARM2 start backcar", new Object[0]);
                    return;
                } else {
                    LogUtil.i("BsvService", "handle ARM2 stop backcar", new Object[0]);
                    return;
                }
            }
            LogUtil.i("BsvService", "do nothing", new Object[0]);
        }
    };
    AudioManager.OnAudioFocusChangeListener mAudioFocusChangeListener = new AudioManager.OnAudioFocusChangeListener() { // from class: com.yftech.bsvservice.BsvService.2
        @Override // android.media.AudioManager.OnAudioFocusChangeListener
        public void onAudioFocusChange(int i) {
            LogUtil.d("BsvService", "onAudioFocusChange, focus = " + i, new Object[0]);
        }
    };
    IUserSwitchObserver mUserSwitchObserver = new IUserSwitchObserver.Stub() { // from class: com.yftech.bsvservice.BsvService.3
        public void onForegroundProfileSwitch(int i) {
        }

        public void onLockedBootComplete(int i) {
        }

        public void onUserSwitching(int i, IRemoteCallback iRemoteCallback) {
            LogUtil.d("BsvService", "onUserSwitching  newUserId = " + i, new Object[0]);
            BsvService.this.mCurrentUserId = i;
        }

        public void onUserSwitchComplete(int i) {
            LogUtil.d("BsvService", "onUserSwitchComplete newUserId = " + i, new Object[0]);
            BsvService.this.mCurrentUserId = i;
            LogUtil.d("BsvService", "onUserSwitchComplete mIsBackcarOn = " + BsvService.this.mIsBackcarOn, new Object[0]);
            if (BsvService.this.mCurrentBackcarCameraId != null && BsvService.this.mCurrentUserId != UserHandle.myUserId() && BsvService.this.mIsBackcarOn) {
                LogUtil.d("BsvService", "stopBackcar because user switch", new Object[0]);
                BsvService.this.mHandler.post(new Runnable() { // from class: com.yftech.bsvservice.BsvService.3.1
                    @Override // java.lang.Runnable
                    public void run() {
                        BsvService.this.mBsvServiceImpl.stopBackcar(BsvService.this.mCurrentBackcarCameraId);
                    }
                });
            }
            if (BsvService.this.mCurrentUserId == UserHandle.myUserId() && BsvService.this.mCurrentBackcarCameraId != null && BsvService.this.mIsBackcarOn) {
                LogUtil.d("BsvService", "startBackcar after user switch", new Object[0]);
                BsvService.this.mHandler.post(new Runnable() { // from class: com.yftech.bsvservice.BsvService.3.2
                    @Override // java.lang.Runnable
                    public void run() {
                        BsvService.this.mBsvServiceImpl.startBackcar(BsvService.this.mCurrentBackcarCameraId);
                    }
                });
            }
        }
    };
    Runnable metaZoneCheckRunnable = new Runnable() { // from class: com.yftech.bsvservice.BsvService.5
        @Override // java.lang.Runnable
        public void run() {
            LogUtil.d("BsvService", "metaZoneCheckRunnable in", new Object[0]);
            while (true) {
                LogUtil.d("BsvService", "nit.svc.metalogo_daemon:" + SystemProperties.get("init.svc.metalogo_daemon"), new Object[0]);
                boolean equals = SystemProperties.get("init.svc.metalogo_daemon").equals("running");
                if (BsvService.this.isMetalogoRun != equals) {
                    LogUtil.d("BsvService", "init.svc.metalogo_daemon changed state:" + equals, new Object[0]);
                    BsvService.this.isMetalogoRun = equals;
                    LogUtil.d("BsvService", "metaZoneCheckRunnable out", new Object[0]);
                    return;
                }
                try {
                    Thread.sleep(500L);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    };
    private BroadcastReceiver mMountUnmountBroadcastReceiver = new BroadcastReceiver() { // from class: com.yftech.bsvservice.BsvService.6
        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            Uri data = intent.getData();
            String path = data != null ? data.getPath() : null;
            LogUtil.i("BsvService", "mMountUnmountBroadcastReceiver - onReceive:" + action + " mountPoint:" + path, new Object[0]);
            if (path == null || StorageUtil.sCurrentPath == null || !path.equals(StorageUtil.toPublicPath(StorageUtil.sCurrentPath))) {
                return;
            }
            if ("android.intent.action.MEDIA_MOUNTED".equals(action)) {
                BsvService.this.mBsvServiceImpl.sendMediaMountedAndEjectedMessage(true);
            } else if ("android.intent.action.MEDIA_EJECT".equals(action)) {
                BsvService.this.mBsvServiceImpl.sendMediaMountedAndEjectedMessage(false);
            }
        }
    };
    BroadcastReceiver mQBReceiver = new BroadcastReceiver() { // from class: com.yftech.bsvservice.BsvService.7
        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            LogUtil.i("BsvService", "mQBReceiver - onReceive:" + action, new Object[0]);
            if (BsvService.ACTION_PREQB_ON.equals(action)) {
                BsvService.this.mBsvServiceImpl.sendQBMessage(true);
                BsvService.this.mIsQBOn = true;
                if (BsvService.this.mNeedStartBackcarAfterQBOn) {
                    BsvService.this.mBsvServiceImpl.startBackcar("0");
                    BsvService.this.mNeedStartBackcarAfterQBOn = false;
                    return;
                }
                return;
            }
            if (BsvService.ACTION_QB_OFF.equals(action)) {
                if (!BsvService.this.mIsArm2Exited && BsvService.this.mIsRVCMode) {
                    BsvService.this.mBackcar.sendForceExitToArm2();
                }
                BsvService.this.mBsvServiceImpl.sendQBMessage(false);
                BsvService.this.mIsQBOn = false;
                return;
            }
            if ("android.intent.action.ACTION_SHUTDOWN".equals(action)) {
                if (!BsvService.this.mIsArm2Exited && BsvService.this.mIsRVCMode) {
                    BsvService.this.mBackcar.sendForceExitToArm2();
                }
                BsvService.this.mBsvServiceImpl.sendQBMessage(false);
            }
        }
    };

    public static BsvService getInstance() {
        return gInst;
    }

    public void startUserPreview() {
        if (this.mCurrentUserId == UserHandle.myUserId() && getBackcarCameraId()) {
            this.mBsvServiceImpl.startUserPreview(this.mCurrentBackcarCameraId);
        }
    }

    public void stopUserPreview() {
        if (this.mCurrentBackcarCameraId != null) {
            this.mBsvServiceImpl.stopUserPreview(this.mCurrentBackcarCameraId);
        }
    }

    public void startBackCar() {
        if (this.mCurrentUserId == UserHandle.myUserId() && getBackcarCameraId()) {
            this.mBsvServiceImpl.startBackcar(this.mCurrentBackcarCameraId);
        }
    }

    public void stopBackCar() {
        if (this.mCurrentBackcarCameraId != null) {
            this.mBsvServiceImpl.stopBackcar(this.mCurrentBackcarCameraId);
        }
    }

    public boolean isPreviewStarted() {
        if (this.mCurrentBackcarCameraId != null) {
            return this.mBsvServiceImpl.isPreviewStarted(this.mCurrentBackcarCameraId);
        }
        return false;
    }

    private void requestBackcarAudioFocusForArm2() {
        LogUtil.d("BsvService", "requestBackcarAudioFocusForArm2, " + this.mAudioManager.requestAudioFocus(this.mAudioFocusChangeListener, new AudioAttributes.Builder().setContentType(6).build(), 4, 0), new Object[0]);
    }

    private void abandonAudioFocusWhenArm2Exit() {
        this.mAudioManager.abandonAudioFocus(this.mAudioFocusChangeListener, new AudioAttributes.Builder().setContentType(6).build());
    }

    private boolean getBackcarCameraId() {
        if (this.mCurrentBackcarCameraId != null) {
            return true;
        }
        if (!AvmControl.getInstance().isRvcMode()) {
            LogUtil.w("BsvService", "not ARM1 RVC,skip", new Object[0]);
            return false;
        }
        int backCarCameraID = AvmControl.getInstance().getBackCarCameraID();
        if (backCarCameraID < 0) {
            this.mCurrentBackcarCameraId = null;
            return false;
        }
        this.mCurrentBackcarCameraId = String.valueOf(backCarCameraID);
        return true;
    }

    private boolean isRVCMode() {
        if (!AvmControl.getInstance().isRvcMode()) {
            LogUtil.w("BsvService", "not ARM1 RVC!", new Object[0]);
            return false;
        }
        this.mIsRVCMode = true;
        return true;
    }

    private void setUncaughtExceptionHandler() {
        Thread.setDefaultUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() { // from class: com.yftech.bsvservice.BsvService.4
            @Override // java.lang.Thread.UncaughtExceptionHandler
            public void uncaughtException(Thread thread, Throwable th) {
                LogUtil.d("BsvService", "thread name=" + thread.getName() + "------------" + th.getMessage(), new Object[0]);
                if (!thread.getName().equals("FinalizerWatchdogDaemon") || !(th instanceof TimeoutException)) {
                    BsvService.this.mDefaultUncaughtExceptionHandler.uncaughtException(thread, th);
                } else {
                    LogUtil.d("BsvService", "skip the exception", new Object[0]);
                }
            }
        });
    }

    @Override // android.app.Service
    public void onCreate() {
        LogUtil.d("BsvService", "onCreate", new Object[0]);
        super.onCreate();
        gInst = this;
        this.mBsvServiceImpl = new BsvServiceImpl(this);
        this.mAudioManager = (AudioManager) getSystemService("audio");
        startForegroundNotification();
        registerMountUnmountReceiver();
        registerQBReceiver();
        setUncaughtExceptionHandler();
        if (isRVCMode()) {
            this.mBackcar = new BackCar();
            ArrayList arrayList = new ArrayList(2);
            arrayList.add(0);
            arrayList.add(1);
            arrayList.add(3);
            this.mBackcar.setListener(this.mListenerSignal, arrayList);
            new Thread(this.metaZoneCheckRunnable).start();
        }
        try {
            ActivityManagerNative.getDefault().registerUserSwitchObserver(this.mUserSwitchObserver, BuildConfig.APPLICATION_ID);
        } catch (Exception unused) {
        }
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        LogUtil.d("BsvService", "onStartCommand", new Object[0]);
        return 1;
    }

    @Override // android.app.Service
    public void onDestroy() {
        LogUtil.d("BsvService", "onDestroy", new Object[0]);
        super.onDestroy();
        this.mBsvServiceImpl.release();
        unRegisterMountUnmountReceiver();
        unregisterQBReceiver();
        try {
            ActivityManagerNative.getDefault().unregisterUserSwitchObserver(this.mUserSwitchObserver);
        } catch (Exception unused) {
        }
        if (this.mIsRVCMode) {
            this.mBackcar.setListener((BackCar.Listener) null, (ArrayList) null);
        }
        Thread.setDefaultUncaughtExceptionHandler(this.mDefaultUncaughtExceptionHandler);
        this.mBsvServiceImpl = null;
        stopForeground(true);
        SystemProperties.set("sys.avmservice.run.state", "0");
        LogUtil.d("BsvService", "set sys.avmservice.run.state 0", new Object[0]);
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        LogUtil.d("BsvService", "onBind", new Object[0]);
        return this.mBsvServiceImpl;
    }

    @Override // android.app.Service, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        getResources().updateConfiguration(configuration, null);
        this.mBsvServiceImpl.updateBackcarUi();
    }

    private String getCameraId() {
        AtcMetazone.readval(BC_TYPE_ADDR, new int[4]);
        return DVRConst.UNKOWN_CAMERA_ID;
    }

    private void initChannel() {
        ((NotificationManager) getSystemService("notification")).createNotificationChannel(new NotificationChannel("BsvService", "BsvService", 1));
    }

    private void startForegroundNotification() {
        initChannel();
        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, "BsvService");
        builder.setContentTitle("BsvService");
        builder.setContentText("BsvService is running");
        builder.setSmallIcon(R.mipmap.ic_launcher);
        startForeground(105, builder.build());
    }

    private void registerMountUnmountReceiver() {
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.MEDIA_BAD_REMOVAL");
        intentFilter.addAction("android.intent.action.MEDIA_CHECKING");
        intentFilter.addAction("android.intent.action.MEDIA_MOUNTED");
        intentFilter.addAction("android.intent.action.MEDIA_NOFS");
        intentFilter.addAction("android.intent.action.MEDIA_REMOVED");
        intentFilter.addAction("android.intent.action.MEDIA_SHARED");
        intentFilter.addAction("android.intent.action.MEDIA_UNMOUNTABLE");
        intentFilter.addAction("android.intent.action.MEDIA_UNMOUNTED");
        intentFilter.addAction("android.intent.action.MEDIA_EJECT");
        intentFilter.addDataScheme("file");
        registerReceiver(this.mMountUnmountBroadcastReceiver, intentFilter);
    }

    private void unRegisterMountUnmountReceiver() {
        unregisterReceiver(this.mMountUnmountBroadcastReceiver);
    }

    private void registerQBReceiver() {
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(ACTION_QB_OFF);
        intentFilter.addAction(ACTION_QB_ON);
        intentFilter.addAction(ACTION_PREQB_OFF);
        intentFilter.addAction(ACTION_PREQB_ON);
        intentFilter.addAction("android.intent.action.ACTION_SHUTDOWN");
        registerReceiver(this.mQBReceiver, intentFilter);
    }

    private void unregisterQBReceiver() {
        unregisterReceiver(this.mQBReceiver);
    }
}
