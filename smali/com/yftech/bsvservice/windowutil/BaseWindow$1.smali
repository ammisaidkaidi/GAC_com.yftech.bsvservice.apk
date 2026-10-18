.class Lcom/yftech/bsvservice/windowutil/BaseWindow$1;
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

    .line 102
    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 105
    invoke-static {}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$000()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "update window Visibility  runnable,isUpdateVisibility:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v2}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$100(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 106
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-virtual {v0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isShow()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$100(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 107
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setWindowVisibility(Z)Z

    .line 108
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-static {v0, v1}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->access$102(Lcom/yftech/bsvservice/windowutil/BaseWindow;Z)Z

    .line 110
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;->this$0:Lcom/yftech/bsvservice/windowutil/BaseWindow;

    invoke-virtual {p0, v2}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setCameraState(I)Z

    :cond_0
    return-void
.end method
