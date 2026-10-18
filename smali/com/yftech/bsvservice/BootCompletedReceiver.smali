.class public Lcom/yftech/bsvservice/BootCompletedReceiver;
.super Landroid/content/BroadcastReceiver;
.source "BootCompletedReceiver.java"


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 10
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    const-string v0, "BootCompletedReceiver"

    .line 11
    iput-object v0, p0, Lcom/yftech/bsvservice/BootCompletedReceiver;->TAG:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4

    .line 14
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    .line 15
    iget-object v0, p0, Lcom/yftech/bsvservice/BootCompletedReceiver;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onReceive action: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v0, "android.intent.action.BOOT_COMPLETED"

    .line 16
    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p1, :cond_2

    .line 18
    new-instance p0, Landroid/content/Intent;

    const-class p2, Lcom/yftech/bsvservice/BsvService;

    invoke-direct {p0, p1, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 19
    invoke-virtual {p1, p0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    :cond_0
    const-string p1, "com.yftech.bsvservice.AVM_SHOW"

    .line 21
    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 22
    iget-object p0, p0, Lcom/yftech/bsvservice/BootCompletedReceiver;->TAG:Ljava/lang/String;

    const-string p1, "receive com.yftech.bsvservice.AVM_SHOW"

    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 23
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->userRequestShowAvm()V

    goto :goto_0

    :cond_1
    const-string p1, "android.intent.action.LOCALE_CHANGED"

    .line 24
    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 25
    iget-object p0, p0, Lcom/yftech/bsvservice/BootCompletedReceiver;->TAG:Ljava/lang/String;

    const-string p1, "android.intent.action.LOCALE_CHANGED"

    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 26
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getWindow()Lcom/yftech/bsvservice/windowutil/BaseWindow;

    move-result-object p0

    if-eqz p0, :cond_2

    .line 27
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getWindow()Lcom/yftech/bsvservice/windowutil/BaseWindow;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateWindow()V

    :cond_2
    :goto_0
    return-void
.end method
