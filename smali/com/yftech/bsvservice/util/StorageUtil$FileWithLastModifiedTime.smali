.class Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;
.super Ljava/lang/Object;
.source "StorageUtil.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/util/StorageUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FileWithLastModifiedTime"
.end annotation


# instance fields
.field file:Ljava/io/File;

.field lastModifiedTime:J


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 526
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/util/StorageUtil$1;)V
    .locals 0

    .line 526
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;-><init>()V

    return-void
.end method
