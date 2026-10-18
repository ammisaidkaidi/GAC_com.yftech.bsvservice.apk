.class Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;
.super Lcom/yftech/bsvservice/State;
.source "CameraStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "RecordingState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/CameraStateMachine;


# direct methods
.method private constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;)V
    .locals 0

    .line 457
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Lcom/yftech/bsvservice/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V
    .locals 0

    .line 457
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    const-string p0, "CameraStateMachine"

    const-string v0, "enter RecordingState"

    const/4 v1, 0x0

    .line 460
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 6

    const-string v0, "CameraStateMachine"

    .line 465
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

    .line 466
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/yftech/bsvservice/CameraOperation;

    const-string v1, "CameraStateMachine"

    .line 467
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    .line 468
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    const-string v4, "null"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ", mActiveCameraId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    .line 470
    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

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

    .line 467
    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 471
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v1, v3, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    const/4 v3, 0x1

    if-nez v1, :cond_13

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v4, p1, Landroid/os/Message;->what:I

    .line 472
    invoke-static {v1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1200(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    if-eqz v1, :cond_2

    goto/16 :goto_3

    .line 475
    :cond_2
    iget v1, p1, Landroid/os/Message;->what:I

    const/4 v4, 0x5

    if-eq v1, v4, :cond_10

    const/16 v4, 0xf

    if-eq v1, v4, :cond_e

    const/16 v4, 0x11

    if-eq v1, v4, :cond_c

    const/4 v4, 0x2

    const/4 v5, 0x3

    packed-switch v1, :pswitch_data_0

    packed-switch v1, :pswitch_data_1

    packed-switch v1, :pswitch_data_2

    const/16 v4, 0x1b

    packed-switch v1, :pswitch_data_3

    packed-switch v1, :pswitch_data_4

    const-string v0, "CameraStateMachine"

    .line 583
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

    goto/16 :goto_2

    :pswitch_0
    if-eqz v0, :cond_12

    .line 573
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->isNeedRestoreCamera()Z

    move-result p1

    if-eqz p1, :cond_12

    .line 574
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2200(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-eqz p1, :cond_3

    const-string p1, "CameraStateMachine"

    const-string v0, "restore after other message handled"

    .line 575
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 576
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    invoke-virtual {p1, v4, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    goto/16 :goto_2

    .line 578
    :cond_3
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->restoreCamera()V

    goto/16 :goto_2

    .line 518
    :pswitch_1
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_2

    .line 570
    :pswitch_2
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1500(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V

    goto/16 :goto_2

    :pswitch_3
    const-string p1, "CameraStateMachine"

    const-string v1, "camera close when recording"

    .line 477
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p1, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 478
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {p1, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    if-eqz v0, :cond_12

    .line 480
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1400(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 481
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->open()V

    goto/16 :goto_2

    .line 501
    :pswitch_4
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_12

    if-eqz v0, :cond_5

    .line 502
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 503
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    .line 504
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    .line 505
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    if-nez v1, :cond_4

    .line 506
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {v2, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(Landroid/os/Message;)V

    .line 508
    :cond_4
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 509
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 511
    :cond_5
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    .line 485
    :pswitch_5
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_8

    if-eqz v0, :cond_7

    .line 486
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 487
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    .line 488
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    .line 489
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    if-nez v1, :cond_6

    .line 490
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {v2, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(Landroid/os/Message;)V

    .line 492
    :cond_6
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 493
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 495
    :cond_7
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    :cond_8
    if-eqz v0, :cond_12

    .line 497
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->startPreview()V

    goto/16 :goto_2

    .line 515
    :pswitch_6
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    .line 521
    :pswitch_7
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_9

    .line 522
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    :cond_9
    if-eqz v0, :cond_12

    .line 524
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    goto/16 :goto_2

    .line 550
    :pswitch_8
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_a

    .line 551
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 553
    :cond_a
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->isPreviewRequest()Z

    move-result p1

    if-eqz p1, :cond_b

    .line 554
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_b

    .line 555
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 558
    :cond_b
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 559
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto :goto_2

    .line 539
    :cond_c
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->isRecordRequest()Z

    move-result p1

    if-eqz p1, :cond_d

    .line 540
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    .line 541
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    goto :goto_2

    .line 543
    :cond_d
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    goto :goto_2

    :cond_e
    if-eqz v0, :cond_f

    .line 528
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 529
    :cond_f
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto :goto_2

    .line 532
    :cond_10
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_11

    .line 533
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$RecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto :goto_2

    :cond_11
    if-eqz v0, :cond_12

    .line 535
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->snapshot()V

    :cond_12
    :goto_2
    :pswitch_9
    return v3

    :cond_13
    :goto_3
    return v3

    :pswitch_data_0
    .packed-switch -0x11
        :pswitch_9
        :pswitch_8
    .end packed-switch

    :pswitch_data_1
    .packed-switch -0x3
        :pswitch_7
        :pswitch_6
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x2
        :pswitch_5
        :pswitch_4
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x7
        :pswitch_3
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_1
    .end packed-switch

    :pswitch_data_4
    .packed-switch 0x16
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_0
    .end packed-switch
.end method
