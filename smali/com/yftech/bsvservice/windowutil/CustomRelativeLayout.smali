.class public Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;
.super Landroid/widget/RelativeLayout;
.source "CustomRelativeLayout.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout$OnKeyEventListener;
    }
.end annotation


# instance fields
.field private mKeyListener:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout$OnKeyEventListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 24
    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    .line 28
    invoke-direct {p0, p1, p2}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    .line 32
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .locals 0

    .line 36
    invoke-direct {p0, p1, p2, p3, p4}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    return-void
.end method


# virtual methods
.method public dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 3

    const-string v0, "CustomRelativeLayout"

    .line 41
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "key:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 42
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->mKeyListener:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout$OnKeyEventListener;

    if-eqz v0, :cond_0

    .line 43
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->mKeyListener:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout$OnKeyEventListener;

    invoke-interface {p0, p1}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout$OnKeyEventListener;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    :cond_0
    const/4 p0, 0x1

    return p0
.end method

.method public setOnKeyEventListener(Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout$OnKeyEventListener;)V
    .locals 0

    .line 20
    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->mKeyListener:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout$OnKeyEventListener;

    return-void
.end method
