.class public Lcom/yftech/bsvservice/util/StorageUtil$SpaceNotEnoughException;
.super Ljava/lang/Exception;
.source "StorageUtil.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/util/StorageUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SpaceNotEnoughException"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, "storage free space is nout enough"

    .line 516
    invoke-direct {p0, v0}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    return-void
.end method
