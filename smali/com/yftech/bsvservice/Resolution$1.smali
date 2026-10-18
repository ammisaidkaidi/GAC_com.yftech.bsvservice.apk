.class final Lcom/yftech/bsvservice/Resolution$1;
.super Ljava/lang/Object;
.source "Resolution.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/Resolution;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator<",
        "Lcom/yftech/bsvservice/Resolution;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/yftech/bsvservice/Resolution;
    .locals 0

    .line 31
    new-instance p0, Lcom/yftech/bsvservice/Resolution;

    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/Resolution;-><init>(Landroid/os/Parcel;)V

    return-object p0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 0

    .line 28
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/Resolution$1;->createFromParcel(Landroid/os/Parcel;)Lcom/yftech/bsvservice/Resolution;

    move-result-object p0

    return-object p0
.end method

.method public newArray(I)[Lcom/yftech/bsvservice/Resolution;
    .locals 0

    .line 36
    new-array p0, p1, [Lcom/yftech/bsvservice/Resolution;

    return-object p0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 0

    .line 28
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/Resolution$1;->newArray(I)[Lcom/yftech/bsvservice/Resolution;

    move-result-object p0

    return-object p0
.end method
