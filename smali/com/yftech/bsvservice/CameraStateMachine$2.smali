.class Lcom/yftech/bsvservice/CameraStateMachine$2;
.super Landroid/os/Handler;
.source "CameraStateMachine.java"


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

    .line 1289
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraStateMachine$2;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    .line 1292
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 1293
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    .line 1294
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraStateMachine$2;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2600(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 1295
    iget v1, p1, Landroid/os/Message;->arg1:I

    if-eqz v1, :cond_0

    .line 1296
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$2;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2600(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;

    move-result-object p0

    iget v1, p1, Landroid/os/Message;->what:I

    iget p1, p1, Landroid/os/Message;->arg1:I

    invoke-interface {p0, v0, v1, p1}, Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;->onOperationFail(Ljava/lang/String;II)V

    goto :goto_0

    .line 1298
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraStateMachine$2;->this$0:Lcom/yftech/bsvservice/CameraStateMachine;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraStateMachine;->access$2600(Lcom/yftech/bsvservice/CameraStateMachine;)Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;

    move-result-object p0

    iget p1, p1, Landroid/os/Message;->what:I

    invoke-interface {p0, v0, p1}, Lcom/yftech/bsvservice/CameraStateMachine$StateMachineCallback;->onOperationSuccess(Ljava/lang/String;I)V

    :cond_1
    :goto_0
    return-void
.end method
