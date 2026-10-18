.class Lcom/yftech/bsvservice/BsvService$3;
.super Landroid/app/IUserSwitchObserver$Stub;
.source "BsvService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/BsvService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/BsvService;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/BsvService;)V
    .locals 0

    .line 196
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-direct {p0}, Landroid/app/IUserSwitchObserver$Stub;-><init>()V

    return-void
.end method


# virtual methods
.method public onForegroundProfileSwitch(I)V
    .locals 0

    return-void
.end method

.method public onLockedBootComplete(I)V
    .locals 0

    return-void
.end method

.method public onUserSwitchComplete(I)V
    .locals 4

    const-string v0, "BsvService"

    .line 205
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onUserSwitchComplete newUserId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 206
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {v0, p1}, Lcom/yftech/bsvservice/BsvService;->access$702(Lcom/yftech/bsvservice/BsvService;I)I

    const-string p1, "BsvService"

    .line 208
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onUserSwitchComplete mIsBackcarOn = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {v1}, Lcom/yftech/bsvservice/BsvService;->access$400(Lcom/yftech/bsvservice/BsvService;)Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 209
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$800(Lcom/yftech/bsvservice/BsvService;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$700(Lcom/yftech/bsvservice/BsvService;)I

    move-result p1

    invoke-static {}, Landroid/os/UserHandle;->myUserId()I

    move-result v0

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    .line 210
    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$400(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "BsvService"

    const-string v0, "stopBackcar because user switch"

    .line 211
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 212
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$900(Lcom/yftech/bsvservice/BsvService;)Landroid/os/Handler;

    move-result-object p1

    new-instance v0, Lcom/yftech/bsvservice/BsvService$3$1;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$3$1;-><init>(Lcom/yftech/bsvservice/BsvService$3;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 219
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$700(Lcom/yftech/bsvservice/BsvService;)I

    move-result p1

    invoke-static {}, Landroid/os/UserHandle;->myUserId()I

    move-result v0

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$800(Lcom/yftech/bsvservice/BsvService;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$400(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-string p1, "BsvService"

    const-string v0, "startBackcar after user switch"

    .line 220
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 221
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$900(Lcom/yftech/bsvservice/BsvService;)Landroid/os/Handler;

    move-result-object p1

    new-instance v0, Lcom/yftech/bsvservice/BsvService$3$2;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$3$2;-><init>(Lcom/yftech/bsvservice/BsvService$3;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_1
    return-void
.end method

.method public onUserSwitching(ILandroid/os/IRemoteCallback;)V
    .locals 2

    const-string p2, "BsvService"

    .line 199
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onUserSwitching  newUserId = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p2, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 200
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, p1}, Lcom/yftech/bsvservice/BsvService;->access$702(Lcom/yftech/bsvservice/BsvService;I)I

    return-void
.end method
