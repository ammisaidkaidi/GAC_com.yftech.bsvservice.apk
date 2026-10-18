.class public Lcom/yftech/bsvservice/BsvServiceImpl;
.super Lcom/yftech/bsvservice/IBsvService$Stub;
.source "BsvServiceImpl.java"

# interfaces
.implements Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;
    }
.end annotation


# static fields
.field private static final BRIGHTNESS_ADDR:I = 0x10018

.field private static final CONTRAST_ADDR:I = 0x1001a

.field private static final HUE_ADDR:I = 0x10017

.field private static final H_ADDR:I = 0x1000f

.field private static final ROTATION_OF_SCREEN:Ljava/lang/String; = "persist.sf.hwrotation"

.field private static final SATURATION_ADDR:I = 0x10019

.field private static final TAG:Ljava/lang/String; = "BsvServiceImpl"

.field private static final W_ADDR:I = 0x1000e

.field private static final X_ADDR:I = 0x1000c

.field private static final Y_ADDR:I = 0x1000d

.field private static gInst:Lcom/yftech/bsvservice/BsvServiceImpl;


# instance fields
.field private cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

.field private mAlertDialog:Landroid/app/AlertDialog;

.field private mAudioManager:Lcom/autochips/atcaudiomanager/ATCAudioManager;

.field private mBackCar:Lcom/autochips/backcar/BackCar;

.field private mBackcarViewRect:Landroid/graphics/Rect;

.field private mCallbacks:Landroid/os/RemoteCallbackList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/RemoteCallbackList<",
            "Lcom/yftech/bsvservice/IBsvServiceCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mCameraStateMachineMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/yftech/bsvservice/CameraStateMachine;",
            ">;"
        }
    .end annotation
.end field

.field private mContext:Landroid/content/Context;

.field private mCurrentBackCamerId:Ljava/lang/String;

.field private mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

.field private mHandler:Landroid/os/Handler;

.field private mIsArm2Exit:Z

.field private mIsArm2RvcOn:Z

.field private mLayoutParams:Landroid/view/WindowManager$LayoutParams;

.field private mRotation:I

.field public mSignalOn:Z

.field private mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

.field private mSurfaceView:Landroid/view/SurfaceView;

.field public mUserPreviewOn:Z

.field private mWM:Landroid/view/WindowManager;

.field private mWindowHeight:I

.field private mWindowWidth:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    .line 107
    invoke-direct {p0}, Lcom/yftech/bsvservice/IBsvService$Stub;-><init>()V

    .line 49
    new-instance v0, Landroid/os/RemoteCallbackList;

    invoke-direct {v0}, Landroid/os/RemoteCallbackList;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    const/4 v0, 0x0

    .line 62
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    .line 63
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mUserPreviewOn:Z

    .line 79
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mHandler:Landroid/os/Handler;

    .line 108
    sput-object p0, Lcom/yftech/bsvservice/BsvServiceImpl;->gInst:Lcom/yftech/bsvservice/BsvServiceImpl;

    .line 109
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mContext:Landroid/content/Context;

    .line 110
    new-instance v0, Lcom/autochips/atcaudiomanager/ATCAudioManager;

    invoke-direct {v0, p1}, Lcom/autochips/atcaudiomanager/ATCAudioManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mAudioManager:Lcom/autochips/atcaudiomanager/ATCAudioManager;

    .line 111
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCameraStateMachineMap:Ljava/util/Map;

    .line 112
    new-instance v0, Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    invoke-direct {v0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    .line 113
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getWindowInfo(Landroid/content/Context;)V

    .line 115
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->initBarcarView()V

    .line 116
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->initAlertDialog(Landroid/content/Context;)V

    .line 117
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->initCameraStateMachines()V

    .line 118
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/avm/AvmControl;->setAvmServiceRun(Z)V

    .line 119
    invoke-static {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->init(Landroid/content/Context;)V

    .line 120
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getSurface()Landroid/view/SurfaceView;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    .line 121
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->setCameraMonitorListener(Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;)V

    return-void
.end method

.method private collapsePanels()V
    .locals 1

    .line 548
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mContext:Landroid/content/Context;

    const-string v0, "statusbar"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/StatusBarManager;

    .line 549
    invoke-virtual {p0}, Landroid/app/StatusBarManager;->collapsePanels()V

    return-void
.end method

.method private disableBackcarAudio()V
    .locals 1

    .line 557
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mAudioManager:Lcom/autochips/atcaudiomanager/ATCAudioManager;

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/autochips/atcaudiomanager/ATCAudioManager;->enableBackcarVolumePolicy(Z)Z

    return-void
.end method

.method private disableStatusBarExpand(Z)V
    .locals 1

    .line 539
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mContext:Landroid/content/Context;

    const-string v0, "statusbar"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/StatusBarManager;

    if-eqz p1, :cond_0

    const/high16 p1, 0x1010000

    .line 541
    invoke-virtual {p0, p1}, Landroid/app/StatusBarManager;->disable(I)V

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 543
    invoke-virtual {p0, p1}, Landroid/app/StatusBarManager;->disable(I)V

    :goto_0
    return-void
.end method

.method private enableBackcarAudio()V
    .locals 1

    .line 553
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mAudioManager:Lcom/autochips/atcaudiomanager/ATCAudioManager;

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/autochips/atcaudiomanager/ATCAudioManager;->enableBackcarVolumePolicy(Z)Z

    return-void
.end method

.method private filterRecordTooSlowMsg(Ljava/lang/String;II)Z
    .locals 0

    const/16 p1, 0xe

    if-ne p2, p1, :cond_1

    const/16 p1, 0x11

    if-ne p3, p1, :cond_1

    .line 663
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {p1}, Landroid/app/AlertDialog;->isShowing()Z

    move-result p1

    if-nez p1, :cond_0

    .line 664
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {p0}, Landroid/app/AlertDialog;->show()V

    :cond_0
    const/4 p0, 0x1

    return p0

    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method private getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;
    .locals 2

    .line 131
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCameraStateMachineMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/yftech/bsvservice/CameraStateMachine;

    if-nez v0, :cond_0

    .line 133
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1, p1}, Lcom/yftech/bsvservice/CameraStateMachine;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 134
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCameraStateMachineMap:Ljava/util/Map;

    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 135
    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->registerCallback(Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;)V

    .line 136
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->start()V

    :cond_0
    return-object v0
.end method

.method public static getInstance()Lcom/yftech/bsvservice/BsvServiceImpl;
    .locals 1

    .line 97
    sget-object v0, Lcom/yftech/bsvservice/BsvServiceImpl;->gInst:Lcom/yftech/bsvservice/BsvServiceImpl;

    return-object v0
.end method

.method private getWindowInfo(Landroid/content/Context;)V
    .locals 3

    .line 142
    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0}, Landroid/graphics/Point;-><init>()V

    const-string v1, "window"

    .line 143
    invoke-virtual {p1, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/WindowManager;

    .line 144
    invoke-interface {p1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/Display;->getRealSize(Landroid/graphics/Point;)V

    .line 145
    iget p1, v0, Landroid/graphics/Point;->x:I

    iput p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    .line 146
    iget p1, v0, Landroid/graphics/Point;->y:I

    iput p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowHeight:I

    const-string p1, "persist.sf.hwrotation"

    const/4 v0, 0x0

    .line 147
    invoke-static {p1, v0}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result p1

    iput p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mRotation:I

    const-string p1, "BsvServiceImpl"

    .line 148
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mWindowWidth="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", mWindowHeight="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowHeight:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", mRotation="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mRotation:I

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p1, p0, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method private initAlertDialog(Landroid/content/Context;)V
    .locals 2

    .line 183
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const p1, 0x7f0b0003

    .line 184
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const v0, 0x7f0b0002

    .line 185
    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance v0, Lcom/yftech/bsvservice/BsvServiceImpl$2;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl$2;-><init>(Lcom/yftech/bsvservice/BsvServiceImpl;)V

    const v1, 0x7f0b0001

    .line 186
    invoke-virtual {p1, v1, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance v0, Lcom/yftech/bsvservice/BsvServiceImpl$1;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl$1;-><init>(Lcom/yftech/bsvservice/BsvServiceImpl;)V

    const/high16 v1, 0x7f0b0000

    .line 196
    invoke-virtual {p1, v1, v0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 201
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mAlertDialog:Landroid/app/AlertDialog;

    .line 202
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mAlertDialog:Landroid/app/AlertDialog;

    invoke-virtual {p0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object p0

    const/16 p1, 0x7d3

    invoke-virtual {p0, p1}, Landroid/view/Window;->setType(I)V

    return-void
.end method

.method private initBarcarView()V
    .locals 2

    .line 177
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mContext:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWM:Landroid/view/WindowManager;

    const-string v0, "persist.sf.hwrotation"

    const/4 v1, 0x0

    .line 178
    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    .line 179
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mContext:Landroid/content/Context;

    const-string v0, "layout_inflater"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/view/LayoutInflater;

    return-void
.end method

.method private initCameraStateMachines()V
    .locals 1

    const-string v0, "10"

    .line 126
    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    const-string v0, "0"

    .line 127
    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    return-void
.end method

.method private showBackcarInfo(I)V
    .locals 1

    const/16 v0, 0x12

    if-eq p1, v0, :cond_0

    const/16 v0, 0x14

    if-eq p1, v0, :cond_1

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 642
    :pswitch_0
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    if-eqz p1, :cond_1

    .line 643
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {p1}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorNoSignal()V

    .line 644
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {p0}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorReady()V

    goto :goto_0

    .line 652
    :cond_0
    :pswitch_1
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    if-eqz p1, :cond_1

    .line 653
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {p1}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorResumeSignal()V

    .line 654
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {p0}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorReady()V

    :cond_1
    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0xd
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private updateDisplayInfoFromMetazone()V
    .locals 8

    const/4 v0, 0x4

    .line 152
    new-array v0, v0, [I

    const v1, 0x1000c

    .line 153
    invoke-static {v1, v0}, Lcom/autochips/metazone/AtcMetazone;->readval(I[I)I

    const/4 v1, 0x0

    .line 154
    aget v2, v0, v1

    const v3, 0x1000d

    .line 155
    invoke-static {v3, v0}, Lcom/autochips/metazone/AtcMetazone;->readval(I[I)I

    .line 156
    aget v3, v0, v1

    const v4, 0x1000e

    .line 157
    invoke-static {v4, v0}, Lcom/autochips/metazone/AtcMetazone;->readval(I[I)I

    .line 158
    aget v4, v0, v1

    const v5, 0x1000f

    .line 159
    invoke-static {v5, v0}, Lcom/autochips/metazone/AtcMetazone;->readval(I[I)I

    .line 160
    aget v0, v0, v1

    const-string v5, "BsvServiceImpl"

    .line 161
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "x="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v7, ", y="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v7, ", w="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v7, ", h="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-array v7, v1, [Ljava/lang/Object;

    invoke-static {v5, v6, v7}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-ltz v4, :cond_0

    if-ltz v0, :cond_0

    if-lez v4, :cond_0

    if-lez v0, :cond_0

    add-int/2addr v4, v2

    .line 162
    iget v5, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    if-gt v4, v5, :cond_0

    add-int/2addr v0, v3

    iget v5, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowHeight:I

    if-gt v0, v5, :cond_0

    .line 163
    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1, v2, v3, v4, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mBackcarViewRect:Landroid/graphics/Rect;

    goto :goto_0

    .line 165
    :cond_0
    iget v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    iget v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowHeight:I

    if-ge v0, v2, :cond_1

    .line 166
    iget v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    .line 167
    iget v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    iget v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    mul-int/2addr v2, v3

    iget v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowHeight:I

    div-int/2addr v2, v3

    .line 168
    new-instance v3, Landroid/graphics/Rect;

    iget v4, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowHeight:I

    sub-int/2addr v4, v2

    div-int/lit8 v4, v4, 0x2

    invoke-direct {v3, v1, v4, v0, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mBackcarViewRect:Landroid/graphics/Rect;

    goto :goto_0

    .line 170
    :cond_1
    new-instance v0, Landroid/graphics/Rect;

    iget v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowWidth:I

    iget v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWindowHeight:I

    invoke-direct {v0, v1, v1, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mBackcarViewRect:Landroid/graphics/Rect;

    :goto_0
    return-void
.end method

.method private updateError(Ljava/lang/String;II)V
    .locals 4

    .line 592
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    .line 593
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v0}, Landroid/os/RemoteCallbackList;->beginBroadcast()I

    .line 594
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v0}, Landroid/os/RemoteCallbackList;->getRegisteredCallbackCount()I

    move-result v0

    :goto_0
    if-ge v1, v0, :cond_2

    const/4 v2, 0x0

    .line 598
    :try_start_0
    iget-object v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v3, v1}, Landroid/os/RemoteCallbackList;->getBroadcastItem(I)Landroid/os/IInterface;

    move-result-object v3

    check-cast v3, Lcom/yftech/bsvservice/IBsvServiceCallback;
    :try_end_0
    .catch Landroid/os/DeadObjectException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v3, :cond_0

    goto :goto_2

    .line 602
    :cond_0
    :try_start_1
    invoke-interface {v3}, Lcom/yftech/bsvservice/IBsvServiceCallback;->getCameraId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 603
    invoke-interface {v3, p1, p2, p3}, Lcom/yftech/bsvservice/IBsvServiceCallback;->onErrorOccurred(Ljava/lang/String;II)V
    :try_end_1
    .catch Landroid/os/DeadObjectException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_0
    move-object v2, v3

    goto :goto_1

    :catch_1
    move-exception v2

    .line 609
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_2

    :catch_2
    :goto_1
    if-eqz v2, :cond_1

    .line 607
    iget-object v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v3, v2}, Landroid/os/RemoteCallbackList;->unregister(Landroid/os/IInterface;)Z

    :cond_1
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 612
    :cond_2
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {p0}, Landroid/os/RemoteCallbackList;->finishBroadcast()V

    goto :goto_3

    :cond_3
    const-string p0, "BsvServiceImpl"

    const-string p1, "updateError - Callbacks map no such camera id"

    .line 614
    new-array p2, v1, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_3
    return-void
.end method

.method private updateStatus(Ljava/lang/String;I)V
    .locals 4

    .line 561
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    .line 562
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v0}, Landroid/os/RemoteCallbackList;->beginBroadcast()I

    .line 563
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v0}, Landroid/os/RemoteCallbackList;->getRegisteredCallbackCount()I

    move-result v0

    :goto_0
    if-ge v1, v0, :cond_3

    const/4 v2, 0x0

    .line 567
    :try_start_0
    iget-object v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v3, v1}, Landroid/os/RemoteCallbackList;->getBroadcastItem(I)Landroid/os/IInterface;

    move-result-object v3

    check-cast v3, Lcom/yftech/bsvservice/IBsvServiceCallback;
    :try_end_0
    .catch Landroid/os/DeadObjectException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v3, :cond_0

    goto :goto_2

    :cond_0
    if-nez p1, :cond_1

    goto :goto_2

    .line 574
    :cond_1
    :try_start_1
    invoke-interface {v3}, Lcom/yftech/bsvservice/IBsvServiceCallback;->getCameraId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 575
    invoke-interface {v3, p1, p2}, Lcom/yftech/bsvservice/IBsvServiceCallback;->onStatusChanged(Ljava/lang/String;I)V
    :try_end_1
    .catch Landroid/os/DeadObjectException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_0
    move-object v2, v3

    goto :goto_1

    :catch_1
    move-exception v2

    .line 581
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_2

    :catch_2
    :goto_1
    if-eqz v2, :cond_2

    .line 579
    iget-object v3, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v3, v2}, Landroid/os/RemoteCallbackList;->unregister(Landroid/os/IInterface;)Z

    :cond_2
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 584
    :cond_3
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {p0}, Landroid/os/RemoteCallbackList;->finishBroadcast()V

    goto :goto_3

    :cond_4
    const-string p0, "BsvServiceImpl"

    const-string p1, "updateStatus - Callbacks map no such camera id"

    .line 586
    new-array p2, v1, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_3
    return-void
.end method


# virtual methods
.method public cameraready()V
    .locals 1

    .line 101
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    if-eqz v0, :cond_0

    .line 102
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {p0}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorReady()V

    :cond_0
    return-void
.end method

.method cancelTouchInputFilterView()V
    .locals 3

    const-string v0, "BsvServiceImpl"

    const-string v1, "cancelTouchInputFilterView"

    const/4 v2, 0x0

    .line 410
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 411
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWM:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V

    const/4 v0, 0x0

    .line 412
    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    .line 413
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.MAIN"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.intent.category.HOME"

    .line 414
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v1, 0x10000000

    .line 415
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 416
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mContext:Landroid/content/Context;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method public getDuration(Ljava/lang/String;)I
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 315
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getDuration - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 316
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getDuration(Ljava/lang/String;)J

    move-result-wide p0

    const-wide/16 v0, 0x3e8

    .line 317
    div-long/2addr p0, v0

    long-to-int p0, p0

    return p0
.end method

.method public getMicState(Ljava/lang/String;)Z
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 284
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getMicState - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 285
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getMicState(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public getResolutions(Ljava/lang/String;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/Resolution;",
            ">;"
        }
    .end annotation

    const-string v0, "BsvServiceImpl"

    .line 297
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getResolution - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 298
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getResolutions(Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    .line 299
    new-instance p1, Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 300
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Size;

    .line 301
    new-instance v1, Lcom/yftech/bsvservice/Resolution;

    invoke-virtual {v0}, Landroid/util/Size;->getWidth()I

    move-result v2

    invoke-virtual {v0}, Landroid/util/Size;->getHeight()I

    move-result v0

    invoke-direct {v1, v2, v0}, Lcom/yftech/bsvservice/Resolution;-><init>(II)V

    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    return-object p1
.end method

.method public getWatermarkState(Ljava/lang/String;)Z
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 358
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getWatermarkState - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 359
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getWatermarkState(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public isArm2Exit()Z
    .locals 0

    .line 364
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mIsArm2Exit:Z

    return p0
.end method

.method public isBackCar()Z
    .locals 0

    .line 474
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    return p0
.end method

.method public isNormalRecordStarted(Ljava/lang/String;)Z
    .locals 4

    const-string v0, "BsvServiceImpl"

    .line 260
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isNormalRecordStarted - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 261
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->getRecordingState(Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method public isPreviewStarted(Ljava/lang/String;)Z
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 242
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isPreviewStarted - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 243
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getPreviewState(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public isUrgentRecordStarted(Ljava/lang/String;)Z
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 266
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isUrgentRecordStarted - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 267
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->getRecordingState(Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method public linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    .locals 0

    .line 696
    invoke-super {p0, p1, p2}, Lcom/yftech/bsvservice/IBsvService$Stub;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V

    return-void
.end method

.method public notifyExitArm2()V
    .locals 1

    const/4 v0, 0x1

    .line 221
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mIsArm2Exit:Z

    return-void
.end method

.method public onOperationFail(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 680
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onOperationFail -id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " operation:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " error:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 681
    invoke-direct {p0, p1, p2, p3}, Lcom/yftech/bsvservice/BsvServiceImpl;->filterRecordTooSlowMsg(Ljava/lang/String;II)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/16 v0, 0xe

    if-ne p2, v0, :cond_1

    .line 685
    iget-boolean v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    iget-object v1, v1, Lcom/yftech/bsvservice/BackcarSurfaceCallback;->mCameraId:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 686
    invoke-direct {p0, p3}, Lcom/yftech/bsvservice/BsvServiceImpl;->showBackcarInfo(I)V

    goto :goto_0

    :cond_1
    if-ne p2, v0, :cond_2

    .line 687
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mUserPreviewOn:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    iget-object v0, v0, Lcom/yftech/bsvservice/BackcarSurfaceCallback;->mCameraId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 688
    invoke-direct {p0, p3}, Lcom/yftech/bsvservice/BsvServiceImpl;->showBackcarInfo(I)V

    .line 691
    :cond_2
    :goto_0
    invoke-direct {p0, p1, p2, p3}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateError(Ljava/lang/String;II)V

    return-void
.end method

.method public onOperationSuccess(Ljava/lang/String;I)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 674
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onOperationSuccess -id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " operation:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 675
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateStatus(Ljava/lang/String;I)V

    return-void
.end method

.method public registerBsvServiceCallback(Ljava/lang/String;Lcom/yftech/bsvservice/IBsvServiceCallback;)V
    .locals 4

    const-string v0, "BsvServiceImpl"

    .line 369
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "registerBsvServiceCallback - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p2, :cond_1

    .line 371
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {v0, p2}, Landroid/os/RemoteCallbackList;->register(Landroid/os/IInterface;)Z

    .line 372
    iget-boolean p2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    if-nez p2, :cond_0

    const/16 p2, 0x65

    .line 373
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateStatus(Ljava/lang/String;I)V

    .line 375
    :cond_0
    iget-boolean p2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mIsArm2RvcOn:Z

    if-nez p2, :cond_1

    const-string p2, "BsvServiceImpl"

    const-string v0, "notify arm2 rvc exit"

    .line 376
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p2, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 p2, 0x69

    .line 377
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateStatus(Ljava/lang/String;I)V

    :cond_1
    return-void
.end method

.method public release()V
    .locals 0

    return-void
.end method

.method public resetSettings(Ljava/lang/String;)V
    .locals 0

    .line 323
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->resetSettings(Ljava/lang/String;)V

    return-void
.end method

.method public sendMediaMountedAndEjectedMessage(Z)V
    .locals 2

    .line 206
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCameraStateMachineMap:Ljava/util/Map;

    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p0

    .line 207
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 208
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/yftech/bsvservice/CameraStateMachine;

    if-eqz p1, :cond_0

    const/16 v1, -0x11

    goto :goto_1

    :cond_0
    const/16 v1, 0x11

    :goto_1
    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(I)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public sendQBMessage(Z)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 213
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendQBMessage, isQbOn="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 214
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCameraStateMachineMap:Ljava/util/Map;

    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p0

    .line 215
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 216
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/yftech/bsvservice/CameraStateMachine;

    if-eqz p1, :cond_0

    const/16 v1, 0x10

    goto :goto_1

    :cond_0
    const/16 v1, -0x10

    :goto_1
    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(I)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public setCameraMonitorListener(Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;)V
    .locals 0

    .line 700
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    return-void
.end method

.method public setDuration(Ljava/lang/String;I)V
    .locals 4

    const-string v0, "BsvServiceImpl"

    .line 308
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setDuration - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " duration:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "(s)"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    int-to-long v0, p2

    const-wide/16 v2, 0x3e8

    mul-long/2addr v0, v2

    .line 310
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->setDuration(Ljava/lang/String;J)V

    return-void
.end method

.method public setMicState(Ljava/lang/String;Z)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 278
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setMicState - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " micOn:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 279
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->setMic(Ljava/lang/String;Z)V

    return-void
.end method

.method public setResolution(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 290
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setResolution - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " width:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " height:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 291
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/CameraStateMachine;->setResolution(Ljava/lang/String;II)V

    return-void
.end method

.method public setWatermarkHeight(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 352
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWatermarkHeight - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "type = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " value:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 353
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/CameraStateMachine;->setWatermarkHeight(Ljava/lang/String;II)V

    return-void
.end method

.method public setWatermarkStartX(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 334
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWatermarkStartX - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "type = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " value:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 335
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/CameraStateMachine;->setWatermarkStartX(Ljava/lang/String;II)V

    return-void
.end method

.method public setWatermarkStartY(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 340
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWatermarkStartY - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "type = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " value:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 341
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/CameraStateMachine;->setWatermarkStartY(Ljava/lang/String;II)V

    return-void
.end method

.method public setWatermarkState(Ljava/lang/String;IZ)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 328
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWatermarkState - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " watermarkOn:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 329
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/CameraStateMachine;->setWaterMark(Ljava/lang/String;IZ)V

    return-void
.end method

.method public setWatermarkWidth(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 346
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWatermarkWidth - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "type = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " value:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 347
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/CameraStateMachine;->setWatermarkWidth(Ljava/lang/String;II)V

    return-void
.end method

.method showTouchInputFilterView()V
    .locals 3

    const-string v0, "BsvServiceImpl"

    const-string v1, "filterTouchInputForArm2"

    const/4 v2, 0x0

    .line 401
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 402
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;->setGravity(I)V

    .line 403
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    const/high16 v1, 0x42200000    # 40.0f

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;->setTextSize(F)V

    .line 404
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;->setTextColor(I)V

    .line 405
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    const v1, 0x7f0b0052

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;->setText(I)V

    .line 406
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mWM:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mFilterView:Lcom/yftech/bsvservice/BsvServiceImpl$TouchInputFilterView;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mLayoutParams:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, p0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method public snapShot(Ljava/lang/String;)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 272
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "snapShot - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 273
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->snapshot(Ljava/lang/String;)V

    return-void
.end method

.method public startBackcar(Ljava/lang/String;)V
    .locals 6

    .line 478
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string p0, "BsvServiceImpl"

    const-string p1, "startBackcar when has not stop it"

    .line 479
    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_0
    const/4 v0, 0x1

    .line 482
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    .line 483
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->enableBackcarAudio()V

    .line 485
    iget-boolean v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mUserPreviewOn:Z

    const/16 v3, 0x64

    if-eqz v2, :cond_1

    const-string v0, "BsvServiceImpl"

    const-string v2, "startBackcar when user preview has not stop it"

    .line 486
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v1}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 487
    invoke-direct {p0, p1, v3}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateStatus(Ljava/lang/String;I)V

    return-void

    .line 490
    :cond_1
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCurrentBackCamerId:Ljava/lang/String;

    .line 491
    iget-object v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    if-eqz v2, :cond_2

    .line 492
    iget-object v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {v2}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorReqShow()V

    :cond_2
    const-string v2, "BsvServiceImpl"

    .line 496
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "startBackcar, backcar camera id is "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v5}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 497
    iget-object v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v2}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    iget-object v4, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-interface {v2, v4}, Landroid/view/SurfaceHolder;->removeCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 498
    iget-object v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v2}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    invoke-interface {v2}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Surface;->isValid()Z

    move-result v2

    if-eqz v2, :cond_3

    const-string v2, "BsvServiceImpl"

    .line 499
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "startBackcar, backcar camera id is11 "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 500
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v1

    invoke-virtual {p0, p1, v1, v0}, Lcom/yftech/bsvservice/BsvServiceImpl;->startPreview(Ljava/lang/String;Landroid/view/Surface;Z)V

    goto :goto_0

    :cond_3
    const-string v0, "BsvServiceImpl"

    .line 502
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "startBackcar, backcar camera id is22 "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 503
    new-instance v0, Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-direct {v0, p1, p0}, Lcom/yftech/bsvservice/BackcarSurfaceCallback;-><init>(Ljava/lang/String;Lcom/yftech/bsvservice/BsvServiceImpl;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    .line 504
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 506
    :goto_0
    invoke-direct {p0, p1, v3}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateStatus(Ljava/lang/String;I)V

    return-void
.end method

.method public startPreview(Ljava/lang/String;Landroid/view/Surface;Z)V
    .locals 4

    const-string v0, "BsvServiceImpl"

    .line 226
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "startPreview - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-nez p3, :cond_0

    .line 227
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    if-eqz v0, :cond_0

    const-string p0, "BsvServiceImpl"

    const-string p1, "do not start preview when backcar started"

    .line 228
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 231
    :cond_0
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    new-instance v0, Lcom/yftech/bsvservice/WrappedSurface;

    invoke-direct {v0, p2, p3}, Lcom/yftech/bsvservice/WrappedSurface;-><init>(Landroid/view/Surface;Z)V

    invoke-virtual {p0, p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->startPreview(Ljava/lang/String;Lcom/yftech/bsvservice/WrappedSurface;)V

    return-void
.end method

.method public startRecord(Ljava/lang/String;Z)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 248
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "startRecord - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 249
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->startRecord(Ljava/lang/String;Z)V

    return-void
.end method

.method public startUserPreview(Ljava/lang/String;)V
    .locals 4

    .line 424
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string p0, "BsvServiceImpl"

    const-string p1, "userStartPreivew but Backcar has not stop it"

    .line 425
    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 428
    :cond_0
    iput-boolean v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    const/4 v0, 0x1

    .line 429
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mUserPreviewOn:Z

    .line 430
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCurrentBackCamerId:Ljava/lang/String;

    .line 431
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    if-eqz v0, :cond_1

    .line 432
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {v0}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorReqShow()V

    :cond_1
    const-string v0, "BsvServiceImpl"

    .line 436
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "userStartPreivew, backcar camera id is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 437
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    iget-object v2, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-interface {v0, v2}, Landroid/view/SurfaceHolder;->removeCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 438
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Surface;->isValid()Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "BsvServiceImpl"

    .line 439
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "userStartPreivew, backcar camera id is11 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 440
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    iget-boolean v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    invoke-virtual {p0, p1, v0, v1}, Lcom/yftech/bsvservice/BsvServiceImpl;->startPreview(Ljava/lang/String;Landroid/view/Surface;Z)V

    goto :goto_0

    :cond_2
    const-string v0, "BsvServiceImpl"

    .line 442
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "userStartPreivew, backcar camera id is22 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 443
    new-instance v0, Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-direct {v0, p1, p0}, Lcom/yftech/bsvservice/BackcarSurfaceCallback;-><init>(Ljava/lang/String;Lcom/yftech/bsvservice/BsvServiceImpl;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    .line 444
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-interface {p1, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    :goto_0
    return-void
.end method

.method public stopBackcar(Ljava/lang/String;)V
    .locals 5

    .line 510
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string p0, "BsvServiceImpl"

    const-string p1, "stop backcar when has not start it"

    .line 511
    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 514
    :cond_0
    iput-boolean v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    .line 516
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mUserPreviewOn:Z

    if-eqz v0, :cond_1

    const/16 v0, 0x65

    .line 517
    invoke-direct {p0, p1, v0}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateStatus(Ljava/lang/String;I)V

    return-void

    :cond_1
    const/4 v0, 0x0

    .line 520
    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCurrentBackCamerId:Ljava/lang/String;

    const-string v2, "BsvServiceImpl"

    .line 521
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "stopBackcar, backcar camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 522
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v1, v0}, Landroid/view/SurfaceView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 523
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 524
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Surface;->isValid()Z

    const/4 v0, 0x1

    .line 525
    invoke-virtual {p0, p1, v0}, Lcom/yftech/bsvservice/BsvServiceImpl;->stopPreview(Ljava/lang/String;Z)V

    .line 527
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    if-eqz p1, :cond_2

    .line 528
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {p1}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorReqHide()V

    .line 530
    :cond_2
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-interface {p1, v0}, Landroid/view/SurfaceHolder;->removeCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 531
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->disableBackcarAudio()V

    return-void
.end method

.method public stopPreview(Ljava/lang/String;Z)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 236
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stopPreview - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 237
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->stopPreview(Ljava/lang/String;Z)V

    return-void
.end method

.method public stopRecord(Ljava/lang/String;)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 254
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stopRecord - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 255
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->getCameraStateMachine(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraStateMachine;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->stopRecord(Ljava/lang/String;)V

    return-void
.end method

.method public stopUserPreview(Ljava/lang/String;)V
    .locals 5

    .line 450
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mUserPreviewOn:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string p0, "BsvServiceImpl"

    const-string p1, "stop user preview when has not start it"

    .line 451
    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 454
    :cond_0
    iput-boolean v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mUserPreviewOn:Z

    .line 456
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSignalOn:Z

    if-eqz v0, :cond_1

    return-void

    :cond_1
    const/4 v0, 0x0

    .line 459
    iput-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCurrentBackCamerId:Ljava/lang/String;

    const-string v2, "BsvServiceImpl"

    .line 460
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "stopUserPreview, backcar camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 461
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v1, v0}, Landroid/view/SurfaceView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 462
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 464
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {v0}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Surface;->isValid()Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    .line 465
    invoke-virtual {p0, p1, v0}, Lcom/yftech/bsvservice/BsvServiceImpl;->stopPreview(Ljava/lang/String;Z)V

    .line 467
    :cond_2
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    if-eqz p1, :cond_3

    .line 468
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->cameraMonitorListener:Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;

    invoke-interface {p1}, Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;->onCameraMonitorReqHide()V

    .line 470
    :cond_3
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceView:Landroid/view/SurfaceView;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mSurfaceCallback:Lcom/yftech/bsvservice/BackcarSurfaceCallback;

    invoke-interface {p1, p0}, Landroid/view/SurfaceHolder;->removeCallback(Landroid/view/SurfaceHolder$Callback;)V

    return-void
.end method

.method public unregisterBsvServiceCallback(Ljava/lang/String;Lcom/yftech/bsvservice/IBsvServiceCallback;)V
    .locals 3

    const-string v0, "BsvServiceImpl"

    .line 384
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unregisterBsvServiceCallback - cameraId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p1, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p2, :cond_0

    .line 386
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl;->mCallbacks:Landroid/os/RemoteCallbackList;

    invoke-virtual {p0, p2}, Landroid/os/RemoteCallbackList;->unregister(Landroid/os/IInterface;)Z

    :cond_0
    return-void
.end method

.method public updateBackcarUi()V
    .locals 0

    return-void
.end method
