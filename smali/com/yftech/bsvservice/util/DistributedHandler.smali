.class public Lcom/yftech/bsvservice/util/DistributedHandler;
.super Landroid/os/Handler;
.source "DistributedHandler.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "DistributedHandler"


# instance fields
.field private handlerParts:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method public constructor <init>(Landroid/os/Looper;)V
    .locals 0

    .line 24
    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public addHandlerPart(Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;)V
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    if-nez v0, :cond_0

    .line 41
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    .line 43
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 44
    iget-object p0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    invoke-interface {p0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 3

    .line 30
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    if-ge v1, v0, :cond_2

    .line 31
    iget-object v2, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;

    invoke-interface {v2, p1}, Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;->dispatchHandleMessage(Landroid/os/Message;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_1

    return-void

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    move-exception p0

    const-string v0, "DistributedHandler"

    .line 35
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleMessage = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p1, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ","

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, p0}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_2
    return-void
.end method

.method public removeHandlerPart(Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;)V
    .locals 1

    .line 48
    iget-object v0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 49
    iget-object p0, p0, Lcom/yftech/bsvservice/util/DistributedHandler;->handlerParts:Ljava/util/List;

    invoke-interface {p0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method
