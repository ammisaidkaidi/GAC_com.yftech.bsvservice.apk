package com.yftech.bsvservice.avm;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.SystemProperties;
import android.view.Surface;
import android.view.SurfaceView;
import com.yftech.bsvservice.BsvService;
import com.yftech.bsvservice.avm.AVMMonitor;
import com.yftech.bsvservice.common.CameraDataDef;
import com.yftech.bsvservice.common.ICameraControl;
import com.yftech.bsvservice.constant.Constant;
import com.yftech.bsvservice.util.DistributedHandler;
import com.yftech.bsvservice.util.LogUtil;
import com.yftech.bsvservice.windowutil.BSVWindow;
import com.yftech.bsvservice.windowutil.BaseWindow;
import com.yftech.vehicle.internal.adapter.ICarConfig;
import com.yftech.vehicle.sdk.CarConfig;
import java.lang.ref.WeakReference;
import java.nio.ByteBuffer;

/* loaded from: /home/user/work/dex/classes.dex */
public class AvmControl implements ICameraControl.ICameraControlListener, AVMMonitor.ICameraMonitorListener {
    private static final int ADDR_RVC_CAMERA_ID = 65581;
    public static final int AVM_CAMERA_HIDE = 0;
    public static final int AVM_CAMERA_REQ_SHOW_BY_AVM_PROCOTOL = 1;
    public static final int AVM_CAMERA_REQ_SHOW_BY_USER_ACTION = 2;
    public static final int CAR_TYPE_A58 = 1;
    public static final int CAR_TYPE_A79 = 3;
    public static final int CAR_TYPE_A88 = 2;
    public static final int CAR_TYPE_UNKNOWN = 0;
    private static final boolean DEBUG = true;
    public static final int DEVICE_TYPE_360RVCSVC = 3;
    public static final int DEVICE_TYPE_AVM = 2;
    public static final int DEVICE_TYPE_HAVM = 4;
    public static final int DEVICE_TYPE_NONE = 0;
    public static final int DEVICE_TYPE_RADAR = 5;
    public static final int DEVICE_TYPE_RVC = 1;
    public static final int FRONT_0_REAR_3 = 1;
    public static final int FRONT_0_REAR_4 = 2;
    public static final int FRONT_2_REAR_3 = 3;
    public static final int FRONT_2_REAR_4 = 4;
    public static final int FRONT_4_REAR_4 = 5;
    public static final int RADAR_TYPE_NONE = 0;
    private static final String TAG = "AvmControl";
    private static volatile boolean isInit = false;
    int car_type;
    private WeakReference<Context> contextWeakReference;
    int device_type;
    private CameraDataDef.APAInfo mAPADrvReq;
    private boolean mAvmDisplayShowState;
    private boolean mAvmFrontRadarErr;
    private boolean mAvmRearRadarErr;
    private boolean mAvmSignalErr;
    private boolean mAvmSystemErr;
    private int mBackCarCameraId;
    private BaseWindow mBaseWindow;
    private BSVWindow mBsvWindow;
    private int mCameraInputErr;
    private boolean mCarTrunkOpen;
    Handler mHandler;
    private boolean mIsAVMPlusFAPAMode;
    private boolean mIsAvmServiceRun;
    private boolean mIsBackcar;
    private boolean mIsGearState;
    private boolean mIsHaveBsvDevice;
    private boolean mIsRvcMode;
    private DistributedHandler mMainHandler;
    CameraDataDef.RadarInfo mRadarInfo;
    private boolean mShowLoading;
    Runnable r;
    int radar_type;
    private boolean testCmd;
    private static ByteBuffer buffer = ByteBuffer.allocateDirect(56);
    private static int avmReqOnOff = 0;

    public boolean canShow() {
        return false;
    }

    public int getAvmHardwareState() {
        return 0;
    }

    public int getAvmMode() {
        return 0;
    }

    public int getAvmSignal() {
        return 0;
    }

    public int getCarSpeed() {
        return 1;
    }

    public void setAvmMode(int i) {
    }

    private boolean isAvmSignalOk(int i) {
        int avmSignal = getAvmSignal();
        try {
            Thread.sleep(i);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        int avmSignal2 = getAvmSignal();
        LogUtil.d(TAG, "avmSignal:" + avmSignal + ",tmp_avmSignal:" + avmSignal2, new Object[0]);
        return avmSignal != avmSignal2;
    }

    public synchronized void onBackcarChange(boolean z) {
        this.mIsBackcar = z;
        this.mMainHandler.sendEmptyMessage(Constant.MSG_GEAR_STATE_CHANGE);
    }

    public synchronized boolean isBackCar() {
        return this.mIsBackcar;
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onCameraReqShow() {
        LogUtil.d(TAG, "onAvmProcotolReqShow:" + getAvmReqOnOff(), new Object[0]);
        if (this.device_type == 0) {
            AudioFocus.getInstance().requestRvcFocus();
            return;
        }
        if (this.device_type == 1 || this.device_type == 2) {
            if ((getAvmReqOnOff() & 1) != 1) {
                this.mAvmSignalErr = false;
                this.mShowLoading = false;
                setAvmReqOnOff(getAvmReqOnOff() + 1);
                BsvService.getInstance().startBackCar();
                return;
            }
            return;
        }
        if (this.device_type == 5) {
            setAvmReqOnOff(getAvmReqOnOff() + 1);
            if (getAvmReqOnOff() == 1) {
                onCameraMonitorReqShow();
                onCameraMonitorReady();
                return;
            }
            return;
        }
        LogUtil.d(TAG, "onCameraReqShow device_type:" + this.device_type, new Object[0]);
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onCameraReqHide() {
        LogUtil.d(TAG, "onAvmProcotolReqHide:" + getAvmReqOnOff(), new Object[0]);
        if (this.device_type == 0) {
            AudioFocus.getInstance().abondRvcFocus();
            return;
        }
        if (this.device_type == 1 || this.device_type == 2) {
            if ((getAvmReqOnOff() & 1) == 1) {
                this.mShowLoading = false;
                setAvmReqOnOff(getAvmReqOnOff() & (-2));
                BsvService.getInstance().stopBackCar();
                return;
            }
            return;
        }
        if (this.device_type == 5) {
            if ((getAvmReqOnOff() & 1) == 1) {
                setAvmReqOnOff(getAvmReqOnOff() & (-2));
                if (getAvmReqOnOff() == 0) {
                    onCameraMonitorReqHide();
                    return;
                }
                return;
            }
            return;
        }
        LogUtil.d(TAG, "onCameraReqHide device_type:" + this.device_type, new Object[0]);
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onCameraSystemErr(boolean z) {
        this.mAvmSystemErr = z;
        if (z) {
            this.mMainHandler.sendEmptyMessage(Constant.HANDLE_SHOW_SYSTEM_ERR);
        } else {
            this.mMainHandler.sendEmptyMessage(Constant.HANDLE_HIDE_SYSTEM_ERR);
        }
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onCameraCommTimeOut(boolean z) {
        LogUtil.d(TAG, "onCameraCommTimeOut：" + z, new Object[0]);
        this.mMainHandler.sendEmptyMessage(Constant.HANDLE_COMM_TIMEOUT);
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onCameraOpStateErr(boolean z) {
        if (z) {
            this.mMainHandler.sendEmptyMessage(Constant.HANDLE_SHOW_SYSTEM_ERR);
        } else {
            this.mMainHandler.sendEmptyMessage(Constant.HANDLE_HIDE_SYSTEM_ERR);
        }
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onSteerWheelAngel(float f) {
        this.mMainHandler.sendEmptyMessage(Constant.MSG_STEER_WHEEL_ANGEL_CHANGE);
    }

    boolean isReverseWindowShow() {
        String str = SystemProperties.get("sys.avmservice.show.state", "0");
        LogUtil.d(TAG, " sys.avmservice.show.state :" + str, new Object[0]);
        boolean z = str.compareTo("1") == 0;
        LogUtil.d(TAG, " isReverseShow :" + z, new Object[0]);
        return z;
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onDisplayState(boolean z) {
        if (z && isReverseWindowShow()) {
            LogUtil.d(TAG, " reverse ui is show,no show bsv", new Object[0]);
            return;
        }
        this.mAvmDisplayShowState = z;
        Message message = new Message();
        message.what = Constant.MSG_BSV_REQUEST_STATE;
        message.arg1 = z ? 1 : 0;
        message.arg2 = 0;
        this.mMainHandler.sendMessage(message);
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onGearStateChange(int i) {
        boolean z = i == 14;
        if (this.mIsGearState == z) {
            return;
        }
        this.mIsGearState = z;
        if (i == 14) {
            playReverseEffect();
            onBackcarChange(true);
        } else {
            onBackcarChange(false);
        }
    }

    @Override // com.yftech.bsvservice.common.ICameraControl.ICameraControlListener
    public void onAPADrvReq(CameraDataDef.APAInfo aPAInfo) {
        this.mAPADrvReq = aPAInfo;
        this.mMainHandler.sendEmptyMessage(Constant.MSG_APA_SOUND_REQ);
    }

    public CameraDataDef.APAInfo getAPADrvReq() {
        return this.mAPADrvReq;
    }

    public boolean isAvmDisplay() {
        return this.mAvmDisplayShowState;
    }

    @Override // com.yftech.bsvservice.avm.AVMMonitor.ICameraMonitorListener
    public void onCameraMonitorReqShow() {
        LogUtil.d(TAG, "onAvmMonitorReqShow", new Object[0]);
        this.mShowLoading = false;
        showAvm();
    }

    @Override // com.yftech.bsvservice.avm.AVMMonitor.ICameraMonitorListener
    public void onCameraMonitorReqHide() {
        LogUtil.d(TAG, "onAvmMonitorReqHide", new Object[0]);
        hideAvm();
    }

    @Override // com.yftech.bsvservice.avm.AVMMonitor.ICameraMonitorListener
    public void onCameraMonitorLoading(boolean z) {
        this.mShowLoading = z;
        if (this.mShowLoading) {
            this.mMainHandler.sendEmptyMessage(Constant.HANDLE_SHOW_AVM);
        } else {
            this.mMainHandler.sendEmptyMessage(Constant.HANDLE_HIDE_LOADING);
        }
    }

    @Override // com.yftech.bsvservice.avm.AVMMonitor.ICameraMonitorListener
    public void onCameraMonitorNoSignal() {
        LogUtil.d(TAG, "onAvmMonitorNoSignal", new Object[0]);
        this.mShowLoading = false;
        this.mAvmSignalErr = true;
        this.mMainHandler.sendEmptyMessage(Constant.HANDLE_SHOW_NO_SIG);
    }

    @Override // com.yftech.bsvservice.avm.AVMMonitor.ICameraMonitorListener
    public void onCameraMonitorResumeSignal() {
        this.mAvmSignalErr = false;
        this.mMainHandler.sendEmptyMessage(Constant.HANDLE_HIDE_NO_SIG);
    }

    @Override // com.yftech.bsvservice.avm.AVMMonitor.ICameraMonitorListener
    public void onCameraMonitorReady() {
        this.mMainHandler.sendEmptyMessage(255);
    }

    public boolean isShowLoading() {
        return this.mShowLoading;
    }

    public boolean isAvmSignalErr() {
        return this.mAvmSignalErr;
    }

    public boolean isCarTrunkOpen() {
        return this.mCarTrunkOpen;
    }

    private AvmControl() {
        this.mIsRvcMode = true;
        this.mBackCarCameraId = 0;
        this.mAvmDisplayShowState = false;
        this.mAPADrvReq = new CameraDataDef.APAInfo();
        this.device_type = 1;
        this.radar_type = 2;
        this.car_type = 0;
        this.mIsGearState = false;
        this.mBaseWindow = null;
        this.mBsvWindow = null;
        this.mAvmSystemErr = false;
        this.mCameraInputErr = 0;
        this.mAvmSignalErr = false;
        this.mAvmFrontRadarErr = false;
        this.mAvmRearRadarErr = false;
        this.mCarTrunkOpen = false;
        this.mShowLoading = false;
        this.mRadarInfo = new CameraDataDef.RadarInfo();
        this.mMainHandler = new DistributedHandler();
        this.mIsBackcar = false;
        this.mIsAvmServiceRun = false;
        this.mIsAVMPlusFAPAMode = false;
        this.mIsHaveBsvDevice = false;
        this.testCmd = false;
        this.mHandler = new Handler();
        this.r = new Runnable() { // from class: com.yftech.bsvservice.avm.AvmControl.1
            @Override // java.lang.Runnable
            public void run() {
                if (AvmControl.this.testCmd) {
                    AvmControl.this.onDisplayState(true);
                } else {
                    AvmControl.this.onDisplayState(false);
                }
                AvmControl.this.testCmd = true ^ AvmControl.this.testCmd;
                AvmControl.this.postDelayHandler(10000);
            }
        };
    }

    private void getDevice() {
        ICarConfig.VehiclePlatform vehiclePlatform = CarConfig.getVehiclePlatform();
        LogUtil.d(TAG, "getVehiclePlatform vehiclePlatform type:" + vehiclePlatform, new Object[0]);
        if (vehiclePlatform == ICarConfig.VehiclePlatform.A58) {
            this.car_type = 1;
        } else if (vehiclePlatform == ICarConfig.VehiclePlatform.A88) {
            this.car_type = 2;
        } else if (vehiclePlatform == ICarConfig.VehiclePlatform.A79) {
            this.car_type = 3;
        }
        this.car_type = 3;
        if (this.car_type == 3) {
            ICarConfig.CameraNumber cameraNumber = CarConfig.getCameraNumber();
            LogUtil.d(TAG, "getCameraNumber cameraNumber:" + cameraNumber, new Object[0]);
            this.mIsHaveBsvDevice = CarConfig.isBsdPresent();
            LogUtil.d(TAG, "isBsdPresent mIsHaveBsvDevice:" + this.mIsHaveBsvDevice, new Object[0]);
            if (this.mIsHaveBsvDevice) {
                this.mIsRvcMode = true;
                this.device_type = 2;
                this.mBackCarCameraId = 10;
            } else {
                this.mIsRvcMode = false;
                this.device_type = 0;
                this.mBackCarCameraId = 0;
            }
        } else {
            this.mIsRvcMode = false;
            this.device_type = 0;
            this.mBackCarCameraId = 0;
        }
        LogUtil.d(TAG, "device type11:" + this.device_type, new Object[0]);
    }

    private void getRadar() {
        ICarConfig.RadarNumber radarNumber = CarConfig.getRadarNumber();
        LogUtil.d(TAG, "getRadarNumber radar type:" + radarNumber, new Object[0]);
        if (radarNumber == ICarConfig.RadarNumber.FRONT_0_REAR_3) {
            this.radar_type = 1;
        } else if (radarNumber == ICarConfig.RadarNumber.NONE) {
            this.radar_type = 0;
        } else {
            this.radar_type = 1;
        }
    }

    public boolean isRvcMode() {
        return this.mIsRvcMode;
    }

    public int getBackCarCameraID() {
        return this.mBackCarCameraId;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public static class SingletonFactory {
        private static AvmControl instance = new AvmControl();

        private SingletonFactory() {
        }
    }

    public static AvmControl getInstance() {
        return SingletonFactory.instance;
    }

    public Object readResolve() {
        return getInstance();
    }

    public DistributedHandler getMainHandler() {
        return this.mMainHandler;
    }

    public static void init(Context context) {
        if (isInit) {
            return;
        }
        isInit = true;
        getInstance().avmInit(context);
        getInstance().windowInit();
        AudioFocus.getInstance();
        LogUtil.d(TAG, "avmservice_init_end", new Object[0]);
    }

    public void setAvmServiceRun(boolean z) {
        this.mIsAvmServiceRun = z;
    }

    public boolean isAvmServiceRun() {
        LogUtil.d(TAG, "mIsAvmServiceRun: " + this.mIsAvmServiceRun, new Object[0]);
        return this.mIsAvmServiceRun;
    }

    public synchronized int avmInit(Context context) {
        this.contextWeakReference = new WeakReference<>(context);
        getInstance().getRadar();
        getInstance().getDevice();
        if (getDeviceType() != 2) {
            LogUtil.d(TAG, "no set Proctol listener", new Object[0]);
        }
        boolean z = this.mIsHaveBsvDevice;
        return 0;
    }

    public BaseWindow getWindow() {
        return this.mBaseWindow;
    }

    public synchronized void windowInit() {
        if (this.mIsHaveBsvDevice && this.mBsvWindow == null && this.contextWeakReference.get() != null) {
            this.mBsvWindow = new BSVWindow(this.contextWeakReference.get());
        }
    }

    public synchronized SurfaceView getSurface() {
        return this.mBsvWindow != null ? this.mBsvWindow.getSurface() : null;
    }

    public synchronized void dispSurfaceInit(int i, int i2, Surface surface) {
    }

    public synchronized void dispSurfaceRelease() {
    }

    public int getDeviceType() {
        return this.device_type;
    }

    public int getRadarType() {
        return this.radar_type;
    }

    public int getCarType() {
        return this.car_type;
    }

    public synchronized void userRequestShowAvm() {
        LogUtil.d(TAG, "userRequestShowAvm:" + getAvmReqOnOff(), new Object[0]);
        if (this.device_type == 0) {
            return;
        }
        if (getAvmReqOnOff() == 0) {
            this.mAvmSignalErr = false;
            this.mShowLoading = false;
            if (this.device_type != 1 && this.device_type != 2) {
                if (this.device_type == 5) {
                    setAvmReqOnOff(2);
                    onCameraMonitorReqShow();
                    onCameraMonitorReady();
                } else {
                    LogUtil.d(TAG, "userRequestShowAvm device_type:" + this.device_type, new Object[0]);
                }
            }
            setAvmReqOnOff(2);
            BsvService.getInstance().startUserPreview();
        }
    }

    public synchronized void userRequestHideAvm() {
        LogUtil.d(TAG, "userRequestHideAvm:" + getAvmReqOnOff(), new Object[0]);
        if (this.device_type != 1 && this.device_type != 2) {
            if (this.device_type == 5) {
                if ((getAvmReqOnOff() & 2) == 2) {
                    setAvmReqOnOff(getAvmReqOnOff() & (-3));
                    onCameraMonitorReqHide();
                }
            } else {
                LogUtil.d(TAG, "userRequestHideAvm device_type:" + this.device_type, new Object[0]);
            }
        }
        if ((getAvmReqOnOff() & 2) == 2) {
            this.mShowLoading = false;
            setAvmReqOnOff(getAvmReqOnOff() & (-3));
            BsvService.getInstance().stopUserPreview();
        }
    }

    public synchronized void showAvm() {
        this.mMainHandler.sendEmptyMessage(Constant.HANDLE_SHOW_AVM);
    }

    public synchronized void hideAvm() {
        this.mMainHandler.sendEmptyMessage(Constant.HANDLE_HIDE_AVM);
    }

    public boolean sourceStart(Bundle bundle) {
        LogUtil.d(TAG, "sourceStart", new Object[0]);
        if (getAvmHardwareState() == 1) {
            return true;
        }
        getInstance().showAvm();
        return true;
    }

    public boolean sourcePause(Bundle bundle) {
        LogUtil.d(TAG, "sourcePause", new Object[0]);
        if (getAvmHardwareState() == 1) {
            return true;
        }
        getInstance().hideAvm();
        return true;
    }

    public boolean sourceResume(Bundle bundle) {
        LogUtil.d(TAG, "sourceResume", new Object[0]);
        if (getAvmHardwareState() == 1) {
            return true;
        }
        getInstance().showAvm();
        return true;
    }

    public boolean sourceStop(Bundle bundle) {
        LogUtil.d(TAG, "sourceStop", new Object[0]);
        if (getAvmHardwareState() == 1) {
            return true;
        }
        getInstance().hideAvm();
        return true;
    }

    private void setAvmReqOnOff(int i) {
        avmReqOnOff = i;
        LogUtil.d(TAG, "set avmReqOnOff:" + avmReqOnOff, new Object[0]);
    }

    public int getAvmReqOnOff() {
        return avmReqOnOff;
    }

    public void playReverseEffect() {
        BaseWindow baseWindow = this.mBaseWindow;
    }

    public void postDelayHandler(int i) {
        this.mHandler.postDelayed(this.r, i);
    }
}
