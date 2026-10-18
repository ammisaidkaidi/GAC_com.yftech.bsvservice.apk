.class public Lcom/yftech/bsvservice/StateMachine;
.super Ljava/lang/Object;
.source "StateMachine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/StateMachine$SmHandler;,
        Lcom/yftech/bsvservice/StateMachine$LogRecords;,
        Lcom/yftech/bsvservice/StateMachine$LogRec;
    }
.end annotation


# static fields
.field public static final HANDLED:Z = true

.field public static final NOT_HANDLED:Z = false

.field private static final SM_INIT_CMD:I = -0x2

.field private static final SM_QUIT_CMD:I = -0x1


# instance fields
.field private mName:Ljava/lang/String;

.field private mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

.field private mSmThread:Landroid/os/HandlerThread;


# direct methods
.method protected constructor <init>(Ljava/lang/String;)V
    .locals 1

    .line 1300
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1301
    new-instance v0, Landroid/os/HandlerThread;

    invoke-direct {v0, p1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmThread:Landroid/os/HandlerThread;

    .line 1302
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 1303
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmThread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v0

    .line 1305
    invoke-direct {p0, p1, v0}, Lcom/yftech/bsvservice/StateMachine;->initStateMachine(Ljava/lang/String;Landroid/os/Looper;)V

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;Landroid/os/Handler;)V
    .locals 0

    .line 1322
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1323
    invoke-virtual {p2}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->initStateMachine(Ljava/lang/String;Landroid/os/Looper;)V

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;Landroid/os/Looper;)V
    .locals 0

    .line 1313
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1314
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->initStateMachine(Ljava/lang/String;Landroid/os/Looper;)V

    return-void
.end method

.method static synthetic access$400(Lcom/yftech/bsvservice/StateMachine;)Landroid/os/HandlerThread;
    .locals 0

    .line 420
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmThread:Landroid/os/HandlerThread;

    return-object p0
.end method

.method static synthetic access$402(Lcom/yftech/bsvservice/StateMachine;Landroid/os/HandlerThread;)Landroid/os/HandlerThread;
    .locals 0

    .line 420
    iput-object p1, p0, Lcom/yftech/bsvservice/StateMachine;->mSmThread:Landroid/os/HandlerThread;

    return-object p1
.end method

.method static synthetic access$502(Lcom/yftech/bsvservice/StateMachine;Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$SmHandler;
    .locals 0

    .line 420
    iput-object p1, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    return-object p1
.end method

.method static synthetic access$700(Lcom/yftech/bsvservice/StateMachine;)Ljava/lang/String;
    .locals 0

    .line 420
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    return-object p0
.end method

.method private initStateMachine(Ljava/lang/String;Landroid/os/Looper;)V
    .locals 1

    .line 1291
    iput-object p1, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    .line 1292
    new-instance p1, Lcom/yftech/bsvservice/StateMachine$SmHandler;

    const/4 v0, 0x0

    invoke-direct {p1, p2, p0, v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;-><init>(Landroid/os/Looper;Lcom/yftech/bsvservice/StateMachine;Lcom/yftech/bsvservice/StateMachine$1;)V

    iput-object p1, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    return-void
.end method


# virtual methods
.method public addLogRec(Ljava/lang/String;)V
    .locals 8

    .line 1557
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1559
    :cond_0
    invoke-static {v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object v1

    invoke-static {v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1200(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Landroid/os/Message;

    move-result-object v3

    invoke-static {v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1300(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/IState;

    move-result-object v5

    .line 1560
    invoke-static {v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2100(Lcom/yftech/bsvservice/StateMachine$SmHandler;)[Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;

    move-result-object v2

    invoke-static {v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2200(Lcom/yftech/bsvservice/StateMachine$SmHandler;)I

    move-result v4

    aget-object v2, v2, v4

    iget-object v6, v2, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;->state:Lcom/yftech/bsvservice/State;

    invoke-static {v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2300(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/State;

    move-result-object v7

    move-object v2, p0

    move-object v4, p1

    .line 1559
    invoke-virtual/range {v1 .. v7}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->add(Lcom/yftech/bsvservice/StateMachine;Landroid/os/Message;Ljava/lang/String;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;)V

    return-void
.end method

.method public final addState(Lcom/yftech/bsvservice/State;)V
    .locals 1

    .line 1355
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$900(Lcom/yftech/bsvservice/StateMachine$SmHandler;Lcom/yftech/bsvservice/State;Lcom/yftech/bsvservice/State;)Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;

    return-void
.end method

.method public final addState(Lcom/yftech/bsvservice/State;Lcom/yftech/bsvservice/State;)V
    .locals 0

    .line 1347
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$900(Lcom/yftech/bsvservice/StateMachine$SmHandler;Lcom/yftech/bsvservice/State;Lcom/yftech/bsvservice/State;)Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;

    return-void
.end method

.method protected final clearDeferredMessages()V
    .locals 1

    .line 1939
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1940
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2400(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Ljava/util/ArrayList;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method public final copyLogRecs()Ljava/util/Collection;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection<",
            "Lcom/yftech/bsvservice/StateMachine$LogRec;",
            ">;"
        }
    .end annotation

    .line 1540
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    .line 1541
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-eqz p0, :cond_0

    .line 1543
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object p0

    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->access$2000(Lcom/yftech/bsvservice/StateMachine$LogRecords;)Ljava/util/Vector;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/Vector;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/yftech/bsvservice/StateMachine$LogRec;

    .line 1544
    invoke-virtual {v0, v1}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method public final deferMessage(Landroid/os/Message;)V
    .locals 0

    .line 1435
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1600(Lcom/yftech/bsvservice/StateMachine$SmHandler;Landroid/os/Message;)V

    return-void
.end method

.method public dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V
    .locals 1

    .line 2111
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/yftech/bsvservice/StateMachine;->getName()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, ":"

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 2112
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, " total records="

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/StateMachine;->getLogRecCount()I

    move-result p3

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    const/4 p1, 0x0

    .line 2113
    :goto_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/StateMachine;->getLogRecSize()I

    move-result p3

    if-ge p1, p3, :cond_0

    .line 2114
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, " rec["

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "]: "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine;->getLogRec(I)Lcom/yftech/bsvservice/StateMachine$LogRec;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/StateMachine$LogRec;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 2115
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 2117
    :cond_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "curState="

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/StateMachine;->getCurrentState()Lcom/yftech/bsvservice/IState;

    move-result-object p0

    invoke-interface {p0}, Lcom/yftech/bsvservice/IState;->getName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p2, p0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    return-void
.end method

.method public final getCurrentMessage()Landroid/os/Message;
    .locals 0

    .line 1381
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 1383
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1200(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Landroid/os/Message;

    move-result-object p0

    return-object p0
.end method

.method public final getCurrentState()Lcom/yftech/bsvservice/IState;
    .locals 0

    .line 1391
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 1393
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1300(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/IState;

    move-result-object p0

    return-object p0
.end method

.method public final getHandler()Landroid/os/Handler;
    .locals 0

    .line 1592
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    return-object p0
.end method

.method public final getLogRec(I)Lcom/yftech/bsvservice/StateMachine$LogRec;
    .locals 0

    .line 1531
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 1533
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->get(I)Lcom/yftech/bsvservice/StateMachine$LogRec;

    move-result-object p0

    return-object p0
.end method

.method public final getLogRecCount()I
    .locals 0

    .line 1521
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 1523
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->count()I

    move-result p0

    return p0
.end method

.method public final getLogRecMaxSize()I
    .locals 0

    .line 1511
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 1513
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object p0

    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->access$1900(Lcom/yftech/bsvservice/StateMachine$LogRecords;)I

    move-result p0

    return p0
.end method

.method public final getLogRecSize()I
    .locals 0

    .line 1501
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 1503
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->size()I

    move-result p0

    return p0
.end method

.method protected getLogRecString(Landroid/os/Message;)Ljava/lang/String;
    .locals 0

    const-string p0, ""

    return-object p0
.end method

.method public final getName()Ljava/lang/String;
    .locals 0

    .line 1475
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    return-object p0
.end method

.method protected getWhatToString(I)Ljava/lang/String;
    .locals 0

    const/4 p0, 0x0

    return-object p0
.end method

.method protected haltedProcessMessage(Landroid/os/Message;)V
    .locals 0

    return-void
.end method

.method protected final hasDeferredMessages(I)Z
    .locals 2

    .line 1990
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 1993
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2400(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Ljava/util/ArrayList;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    .line 1994
    :cond_1
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1995
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/Message;

    .line 1996
    iget v1, v1, Landroid/os/Message;->what:I

    if-ne v1, p1, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_2
    return v0
.end method

.method protected final hasDeferredMessages(ILjava/lang/Object;)Z
    .locals 3

    .line 2003
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 2006
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2400(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Ljava/util/ArrayList;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    .line 2007
    :cond_1
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2008
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/Message;

    .line 2009
    iget v2, v1, Landroid/os/Message;->what:I

    if-ne v2, p1, :cond_1

    iget-object v1, v1, Landroid/os/Message;->obj:Ljava/lang/Object;

    if-ne v1, p2, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_2
    return v0
.end method

.method protected final hasMessages(I)Z
    .locals 0

    .line 2020
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 2023
    :cond_0
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->hasMessages(I)Z

    move-result p0

    return p0
.end method

.method protected final hasMessages(ILjava/lang/Object;)Z
    .locals 0

    .line 2027
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 2030
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->hasMessages(ILjava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public isDbg()Z
    .locals 0

    .line 2072
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 2075
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Z

    move-result p0

    return p0
.end method

.method protected final isQuit(Landroid/os/Message;)Z
    .locals 0

    .line 2039
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_1

    .line 2040
    iget p0, p1, Landroid/os/Message;->what:I

    const/4 p1, -0x1

    if-ne p0, p1, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0

    .line 2042
    :cond_1
    invoke-static {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2500(Lcom/yftech/bsvservice/StateMachine$SmHandler;Landroid/os/Message;)Z

    move-result p0

    return p0
.end method

.method protected log(Ljava/lang/String;)V
    .locals 0

    .line 2149
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected logAndAddLogRec(Ljava/lang/String;)V
    .locals 0

    .line 2139
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine;->addLogRec(Ljava/lang/String;)V

    .line 2140
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine;->log(Ljava/lang/String;)V

    return-void
.end method

.method protected logd(Ljava/lang/String;)V
    .locals 0

    .line 2158
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected loge(Ljava/lang/String;)V
    .locals 0

    .line 2194
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected loge(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    .line 2204
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method protected logi(Ljava/lang/String;)V
    .locals 0

    .line 2176
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected logv(Ljava/lang/String;)V
    .locals 0

    .line 2167
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected logw(Ljava/lang/String;)V
    .locals 0

    .line 2185
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public final obtainMessage()Landroid/os/Message;
    .locals 0

    .line 1606
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0}, Landroid/os/Message;->obtain(Landroid/os/Handler;)Landroid/os/Message;

    move-result-object p0

    return-object p0
.end method

.method public final obtainMessage(I)Landroid/os/Message;
    .locals 0

    .line 1621
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object p0

    return-object p0
.end method

.method public final obtainMessage(II)Landroid/os/Message;
    .locals 1

    .line 1656
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Landroid/os/Message;->obtain(Landroid/os/Handler;III)Landroid/os/Message;

    move-result-object p0

    return-object p0
.end method

.method public final obtainMessage(III)Landroid/os/Message;
    .locals 0

    .line 1674
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1, p2, p3}, Landroid/os/Message;->obtain(Landroid/os/Handler;III)Landroid/os/Message;

    move-result-object p0

    return-object p0
.end method

.method public final obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;
    .locals 0

    .line 1693
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1, p2, p3, p4}, Landroid/os/Message;->obtain(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    return-object p0
.end method

.method public final obtainMessage(ILjava/lang/Object;)Landroid/os/Message;
    .locals 0

    .line 1638
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1, p2}, Landroid/os/Message;->obtain(Landroid/os/Handler;ILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    return-object p0
.end method

.method protected onHalting()V
    .locals 0

    return-void
.end method

.method protected onPostHandleMessage(Landroid/os/Message;)V
    .locals 0

    return-void
.end method

.method protected onPreHandleMessage(Landroid/os/Message;)V
    .locals 0

    return-void
.end method

.method protected onQuitting()V
    .locals 0

    return-void
.end method

.method public final quit()V
    .locals 0

    .line 2050
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 2053
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2600(Lcom/yftech/bsvservice/StateMachine$SmHandler;)V

    return-void
.end method

.method public final quitNow()V
    .locals 0

    .line 2061
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 2064
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2700(Lcom/yftech/bsvservice/StateMachine$SmHandler;)V

    return-void
.end method

.method protected recordLogRec(Landroid/os/Message;)Z
    .locals 0

    const/4 p0, 0x1

    return p0
.end method

.method protected final removeDeferredMessages(I)V
    .locals 1

    .line 1965
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 1968
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2400(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Ljava/util/ArrayList;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    .line 1969
    :cond_1
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1970
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Message;

    .line 1971
    iget v0, v0, Landroid/os/Message;->what:I

    if-ne v0, p1, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_2
    return-void
.end method

.method protected final removeDeferredMessages(ILjava/lang/Object;)V
    .locals 2

    .line 1976
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 1979
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2400(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Ljava/util/ArrayList;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    .line 1980
    :cond_1
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1981
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Message;

    .line 1982
    iget v1, v0, Landroid/os/Message;->what:I

    if-ne v1, p1, :cond_1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    if-ne v0, p2, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_2
    return-void
.end method

.method protected final removeMessages(I)V
    .locals 0

    .line 1949
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 1952
    :cond_0
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->removeMessages(I)V

    return-void
.end method

.method protected final removeMessages(ILjava/lang/Object;)V
    .locals 0

    .line 1956
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 1958
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->removeMessages(ILjava/lang/Object;)V

    return-void
.end method

.method public final removeState(Lcom/yftech/bsvservice/State;)V
    .locals 0

    .line 1363
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1000(Lcom/yftech/bsvservice/StateMachine$SmHandler;Lcom/yftech/bsvservice/State;)V

    return-void
.end method

.method public sendMessage(I)V
    .locals 1

    .line 1703
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1706
    :cond_0
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(I)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public sendMessage(II)V
    .locals 1

    .line 1729
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1732
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(II)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public sendMessage(III)V
    .locals 1

    .line 1742
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1745
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(III)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public sendMessage(IIILjava/lang/Object;)V
    .locals 1

    .line 1755
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1758
    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public sendMessage(ILjava/lang/Object;)V
    .locals 1

    .line 1716
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1719
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method public sendMessage(Landroid/os/Message;)V
    .locals 0

    .line 1768
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 1771
    :cond_0
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessage(Landroid/os/Message;)Z

    return-void
.end method

.method protected final sendMessageAtFrontOfQueue(I)V
    .locals 1

    .line 1861
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1864
    :cond_0
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(I)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageAtFrontOfQueue(Landroid/os/Message;)Z

    return-void
.end method

.method protected final sendMessageAtFrontOfQueue(II)V
    .locals 1

    .line 1889
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1892
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(II)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageAtFrontOfQueue(Landroid/os/Message;)Z

    return-void
.end method

.method protected final sendMessageAtFrontOfQueue(III)V
    .locals 1

    .line 1904
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1907
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(III)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageAtFrontOfQueue(Landroid/os/Message;)Z

    return-void
.end method

.method protected final sendMessageAtFrontOfQueue(IIILjava/lang/Object;)V
    .locals 1

    .line 1918
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1921
    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageAtFrontOfQueue(Landroid/os/Message;)Z

    return-void
.end method

.method protected final sendMessageAtFrontOfQueue(ILjava/lang/Object;)V
    .locals 1

    .line 1875
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1878
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageAtFrontOfQueue(Landroid/os/Message;)Z

    return-void
.end method

.method protected final sendMessageAtFrontOfQueue(Landroid/os/Message;)V
    .locals 0

    .line 1932
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 1935
    :cond_0
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageAtFrontOfQueue(Landroid/os/Message;)Z

    return-void
.end method

.method public sendMessageDelayed(IIIJ)V
    .locals 1

    .line 1820
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1823
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(III)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0, p4, p5}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method

.method public sendMessageDelayed(IIILjava/lang/Object;J)V
    .locals 1

    .line 1834
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1837
    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0, p5, p6}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method

.method public sendMessageDelayed(IIJ)V
    .locals 1

    .line 1807
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1810
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(II)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0, p3, p4}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method

.method public sendMessageDelayed(IJ)V
    .locals 1

    .line 1781
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1784
    :cond_0
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(I)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0, p2, p3}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method

.method public sendMessageDelayed(ILjava/lang/Object;J)V
    .locals 1

    .line 1794
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez v0, :cond_0

    return-void

    .line 1797
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/yftech/bsvservice/StateMachine;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object p0

    invoke-virtual {v0, p0, p3, p4}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method

.method public sendMessageDelayed(Landroid/os/Message;J)V
    .locals 0

    .line 1847
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 1850
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method

.method public setDbg(Z)V
    .locals 0

    .line 2085
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 2088
    :cond_0
    invoke-static {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$2900(Lcom/yftech/bsvservice/StateMachine$SmHandler;Z)V

    return-void
.end method

.method public final setInitialState(Lcom/yftech/bsvservice/State;)V
    .locals 0

    .line 1373
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1100(Lcom/yftech/bsvservice/StateMachine$SmHandler;Lcom/yftech/bsvservice/State;)V

    return-void
.end method

.method public final setLogOnlyTransitions(Z)V
    .locals 0

    .line 1493
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->setLogOnlyTransitions(Z)V

    return-void
.end method

.method public final setLogRecSize(I)V
    .locals 0

    .line 1484
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1800(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$LogRecords;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->setSize(I)V

    return-void
.end method

.method public start()V
    .locals 0

    .line 2096
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    if-nez p0, :cond_0

    return-void

    .line 2100
    :cond_0
    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$3000(Lcom/yftech/bsvservice/StateMachine$SmHandler;)V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    const-string v0, "(null)"

    const-string v1, "(null)"

    .line 2125
    :try_start_0
    iget-object v2, p0, Lcom/yftech/bsvservice/StateMachine;->mName:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2126
    :try_start_1
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1300(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/IState;

    move-result-object p0

    invoke-interface {p0}, Lcom/yftech/bsvservice/IState;->getName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_1
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-object v2, v0

    :catch_1
    move-object p0, v1

    .line 2130
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "name="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " state="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public final transitionTo(Lcom/yftech/bsvservice/IState;)V
    .locals 0

    .line 1411
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1400(Lcom/yftech/bsvservice/StateMachine$SmHandler;Lcom/yftech/bsvservice/IState;)V

    return-void
.end method

.method public final transitionToHaltingState()V
    .locals 1

    .line 1422
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1500(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Lcom/yftech/bsvservice/StateMachine$SmHandler$HaltingState;

    move-result-object p0

    invoke-static {v0, p0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1400(Lcom/yftech/bsvservice/StateMachine$SmHandler;Lcom/yftech/bsvservice/IState;)V

    return-void
.end method

.method protected unhandledMessage(Landroid/os/Message;)V
    .locals 2

    .line 1444
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine;->mSmHandler:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-static {v0}, Lcom/yftech/bsvservice/StateMachine$SmHandler;->access$1700(Lcom/yftech/bsvservice/StateMachine$SmHandler;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " - unhandledMessage: msg.what="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p1, p1, Landroid/os/Message;->what:I

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/StateMachine;->loge(Ljava/lang/String;)V

    :cond_0
    return-void
.end method
