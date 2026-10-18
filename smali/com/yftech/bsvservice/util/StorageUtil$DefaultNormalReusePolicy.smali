.class Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;
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
    name = "DefaultNormalReusePolicy"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/util/StorageUtil;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/util/StorageUtil;)V
    .locals 0

    .line 409
    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public enoughSpaceAfterReuse(Ljava/io/File;)Z
    .locals 9

    .line 412
    invoke-virtual {p1}, Ljava/io/File;->getFreeSpace()J

    move-result-wide v0

    const-wide/16 v2, 0x400

    div-long/2addr v0, v2

    div-long/2addr v0, v2

    long-to-int v0, v0

    .line 413
    iget-object v1, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-virtual {v1, p1}, Lcom/yftech/bsvservice/util/StorageUtil;->getDirSize(Ljava/io/File;)I

    move-result v1

    div-int/lit16 v1, v1, 0x400

    const-string v4, "StorageUtil"

    .line 414
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "enoughSpaceAtferReuse, freeSpace="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v6, ", spaceUsed="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    new-array v7, v6, [Ljava/lang/Object;

    invoke-static {v4, v5, v7}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v4, 0x0

    const/4 v5, 0x1

    const/16 v7, 0x32

    const/16 v8, 0x1fce

    if-le v1, v8, :cond_2

    .line 416
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    add-int/lit16 v1, v1, -0x2000

    add-int/2addr v1, v7

    invoke-virtual {p0, p1, v4, v1}, Lcom/yftech/bsvservice/util/StorageUtil;->deleteOldFiles(Ljava/io/File;Ljava/io/File;I)Z

    move-result p0

    if-eqz p0, :cond_1

    .line 417
    invoke-virtual {p1}, Ljava/io/File;->getFreeSpace()J

    move-result-wide p0

    div-long/2addr p0, v2

    div-long/2addr p0, v2

    long-to-int p0, p0

    if-lt p0, v7, :cond_0

    return v5

    :cond_0
    return v6

    :cond_1
    return v6

    :cond_2
    if-ge v0, v7, :cond_4

    .line 427
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    sub-int/2addr v7, v0

    invoke-virtual {p0, p1, v4, v7}, Lcom/yftech/bsvservice/util/StorageUtil;->deleteOldFiles(Ljava/io/File;Ljava/io/File;I)Z

    move-result p0

    if-eqz p0, :cond_3

    return v5

    :cond_3
    return v6

    :cond_4
    return v5
.end method

.method public ensureFileNumWithinLimits(Ljava/io/File;)V
    .locals 4

    .line 439
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    .line 440
    iget-object v1, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-static {v1, p1, v0}, Lcom/yftech/bsvservice/util/StorageUtil;->access$200(Lcom/yftech/bsvservice/util/StorageUtil;Ljava/io/File;Ljava/util/List;)V

    .line 441
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p1

    const-string v1, "StorageUtil"

    .line 442
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isFileNumWithinLimitsAfterReuse, fileNum = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 v1, 0x95

    if-le p1, v1, :cond_0

    .line 444
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    sub-int/2addr p1, v1

    invoke-virtual {p0, v0, p1}, Lcom/yftech/bsvservice/util/StorageUtil;->deleteOldFiles(Ljava/util/List;I)Z

    :cond_0
    return-void
.end method
