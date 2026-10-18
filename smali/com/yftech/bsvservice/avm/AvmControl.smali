.class public Lcom/yftech/bsvservice/avm/AvmControl;
.super Ljava/lang/Object;
.source "AvmControl.java"

# interfaces
.implements Lcom/yftech/bsvservice/common/ICameraControl$ICameraControlListener;
.implements Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/avm/AvmControl$SingletonFactory;
    }
.end annotation


# static fields
.field private static final ADDR_RVC_CAMERA_ID:I = 0x1002d

.field public static final AVM_CAMERA_HIDE:I = 0x0

.field public static final AVM_CAMERA_REQ_SHOW_BY_AVM_PROCOTOL:I = 0x1

.field public static final AVM_CAMERA_REQ_SHOW_BY_USER_ACTION:I = 0x2

.field public static final CAR_TYPE_A58:I = 0x1

.field public static final CAR_TYPE_A79:I = 0x3

.field public static final CAR_TYPE_A88:I = 0x2

.field public static final CAR_TYPE_UNKNOWN:I = 0x0

.field private static final DEBUG:Z = true

.field public static final DEVICE_TYPE_360RVCSVC:I = 0x3

.field public static final DEVICE_TYPE_AVM:I = 0x2

.field public static final DEVICE_TYPE_HAVM:I = 0x4

.field public static final DEVICE_TYPE_NONE:I = 0x0

.field public static final DEVICE_TYPE_RADAR:I = 0x5

.field public static final DEVICE_TYPE_RVC:I = 0x1

.field public static final FRONT_0_REAR_3:I = 0x1

.field public static final FRONT_0_REAR_4:I = 0x2

.field public static final FRONT_2_REAR_3:I = 0x3

.field public static final FRONT_2_REAR_4:I = 0x4

.field public static final FRONT_4_REAR_4:I = 0x5

.field public static final RADAR_TYPE_NONE:I = 0x0

.field private static final TAG:Ljava/lang/String; = "AvmControl"

.field private static avmReqOnOff:I = 0x0

.field private static buffer:Ljava/nio/ByteBuffer; = null

.field private static volatile isInit:Z = false


# instance fields
.field car_type:I

.field private contextWeakReference:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/content/Context;",
            ">;"
        }
    .end annotation
.end field

.field device_type:I

.field private mAPADrvReq:Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;

.field private mAvmDisplayShowState:Z

.field private mAvmFrontRadarErr:Z

.field private mAvmRearRadarErr:Z

.field private mAvmSignalErr:Z

.field private mAvmSystemErr:Z

.field private mBackCarCameraId:I

.field private mBaseWindow:Lcom/yftech/bsvservice/windowutil/BaseWindow;

.field private mBsvWindow:Lcom/yftech/bsvservice/windowutil/BSVWindow;

.field private mCameraInputErr:I

.field private mCarTrunkOpen:Z

.field mHandler:Landroid/os/Handler;

.field private mIsAVMPlusFAPAMode:Z

.field private mIsAvmServiceRun:Z

.field private mIsBackcar:Z

.field private mIsGearState:Z

.field private mIsHaveBsvDevice:Z

.field private mIsRvcMode:Z

.field private mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

.field mRadarInfo:Lcom/yftech/bsvservice/common/CameraDataDef$RadarInfo;

.field private mShowLoading:Z

.field r:Ljava/lang/Runnable;

.field radar_type:I

.field private testCmd:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x38

    .line 70
    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    sput-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->buffer:Ljava/nio/ByteBuffer;

    const/4 v0, 0x0

    .line 83
    sput v0, Lcom/yftech/bsvservice/avm/AvmControl;->avmReqOnOff:I

    return-void
.end method

.method private constructor <init>()V
    .locals 3

    .line 332
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    .line 61
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsRvcMode:Z

    const/4 v1, 0x0

    .line 62
    iput v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBackCarCameraId:I

    .line 63
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmDisplayShowState:Z

    .line 64
    new-instance v2, Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;

    invoke-direct {v2}, Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;-><init>()V

    iput-object v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAPADrvReq:Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;

    .line 74
    iput v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v0, 0x2

    .line 75
    iput v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->radar_type:I

    .line 76
    iput v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->car_type:I

    .line 85
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsGearState:Z

    const/4 v0, 0x0

    .line 88
    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBaseWindow:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    .line 91
    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBsvWindow:Lcom/yftech/bsvservice/windowutil/BSVWindow;

    .line 92
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSystemErr:Z

    .line 93
    iput v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mCameraInputErr:I

    .line 94
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSignalErr:Z

    .line 95
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmFrontRadarErr:Z

    .line 96
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmRearRadarErr:Z

    .line 97
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mCarTrunkOpen:Z

    .line 98
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    .line 99
    new-instance v0, Lcom/yftech/bsvservice/common/CameraDataDef$RadarInfo;

    invoke-direct {v0}, Lcom/yftech/bsvservice/common/CameraDataDef$RadarInfo;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mRadarInfo:Lcom/yftech/bsvservice/common/CameraDataDef$RadarInfo;

    .line 100
    new-instance v0, Lcom/yftech/bsvservice/util/DistributedHandler;

    invoke-direct {v0}, Lcom/yftech/bsvservice/util/DistributedHandler;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    .line 105
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsBackcar:Z

    .line 107
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsAvmServiceRun:Z

    .line 110
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsAVMPlusFAPAMode:Z

    .line 112
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsHaveBsvDevice:Z

    .line 674
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->testCmd:Z

    .line 675
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mHandler:Landroid/os/Handler;

    .line 676
    new-instance v0, Lcom/yftech/bsvservice/avm/AvmControl$1;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/avm/AvmControl$1;-><init>(Lcom/yftech/bsvservice/avm/AvmControl;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->r:Ljava/lang/Runnable;

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/avm/AvmControl$1;)V
    .locals 0

    .line 33
    invoke-direct {p0}, Lcom/yftech/bsvservice/avm/AvmControl;-><init>()V

    return-void
.end method

.method static synthetic access$200(Lcom/yftech/bsvservice/avm/AvmControl;)Z
    .locals 0

    .line 33
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->testCmd:Z

    return p0
.end method

.method static synthetic access$202(Lcom/yftech/bsvservice/avm/AvmControl;Z)Z
    .locals 0

    .line 33
    iput-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->testCmd:Z

    return p1
.end method

.method private getDevice()V
    .locals 7

    .line 338
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarConfig;->getVehiclePlatform()Lcom/yftech/vehicle/internal/adapter/ICarConfig$VehiclePlatform;

    move-result-object v0

    .line 339
    sget-object v1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getVehiclePlatform vehiclePlatform type:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {v1, v2, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 340
    sget-object v1, Lcom/yftech/vehicle/internal/adapter/ICarConfig$VehiclePlatform;->A58:Lcom/yftech/vehicle/internal/adapter/ICarConfig$VehiclePlatform;

    const/4 v2, 0x2

    const/4 v4, 0x1

    const/4 v5, 0x3

    if-ne v0, v1, :cond_0

    .line 341
    iput v4, p0, Lcom/yftech/bsvservice/avm/AvmControl;->car_type:I

    goto :goto_0

    .line 342
    :cond_0
    sget-object v1, Lcom/yftech/vehicle/internal/adapter/ICarConfig$VehiclePlatform;->A88:Lcom/yftech/vehicle/internal/adapter/ICarConfig$VehiclePlatform;

    if-ne v0, v1, :cond_1

    .line 343
    iput v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->car_type:I

    goto :goto_0

    .line 344
    :cond_1
    sget-object v1, Lcom/yftech/vehicle/internal/adapter/ICarConfig$VehiclePlatform;->A79:Lcom/yftech/vehicle/internal/adapter/ICarConfig$VehiclePlatform;

    if-ne v0, v1, :cond_2

    .line 345
    iput v5, p0, Lcom/yftech/bsvservice/avm/AvmControl;->car_type:I

    .line 347
    :cond_2
    :goto_0
    iput v5, p0, Lcom/yftech/bsvservice/avm/AvmControl;->car_type:I

    .line 348
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->car_type:I

    if-ne v0, v5, :cond_4

    .line 350
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarConfig;->getCameraNumber()Lcom/yftech/vehicle/internal/adapter/ICarConfig$CameraNumber;

    move-result-object v0

    .line 351
    sget-object v1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getCameraNumber cameraNumber:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v5, v3, [Ljava/lang/Object;

    invoke-static {v1, v0, v5}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 353
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarConfig;->isBsdPresent()Z

    move-result v0

    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsHaveBsvDevice:Z

    .line 354
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isBsdPresent mIsHaveBsvDevice:"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v5, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsHaveBsvDevice:Z

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v5, v3, [Ljava/lang/Object;

    invoke-static {v0, v1, v5}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 356
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsHaveBsvDevice:Z

    if-eqz v0, :cond_3

    .line 357
    iput-boolean v4, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsRvcMode:Z

    .line 358
    iput v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/16 v0, 0xa

    .line 359
    iput v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBackCarCameraId:I

    goto :goto_1

    .line 361
    :cond_3
    iput-boolean v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsRvcMode:Z

    .line 362
    iput v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    .line 363
    iput v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBackCarCameraId:I

    goto :goto_1

    .line 366
    :cond_4
    iput-boolean v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsRvcMode:Z

    .line 367
    iput v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    .line 368
    iput v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBackCarCameraId:I

    .line 372
    :goto_1
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "device type11:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public static getInstance()Lcom/yftech/bsvservice/avm/AvmControl;
    .locals 1

    .line 408
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl$SingletonFactory;->access$100()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    return-object v0
.end method

.method private getRadar()V
    .locals 5

    .line 376
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarConfig;->getRadarNumber()Lcom/yftech/vehicle/internal/adapter/ICarConfig$RadarNumber;

    move-result-object v0

    .line 377
    sget-object v1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getRadarNumber radar type:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {v1, v2, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 378
    sget-object v1, Lcom/yftech/vehicle/internal/adapter/ICarConfig$RadarNumber;->FRONT_0_REAR_3:Lcom/yftech/vehicle/internal/adapter/ICarConfig$RadarNumber;

    const/4 v2, 0x1

    if-ne v0, v1, :cond_0

    .line 379
    iput v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->radar_type:I

    goto :goto_0

    .line 380
    :cond_0
    sget-object v1, Lcom/yftech/vehicle/internal/adapter/ICarConfig$RadarNumber;->NONE:Lcom/yftech/vehicle/internal/adapter/ICarConfig$RadarNumber;

    if-ne v0, v1, :cond_1

    .line 381
    iput v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->radar_type:I

    goto :goto_0

    .line 383
    :cond_1
    iput v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->radar_type:I

    :goto_0
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .locals 2

    .line 426
    sget-boolean v0, Lcom/yftech/bsvservice/avm/AvmControl;->isInit:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    .line 427
    sput-boolean v0, Lcom/yftech/bsvservice/avm/AvmControl;->isInit:Z

    .line 428
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/avm/AvmControl;->avmInit(Landroid/content/Context;)I

    .line 429
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->windowInit()V

    .line 430
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->getInstance()Lcom/yftech/bsvservice/avm/AudioFocus;

    .line 431
    sget-object p0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v0, "avmservice_init_end"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-void
.end method

.method private isAvmSignalOk(I)Z
    .locals 4

    .line 115
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmSignal()I

    move-result v0

    int-to-long v1, p1

    .line 117
    :try_start_0
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 119
    invoke-virtual {p1}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 121
    :goto_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmSignal()I

    move-result p0

    .line 122
    sget-object p1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "avmSignal:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ",tmp_avmSignal:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {p1, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eq v0, p0, :cond_0

    const/4 v2, 0x1

    :cond_0
    return v2
.end method

.method private setAvmReqOnOff(I)V
    .locals 1

    .line 661
    sput p1, Lcom/yftech/bsvservice/avm/AvmControl;->avmReqOnOff:I

    .line 662
    sget-object p0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "set avmReqOnOff:"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v0, Lcom/yftech/bsvservice/avm/AvmControl;->avmReqOnOff:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public declared-synchronized avmInit(Landroid/content/Context;)I
    .locals 3

    monitor-enter p0

    .line 453
    :try_start_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->contextWeakReference:Ljava/lang/ref/WeakReference;

    .line 454
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-direct {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getRadar()V

    .line 455
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-direct {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getDevice()V

    .line 457
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getDeviceType()I

    move-result p1

    const/4 v0, 0x2

    const/4 v1, 0x0

    if-ne p1, v0, :cond_0

    goto :goto_0

    .line 460
    :cond_0
    sget-object p1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v0, "no set Proctol listener"

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 462
    :goto_0
    iget-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsHaveBsvDevice:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 468
    monitor-exit p0

    return v1

    :catchall_0
    move-exception p1

    .line 451
    monitor-exit p0

    throw p1
.end method

.method public canShow()Z
    .locals 0

    const/4 p0, 0x0

    return p0
.end method

.method public declared-synchronized dispSurfaceInit(IILandroid/view/Surface;)V
    .locals 0

    monitor-enter p0

    .line 497
    monitor-exit p0

    return-void
.end method

.method public declared-synchronized dispSurfaceRelease()V
    .locals 0

    monitor-enter p0

    .line 504
    monitor-exit p0

    return-void
.end method

.method public getAPADrvReq()Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;
    .locals 0

    .line 264
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAPADrvReq:Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;

    return-object p0
.end method

.method public getAvmHardwareState()I
    .locals 0

    const/4 p0, 0x0

    return p0
.end method

.method public getAvmMode()I
    .locals 0

    const/4 p0, 0x0

    return p0
.end method

.method public getAvmReqOnOff()I
    .locals 0

    .line 665
    sget p0, Lcom/yftech/bsvservice/avm/AvmControl;->avmReqOnOff:I

    return p0
.end method

.method public getAvmSignal()I
    .locals 0

    const/4 p0, 0x0

    return p0
.end method

.method public getBackCarCameraID()I
    .locals 0

    .line 394
    iget p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBackCarCameraId:I

    return p0
.end method

.method public getCarSpeed()I
    .locals 0

    const/4 p0, 0x1

    return p0
.end method

.method public getCarType()I
    .locals 0

    .line 520
    iget p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->car_type:I

    return p0
.end method

.method public getDeviceType()I
    .locals 0

    .line 511
    iget p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    return p0
.end method

.method public getMainHandler()Lcom/yftech/bsvservice/util/DistributedHandler;
    .locals 0

    .line 416
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    return-object p0
.end method

.method public getRadarType()I
    .locals 0

    .line 516
    iget p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->radar_type:I

    return p0
.end method

.method public declared-synchronized getSurface()Landroid/view/SurfaceView;
    .locals 2

    monitor-enter p0

    const/4 v0, 0x0

    .line 486
    :try_start_0
    iget-object v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBsvWindow:Lcom/yftech/bsvservice/windowutil/BSVWindow;

    if-eqz v1, :cond_0

    .line 487
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBsvWindow:Lcom/yftech/bsvservice/windowutil/BSVWindow;

    invoke-virtual {v0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->getSurface()Landroid/view/SurfaceView;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 489
    :cond_0
    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    .line 484
    monitor-exit p0

    throw v0
.end method

.method public getWindow()Lcom/yftech/bsvservice/windowutil/BaseWindow;
    .locals 0

    .line 472
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBaseWindow:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    return-object p0
.end method

.method public declared-synchronized hideAvm()V
    .locals 2

    monitor-enter p0

    .line 601
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 v1, 0xc9

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 602
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 600
    monitor-exit p0

    throw v0
.end method

.method public isAvmDisplay()Z
    .locals 0

    .line 267
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmDisplayShowState:Z

    return p0
.end method

.method public isAvmServiceRun()Z
    .locals 3

    .line 441
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mIsAvmServiceRun: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsAvmServiceRun:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 442
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsAvmServiceRun:Z

    return p0
.end method

.method public isAvmSignalErr()Z
    .locals 0

    .line 321
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSignalErr:Z

    return p0
.end method

.method public declared-synchronized isBackCar()Z
    .locals 1

    monitor-enter p0

    .line 132
    :try_start_0
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsBackcar:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public isCarTrunkOpen()Z
    .locals 0

    .line 328
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mCarTrunkOpen:Z

    return p0
.end method

.method isReverseWindowShow()Z
    .locals 4

    const-string p0, "sys.avmservice.show.state"

    const-string v0, "0"

    .line 217
    invoke-static {p0, v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 218
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " sys.avmservice.show.state :"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v0, "1"

    .line 219
    invoke-virtual {p0, v0}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    if-nez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    move p0, v2

    .line 222
    :goto_0
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " isReverseShow :"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return p0
.end method

.method public isRvcMode()Z
    .locals 0

    .line 389
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsRvcMode:Z

    return p0
.end method

.method public isShowLoading()Z
    .locals 0

    .line 317
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    return p0
.end method

.method public onAPADrvReq(Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;)V
    .locals 0

    .line 259
    iput-object p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAPADrvReq:Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;

    .line 260
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0x107

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public declared-synchronized onBackcarChange(Z)V
    .locals 1

    monitor-enter p0

    .line 127
    :try_start_0
    iput-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsBackcar:Z

    .line 128
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 v0, 0x105

    invoke-virtual {p1, v0}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 129
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    .line 126
    monitor-exit p0

    throw p1
.end method

.method public onCameraCommTimeOut(Z)V
    .locals 3

    .line 197
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onCameraCommTimeOut\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p1, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 198
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0xd8

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public onCameraMonitorLoading(Z)V
    .locals 0

    .line 288
    iput-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    .line 289
    iget-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    if-eqz p1, :cond_0

    .line 290
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0xca

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    goto :goto_0

    .line 292
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0xd4

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    :goto_0
    return-void
.end method

.method public onCameraMonitorNoSignal()V
    .locals 4

    .line 298
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v1, "onAvmMonitorNoSignal"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 299
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    const/4 v0, 0x1

    .line 300
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSignalErr:Z

    .line 301
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 v0, 0xcc

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public onCameraMonitorReady()V
    .locals 1

    .line 312
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 v0, 0xff

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public onCameraMonitorReqHide()V
    .locals 3

    .line 282
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v1, "onAvmMonitorReqHide"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 283
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->hideAvm()V

    return-void
.end method

.method public onCameraMonitorReqShow()V
    .locals 4

    .line 272
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v1, "onAvmMonitorReqShow"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 274
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    .line 275
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->showAvm()V

    return-void
.end method

.method public onCameraMonitorResumeSignal()V
    .locals 1

    const/4 v0, 0x0

    .line 306
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSignalErr:Z

    .line 307
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 v0, 0xcb

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public onCameraOpStateErr(Z)V
    .locals 0

    if-eqz p1, :cond_0

    .line 204
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0xce

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    goto :goto_0

    .line 206
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0xcd

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    :goto_0
    return-void
.end method

.method public onCameraReqHide()V
    .locals 4

    .line 162
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onAvmProcotolReqHide:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 163
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    if-nez v0, :cond_0

    .line 164
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->getInstance()Lcom/yftech/bsvservice/avm/AudioFocus;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->abondRvcFocus()V

    return-void

    .line 167
    :cond_0
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_3

    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v3, 0x2

    if-ne v0, v3, :cond_1

    goto :goto_0

    .line 173
    :cond_1
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v3, 0x5

    if-ne v0, v3, :cond_2

    .line 174
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_4

    .line 175
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/lit8 v0, v0, -0x2

    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 176
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    if-nez v0, :cond_4

    .line 177
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraMonitorReqHide()V

    goto :goto_1

    .line 181
    :cond_2
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onCameraReqHide device_type:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 168
    :cond_3
    :goto_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_4

    .line 169
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    .line 170
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/lit8 v0, v0, -0x2

    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 171
    invoke-static {}, Lcom/yftech/bsvservice/BsvService;->getInstance()Lcom/yftech/bsvservice/BsvService;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/BsvService;->stopBackCar()V

    :cond_4
    :goto_1
    return-void
.end method

.method public onCameraReqShow()V
    .locals 4

    .line 137
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onAvmProcotolReqShow:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 138
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    if-nez v0, :cond_0

    .line 139
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->getInstance()Lcom/yftech/bsvservice/avm/AudioFocus;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->requestRvcFocus()I

    return-void

    .line 142
    :cond_0
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_3

    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v3, 0x2

    if-ne v0, v3, :cond_1

    goto :goto_0

    .line 149
    :cond_1
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v3, 0x5

    if-ne v0, v3, :cond_2

    .line 150
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    add-int/2addr v0, v1

    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 151
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    if-ne v0, v1, :cond_4

    .line 152
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraMonitorReqShow()V

    .line 153
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraMonitorReady()V

    goto :goto_1

    .line 156
    :cond_2
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onCameraReqShow device_type:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 143
    :cond_3
    :goto_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/2addr v0, v1

    if-eq v0, v1, :cond_4

    .line 144
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSignalErr:Z

    .line 145
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    .line 146
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    add-int/2addr v0, v1

    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 147
    invoke-static {}, Lcom/yftech/bsvservice/BsvService;->getInstance()Lcom/yftech/bsvservice/BsvService;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/BsvService;->startBackCar()V

    :cond_4
    :goto_1
    return-void
.end method

.method public onCameraSystemErr(Z)V
    .locals 0

    .line 187
    iput-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSystemErr:Z

    if-eqz p1, :cond_0

    .line 189
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0xce

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    goto :goto_0

    .line 191
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0xcd

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    :goto_0
    return-void
.end method

.method public onDisplayState(Z)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    .line 229
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->isReverseWindowShow()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 230
    sget-object p0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string p1, " reverse ui is show,no show bsv"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 235
    :cond_0
    iput-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmDisplayShowState:Z

    .line 236
    new-instance v1, Landroid/os/Message;

    invoke-direct {v1}, Landroid/os/Message;-><init>()V

    const/16 v2, 0x109

    .line 237
    iput v2, v1, Landroid/os/Message;->what:I

    .line 238
    iput p1, v1, Landroid/os/Message;->arg1:I

    .line 239
    iput v0, v1, Landroid/os/Message;->arg2:I

    .line 240
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    invoke-virtual {p0, v1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public onGearStateChange(I)V
    .locals 5

    const/4 v0, 0x0

    const/4 v1, 0x1

    const/16 v2, 0xe

    if-ne p1, v2, :cond_0

    move v3, v1

    goto :goto_0

    :cond_0
    move v3, v0

    .line 247
    :goto_0
    iget-boolean v4, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsGearState:Z

    if-ne v4, v3, :cond_1

    return-void

    .line 248
    :cond_1
    iput-boolean v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsGearState:Z

    if-ne p1, v2, :cond_2

    .line 250
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->playReverseEffect()V

    .line 251
    invoke-virtual {p0, v1}, Lcom/yftech/bsvservice/avm/AvmControl;->onBackcarChange(Z)V

    goto :goto_1

    .line 253
    :cond_2
    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->onBackcarChange(Z)V

    :goto_1
    return-void
.end method

.method public onSteerWheelAngel(F)V
    .locals 0

    .line 212
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 p1, 0x104

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z

    return-void
.end method

.method public playReverseEffect()V
    .locals 0

    .line 669
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBaseWindow:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    return-void
.end method

.method public postDelayHandler(I)V
    .locals 3

    .line 695
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mHandler:Landroid/os/Handler;

    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->r:Ljava/lang/Runnable;

    int-to-long v1, p1

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public readResolve()Ljava/lang/Object;
    .locals 0

    .line 412
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    return-object p0
.end method

.method public setAvmMode(I)V
    .locals 0

    return-void
.end method

.method public setAvmServiceRun(Z)V
    .locals 0

    .line 437
    iput-boolean p1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsAvmServiceRun:Z

    return-void
.end method

.method public declared-synchronized showAvm()V
    .locals 2

    monitor-enter p0

    .line 597
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mMainHandler:Lcom/yftech/bsvservice/util/DistributedHandler;

    const/16 v1, 0xca

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/util/DistributedHandler;->sendEmptyMessage(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 598
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 596
    monitor-exit p0

    throw v0
.end method

.method public sourcePause(Landroid/os/Bundle;)Z
    .locals 2

    .line 632
    sget-object p1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v0, "sourcePause"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 633
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmHardwareState()I

    move-result p0

    const/4 p1, 0x1

    if-ne p0, p1, :cond_0

    return p1

    .line 637
    :cond_0
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->hideAvm()V

    return p1
.end method

.method public sourceResume(Landroid/os/Bundle;)Z
    .locals 2

    .line 642
    sget-object p1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v0, "sourceResume"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 643
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmHardwareState()I

    move-result p0

    const/4 p1, 0x1

    if-ne p0, p1, :cond_0

    return p1

    .line 647
    :cond_0
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->showAvm()V

    return p1
.end method

.method public sourceStart(Landroid/os/Bundle;)Z
    .locals 2

    .line 623
    sget-object p1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v0, "sourceStart"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 624
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmHardwareState()I

    move-result p0

    const/4 p1, 0x1

    if-ne p0, p1, :cond_0

    return p1

    .line 627
    :cond_0
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->showAvm()V

    return p1
.end method

.method public sourceStop(Landroid/os/Bundle;)Z
    .locals 2

    .line 652
    sget-object p1, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    const-string v0, "sourceStop"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 653
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmHardwareState()I

    move-result p0

    const/4 p1, 0x1

    if-ne p0, p1, :cond_0

    return p1

    .line 657
    :cond_0
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->hideAvm()V

    return p1
.end method

.method public declared-synchronized userRequestHideAvm()V
    .locals 4

    monitor-enter p0

    .line 579
    :try_start_0
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "userRequestHideAvm:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 580
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v1, 0x1

    const/4 v3, 0x2

    if-eq v0, v1, :cond_2

    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    if-ne v0, v3, :cond_0

    goto :goto_0

    .line 586
    :cond_0
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_1

    .line 587
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/2addr v0, v3

    if-ne v0, v3, :cond_3

    .line 588
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/lit8 v0, v0, -0x3

    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 589
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraMonitorReqHide()V

    goto :goto_1

    .line 592
    :cond_1
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "userRequestHideAvm device_type:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 581
    :cond_2
    :goto_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/2addr v0, v3

    if-ne v0, v3, :cond_3

    .line 582
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    .line 583
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    and-int/lit8 v0, v0, -0x3

    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 584
    invoke-static {}, Lcom/yftech/bsvservice/BsvService;->getInstance()Lcom/yftech/bsvservice/BsvService;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/BsvService;->stopUserPreview()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 594
    :cond_3
    :goto_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 578
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized userRequestShowAvm()V
    .locals 4

    monitor-enter p0

    .line 560
    :try_start_0
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "userRequestShowAvm:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 561
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    monitor-exit p0

    return-void

    .line 562
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result v0

    if-nez v0, :cond_4

    .line 563
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mAvmSignalErr:Z

    .line 564
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mShowLoading:Z

    .line 565
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v1, 0x1

    const/4 v3, 0x2

    if-eq v0, v1, :cond_3

    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    if-ne v0, v3, :cond_1

    goto :goto_0

    .line 568
    :cond_1
    iget v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_2

    .line 569
    invoke-direct {p0, v3}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 570
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraMonitorReqShow()V

    .line 571
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraMonitorReady()V

    goto :goto_1

    .line 573
    :cond_2
    sget-object v0, Lcom/yftech/bsvservice/avm/AvmControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "userRequestShowAvm device_type:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lcom/yftech/bsvservice/avm/AvmControl;->device_type:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 566
    :cond_3
    :goto_0
    invoke-direct {p0, v3}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmReqOnOff(I)V

    .line 567
    invoke-static {}, Lcom/yftech/bsvservice/BsvService;->getInstance()Lcom/yftech/bsvservice/BsvService;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/BsvService;->startUserPreview()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 576
    :cond_4
    :goto_1
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 559
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized windowInit()V
    .locals 2

    monitor-enter p0

    .line 476
    :try_start_0
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mIsHaveBsvDevice:Z

    if-eqz v0, :cond_0

    .line 477
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBsvWindow:Lcom/yftech/bsvservice/windowutil/BSVWindow;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->contextWeakReference:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 478
    new-instance v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;

    iget-object v1, p0, Lcom/yftech/bsvservice/avm/AvmControl;->contextWeakReference:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/yftech/bsvservice/windowutil/BSVWindow;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl;->mBsvWindow:Lcom/yftech/bsvservice/windowutil/BSVWindow;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 482
    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 475
    monitor-exit p0

    throw v0
.end method
