.class Lcom/yftech/bsvservice/BsvServiceImpl$2;
.super Ljava/lang/Object;
.source "BsvServiceImpl.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/yftech/bsvservice/BsvServiceImpl;->initAlertDialog(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/BsvServiceImpl;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/BsvServiceImpl;)V
    .locals 0

    .line 186
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl$2;->this$0:Lcom/yftech/bsvservice/BsvServiceImpl;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 188
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl$2;->this$0:Lcom/yftech/bsvservice/BsvServiceImpl;

    const-string p2, "10"

    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->isNormalRecordStarted(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl$2;->this$0:Lcom/yftech/bsvservice/BsvServiceImpl;

    const-string p2, "10"

    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->isUrgentRecordStarted(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 189
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl$2;->this$0:Lcom/yftech/bsvservice/BsvServiceImpl;

    const-string p2, "10"

    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->stopRecord(Ljava/lang/String;)V

    .line 191
    :cond_1
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl$2;->this$0:Lcom/yftech/bsvservice/BsvServiceImpl;

    const-string p2, "0"

    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->isNormalRecordStarted(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/yftech/bsvservice/BsvServiceImpl$2;->this$0:Lcom/yftech/bsvservice/BsvServiceImpl;

    const-string p2, "0"

    invoke-virtual {p1, p2}, Lcom/yftech/bsvservice/BsvServiceImpl;->isUrgentRecordStarted(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 192
    :cond_2
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvServiceImpl$2;->this$0:Lcom/yftech/bsvservice/BsvServiceImpl;

    const-string p1, "0"

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/BsvServiceImpl;->stopRecord(Ljava/lang/String;)V

    :cond_3
    return-void
.end method
