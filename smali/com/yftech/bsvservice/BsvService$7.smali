.class Lcom/yftech/bsvservice/BsvService$7;
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

    .line 545
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3

    .line 548
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    const-string p2, "BsvService"

    .line 549
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mQBReceiver - onReceive:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p2, v0, v2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string p2, "autochips.intent.action.PREQB_POWERON"

    .line 550
    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    .line 551
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object p1

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->sendQBMessage(Z)V

    .line 552
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1, p2}, Lcom/yftech/bsvservice/BsvService;->access$202(Lcom/yftech/bsvservice/BsvService;Z)Z

    .line 553
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$300(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-eqz p1, :cond_4

    .line 554
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object p1

    const-string p2, "0"

    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->startBackcar(Ljava/lang/String;)V

    .line 555
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, v1}, Lcom/yftech/bsvservice/BsvService;->access$302(Lcom/yftech/bsvservice/BsvService;Z)Z

    goto :goto_0

    :cond_0
    const-string p2, "autochips.intent.action.QB_POWEROFF"

    .line 557
    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_2

    .line 558
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$000(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$1200(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 559
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$1300(Lcom/yftech/bsvservice/BsvService;)Lcom/autochips/backcar/BackCar;

    move-result-object p1

    invoke-virtual {p1}, Lcom/autochips/backcar/BackCar;->sendForceExitToArm2()Z

    .line 561
    :cond_1
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object p1

    invoke-virtual {p1, v1}, Lcom/yftech/bsvservice/BsvServiceImpl;->sendQBMessage(Z)V

    .line 562
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, v1}, Lcom/yftech/bsvservice/BsvService;->access$202(Lcom/yftech/bsvservice/BsvService;Z)Z

    goto :goto_0

    :cond_2
    const-string p2, "android.intent.action.ACTION_SHUTDOWN"

    .line 563
    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    .line 564
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$000(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$1200(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 565
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$1300(Lcom/yftech/bsvservice/BsvService;)Lcom/autochips/backcar/BackCar;

    move-result-object p1

    invoke-virtual {p1}, Lcom/autochips/backcar/BackCar;->sendForceExitToArm2()Z

    .line 567
    :cond_3
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$7;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object p0

    invoke-virtual {p0, v1}, Lcom/yftech/bsvservice/BsvServiceImpl;->sendQBMessage(Z)V

    :cond_4
    :goto_0
    return-void
.end method
