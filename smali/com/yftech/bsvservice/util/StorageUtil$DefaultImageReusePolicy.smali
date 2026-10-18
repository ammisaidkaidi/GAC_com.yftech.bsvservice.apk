.class Lcom/yftech/bsvservice/util/StorageUtil$DefaultImageReusePolicy;
.super Ljava/lang/Object;
.source "StorageUtil.java"

# interfaces
.implements Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/util/StorageUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "DefaultImageReusePolicy"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/util/StorageUtil;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/util/StorageUtil;)V
    .locals 0

    .line 482
    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultImageReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public enoughSpaceAfterReuse(Ljava/io/File;)Z
    .locals 2

    .line 485
    invoke-virtual {p1}, Ljava/io/File;->getFreeSpace()J

    move-result-wide p0

    const-wide/16 v0, 0x400

    div-long/2addr p0, v0

    div-long/2addr p0, v0

    long-to-int p0, p0

    const/4 p1, 0x2

    if-lt p0, p1, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public ensureFileNumWithinLimits(Ljava/io/File;)V
    .locals 1

    const-string p0, "StorageUtil"

    const-string p1, "isFileNumWithinLimitsAfterReuse"

    const/4 v0, 0x0

    .line 491
    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
