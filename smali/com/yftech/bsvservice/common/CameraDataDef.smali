.class public Lcom/yftech/bsvservice/common/CameraDataDef;
.super Ljava/lang/Object;
.source "CameraDataDef.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;,
        Lcom/yftech/bsvservice/common/CameraDataDef$SDWRadarInfo;,
        Lcom/yftech/bsvservice/common/CameraDataDef$RadarInfo;
    }
.end annotation


# static fields
.field public static final AUTO_AVM_MODE_CLOSE:I = 0x0

.field public static final AUTO_AVM_MODE_LOW:I = 0x1

.field public static final AUTO_AVM_MODE_MIDDLE_LOW:I = 0x2

.field public static final AVM_3D_ROUND_VIEW:I = 0x12

.field public static final AVM_BAT_VOL_OUT_OF_RANGE:I = 0x1

.field public static final AVM_CALIBRATE_PARAM_TYPE_DEFAULT:I = 0x0

.field public static final AVM_CALIBRATE_PARAM_TYPE_USER:I = 0x1

.field public static final AVM_CALIBRATE_STATE_FAILURE:I = 0x3

.field public static final AVM_CALIBRATE_STATE_PROCESS:I = 0x1

.field public static final AVM_CALIBRATE_STATE_SUCCESS:I = 0x2

.field public static final AVM_CALIBRATE_STATE_UNKNOW:I = 0x0

.field public static final AVM_CAN_COM_FEILED:I = 0x2

.field public static final AVM_CONTROL_OP_FEILED:I = 0x4

.field public static final AVM_EOL_NOT_COMPLETED_FEILED:I = 0x10

.field public static final AVM_FRONT_180_VIEW:I = 0xf

.field public static final AVM_FRONT_CAMERA_INPUT_FEILED:I = 0x1

.field public static final AVM_FRONT_OVERLOOK_VIEW:I = 0xb

.field public static final AVM_FRONT_TO_CENTER_VIEW:I = 0x1

.field public static final AVM_FRONT_VIEW:I = 0x9

.field public static final AVM_LEFT_CAMERA_INPUT_FEILED:I = 0x4

.field public static final AVM_LEFT_FRONT_TO_CENTER_VIEW:I = 0x5

.field public static final AVM_LEFT_REAR_TO_CENTER_VIEW:I = 0x7

.field public static final AVM_LEFT_RIGHT_VIEW:I = 0x11

.field public static final AVM_LEFT_TO_CENTER_VIEW:I = 0x3

.field public static final AVM_LEFT_TURN_VIEW:I = 0xd

.field public static final AVM_MODEL_COLOR_UNKNOW:I = 0x0

.field public static final AVM_NO_ERR:I = 0x0

.field public static final AVM_REAR_180_VIEW:I = 0x10

.field public static final AVM_REAR_CAMERA_INPUT_FEILED:I = 0x2

.field public static final AVM_REAR_OVERLOOK_VIEW:I = 0xc

.field public static final AVM_REAR_TO_CENTER_VIEW:I = 0x2

.field public static final AVM_REAR_VIEW:I = 0xa

.field public static final AVM_RIGHT_CAMERA_INPUT_FEILED:I = 0x8

.field public static final AVM_RIGHT_FRONT_TO_CENTER_VIEW:I = 0x6

.field public static final AVM_RIGHT_REAR_TO_CENTER_VIEW:I = 0x8

.field public static final AVM_RIGHT_TO_CENTER_VIEW:I = 0x4

.field public static final AVM_RIGHT_TURN_VIEW:I = 0xe

.field public static final AVM_UNKNOW_VIEW:I = 0x0

.field public static final AVM_VIDEO_OUTPUT_FEILED:I = 0x8

.field public static final AVM_VIEW_EOL_TEST:I = 0x4

.field public static final AVM_VIEW_MAIN_MAIN_SCREEN:I = 0x1

.field public static final AVM_VIEW_MODE_UNKNOWN:I = 0x0

.field public static final CAMERA_FRONT_TO_CENTER_VIEW:I = 0x1

.field public static final CAMERA_LEFT_FRONT_TO_CENTER_VIEW:I = 0x5

.field public static final CAMERA_LEFT_TO_CENTER_VIEW:I = 0x3

.field public static final CAMERA_REAR_TO_CENTER_VIEW:I = 0x2

.field public static final CAMERA_RIGHT_TO_CENTER_VIEW:I = 0x4

.field public static final CMD_AUTO_AVM_MODE_CLOSE:I = 0x1

.field public static final CMD_AUTO_AVM_MODE_HIGHT:I = 0x3

.field public static final CMD_AUTO_AVM_MODE_LOW:I = 0x2

.field public static final CMD_MODEL_COLOR_GRAY:I = 0x3

.field public static final CMD_MODEL_COLOR_RED:I = 0x2

.field public static final CMD_MODEL_COLOR_SILVERY:I = 0x1

.field public static final GUILD_DISPLAY_BOTH_VIEW:I = 0x0

.field public static final GUILD_DISPLAY_NO_DISPLAY:I = 0x3

.field public static final GUILD_DISPLAY_ONLY_AROUND_VIEW:I = 0x1

.field public static final GUILD_DISPLAY_ONLY_SINGLE_VIEW:I = 0x2

.field public static MODEL_2D_VIEW:I = 0x1

.field public static MODEL_3D_VIEW:I = 0x2

.field public static final MODEL_COLOR_GRAY:I = 0x2

.field public static final MODEL_COLOR_RED:I = 0x1

.field public static final MODEL_COLOR_SILVERY:I = 0x0

.field public static final MODEL_TRANSP_COMPL_TRANSLUCENT:I = 0x2

.field public static final MODEL_TRANSP_OPAQUE:I = 0x0

.field public static final MODEL_TRANSP_TRANSLUCENT:I = 0x1

.field public static final MODEL_TRANSP_UNKNOW:I = -0x1

.field public static MODEL_UNKNOW_VIEW:I = 0x0

.field public static final RADAR_DISPLAY_BOTH_VIEW:I = 0x0

.field public static final RADAR_DISPLAY_NO_DISPLAY:I = 0x3

.field public static final RADAR_DISPLAY_ONLY_AROUND_VIEW:I = 0x1

.field public static final RADAR_DISPLAY_ONLY_SINGLE_VIEW:I = 0x2

.field public static final SAVM_FRONT_TO_CENTER_VIEW:I = 0x0

.field public static final SAVM_LEFT_TO_CENTER_VIEW:I = 0x2

.field public static final SAVM_REAR_OF_LEFT_VIEW:I = 0x4

.field public static final SAVM_REAR_OF_RIGHT_VIEW:I = 0x5

.field public static final SAVM_REAR_TO_CENTER_VIEW:I = 0x1

.field public static final SAVM_RIGHT_TO_CENTER_VIEW:I = 0x3

.field public static final SGL_SEL_VIEW_UNKNOWN:I = 0x0

.field public static final TOUCH_2D_FRONT_BUTTON:I = 0x1

.field public static final TOUCH_2D_LEFT_BACK_BUTTON:I = 0x6

.field public static final TOUCH_2D_LEFT_BUTTON:I = 0x3

.field public static final TOUCH_2D_LEFT_FRONT_BUTTON:I = 0x5

.field public static final TOUCH_2D_REAR_BUTTON:I = 0x2

.field public static final TOUCH_2D_RIGHT_BACK_BUTTON:I = 0x8

.field public static final TOUCH_2D_RIGHT_BUTTON:I = 0x4

.field public static final TOUCH_2D_RIGHT_FRONT_BUTTON:I = 0x7

.field public static final TOUCH_ANGLE_SWITCH_BUTTON:I = 0xa

.field public static final TOUCH_LEFT_AND_RIGHT_BUTTON:I = 0xb

.field public static final TOUCH_RETURN_BUTTON:I = 0x9


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
