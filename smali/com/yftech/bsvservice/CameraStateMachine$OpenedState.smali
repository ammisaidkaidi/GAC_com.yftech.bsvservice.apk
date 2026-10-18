.class Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;
.super Lcom/yftech/bsvservice/State;
.source "CameraStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OpenedState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/CameraStateMachine;


# direct methods
.method private constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;)V
    .locals 0

    .line 258
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Lcom/yftech/bsvservice/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V
    .locals 0

    .line 258
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    const-string p0, "CameraStateMachine"

    const-string v0, "enter OpenedState"

    const/4 v1, 0x0

    .line 261
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 6

    const-string v0, "CameraStateMachine"

    .line 266
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

    .line 267
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/yftech/bsvservice/CameraOperation;

    const-string v1, "CameraStateMachine"

    .line 268
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    .line 269
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    const-string v4, "null"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ", mActiveCameraId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    .line 271
    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

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

    .line 268
    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 273
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v1, v3, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    const/4 v3, 0x1

    if-nez v1, :cond_18

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v4, p1, Landroid/os/Message;->what:I

    .line 274
    invoke-static {v1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1200(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    if-eqz v1, :cond_2

    goto/16 :goto_4

    .line 277
    :cond_2
    iget v1, p1, Landroid/os/Message;->what:I

    const/16 v4, 0x11

    if-eq v1, v4, :cond_16

    const/4 v4, 0x3

    const/4 v5, 0x2

    packed-switch v1, :pswitch_data_0

    packed-switch v1, :pswitch_data_1

    packed-switch v1, :pswitch_data_2

    const/16 v4, 0x1b

    packed-switch v1, :pswitch_data_3

    packed-switch v1, :pswitch_data_4

    const-string v0, "CameraStateMachine"

    .line 400
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

    goto/16 :goto_3

    :pswitch_0
    if-eqz v0, :cond_17

    .line 390
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->isNeedRestoreCamera()Z

    move-result p1

    if-eqz p1, :cond_17

    .line 391
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2200(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-eqz p1, :cond_3

    const-string p1, "CameraStateMachine"

    const-string v0, "restore after other message handled"

    .line 392
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 393
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    invoke-virtual {p1, v4, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    goto/16 :goto_3

    .line 395
    :cond_3
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->restoreCamera()V

    goto/16 :goto_3

    :pswitch_1
    if-eqz v0, :cond_4

    .line 357
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 358
    :cond_4
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_3

    .line 354
    :pswitch_2
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2100(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_3

    .line 351
    :pswitch_3
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_3

    .line 387
    :pswitch_4
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1500(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V

    goto/16 :goto_3

    :pswitch_5
    const-string p1, "CameraStateMachine"

    const-string v1, "camera close when opened"

    .line 279
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p1, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 280
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {p1, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    if-eqz v0, :cond_17

    .line 282
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1400(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 283
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->open()V

    goto/16 :goto_3

    .line 320
    :pswitch_6
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_6

    if-eqz v0, :cond_5

    .line 321
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 322
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 323
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 325
    :cond_5
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_3

    :cond_6
    if-eqz v0, :cond_17

    .line 327
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->snapshot()V

    goto/16 :goto_3

    .line 304
    :pswitch_7
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_8

    if-eqz v0, :cond_7

    .line 305
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 306
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 307
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 310
    :cond_7
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_3

    :cond_8
    if-eqz v0, :cond_b

    .line 312
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v1

    if-nez v1, :cond_9

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {v1, v5}, Lcom/yftech/bsvservice/CameraStateMachine;->hasMessages(I)Z

    move-result v1

    if-nez v1, :cond_b

    .line 313
    :cond_9
    iget p0, p1, Landroid/os/Message;->what:I

    if-ne p0, v4, :cond_a

    goto :goto_2

    :cond_a
    move v2, v3

    :goto_2
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->startRecord(Z)V

    goto/16 :goto_3

    .line 315
    :cond_b
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_3

    .line 287
    :pswitch_8
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_d

    if-eqz v0, :cond_c

    .line 288
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 289
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 290
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 292
    :cond_c
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_3

    :cond_d
    if-eqz v0, :cond_f

    .line 294
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v1

    if-nez v1, :cond_e

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {v1, v5}, Lcom/yftech/bsvservice/CameraStateMachine;->hasMessages(I)Z

    move-result v1

    if-nez v1, :cond_f

    .line 295
    :cond_e
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->startPreview()V

    goto/16 :goto_3

    .line 298
    :cond_f
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_3

    .line 331
    :pswitch_9
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-ne v0, v1, :cond_12

    if-eqz v0, :cond_10

    .line 332
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v1

    if-eqz v1, :cond_10

    .line 333
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 334
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_3

    :cond_10
    if-eqz v0, :cond_17

    .line 336
    iget p0, p1, Landroid/os/Message;->arg1:I

    if-ne p0, v3, :cond_11

    move v2, v3

    :cond_11
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->stopPreview(Z)V

    goto/16 :goto_3

    .line 339
    :cond_12
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_3

    .line 344
    :pswitch_a
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-ne v0, v1, :cond_13

    if-eqz v0, :cond_17

    .line 345
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    goto :goto_3

    .line 347
    :cond_13
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto :goto_3

    .line 365
    :pswitch_b
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->isPreviewRequest()Z

    move-result p1

    if-eqz p1, :cond_14

    .line 366
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_14

    .line 367
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 370
    :cond_14
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->isRecordRequest()Z

    move-result p1

    if-eqz p1, :cond_15

    .line 371
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_15

    .line 372
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 375
    :cond_15
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 376
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto :goto_3

    .line 362
    :cond_16
    :pswitch_c
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$OpenedState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    :cond_17
    :goto_3
    return v3

    :cond_18
    :goto_4
    return v3

    nop

    :pswitch_data_0
    .packed-switch -0x11
        :pswitch_c
        :pswitch_b
    .end packed-switch

    :pswitch_data_1
    .packed-switch -0x4
        :pswitch_a
        :pswitch_a
        :pswitch_9
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x2
        :pswitch_8
        :pswitch_7
        :pswitch_7
        :pswitch_6
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x7
        :pswitch_5
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch

    :pswitch_data_4
    .packed-switch 0x16
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_0
    .end packed-switch
.end method
