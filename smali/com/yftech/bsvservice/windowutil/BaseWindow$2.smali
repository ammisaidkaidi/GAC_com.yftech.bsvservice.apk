.class Lcom/yftech/bsvservice/windowutil/BaseWindow$2;
.super Ljava/lang/Object;
.source "BaseWindow.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/windowutil/BaseWindow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/windowutil/BaseWindow;)V
    .locals 0

    .line 115
    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 118
    invoke-static {}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$000()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "exitAvmFirstShow ,isFirstOpenAvmCamera:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v2}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$200(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 119
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$200(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 121
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v0, v2}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$202(Lcom/yftech/bsvservice/windowutil/BaseWindow;Z)Z

    .line 122
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    iget-object v0, v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->isAvmDisplay()Z

    move-result v0

    if-nez v0, :cond_1

    .line 123
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$300(Lcom/yftech/bsvservice/windowutil/BaseWindow;)I

    move-result v0

    if-nez v0, :cond_0

    .line 124
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraReqHide()V

    .line 126
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->hideWindow()V

    goto :goto_0

    .line 128
    :cond_1
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setWindowVisibility(Z)Z

    .line 129
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v0, v1}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$102(Lcom/yftech/bsvservice/windowutil/BaseWindow;Z)Z

    .line 131
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$400(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Landroid/os/Handler;

    move-result-object v0

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_2
    :goto_0
    return-void
.end method
