package com.yftech.bsvservice.windowutil;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.os.Handler;
import android.os.Message;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.provider.Settings;
import com.yftech.bsvservice.avm.AvmControl;
import com.yftech.bsvservice.constant.Constant;
import com.yftech.bsvservice.util.DistributedHandler;
import com.yftech.bsvservice.util.LogUtil;
import com.yftech.car.screen.CarScreenManager;
import java.util.List;

/* loaded from: /home/user/work/dex/classes.dex */
public class BaseWindow implements DistributedHandler.HandlerPart {
    protected static final String RVC_CAMERA_SIGNAL_STATE = "rvc_camera_signal_state";
    protected static final int RVC_CAMERA_SIGNAL_STATE_ERR = 0;
    protected static final int RVC_CAMERA_SIGNAL_STATE_OK = 1;
    private static final String TAG = "BaseWindow";
    private Context mContext;
    private Boolean isShown = false;
    private Boolean mIsVisibility = false;
    private boolean isUpdateVisibility = false;
    private boolean mIsRestoreScreenBackLight = false;
    private int mCameraState = 1;
    private Handler mCarHandler = new Handler();
    Runnable updateVisibilityRunnable = new Runnable() { // from class: com.yftech.bsvservice.windowutil.BaseWindow.1
        @Override // java.lang.Runnable
        public void run() {
            LogUtil.d(BaseWindow.TAG, "update window Visibility  runnable,isUpdateVisibility:" + BaseWindow.this.isUpdateVisibility, new Object[0]);
            if (!BaseWindow.this.isShow() || BaseWindow.this.isUpdateVisibility) {
                return;
            }
            BaseWindow.this.setWindowVisibility(true);
            BaseWindow.this.isUpdateVisibility = true;
            BaseWindow.this.setCameraState(0);
        }
    };
    Runnable exitAvmFirstShow = new Runnable() { // from class: com.yftech.bsvservice.windowutil.BaseWindow.2
        @Override // java.lang.Runnable
        public void run() {
            LogUtil.d(BaseWindow.TAG, "exitAvmFirstShow ,isFirstOpenAvmCamera:" + BaseWindow.this.isOnFirstOpenCameraState, new Object[0]);
            if (BaseWindow.this.isOnFirstOpenCameraState) {
                BaseWindow.this.isOnFirstOpenCameraState = false;
                if (!BaseWindow.this.mAvmControl.isAvmDisplay()) {
                    if (BaseWindow.this.mCameraState == 0) {
                        AvmControl.getInstance().onCameraReqHide();
                    }
                    BaseWindow.this.hideWindow();
                } else {
                    BaseWindow.this.setWindowVisibility(true);
                    BaseWindow.this.isUpdateVisibility = true;
                    BaseWindow.this.mCarHandler.removeCallbacks(BaseWindow.this.updateVisibilityRunnable);
                }
            }
        }
    };
    private boolean isFirstOpenCamera = true;
    private boolean isOnFirstOpenCameraState = false;
    private boolean isAvmRequestCameraOpen = false;
    protected AvmControl mAvmControl = AvmControl.getInstance();

    public BaseWindow(Context context) {
        this.mContext = null;
        this.mContext = context;
        this.mAvmControl.getMainHandler().addHandlerPart(this);
    }

    public AvmControl getAvmControl() {
        return this.mAvmControl;
    }

    public void showWindow() {
        this.isShown = true;
    }

    public void hideWindow() {
        this.mIsVisibility = false;
        this.isShown = false;
    }

    public boolean isShow() {
        return this.isShown.booleanValue();
    }

    public boolean setWindowVisibility(boolean z) {
        LogUtil.d(TAG, "setWindowVisibility:" + z, new Object[0]);
        this.mIsVisibility = Boolean.valueOf(z);
        return true;
    }

    public void updateWindow() {
        LogUtil.d(TAG, "updateWindow", new Object[0]);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void openScreenBackLight() {
        LogUtil.d(TAG, "openScreenBackLight", new Object[0]);
        CarScreenManager carScreenManager = CarScreenManager.getInstance();
        if (carScreenManager != null && !carScreenManager.isOpenScreenBrightness()) {
            LogUtil.d(TAG, "isOpenScreenBrightness:" + carScreenManager.isOpenScreenBrightness(), new Object[0]);
            carScreenManager.openScreenBrightness(0);
            this.mIsRestoreScreenBackLight = true;
            return;
        }
        this.mIsRestoreScreenBackLight = false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void restoreScreenBackLight() {
        LogUtil.d(TAG, "restoreScreenBackLight,mIsRestoreScreenBackLight:" + this.mIsRestoreScreenBackLight, new Object[0]);
        CarScreenManager carScreenManager = CarScreenManager.getInstance();
        if (this.mIsRestoreScreenBackLight && carScreenManager != null) {
            LogUtil.d(TAG, "no closeScreenBrightness", new Object[0]);
            try {
                Thread.sleep(20L);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        this.mIsRestoreScreenBackLight = false;
    }

    public boolean setCameraState(int i) {
        boolean putInt = Settings.System.putInt(this.mContext.getContentResolver(), RVC_CAMERA_SIGNAL_STATE, i);
        LogUtil.d(TAG, "set rvc camera value:" + i + ",ret: " + putInt, new Object[0]);
        this.mCameraState = i;
        return putInt;
    }

    private void onAvmHideWindow() {
        LogUtil.d(TAG, "onAvmHideWindow mCameraState:" + this.mCameraState, new Object[0]);
        if (this.mCameraState == 0) {
            AvmControl.getInstance().onCameraReqHide();
            hideWindow();
        } else {
            hideWindow();
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // com.yftech.bsvservice.util.DistributedHandler.HandlerPart
    public boolean dispatchHandleMessage(Message message) {
        LogUtil.d(TAG, "dispatchHandleMessage msg:" + message.what, new Object[0]);
        int i = message.what;
        if (i != 212) {
            if (i == 216) {
                updateWindow();
            } else if (i != 250) {
                if (i != 255) {
                    if (i == 265) {
                        if (AvmControl.getInstance().getDeviceType() == 2) {
                            if (message.arg1 == 1) {
                                boolean z = this.mAvmControl.getAvmReqOnOff() != 0;
                                LogUtil.d(TAG, "Avm request show isPreviewStarted:" + z, new Object[0]);
                                if (!z) {
                                    LogUtil.d(TAG, "isOnFirstOpenCameraState:" + this.isOnFirstOpenCameraState + ",isFirstOpenCamera :" + this.isFirstOpenCamera + ", arm1 is not exit!!!", new Object[0]);
                                    if (!this.isFirstOpenCamera) {
                                        if (!this.isOnFirstOpenCameraState) {
                                            this.isFirstOpenCamera = true;
                                            AvmControl.getInstance().onCameraReqHide();
                                            AvmControl.getInstance().onCameraReqShow();
                                            this.isAvmRequestCameraOpen = true;
                                            LogUtil.d(TAG, "onCameraReqShow(),isOnFirstOpenCameraState:" + this.isOnFirstOpenCameraState, new Object[0]);
                                        } else {
                                            LogUtil.d(TAG, "11Avm request show, isOnFirstOpenCameraState:" + this.isOnFirstOpenCameraState, new Object[0]);
                                        }
                                    }
                                } else if (this.isOnFirstOpenCameraState) {
                                    LogUtil.d(TAG, "22Avm request show, isOnFirstOpenCameraState:" + this.isOnFirstOpenCameraState, new Object[0]);
                                    this.isUpdateVisibility = false;
                                    this.mCarHandler.removeCallbacks(this.updateVisibilityRunnable);
                                    this.mCarHandler.postDelayed(this.updateVisibilityRunnable, 5000L);
                                } else {
                                    showWindow();
                                    this.isUpdateVisibility = false;
                                    this.mCarHandler.removeCallbacks(this.updateVisibilityRunnable);
                                    this.mCarHandler.postDelayed(this.updateVisibilityRunnable, 5000L);
                                }
                            } else {
                                LogUtil.d(TAG, "Avm request hide,isFirstOpenCamera:" + this.isFirstOpenCamera + ",isOnFirstOpenCameraState:" + this.isOnFirstOpenCameraState + ",isAvmRequestCameraOpen:" + this.isAvmRequestCameraOpen + ",mIsVisibility:" + this.mIsVisibility, new Object[0]);
                                if (this.isFirstOpenCamera || this.isOnFirstOpenCameraState) {
                                    if (this.isAvmRequestCameraOpen) {
                                        onAvmHideWindow();
                                    } else if (this.mIsVisibility.booleanValue()) {
                                        onAvmHideWindow();
                                    }
                                } else {
                                    onAvmHideWindow();
                                }
                            }
                        }
                    } else {
                        switch (i) {
                            case Constant.HANDLE_HIDE_AVM /* 201 */:
                                hideWindow();
                                break;
                            case Constant.HANDLE_SHOW_AVM /* 202 */:
                                if (AvmControl.getInstance().getDeviceType() == 2) {
                                    LogUtil.d(TAG, "isFirstOpenCamera :" + this.isFirstOpenCamera, new Object[0]);
                                    if (this.isFirstOpenCamera) {
                                        showWindow();
                                        this.mCarHandler.postDelayed(this.exitAvmFirstShow, 5000L);
                                        this.isFirstOpenCamera = false;
                                        this.isOnFirstOpenCameraState = true;
                                        break;
                                    }
                                } else {
                                    showWindow();
                                    this.isUpdateVisibility = false;
                                    this.mCarHandler.removeCallbacks(this.updateVisibilityRunnable);
                                    this.mCarHandler.postDelayed(this.updateVisibilityRunnable, 5000L);
                                    break;
                                }
                                break;
                            case Constant.HANDLE_HIDE_NO_SIG /* 203 */:
                            case Constant.HANDLE_SHOW_NO_SIG /* 204 */:
                                updateWindow();
                                if (message.what == 204) {
                                    setCameraState(0);
                                    break;
                                } else {
                                    setCameraState(1);
                                    break;
                                }
                        }
                    }
                } else if (AvmControl.getInstance().getDeviceType() == 2) {
                    LogUtil.d(TAG, "isOnFirstOpenCameraState :" + this.isOnFirstOpenCameraState, new Object[0]);
                    if (this.isOnFirstOpenCameraState) {
                        this.isOnFirstOpenCameraState = false;
                        this.mCarHandler.removeCallbacks(this.exitAvmFirstShow);
                        if (!this.mAvmControl.isAvmDisplay()) {
                            if (this.mCameraState == 0) {
                                AvmControl.getInstance().onCameraReqHide();
                            }
                            hideWindow();
                        } else {
                            setWindowVisibility(true);
                            this.isUpdateVisibility = true;
                            this.mCarHandler.removeCallbacks(this.updateVisibilityRunnable);
                        }
                    } else {
                        setWindowVisibility(true);
                        this.isUpdateVisibility = true;
                        this.mCarHandler.removeCallbacks(this.updateVisibilityRunnable);
                    }
                } else {
                    setWindowVisibility(true);
                    this.isUpdateVisibility = true;
                    this.mCarHandler.removeCallbacks(this.updateVisibilityRunnable);
                }
            }
            return false;
        }
        updateWindow();
        return false;
    }

    private void sendHXBroadCast(int i, boolean z) {
        Intent intent = new Intent();
        intent.setAction("com.yftech.bsvservice.SHOW_STATE");
        intent.putExtra("type", i);
        intent.putExtra("isShow", z);
        List<ResolveInfo> queryBroadcastReceivers = this.mContext.getPackageManager().queryBroadcastReceivers(intent, 0);
        if (queryBroadcastReceivers != null && queryBroadcastReceivers.size() >= 1) {
            for (ResolveInfo resolveInfo : queryBroadcastReceivers) {
                Intent intent2 = new Intent(intent);
                ComponentName componentName = new ComponentName(resolveInfo.activityInfo.applicationInfo.packageName, resolveInfo.activityInfo.name);
                LogUtil.e(TAG, "packageName " + resolveInfo.activityInfo.applicationInfo.packageName + ",Receiver:" + resolveInfo.activityInfo.name, new Object[0]);
                intent2.setComponent(componentName);
                this.mContext.sendBroadcastAsUser(intent2, UserHandle.ALL);
            }
        }
        this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
    }

    public void BroadcastWindow(int i, boolean z) {
        if (z) {
            SystemProperties.set("sys.bsvservice.show.state", "1");
        } else {
            SystemProperties.set("sys.bsvservice.show.state", "0");
        }
        sendHXBroadCast(i, z);
    }
}
