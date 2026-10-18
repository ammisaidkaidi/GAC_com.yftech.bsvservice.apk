.class Lcom/yftech/bsvservice/StateMachine$LogRecords;
.super Ljava/lang/Object;
.source "StateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/StateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "LogRecords"
.end annotation


# static fields
.field private static final DEFAULT_SIZE:I = 0x14


# instance fields
.field private mCount:I

.field private mLogOnlyTransitions:Z

.field private mLogRecVector:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector<",
            "Lcom/yftech/bsvservice/StateMachine$LogRec;",
            ">;"
        }
    .end annotation
.end field

.field private mMaxSize:I

.field private mOldestIndex:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 586
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 577
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    const/16 v0, 0x14

    .line 578
    iput v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mMaxSize:I

    const/4 v0, 0x0

    .line 579
    iput v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    .line 580
    iput v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mCount:I

    .line 581
    iput-boolean v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogOnlyTransitions:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/StateMachine$1;)V
    .locals 0

    .line 573
    invoke-direct {p0}, Lcom/yftech/bsvservice/StateMachine$LogRecords;-><init>()V

    return-void
.end method

.method static synthetic access$1900(Lcom/yftech/bsvservice/StateMachine$LogRecords;)I
    .locals 0

    .line 573
    iget p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mMaxSize:I

    return p0
.end method

.method static synthetic access$2000(Lcom/yftech/bsvservice/StateMachine$LogRecords;)Ljava/util/Vector;
    .locals 0

    .line 573
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    return-object p0
.end method


# virtual methods
.method declared-synchronized add(Lcom/yftech/bsvservice/StateMachine;Landroid/os/Message;Ljava/lang/String;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;)V
    .locals 9

    monitor-enter p0

    .line 664
    :try_start_0
    iget v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mCount:I

    .line 665
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0

    iget v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mMaxSize:I

    if-ge v0, v1, :cond_0

    .line 666
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    new-instance v8, Lcom/yftech/bsvservice/StateMachine$LogRec;

    move-object v1, v8

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-direct/range {v1 .. v7}, Lcom/yftech/bsvservice/StateMachine$LogRec;-><init>(Lcom/yftech/bsvservice/StateMachine;Landroid/os/Message;Ljava/lang/String;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;)V

    invoke-virtual {v0, v8}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 668
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    iget v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    invoke-virtual {v0, v1}, Ljava/util/Vector;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lcom/yftech/bsvservice/StateMachine$LogRec;

    .line 669
    iget v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    .line 670
    iget v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    iget v2, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mMaxSize:I

    if-lt v0, v2, :cond_1

    const/4 v0, 0x0

    .line 671
    iput v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    :cond_1
    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    .line 673
    invoke-virtual/range {v1 .. v7}, Lcom/yftech/bsvservice/StateMachine$LogRec;->update(Lcom/yftech/bsvservice/StateMachine;Landroid/os/Message;Ljava/lang/String;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 675
    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    .line 663
    monitor-exit p0

    throw p1
.end method

.method declared-synchronized cleanup()V
    .locals 1

    monitor-enter p0

    .line 630
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 631
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 629
    monitor-exit p0

    throw v0
.end method

.method declared-synchronized count()I
    .locals 1

    monitor-enter p0

    .line 623
    :try_start_0
    iget v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized get(I)Lcom/yftech/bsvservice/StateMachine$LogRec;
    .locals 1

    monitor-enter p0

    .line 639
    :try_start_0
    iget v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    add-int/2addr v0, p1

    .line 640
    iget p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mMaxSize:I

    if-lt v0, p1, :cond_0

    .line 641
    iget p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mMaxSize:I

    sub-int/2addr v0, p1

    .line 643
    :cond_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/StateMachine$LogRecords;->size()I

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lt v0, p1, :cond_1

    const/4 p1, 0x0

    .line 644
    monitor-exit p0

    return-object p1

    .line 646
    :cond_1
    :try_start_1
    iget-object p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    invoke-virtual {p1, v0}, Ljava/util/Vector;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/yftech/bsvservice/StateMachine$LogRec;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object p1

    :catchall_0
    move-exception p1

    .line 638
    monitor-exit p0

    throw p1
.end method

.method declared-synchronized logOnlyTransitions()Z
    .locals 1

    monitor-enter p0

    .line 609
    :try_start_0
    iget-boolean v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogOnlyTransitions:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized setLogOnlyTransitions(Z)V
    .locals 0

    monitor-enter p0

    .line 605
    :try_start_0
    iput-boolean p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogOnlyTransitions:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 606
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    .line 604
    monitor-exit p0

    throw p1
.end method

.method declared-synchronized setSize(I)V
    .locals 0

    monitor-enter p0

    .line 598
    :try_start_0
    iput p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mMaxSize:I

    const/4 p1, 0x0

    .line 599
    iput p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mOldestIndex:I

    .line 600
    iput p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mCount:I

    .line 601
    iget-object p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    invoke-virtual {p1}, Ljava/util/Vector;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 602
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    .line 597
    monitor-exit p0

    throw p1
.end method

.method declared-synchronized size()I
    .locals 1

    monitor-enter p0

    .line 616
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRecords;->mLogRecVector:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->size()I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
