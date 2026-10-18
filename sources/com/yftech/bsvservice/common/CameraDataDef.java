package com.yftech.bsvservice.common;

/* loaded from: /home/user/work/dex/classes.dex */
public class CameraDataDef {
    public static final int AUTO_AVM_MODE_CLOSE = 0;
    public static final int AUTO_AVM_MODE_LOW = 1;
    public static final int AUTO_AVM_MODE_MIDDLE_LOW = 2;
    public static final int AVM_3D_ROUND_VIEW = 18;
    public static final int AVM_BAT_VOL_OUT_OF_RANGE = 1;
    public static final int AVM_CALIBRATE_PARAM_TYPE_DEFAULT = 0;
    public static final int AVM_CALIBRATE_PARAM_TYPE_USER = 1;
    public static final int AVM_CALIBRATE_STATE_FAILURE = 3;
    public static final int AVM_CALIBRATE_STATE_PROCESS = 1;
    public static final int AVM_CALIBRATE_STATE_SUCCESS = 2;
    public static final int AVM_CALIBRATE_STATE_UNKNOW = 0;
    public static final int AVM_CAN_COM_FEILED = 2;
    public static final int AVM_CONTROL_OP_FEILED = 4;
    public static final int AVM_EOL_NOT_COMPLETED_FEILED = 16;
    public static final int AVM_FRONT_180_VIEW = 15;
    public static final int AVM_FRONT_CAMERA_INPUT_FEILED = 1;
    public static final int AVM_FRONT_OVERLOOK_VIEW = 11;
    public static final int AVM_FRONT_TO_CENTER_VIEW = 1;
    public static final int AVM_FRONT_VIEW = 9;
    public static final int AVM_LEFT_CAMERA_INPUT_FEILED = 4;
    public static final int AVM_LEFT_FRONT_TO_CENTER_VIEW = 5;
    public static final int AVM_LEFT_REAR_TO_CENTER_VIEW = 7;
    public static final int AVM_LEFT_RIGHT_VIEW = 17;
    public static final int AVM_LEFT_TO_CENTER_VIEW = 3;
    public static final int AVM_LEFT_TURN_VIEW = 13;
    public static final int AVM_MODEL_COLOR_UNKNOW = 0;
    public static final int AVM_NO_ERR = 0;
    public static final int AVM_REAR_180_VIEW = 16;
    public static final int AVM_REAR_CAMERA_INPUT_FEILED = 2;
    public static final int AVM_REAR_OVERLOOK_VIEW = 12;
    public static final int AVM_REAR_TO_CENTER_VIEW = 2;
    public static final int AVM_REAR_VIEW = 10;
    public static final int AVM_RIGHT_CAMERA_INPUT_FEILED = 8;
    public static final int AVM_RIGHT_FRONT_TO_CENTER_VIEW = 6;
    public static final int AVM_RIGHT_REAR_TO_CENTER_VIEW = 8;
    public static final int AVM_RIGHT_TO_CENTER_VIEW = 4;
    public static final int AVM_RIGHT_TURN_VIEW = 14;
    public static final int AVM_UNKNOW_VIEW = 0;
    public static final int AVM_VIDEO_OUTPUT_FEILED = 8;
    public static final int AVM_VIEW_EOL_TEST = 4;
    public static final int AVM_VIEW_MAIN_MAIN_SCREEN = 1;
    public static final int AVM_VIEW_MODE_UNKNOWN = 0;
    public static final int CAMERA_FRONT_TO_CENTER_VIEW = 1;
    public static final int CAMERA_LEFT_FRONT_TO_CENTER_VIEW = 5;
    public static final int CAMERA_LEFT_TO_CENTER_VIEW = 3;
    public static final int CAMERA_REAR_TO_CENTER_VIEW = 2;
    public static final int CAMERA_RIGHT_TO_CENTER_VIEW = 4;
    public static final int CMD_AUTO_AVM_MODE_CLOSE = 1;
    public static final int CMD_AUTO_AVM_MODE_HIGHT = 3;
    public static final int CMD_AUTO_AVM_MODE_LOW = 2;
    public static final int CMD_MODEL_COLOR_GRAY = 3;
    public static final int CMD_MODEL_COLOR_RED = 2;
    public static final int CMD_MODEL_COLOR_SILVERY = 1;
    public static final int GUILD_DISPLAY_BOTH_VIEW = 0;
    public static final int GUILD_DISPLAY_NO_DISPLAY = 3;
    public static final int GUILD_DISPLAY_ONLY_AROUND_VIEW = 1;
    public static final int GUILD_DISPLAY_ONLY_SINGLE_VIEW = 2;
    public static int MODEL_2D_VIEW = 1;
    public static int MODEL_3D_VIEW = 2;
    public static final int MODEL_COLOR_GRAY = 2;
    public static final int MODEL_COLOR_RED = 1;
    public static final int MODEL_COLOR_SILVERY = 0;
    public static final int MODEL_TRANSP_COMPL_TRANSLUCENT = 2;
    public static final int MODEL_TRANSP_OPAQUE = 0;
    public static final int MODEL_TRANSP_TRANSLUCENT = 1;
    public static final int MODEL_TRANSP_UNKNOW = -1;
    public static int MODEL_UNKNOW_VIEW = 0;
    public static final int RADAR_DISPLAY_BOTH_VIEW = 0;
    public static final int RADAR_DISPLAY_NO_DISPLAY = 3;
    public static final int RADAR_DISPLAY_ONLY_AROUND_VIEW = 1;
    public static final int RADAR_DISPLAY_ONLY_SINGLE_VIEW = 2;
    public static final int SAVM_FRONT_TO_CENTER_VIEW = 0;
    public static final int SAVM_LEFT_TO_CENTER_VIEW = 2;
    public static final int SAVM_REAR_OF_LEFT_VIEW = 4;
    public static final int SAVM_REAR_OF_RIGHT_VIEW = 5;
    public static final int SAVM_REAR_TO_CENTER_VIEW = 1;
    public static final int SAVM_RIGHT_TO_CENTER_VIEW = 3;
    public static final int SGL_SEL_VIEW_UNKNOWN = 0;
    public static final int TOUCH_2D_FRONT_BUTTON = 1;
    public static final int TOUCH_2D_LEFT_BACK_BUTTON = 6;
    public static final int TOUCH_2D_LEFT_BUTTON = 3;
    public static final int TOUCH_2D_LEFT_FRONT_BUTTON = 5;
    public static final int TOUCH_2D_REAR_BUTTON = 2;
    public static final int TOUCH_2D_RIGHT_BACK_BUTTON = 8;
    public static final int TOUCH_2D_RIGHT_BUTTON = 4;
    public static final int TOUCH_2D_RIGHT_FRONT_BUTTON = 7;
    public static final int TOUCH_ANGLE_SWITCH_BUTTON = 10;
    public static final int TOUCH_LEFT_AND_RIGHT_BUTTON = 11;
    public static final int TOUCH_RETURN_BUTTON = 9;

    /* loaded from: /home/user/work/dex/classes.dex */
    public static class APAInfo {
        public int APA_VoiceReminder;
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public static class RadarInfo {
        public byte PAS_BattVoltErrFlag;
        public byte PAS_ButtonPress;
        public byte PAS_CtrlModulerrFlag;
        public byte PAS_FSLSideDistance;
        public byte PAS_FSRSideDistance;
        public byte PAS_RPASysFailureFlag;
        public byte PAS_SystemType;
        public byte PAS_WarnTone;
        public byte leftBackDis;
        public byte leftBackSensorFaultSts;
        public byte leftCenterBackDis;
        public byte leftCenterBackSensorFaultSts;
        public byte leftCenterFrontDis;
        public byte leftCenterFrontSensorFaultSts;
        public byte leftFrontDis;
        public byte leftFrontSensorFaultSts;
        public byte rightBackDis;
        public byte rightBackSensorFaultSts;
        public byte rightCenterBackDis;
        public byte rightCenterBackSensorFaultSts;
        public byte rightCenterFrontDis;
        public byte rightCenterFrontSensorFaultSts;
        public byte rightFrontDis;
        public byte rightFrontSensorFaultSts;
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public static class SDWRadarInfo {
        public byte SDWActive;
        public byte leftBackSideSensorFaultSts;
        public byte leftFrontSideSensorFaultSts;
        public byte leftSideArea1;
        public byte leftSideArea2;
        public byte leftSideArea3;
        public byte leftSideArea4;
        public byte leftSideArea5;
        public byte rightBackSideSensorFaultSts;
        public byte rightFrontSideSensorFaultSts;
        public byte rightSideArea1;
        public byte rightSideArea2;
        public byte rightSideArea3;
        public byte rightSideArea4;
        public byte rightSideArea5;
    }
}
