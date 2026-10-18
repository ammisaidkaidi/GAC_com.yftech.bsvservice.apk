.class Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;
.super Ljava/lang/Object;
.source "StorageUtil.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/util/StorageUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FileComparator"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;",
        ">;"
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 288
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/util/StorageUtil$1;)V
    .locals 0

    .line 288
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;)I
    .locals 6

    const/4 p0, 0x0

    if-ne p1, p2, :cond_0

    return p0

    :cond_0
    const/4 v0, -0x1

    if-nez p1, :cond_1

    return v0

    :cond_1
    const/4 v1, 0x1

    if-nez p2, :cond_2

    return v1

    .line 298
    :cond_2
    iget-wide v2, p1, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->lastModifiedTime:J

    iget-wide v4, p2, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->lastModifiedTime:J

    cmp-long v2, v2, v4

    if-lez v2, :cond_3

    return v1

    .line 300
    :cond_3
    iget-wide v1, p1, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->lastModifiedTime:J

    iget-wide p1, p2, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->lastModifiedTime:J

    cmp-long p1, v1, p1

    if-gez p1, :cond_4

    return v0

    :cond_4
    return p0
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    .line 288
    check-cast p1, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;

    check-cast p2, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;

    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;->compare(Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;)I

    move-result p0

    return p0
.end method
