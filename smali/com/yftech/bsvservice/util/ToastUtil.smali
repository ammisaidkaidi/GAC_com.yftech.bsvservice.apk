.class public Lcom/yftech/bsvservice/util/ToastUtil;
.super Ljava/lang/Object;
.source "ToastUtil.java"


# static fields
.field private static mToast:Landroid/widget/Toast;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static showToast(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    if-eqz p0, :cond_2

    if-nez p1, :cond_0

    goto :goto_0

    .line 15
    :cond_0
    sget-object v0, Lcom/yftech/bsvservice/util/ToastUtil;->mToast:Landroid/widget/Toast;

    if-eqz v0, :cond_1

    .line 16
    sget-object v0, Lcom/yftech/bsvservice/util/ToastUtil;->mToast:Landroid/widget/Toast;

    invoke-virtual {v0}, Landroid/widget/Toast;->cancel()V

    :cond_1
    const/4 v0, 0x0

    .line 19
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    sput-object p0, Lcom/yftech/bsvservice/util/ToastUtil;->mToast:Landroid/widget/Toast;

    .line 20
    sget-object p0, Lcom/yftech/bsvservice/util/ToastUtil;->mToast:Landroid/widget/Toast;

    const/16 p1, 0x51

    invoke-virtual {p0, p1, v0, v0}, Landroid/widget/Toast;->setGravity(III)V

    .line 21
    sget-object p0, Lcom/yftech/bsvservice/util/ToastUtil;->mToast:Landroid/widget/Toast;

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    return-void

    :cond_2
    :goto_0
    return-void
.end method
