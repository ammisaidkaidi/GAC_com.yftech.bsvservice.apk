.class public Lcom/yftech/bsvservice/WrappedSurface;
.super Ljava/lang/Object;
.source "WrappedSurface.java"


# instance fields
.field mIsFromBackcar:Z

.field mSurface:Landroid/view/Surface;


# direct methods
.method public constructor <init>(Landroid/view/Surface;Z)V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    iput-object p1, p0, Lcom/yftech/bsvservice/WrappedSurface;->mSurface:Landroid/view/Surface;

    .line 10
    iput-boolean p2, p0, Lcom/yftech/bsvservice/WrappedSurface;->mIsFromBackcar:Z

    return-void
.end method


# virtual methods
.method public isValid()Z
    .locals 0

    .line 13
    iget-object p0, p0, Lcom/yftech/bsvservice/WrappedSurface;->mSurface:Landroid/view/Surface;

    invoke-virtual {p0}, Landroid/view/Surface;->isValid()Z

    move-result p0

    return p0
.end method

.method public toString()Ljava/lang/String;
    .locals 0

    .line 18
    iget-object p0, p0, Lcom/yftech/bsvservice/WrappedSurface;->mSurface:Landroid/view/Surface;

    invoke-virtual {p0}, Landroid/view/Surface;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
