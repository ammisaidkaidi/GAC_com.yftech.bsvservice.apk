.class Lcom/yftech/bsvservice/CameraStateMachine$1;
.super Ljava/lang/Object;
.source "CameraStateMachine.java"

# interfaces
.implements Lcom/yftech/bsvservice/CameraOperation$CameraOperationCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/CameraStateMachine;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/CameraStateMachine;)V
    .locals 0

    .line 1194
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onOperationFailed(ILjava/lang/String;I)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1245
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onOperationFailed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", id = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 1254
    :pswitch_0
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/16 v1, 0xe

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    goto :goto_0

    .line 1248
    :pswitch_1
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/4 v1, 0x7

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    .line 1285
    :goto_0
    :pswitch_2
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2500(Lcom/yftech/bsvservice/CameraStateMachine;)Landroid/os/Handler;

    move-result-object v0

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2500(Lcom/yftech/bsvservice/CameraStateMachine;)Landroid/os/Handler;

    move-result-object p0

    invoke-static {p0, p1, p3, v2, p2}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method public onOperationSuccess(ILjava/lang/String;)V
    .locals 4

    const-string v0, "CameraStateMachine"

    .line 1197
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onOperationSuccess: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", id = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 v0, 0xf

    const/16 v1, 0xd

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 1221
    :pswitch_0
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    goto :goto_0

    .line 1218
    :pswitch_1
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    goto :goto_0

    .line 1215
    :pswitch_2
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/16 v1, 0xe

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    goto :goto_0

    .line 1212
    :pswitch_3
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    goto :goto_0

    .line 1209
    :pswitch_4
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessage(ILjava/lang/Object;)V

    goto :goto_0

    .line 1206
    :pswitch_5
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/16 v1, 0xc

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    goto :goto_0

    .line 1203
    :pswitch_6
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/4 v1, 0x7

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    goto :goto_0

    .line 1200
    :pswitch_7
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    const/4 v1, 0x6

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v3, p2}, Lcom/yftech/bsvservice/CameraStateMachine;->access$900(Lcom/yftech/bsvservice/CameraStateMachine;Ljava/lang/String;)Lcom/yftech/bsvservice/CameraOperation;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/CameraStateMachine;->sendMessageAtFrontOfQueue(ILjava/lang/Object;)V

    .line 1240
    :goto_0
    :pswitch_8
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2500(Lcom/yftech/bsvservice/CameraStateMachine;)Landroid/os/Handler;

    move-result-object v0

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$1;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2500(Lcom/yftech/bsvservice/CameraStateMachine;)Landroid/os/Handler;

    move-result-object p0

    invoke-static {p0, p1, v2, v2, p2}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_8
        :pswitch_8
        :pswitch_8
        :pswitch_8
        :pswitch_8
    .end packed-switch
.end method
