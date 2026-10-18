.class Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;
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
    name = "DefaultUrgentReusePolicy"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/util/StorageUtil;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/util/StorageUtil;)V
    .locals 0

    .line 449
    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public enoughSpaceAfterReuse(Ljava/io/File;)Z
    .locals 7

    .line 452
    invoke-virtual {p1}, Ljava/io/File;->getFreeSpace()J

    move-result-wide v0

    const-wide/16 v2, 0x400

    div-long/2addr v0, v2

    div-long/2addr v0, v2

    long-to-int v0, v0

    .line 453
    iget-object v1, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-virtual {v1, p1}, Lcom/yftech/bsvservice/util/StorageUtil;->getDirSize(Ljava/io/File;)I

    move-result p1

    div-int/lit16 p1, p1, 0x400

    const-string v1, "StorageUtil"

    .line 454
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "enoughSpaceAtferReuse, freeSpace="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ", spaceUsed="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {v1, v2, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 v1, 0x7ce

    if-le p1, v1, :cond_0

    return v3

    :cond_0
    const/4 p1, 0x1

    const/16 v1, 0x32

    if-ge v0, v1, :cond_3

    const/4 v2, 0x0

    .line 460
    :try_start_0
    new-instance v4, Ljava/io/File;

    iget-object v5, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-static {v5}, Lcom/yftech/bsvservice/util/StorageUtil;->access$300(Lcom/yftech/bsvservice/util/StorageUtil;)Ljava/io/File;

    move-result-object v5

    iget-object v6, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    invoke-static {v6}, Lcom/yftech/bsvservice/util/StorageUtil;->access$400(Lcom/yftech/bsvservice/util/StorageUtil;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v4

    const-string v5, "StorageUtil"

    .line 462
    invoke-virtual {v4}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v6, v3, [Ljava/lang/Object;

    invoke-static {v5, v4, v6}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    move-object v4, v2

    :goto_0
    if-nez v4, :cond_1

    return v3

    .line 467
    :cond_1
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;->this$0:Lcom/yftech/bsvservice/util/StorageUtil;

    sub-int/2addr v1, v0

    invoke-virtual {p0, v4, v2, v1}, Lcom/yftech/bsvservice/util/StorageUtil;->deleteOldFiles(Ljava/io/File;Ljava/io/File;I)Z

    move-result p0

    if-eqz p0, :cond_2

    return p1

    :cond_2
    return v3

    :cond_3
    return p1
.end method

.method public ensureFileNumWithinLimits(Ljava/io/File;)V
    .locals 1

    const-string p0, "StorageUtil"

    const-string p1, "isFileNumWithinLimitsAfterReuse"

    const/4 v0, 0x0

    .line 478
    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
