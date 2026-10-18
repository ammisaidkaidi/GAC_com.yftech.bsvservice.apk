.class Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;
.super Lcom/yftech/bsvservice/State;
.source "CameraStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ClosedState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/CameraStateMachine;


# direct methods
.method private constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;)V
    .locals 0

    .line 130
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Lcom/yftech/bsvservice/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V
    .locals 0

    .line 130
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 3

    const-string v0, "CameraStateMachine"

    const-string v1, "enter ClosedState"

    const/4 v2, 0x0

    .line 133
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$800(Lcom/yftech/bsvservice/CameraStateMachine;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 5

    const-string v0, "CameraStateMachine"

    .line 139
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

    .line 140
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/yftech/bsvservice/CameraOperation;

    const-string v1, "CameraStateMachine"

    .line 141
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    .line 142
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    const-string v4, "null"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ", mActiveCameraId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    .line 144
    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

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

    .line 141
    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 146
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v1, v3, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    const/4 v3, 0x1

    if-nez v1, :cond_8

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v4, p1, Landroid/os/Message;->what:I

    .line 147
    invoke-static {v1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1200(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    if-eqz v1, :cond_2

    goto/16 :goto_3

    .line 150
    :cond_2
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/16 v4, -0x10

    invoke-virtual {v1, v4}, Lcom/yftech/bsvservice/CameraStateMachine;->hasMessages(I)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 151
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 152
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v0

    check-cast v0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;

    iput-boolean v3, v0, Lcom/yftech/bsvservice/CameraStateMachine$QBOffState;->mIsCameraClosed:Z

    .line 153
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    return v3

    .line 156
    :cond_3
    iget v1, p1, Landroid/os/Message;->what:I

    const/4 v4, 0x5

    if-eq v1, v4, :cond_4

    packed-switch v1, :pswitch_data_0

    packed-switch v1, :pswitch_data_1

    packed-switch v1, :pswitch_data_2

    packed-switch v1, :pswitch_data_3

    const-string v0, "CameraStateMachine"

    .line 185
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "illegal mesage "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p1, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, " appear in "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array p1, v2, [Ljava/lang/Object;

    invoke-static {v0, p0, p1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    .line 182
    :pswitch_0
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1500(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V

    goto :goto_2

    .line 160
    :cond_4
    :pswitch_1
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-ne v0, v1, :cond_7

    :cond_5
    if-eqz v0, :cond_7

    .line 161
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v1

    if-nez v1, :cond_6

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->hasMessages(I)Z

    move-result v1

    if-nez v1, :cond_7

    .line 162
    :cond_6
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1400(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 163
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1002(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;)Lcom/yftech/bsvservice/CameraOperation;

    .line 164
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->open()V

    .line 167
    :cond_7
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$ClosedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    :goto_2
    :pswitch_2
    return v3

    :cond_8
    :goto_3
    return v3

    :pswitch_data_0
    .packed-switch -0x3
        :pswitch_2
        :pswitch_2
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x2
        :pswitch_1
        :pswitch_1
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x8
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x16
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method
