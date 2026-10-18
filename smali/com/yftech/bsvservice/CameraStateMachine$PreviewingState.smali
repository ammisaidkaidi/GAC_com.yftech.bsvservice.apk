.class Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;
.super Lcom/yftech/bsvservice/State;
.source "CameraStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "PreviewingState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/CameraStateMachine;


# direct methods
.method private constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;)V
    .locals 0

    .line 590
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Lcom/yftech/bsvservice/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V
    .locals 0

    .line 590
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    const-string p0, "CameraStateMachine"

    const-string v0, "enter PreviewingState"

    const/4 v1, 0x0

    .line 593
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 6

    const-string v0, "CameraStateMachine"

    .line 598
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

    .line 599
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/yftech/bsvservice/CameraOperation;

    const-string v1, "CameraStateMachine"

    .line 600
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    .line 601
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    const-string v4, "null"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ", mActiveCameraId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    .line 603
    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

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

    .line 600
    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 604
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v1, v3, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    const/4 v3, 0x1

    if-eqz v1, :cond_3

    .line 605
    iget v1, p1, Landroid/os/Message;->what:I

    const/4 v4, -0x2

    if-ne v1, v4, :cond_2

    iget v1, p1, Landroid/os/Message;->arg1:I

    if-nez v1, :cond_2

    const-string v1, "CameraStateMachine"

    const-string v4, "stop preview before start backcar"

    .line 606
    new-array v5, v2, [Ljava/lang/Object;

    invoke-static {v1, v4, v5}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    :cond_2
    return v3

    .line 610
    :cond_3
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v4, p1, Landroid/os/Message;->what:I

    invoke-static {v1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1200(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    if-eqz v1, :cond_4

    return v3

    .line 613
    :cond_4
    :goto_2
    iget v1, p1, Landroid/os/Message;->what:I

    const/4 v4, 0x2

    const/4 v5, 0x3

    packed-switch v1, :pswitch_data_0

    packed-switch v1, :pswitch_data_1

    packed-switch v1, :pswitch_data_2

    const/16 v4, 0x1b

    packed-switch v1, :pswitch_data_3

    packed-switch v1, :pswitch_data_4

    packed-switch v1, :pswitch_data_5

    const-string v0, "CameraStateMachine"

    .line 744
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

    goto/16 :goto_4

    :pswitch_0
    if-eqz v0, :cond_18

    .line 734
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->isNeedRestoreCamera()Z

    move-result p1

    if-eqz p1, :cond_18

    .line 735
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2200(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-eqz p1, :cond_5

    const-string p1, "CameraStateMachine"

    const-string v0, "restore after other message handled"

    .line 736
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 737
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    invoke-virtual {p1, v4, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    goto/16 :goto_4

    .line 739
    :cond_5
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->restoreCamera()V

    goto/16 :goto_4

    :pswitch_1
    if-eqz v0, :cond_18

    .line 731
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setContrast(I)V

    goto/16 :goto_4

    :pswitch_2
    if-eqz v0, :cond_18

    .line 728
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setSaturation(I)V

    goto/16 :goto_4

    :pswitch_3
    if-eqz v0, :cond_18

    .line 725
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setBrightness(I)V

    goto/16 :goto_4

    :pswitch_4
    if-eqz v0, :cond_18

    .line 722
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setHue(I)V

    goto/16 :goto_4

    .line 685
    :pswitch_5
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->isRecordRequest()Z

    move-result p1

    if-eqz p1, :cond_6

    .line 686
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    goto/16 :goto_4

    .line 688
    :cond_6
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    goto/16 :goto_4

    :pswitch_6
    if-eqz v0, :cond_7

    .line 671
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 672
    :cond_7
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_4

    .line 661
    :pswitch_7
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_4

    .line 719
    :pswitch_8
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1500(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V

    goto/16 :goto_4

    :pswitch_9
    const-string p1, "CameraStateMachine"

    const-string v1, "camera close when previewing"

    .line 615
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p1, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 616
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {p1, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    if-eqz v0, :cond_18

    .line 618
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1400(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 619
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->open()V

    goto/16 :goto_4

    .line 678
    :pswitch_a
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_8

    .line 679
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_4

    :cond_8
    if-eqz v0, :cond_18

    .line 681
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->snapshot()V

    goto/16 :goto_4

    .line 644
    :pswitch_b
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_c

    if-eqz v0, :cond_b

    .line 645
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_b

    .line 646
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->arg1:I

    if-ne v1, v3, :cond_9

    move v2, v3

    :cond_9
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->stopPreview(Z)V

    .line 647
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v1, p1, Landroid/os/Message;->what:I

    iget-object v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_a

    .line 648
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v2, p1, Landroid/os/Message;->what:I

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    invoke-virtual {v1, v2, v4}, Lcom/yftech/bsvservice/CameraStateMachine;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(Landroid/os/Message;)V

    .line 650
    :cond_a
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 651
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 652
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_4

    .line 654
    :cond_b
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_4

    :cond_c
    if-eqz v0, :cond_18

    .line 657
    iget p0, p1, Landroid/os/Message;->what:I

    if-ne p0, v5, :cond_d

    goto :goto_3

    :cond_d
    move v2, v3

    :goto_3
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->startRecord(Z)V

    goto/16 :goto_4

    .line 623
    :pswitch_c
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_12

    if-eqz v0, :cond_11

    .line 624
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_11

    .line 625
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->arg1:I

    if-ne v1, v3, :cond_e

    move v2, v3

    :cond_e
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->stopPreview(Z)V

    .line 626
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-static {v0, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_f

    .line 627
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {v0, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 629
    :cond_f
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->isRecordRequest()Z

    move-result v0

    if-eqz v0, :cond_10

    .line 630
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-static {v0, v5, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_10

    .line 631
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {v0, v5, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 634
    :cond_10
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 635
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 637
    :cond_11
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_4

    :cond_12
    if-eqz v0, :cond_18

    .line 639
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->startPreview()V

    goto/16 :goto_4

    .line 664
    :pswitch_d
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_13

    .line 665
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_4

    :cond_13
    if-eqz v0, :cond_18

    .line 667
    iget p0, p1, Landroid/os/Message;->arg1:I

    if-ne p0, v3, :cond_14

    move v2, v3

    :cond_14
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->stopPreview(Z)V

    goto :goto_4

    .line 675
    :pswitch_e
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto :goto_4

    .line 699
    :pswitch_f
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_15

    .line 700
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 702
    :cond_15
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->isRecordRequest()Z

    move-result p1

    if-eqz p1, :cond_16

    .line 703
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_16

    .line 704
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 707
    :cond_16
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 708
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto :goto_4

    .line 692
    :pswitch_10
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2400(Lcom/yftech/bsvservice/CameraStateMachine;)Z

    move-result p1

    if-eqz p1, :cond_17

    .line 693
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1, v2}, Lcom/yftech/bsvservice/CameraOperation;->startRecord(Z)V

    .line 695
    :cond_17
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    :cond_18
    :goto_4
    return v3

    nop

    :pswitch_data_0
    .packed-switch -0x11
        :pswitch_10
        :pswitch_f
    .end packed-switch

    :pswitch_data_1
    .packed-switch -0x3
        :pswitch_e
        :pswitch_d
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x2
        :pswitch_c
        :pswitch_b
        :pswitch_b
        :pswitch_a
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x7
        :pswitch_9
        :pswitch_8
        :pswitch_8
        :pswitch_8
        :pswitch_8
    .end packed-switch

    :pswitch_data_4
    .packed-switch 0xd
        :pswitch_7
        :pswitch_6
    .end packed-switch

    :pswitch_data_5
    .packed-switch 0x11
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_8
        :pswitch_8
        :pswitch_8
        :pswitch_8
        :pswitch_8
        :pswitch_0
    .end packed-switch
.end method
