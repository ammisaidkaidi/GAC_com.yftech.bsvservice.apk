.class Lcom/yftech/bsvservice/BsvService$6;
.super Landroid/content/BroadcastReceiver;
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

    .line 507
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvService$6;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4

    .line 510
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    .line 512
    invoke-virtual {p2}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    if-eqz p2, :cond_0

    .line 514
    invoke-virtual {p2}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    :goto_0
    const-string v0, "BsvService"

    .line 516
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mMountUnmountBroadcastReceiver - onReceive:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " mountPoint:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-nez p2, :cond_1

    return-void

    .line 520
    :cond_1
    sget-object v0, Lcom/yftech/bsvservice/util/StorageUtil;->sCurrentPath:Ljava/lang/String;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/yftech/bsvservice/util/StorageUtil;->sCurrentPath:Ljava/lang/String;

    invoke-static {v0}, Lcom/yftech/bsvservice/util/StorageUtil;->toPublicPath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_3

    const-string p2, "android.intent.action.MEDIA_MOUNTED"

    .line 521
    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_2

    .line 522
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$6;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object p0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->sendMediaMountedAndEjectedMessage(Z)V

    goto :goto_1

    :cond_2
    const-string p2, "android.intent.action.MEDIA_EJECT"

    .line 523
    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 524
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$6;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object p0

    invoke-virtual {p0, v2}, Lcom/yftech/bsvservice/BsvServiceImpl;->sendMediaMountedAndEjectedMessage(Z)V

    :cond_3
    :goto_1
    return-void
.end method
