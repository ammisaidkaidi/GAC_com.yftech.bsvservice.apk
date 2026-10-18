.class Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;
.super Lcom/yftech/bsvservice/State;
.source "CameraStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "QBOffState"
.end annotation


# instance fields
.field mIsCameraClosed:Z

.field mIsQbOn:Z

.field final synthetic this$0:Lcom/yftech/bsvservice/CameraStateMachine;


# direct methods
.method private constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;)V
    .locals 0

    .line 908
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Lcom/yftech/bsvservice/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V
    .locals 0

    .line 908
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    const-string p0, "CameraStateMachine"

    const-string v0, "enter QBOffState"

    const/4 v1, 0x0

    .line 913
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 6

    const-string v0, "CameraStateMachine"

    .line 918
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " processMessage "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 919
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/yftech/bsvservice/CameraOperation;

    const-string v1, "CameraStateMachine"

    .line 920
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    .line 921
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    const-string v4, "null"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ", mActiveCameraId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    .line 923
    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    invoke-virtual {v4}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_1
    const-string v4, "null"

    :goto_1
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v4, v2, [Ljava/lang/Object;

    .line 920
    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 924
    iget v1, p1, Landroid/os/Message;->what:I

    const/4 v3, -0x2

    const/4 v4, 0x2

    const/4 v5, 0x1

    if-eq v1, v3, :cond_5

    const/4 v3, 0x7

    if-eq v1, v3, :cond_3

    packed-switch v1, :pswitch_data_0

    packed-switch v1, :pswitch_data_1

    .line 963
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto :goto_2

    .line 945
    :pswitch_0
    iget-boolean p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsCameraClosed:Z

    if-eqz p1, :cond_2

    .line 946
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1800(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 947
    iput-boolean v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsQbOn:Z

    .line 948
    iput-boolean v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsCameraClosed:Z

    goto :goto_2

    .line 950
    :cond_2
    iput-boolean v5, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsQbOn:Z

    goto :goto_2

    .line 960
    :pswitch_1
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/4 p1, 0x3

    invoke-virtual {p0, p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    goto :goto_2

    .line 957
    :pswitch_2
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    goto :goto_2

    .line 954
    :pswitch_3
    iput-boolean v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsQbOn:Z

    goto :goto_2

    .line 926
    :cond_3
    iget-boolean p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsQbOn:Z

    if-eqz p1, :cond_4

    .line 927
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1800(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 928
    iput-boolean v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsCameraClosed:Z

    .line 929
    iput-boolean v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsQbOn:Z

    goto :goto_2

    .line 931
    :cond_4
    iput-boolean v5, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsCameraClosed:Z

    goto :goto_2

    :cond_5
    if-eqz v0, :cond_6

    .line 939
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->hasPendingPreviewSurface()Z

    move-result p1

    if-nez p1, :cond_6

    .line 940
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1700(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)V

    :cond_6
    if-eqz v0, :cond_7

    .line 942
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopPreviewWhileQbOff()V

    :cond_7
    :goto_2
    :pswitch_4
    return v5

    nop

    :pswitch_data_0
    .packed-switch -0x11
        :pswitch_4
        :pswitch_3
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0xc
        :pswitch_2
        :pswitch_1
        :pswitch_4
        :pswitch_4
        :pswitch_0
        :pswitch_4
    .end packed-switch
.end method
