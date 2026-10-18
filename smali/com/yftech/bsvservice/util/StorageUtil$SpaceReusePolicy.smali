.class interface abstract Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;
.super Ljava/lang/Object;
.source "StorageUtil.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/util/StorageUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x608
    name = "SpaceReusePolicy"
.end annotation


# virtual methods
.method public abstract enoughSpaceAfterReuse(Ljava/io/File;)Z
.end method

.method public abstract ensureFileNumWithinLimits(Ljava/io/File;)V
.end method
