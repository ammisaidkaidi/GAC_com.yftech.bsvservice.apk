.class Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;
.super Lcom/yftech/bsvservice/State;
.source "CameraStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "PreviewingAndRecordingState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/CameraStateMachine;


# direct methods
.method private constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;)V
    .locals 0

    .line 752
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Lcom/yftech/bsvservice/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraStateMachine$1;)V
    .locals 0

    .line 752
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;-><init>(Lcom/yftech/bsvservice/CameraStateMachine;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    const-string p0, "CameraStateMachine"

    const-string v0, "enter PreviewingAndRecordingState"

    const/4 v1, 0x0

    .line 755
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 6

    const-string v0, "CameraStateMachine"

    .line 760
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

    .line 761
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/yftech/bsvservice/CameraOperation;

    const-string v1, "CameraStateMachine"

    .line 762
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "camera id is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    .line 763
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getCameraId()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_0
    const-string v4, "null"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ", mActiveCameraId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    .line 765
    invoke-static {v4}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

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

    .line 762
    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 767
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v1, v3, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    const/4 v3, 0x1

    if-nez v1, :cond_15

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget v4, p1, Landroid/os/Message;->what:I

    .line 768
    invoke-static {v1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1200(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v1

    if-eqz v1, :cond_2

    goto/16 :goto_3

    .line 772
    :cond_2
    iget v1, p1, Landroid/os/Message;->what:I

    const/4 v4, 0x3

    const/4 v5, 0x2

    packed-switch v1, :pswitch_data_0

    packed-switch v1, :pswitch_data_1

    packed-switch v1, :pswitch_data_2

    packed-switch v1, :pswitch_data_3

    packed-switch v1, :pswitch_data_4

    packed-switch v1, :pswitch_data_5

    const-string v0, "CameraStateMachine"

    .line 900
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
    const-string p0, "CameraStateMachine"

    const-string p1, "don\'t need to restore"

    .line 897
    new-array v0, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_2

    :pswitch_1
    if-eqz v0, :cond_14

    .line 894
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setContrast(I)V

    goto/16 :goto_2

    :pswitch_2
    if-eqz v0, :cond_14

    .line 891
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setSaturation(I)V

    goto/16 :goto_2

    :pswitch_3
    if-eqz v0, :cond_14

    .line 888
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setBrightness(I)V

    goto/16 :goto_2

    :pswitch_4
    if-eqz v0, :cond_14

    .line 885
    iget p0, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/CameraOperation;->setHue(I)V

    goto/16 :goto_2

    .line 851
    :pswitch_5
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->isRecordRequest()Z

    move-result p1

    if-eqz p1, :cond_3

    .line 852
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    .line 853
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    goto/16 :goto_2

    .line 855
    :cond_3
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    goto/16 :goto_2

    .line 841
    :pswitch_6
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_2

    .line 830
    :pswitch_7
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2100(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto/16 :goto_2

    .line 882
    :pswitch_8
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1500(Lcom/yftech/bsvservice/CameraStateMachine;Lcom/yftech/bsvservice/CameraOperation;Landroid/os/Message;)V

    goto/16 :goto_2

    :pswitch_9
    const-string p1, "CameraStateMachine"

    const-string v1, "camera close when previewing recording"

    .line 774
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p1, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 775
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/16 v1, 0x1b

    iget-object v2, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    if-eqz v0, :cond_14

    .line 777
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1400(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 778
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->open()V

    goto/16 :goto_2

    .line 844
    :pswitch_a
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_4

    .line 845
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    :cond_4
    if-eqz v0, :cond_14

    .line 847
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->snapshot()V

    goto/16 :goto_2

    .line 804
    :pswitch_b
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_9

    if-eqz v0, :cond_8

    .line 805
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 806
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->arg1:I

    if-ne v1, v3, :cond_5

    move v2, v3

    :cond_5
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->stopPreview(Z)V

    .line 807
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-static {v0, v5, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 808
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {v0, v5, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 810
    :cond_6
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    .line 811
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-static {v0, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_7

    .line 812
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {v0, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 814
    :cond_7
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 815
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 817
    :cond_8
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    :cond_9
    if-eqz v0, :cond_14

    .line 819
    invoke-virtual {v0, v3}, Lcom/yftech/bsvservice/CameraOperation;->startRecord(Z)V

    goto/16 :goto_2

    .line 782
    :pswitch_c
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-ne v0, v1, :cond_a

    if-eqz v0, :cond_14

    .line 783
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->startPreview()V

    goto/16 :goto_2

    .line 787
    :cond_a
    :pswitch_d
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_14

    if-eqz v0, :cond_e

    .line 788
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->getBackcarState()Z

    move-result v0

    if-eqz v0, :cond_e

    .line 789
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->arg1:I

    if-ne v1, v3, :cond_b

    move v2, v3

    :cond_b
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->stopPreview(Z)V

    .line 790
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-static {v0, v5, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_c

    .line 791
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {v0, v5, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 793
    :cond_c
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    .line 794
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-static {v0, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-nez v0, :cond_d

    .line 795
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    invoke-virtual {v0, v4, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 797
    :cond_d
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 798
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1900(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    .line 800
    :cond_e
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    .line 823
    :pswitch_e
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_f

    .line 824
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto/16 :goto_2

    :cond_f
    if-eqz v0, :cond_14

    .line 826
    iget p0, p1, Landroid/os/Message;->arg1:I

    if-ne p0, v3, :cond_10

    move v2, v3

    :cond_10
    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->stopPreview(Z)V

    goto :goto_2

    .line 833
    :pswitch_f
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v1

    if-eq v0, v1, :cond_11

    .line 834
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->deferMessage(Landroid/os/Message;)V

    goto :goto_2

    .line 836
    :cond_11
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/16 p1, 0xd

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraStateMachine;->removeMessages(I)V

    if-eqz v0, :cond_14

    .line 837
    invoke-virtual {v0}, Lcom/yftech/bsvservice/CameraOperation;->stopRecord()V

    goto :goto_2

    .line 863
    :pswitch_10
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_12

    .line 864
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v5, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 867
    :cond_12
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-static {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1100(Lcom/yftech/bsvservice/CameraStateMachine;ILcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-nez p1, :cond_13

    .line 868
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v0

    invoke-virtual {p1, v4, v0}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    .line 870
    :cond_13
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1000(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 871
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$1300(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/State;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/CameraStateMachine;->transitionTo(Lcom/yftech/bsvservice/IState;)V

    goto :goto_2

    .line 859
    :pswitch_11
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$PreviewingAndRecordingState;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2402(Lcom/yftech/bsvservice/CameraStateMachine;Z)Z

    :cond_14
    :goto_2
    return v3

    :cond_15
    :goto_3
    return v3

    nop

    :pswitch_data_0
    .packed-switch -0x11
        :pswitch_11
        :pswitch_10
    .end packed-switch

    :pswitch_data_1
    .packed-switch -0x3
        :pswitch_f
        :pswitch_e
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x2
        :pswitch_c
        :pswitch_d
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
    .packed-switch 0xe
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
