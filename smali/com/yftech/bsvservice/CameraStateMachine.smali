.class public Lcom/yftech/bsvservice/CameraStateMachine;
.super Lcom/yftech/bsvservice/StateMachine;
.source "CameraStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;,
        Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;,
        Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;,
        Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;,
        Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;,
        Lcom/yftech/bsvservice/CameraStateMachine$ClosingState;,
        Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;,
        Lcom/yftech/bsvservice/CameraStateMachine$OpeningState;,
        Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;
    }
.end annotation


# static fields
.field public static final MSG_CAMERA_CLOSED:I = 0x7

.field public static final MSG_CAMERA_OPENED:I = 0x6

.field public static final MSG_CLOSE_CAMERA:I = -0x1

.field public static final MSG_MEDIA_EJECTED:I = 0x11

.field public static final MSG_MEDIA_MOUNTED:I = -0x11

.field public static final MSG_OPEN_CAMERA:I = 0x1

.field public static final MSG_PREVIEWING:I = 0xc

.field public static final MSG_PREVIEW_STOPPED:I = 0xe

.field public static final MSG_QB_OFF:I = -0x10

.field public static final MSG_QB_ON:I = 0x10

.field public static final MSG_RECORDING:I = 0xd

.field public static final MSG_RECORD_STOPPED:I = 0xf

.field public static final MSG_RESET_SETTINGS:I = 0x1a

.field public static final MSG_RESTORE_CAMERA:I = 0x1b

.field public static final MSG_SET_BRIGHTNESS:I = 0x13

.field public static final MSG_SET_CONTRAST:I = 0x15

.field public static final MSG_SET_DURATION:I = 0x9

.field public static final MSG_SET_HEIGHT:I = 0x19

.field public static final MSG_SET_HUE:I = 0x12

.field public static final MSG_SET_MIC:I = 0xa

.field public static final MSG_SET_RESOLUTION:I = 0x8

.field public static final MSG_SET_SATURATION:I = 0x14

.field public static final MSG_SET_STARTX:I = 0x16

.field public static final MSG_SET_STARTY:I = 0x17

.field public static final MSG_SET_WATERMARK:I = 0xb

.field public static final MSG_SET_WIDTH:I = 0x18

.field public static final MSG_SNAPSHOT:I = 0x5

.field public static final MSG_START_PREVIEW:I = 0x2

.field public static final MSG_START_RECORD:I = 0x3

.field public static final MSG_START_URGENT:I = 0x4

.field public static final MSG_STOP_PREVIEW:I = -0x2

.field public static final MSG_STOP_RECORD:I = -0x3

.field public static final MSG_STOP_URGENT:I = -0x4

.field private static final TAG:Ljava/lang/String; = "CameraStateMachine"


# instance fields
.field private mActiveCamera:Lcom/yftech/bsvservice/CameraOperation;

.field private mActiveCameraId:Ljava/lang/String;

.field private mCallback:Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;

.field private mCameraOperations:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/yftech/bsvservice/CameraOperation;",
            ">;"
        }
    .end annotation
.end field

.field private mClosedState:Lcom/yftech/bsvservice/State;

.field private mClosingState:Lcom/yftech/bsvservice/State;

.field private mContext:Landroid/content/Context;

.field private mIsRecordingBeforeMediaEjected:Z

.field private mOpenedState:Lcom/yftech/bsvservice/State;

.field private mOpeningState:Lcom/yftech/bsvservice/State;

.field private mOperationCallback:Lcom/yftech/bsvservice/CameraOperation$CameraOperationCallback;

.field private mOutsideHandler:Landroid/os/Handler;

.field private mPreviewingAndRecordingState:Lcom/yftech/bsvservice/State;

.field private mPreviewingState:Lcom/yftech/bsvservice/State;

.field private mQBOffState:Lcom/yftech/bsvservice/State;

.field private mRecordingState:Lcom/yftech/bsvservice/State;

.field private mServiceThread:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const-string v0, "CameraStateMachine"

    .line 70
    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/StateMachine;-><init>(Ljava/lang/String;)V

    .line 64
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOutsideHandler:Landroid/os/Handler;

    .line 65
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mCameraOperations:Ljava/util/ArrayList;

    .line 1194
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$1;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/CameraStateMachine$1;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOperationCallback:Lcom/yftech/bsvservice/CameraOperation$CameraOperationCallback;

    .line 1289
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$2;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/CameraStateMachine$2;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mServiceThread:Landroid/os/Handler;

    .line 71
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mContext:Landroid/content/Context;

    .line 72
    iput-object p2, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mActiveCameraId:Ljava/lang/String;

    .line 73
    invoke-direct {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->initStates()V

    return-void
.end method

.method static synthetic access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mActiveCamera:Lcom/yftech/bsvservice/CameraOperation;

    return-object p0
.end method

.method static synthetic access$1002(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;)Lcom/yftech/bsvservice/CameraOperation;
    .locals 0

    .line 15
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mActiveCamera:Lcom/yftech/bsvservice/CameraOperation;

    return-object p1
.end method

.method static synthetic access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z
    .locals 0

    .line 15
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheOppositeMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$1200(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z
    .locals 0

    .line 15
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$1300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mQBOffState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$1400(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpeningState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$1500(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V
    .locals 0

    .line 15
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->handleSetParamMessage(Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V

    return-void
.end method

.method static synthetic access$1600(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpenedState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$1700(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)V
    .locals 0

    .line 15
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->removeTheSameMessages(ILcom/yftech/bsvservice/CameraOperation;)V

    return-void
.end method

.method static synthetic access$1800(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mClosedState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mClosingState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$2000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mPreviewingState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$2100(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mRecordingState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$2200(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;)Z
    .locals 0

    .line 15
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasPendingStateMessage(Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$2300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mPreviewingAndRecordingState:Lcom/yftech/bsvservice/State;

    return-object p0
.end method

.method static synthetic access$2400(Lcom/yftech/bsvservice/CameraStateMachine;)Z
    .locals 0

    .line 15
    iget-boolean p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mIsRecordingBeforeMediaEjected:Z

    return p0
.end method

.method static synthetic access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z
    .locals 0

    .line 15
    iput-boolean p1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mIsRecordingBeforeMediaEjected:Z

    return p1
.end method

.method static synthetic access$2500(Lcom/yftech/bsvservice/CameraStateMachine;)Landroid/os/Handler;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mServiceThread:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$2600(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mCallback:Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;

    return-object p0
.end method

.method static synthetic access$800(Lcom/yftech/bsvservice/CameraStateMachine;)Ljava/lang/String;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mActiveCameraId:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;
    .locals 0

    .line 15
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    return-object p0
.end method

.method private declared-synchronized getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;
    .locals 3

    monitor-enter p0

    .line 971
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mCameraOperations:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/util/Collections;->singleton(Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->removeAll(Ljava/util/Collection;)Z

    .line 972
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mCameraOperations:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/yftech/bsvservice/CameraOperation;

    if-eqz v1, :cond_0

    .line 973
    invoke-virtual {v1}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    .line 974
    monitor-exit p0

    return-object v1

    .line 977
    :cond_1
    :try_start_1
    new-instance v0, Lcom/yftech/bsvservice/CameraOperation;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1, p1}, Lcom/yftech/bsvservice/CameraOperation;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 978
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOperationCallback:Lcom/yftech/bsvservice/CameraOperation$CameraOperationCallback;

    invoke-virtual {v0, p1}, Lcom/yftech/bsvservice/CameraOperation;->registerCameraOperationCallback(Lcom/yftech/bsvservice/CameraOperation$CameraOperationCallback;)V

    .line 979
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mCameraOperations:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 980
    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception p1

    .line 970
    monitor-exit p0

    throw p1
.end method

.method private handleSetParamMessage(Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V
    .locals 7

    .line 99
    iget v2, p2, Landroid/os/Message;->what:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    packed-switch v2, :pswitch_data_0

    packed-switch v2, :pswitch_data_1

    goto/16 :goto_0

    .line 125
    :pswitch_0
    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->resetSettings()V

    goto/16 :goto_0

    .line 122
    :pswitch_1
    iget v2, p2, Landroid/os/Message;->arg1:I

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x1

    iget v6, p2, Landroid/os/Message;->arg2:I

    move-object v0, p1

    move v1, v2

    move v2, v3

    move v3, v4

    move v4, v5

    move v5, v6

    invoke-virtual/range {v0 .. v5}, Lcom/yftech/bsvservice/CameraOperation;->setWatermarkSize(IZIZI)V

    goto/16 :goto_0

    .line 119
    :pswitch_2
    iget v2, p2, Landroid/os/Message;->arg1:I

    const/4 v3, 0x1

    iget v4, p2, Landroid/os/Message;->arg2:I

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p1

    move v1, v2

    move v2, v3

    move v3, v4

    move v4, v5

    move v5, v6

    invoke-virtual/range {v0 .. v5}, Lcom/yftech/bsvservice/CameraOperation;->setWatermarkSize(IZIZI)V

    goto :goto_0

    .line 116
    :pswitch_3
    iget v2, p2, Landroid/os/Message;->arg1:I

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x1

    iget v6, p2, Landroid/os/Message;->arg2:I

    move-object v0, p1

    move v1, v2

    move v2, v3

    move v3, v4

    move v4, v5

    move v5, v6

    invoke-virtual/range {v0 .. v5}, Lcom/yftech/bsvservice/CameraOperation;->setWatermarkStart(IZIZI)V

    goto :goto_0

    .line 113
    :pswitch_4
    iget v2, p2, Landroid/os/Message;->arg1:I

    const/4 v3, 0x1

    iget v4, p2, Landroid/os/Message;->arg2:I

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p1

    move v1, v2

    move v2, v3

    move v3, v4

    move v4, v5

    move v5, v6

    invoke-virtual/range {v0 .. v5}, Lcom/yftech/bsvservice/CameraOperation;->setWatermarkStart(IZIZI)V

    goto :goto_0

    .line 110
    :pswitch_5
    iget v2, p2, Landroid/os/Message;->arg1:I

    iget v1, p2, Landroid/os/Message;->arg2:I

    if-ne v1, v4, :cond_0

    move v3, v4

    :cond_0
    invoke-virtual {p1, v2, v3}, Lcom/yftech/bsvservice/CameraOperation;->setWatermarkOnOff(IZ)V

    goto :goto_0

    .line 107
    :pswitch_6
    iget v1, p2, Landroid/os/Message;->arg1:I

    if-ne v1, v4, :cond_1

    move v3, v4

    :cond_1
    invoke-virtual {p1, v3}, Lcom/yftech/bsvservice/CameraOperation;->setMicOnOff(Z)V

    goto :goto_0

    .line 104
    :pswitch_7
    iget v1, p2, Landroid/os/Message;->arg1:I

    int-to-long v1, v1

    invoke-virtual {p1, v1, v2}, Lcom/yftech/bsvservice/CameraOperation;->setVideoDuration(J)V

    goto :goto_0

    .line 101
    :pswitch_8
    iget v2, p2, Landroid/os/Message;->arg1:I

    iget v1, p2, Landroid/os/Message;->arg2:I

    invoke-virtual {p1, v2, v1}, Lcom/yftech/bsvservice/CameraOperation;->setResolution(II)V

    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x8
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x16
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private hasPendingStateMessage(Lcom/yftech/bsvservice/CameraOperation;)Z
    .locals 1

    const/4 v0, 0x2

    .line 1015
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, -0x2

    .line 1016
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/16 v0, 0xe

    .line 1017
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/16 v0, 0xc

    .line 1018
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x3

    .line 1019
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, -0x3

    .line 1020
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/16 v0, 0xf

    .line 1021
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/16 v0, 0xd

    .line 1022
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x4

    .line 1023
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, -0x4

    .line 1024
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method private hasTheOppositeMessage(ILcom/yftech/bsvservice/CameraOperation;)Z
    .locals 0

    neg-int p1, p1

    .line 1002
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p0

    return p0
.end method

.method private hasTheSameMessage(ILcom/yftech/bsvservice/CameraOperation;)Z
    .locals 1

    .line 1006
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasMessages(ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1007
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasDeferredMessages(ILjava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method private initStates()V
    .locals 2

    .line 77
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mClosedState:Lcom/yftech/bsvservice/State;

    .line 78
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$OpeningState;

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$OpeningState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpeningState:Lcom/yftech/bsvservice/State;

    .line 79
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpenedState:Lcom/yftech/bsvservice/State;

    .line 80
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$ClosingState;

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$ClosingState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mClosingState:Lcom/yftech/bsvservice/State;

    .line 81
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mQBOffState:Lcom/yftech/bsvservice/State;

    .line 82
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mPreviewingState:Lcom/yftech/bsvservice/State;

    .line 83
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mRecordingState:Lcom/yftech/bsvservice/State;

    .line 84
    new-instance v0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;

    invoke-direct {v0, p0, v1}, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mPreviewingAndRecordingState:Lcom/yftech/bsvservice/State;

    .line 86
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mClosedState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;)V

    .line 87
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpeningState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;)V

    .line 88
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpenedState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;)V

    .line 89
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mClosingState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;)V

    .line 90
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mQBOffState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;)V

    .line 91
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mPreviewingState:Lcom/yftech/bsvservice/State;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpenedState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;Lcom/yftech/bsvservice/State;)V

    .line 92
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mRecordingState:Lcom/yftech/bsvservice/State;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpenedState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;Lcom/yftech/bsvservice/State;)V

    .line 93
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mPreviewingAndRecordingState:Lcom/yftech/bsvservice/State;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mOpenedState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->addState(Lcom/yftech/bsvservice/State;Lcom/yftech/bsvservice/State;)V

    .line 95
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mClosedState:Lcom/yftech/bsvservice/State;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->setInitialState(Lcom/yftech/bsvservice/State;)V

    return-void
.end method

.method private removeTheOppositeMessages(ILcom/yftech/bsvservice/CameraOperation;)V
    .locals 1

    neg-int p1, p1

    .line 993
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasMessages(ILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 994
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->removeMessages(ILjava/lang/Object;)V

    .line 996
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasDeferredMessages(ILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 997
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->removeDeferredMessages(ILjava/lang/Object;)V

    :cond_1
    return-void
.end method

.method private removeTheSameMessages(ILcom/yftech/bsvservice/CameraOperation;)V
    .locals 1

    .line 984
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasMessages(ILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 985
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->removeMessages(ILjava/lang/Object;)V

    .line 987
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasDeferredMessages(ILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 988
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->removeDeferredMessages(ILjava/lang/Object;)V

    :cond_1
    return-void
.end method


# virtual methods
.method public getCurrentResolution(Ljava/lang/String;)Landroid/util/Size;
    .locals 0

    .line 1177
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    .line 1178
    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->getCurrentResolution()Landroid/util/Size;

    move-result-object p0

    return-object p0
.end method

.method public getDuration(Ljava/lang/String;)J
    .locals 0

    .line 1173
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    .line 1174
    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->getDuration()J

    move-result-wide p0

    return-wide p0
.end method

.method public getMicState(Ljava/lang/String;)Z
    .locals 0

    .line 1163
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    .line 1164
    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->getMicState()Z

    move-result p0

    return p0
.end method

.method public getPreviewState(Ljava/lang/String;)Z
    .locals 0

    .line 1148
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    .line 1149
    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->isPreviewing()Z

    move-result p0

    return p0
.end method

.method public getRecordingState(Ljava/lang/String;Z)Z
    .locals 0

    .line 1153
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    .line 1154
    invoke-virtual {p0, p2}, Lcom/yftech/bsvservice/CameraOperation;->isRecording(Z)Z

    move-result p0

    return p0
.end method

.method public getResolutions(Ljava/lang/String;)Ljava/util/List;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Landroid/util/Size;",
            ">;"
        }
    .end annotation

    .line 1158
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    .line 1159
    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->getResolutions()Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method public getWatermarkState(Ljava/lang/String;)Z
    .locals 0

    .line 1168
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    .line 1169
    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->getWatermarkState()Z

    move-result p0

    return p0
.end method

.method public registerCallback(Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;)V
    .locals 0

    .line 1187
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mCallback:Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;

    return-void
.end method

.method resetSettings(Ljava/lang/String;)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1112
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "resetSettings id = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1113
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x1a

    .line 1114
    invoke-virtual {p0, v0, v2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setBrightness(Ljava/lang/String;I)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1130
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setBrightness, value = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1131
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x13

    .line 1132
    invoke-virtual {p0, v0, p2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setContrast(Ljava/lang/String;I)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1142
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setContrast, value = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1143
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x15

    .line 1144
    invoke-virtual {p0, v0, p2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setDuration(Ljava/lang/String;J)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1076
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setDuration id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1077
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    long-to-int p2, p2

    const/16 p3, 0x9

    .line 1078
    invoke-virtual {p0, p3, p2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setHue(Ljava/lang/String;I)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1124
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setHue, value = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1125
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x12

    .line 1126
    invoke-virtual {p0, v0, p2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setMic(Ljava/lang/String;Z)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1082
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setMic id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1083
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0xa

    .line 1084
    invoke-virtual {p0, v0, p2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setResolution(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "CameraStateMachine"

    .line 1070
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setResolution id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1071
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x8

    .line 1072
    invoke-virtual {p0, v0, p2, p3, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setSaturation(Ljava/lang/String;I)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1136
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setSaturation, value = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1137
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x14

    .line 1138
    invoke-virtual {p0, v0, p2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public setWaterMark(Ljava/lang/String;IZ)V
    .locals 3

    const-string v0, "CameraStateMachine"

    .line 1088
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWaterMark id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1089
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0xb

    .line 1090
    invoke-virtual {p0, v0, p2, p3, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method setWatermarkHeight(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "CameraStateMachine"

    const-string v1, "setWatermarkStartHeight"

    const/4 v2, 0x0

    .line 1118
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1119
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x19

    .line 1120
    invoke-virtual {p0, v0, p2, p3, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method setWatermarkStartX(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "CameraStateMachine"

    const-string v1, "setWatermarkStartX"

    const/4 v2, 0x0

    .line 1094
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1095
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x16

    .line 1096
    invoke-virtual {p0, v0, p2, p3, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method setWatermarkStartY(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "CameraStateMachine"

    const-string v1, "setWatermarkStartY"

    const/4 v2, 0x0

    .line 1100
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1101
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x17

    .line 1102
    invoke-virtual {p0, v0, p2, p3, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method setWatermarkWidth(Ljava/lang/String;II)V
    .locals 3

    const-string v0, "CameraStateMachine"

    const-string v1, "setWatermarkStartWidth"

    const/4 v2, 0x0

    .line 1106
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1107
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/16 v0, 0x18

    .line 1108
    invoke-virtual {p0, v0, p2, p3, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public snapshot(Ljava/lang/String;)V
    .locals 3

    const-string v0, "CameraStateMachine"

    .line 1064
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "snapshot id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1065
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/4 v0, 0x5

    .line 1066
    invoke-virtual {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    return-void
.end method

.method public startPreview(Ljava/lang/String;Lcom/yftech/bsvservice/WrappedSurface;)V
    .locals 3

    const-string v0, "CameraStateMachine"

    .line 1031
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "startPreview id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1032
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    .line 1033
    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/CameraOperation;->setPreviewSurface(Lcom/yftech/bsvservice/WrappedSurface;)V

    const/4 p2, 0x2

    .line 1036
    invoke-virtual {p0, p2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    return-void
.end method

.method public startRecord(Ljava/lang/String;Z)V
    .locals 3

    const-string v0, "CameraStateMachine"

    .line 1048
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "startRecord id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " isUrgent:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1049
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/4 v0, 0x3

    .line 1050
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->removeTheOppositeMessages(ILcom/yftech/bsvservice/CameraOperation;)V

    .line 1051
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->removeTheSameMessages(ILcom/yftech/bsvservice/CameraOperation;)V

    if-eqz p2, :cond_0

    const/4 v0, 0x4

    .line 1052
    :cond_0
    invoke-virtual {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    return-void
.end method

.method public stopPreview(Ljava/lang/String;Z)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1040
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stopPreview id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1041
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/4 v0, -0x2

    .line 1044
    invoke-virtual {p0, v0, p2, v2, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(IIILjava/lang/Object;)V

    return-void
.end method

.method public stopRecord(Ljava/lang/String;)V
    .locals 3

    const-string v0, "CameraStateMachine"

    .line 1056
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stopRecord id:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1057
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->getCameraOperation(Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    const/4 v0, -0x3

    .line 1058
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->removeTheOppositeMessages(ILcom/yftech/bsvservice/CameraOperation;)V

    .line 1059
    invoke-direct {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->removeTheSameMessages(ILcom/yftech/bsvservice/CameraOperation;)V

    .line 1060
    invoke-virtual {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    return-void
.end method

.method public unregisterCallback(Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;)V
    .locals 0

    const/4 p1, 0x0

    .line 1191
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine;->mCallback:Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;

    return-void
.end method
