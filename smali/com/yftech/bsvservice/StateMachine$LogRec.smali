.class public Lcom/yftech/bsvservice/StateMachine$LogRec;
.super Ljava/lang/Object;
.source "StateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/StateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "LogRec"
.end annotation


# instance fields
.field private mDstState:Lcom/yftech/bsvservice/IState;

.field private mInfo:Ljava/lang/String;

.field private mOrgState:Lcom/yftech/bsvservice/IState;

.field private mSm:Lcom/yftech/bsvservice/StateMachine;

.field private mState:Lcom/yftech/bsvservice/IState;

.field private mTime:J

.field private mWhat:I


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/StateMachine;Landroid/os/Message;Ljava/lang/String;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;)V
    .locals 0

    .line 468
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 469
    invoke-virtual/range {p0 .. p6}, Lcom/yftech/bsvservice/StateMachine$LogRec;->update(Lcom/yftech/bsvservice/StateMachine;Landroid/os/Message;Ljava/lang/String;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;)V

    return-void
.end method


# virtual methods
.method public getDestState()Lcom/yftech/bsvservice/IState;
    .locals 0

    .line 521
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mDstState:Lcom/yftech/bsvservice/IState;

    return-object p0
.end method

.method public getInfo()Ljava/lang/String;
    .locals 0

    .line 507
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mInfo:Ljava/lang/String;

    return-object p0
.end method

.method public getOriginalState()Lcom/yftech/bsvservice/IState;
    .locals 0

    .line 528
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mOrgState:Lcom/yftech/bsvservice/IState;

    return-object p0
.end method

.method public getState()Lcom/yftech/bsvservice/IState;
    .locals 0

    .line 514
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mState:Lcom/yftech/bsvservice/IState;

    return-object p0
.end method

.method public getTime()J
    .locals 2

    .line 493
    iget-wide v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mTime:J

    return-wide v0
.end method

.method public getWhat()J
    .locals 2

    .line 500
    iget p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mWhat:I

    int-to-long v0, p0

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    .line 533
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "time="

    .line 534
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 535
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v1

    .line 536
    iget-wide v2, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mTime:J

    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const-string v2, "%tm-%td %tH:%tM:%tS.%tL"

    const/4 v3, 0x6

    .line 537
    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    const/4 v4, 0x1

    aput-object v1, v3, v4

    const/4 v4, 0x2

    aput-object v1, v3, v4

    const/4 v4, 0x3

    aput-object v1, v3, v4

    const/4 v4, 0x4

    aput-object v1, v3, v4

    const/4 v4, 0x5

    aput-object v1, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " processed="

    .line 538
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 539
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mState:Lcom/yftech/bsvservice/IState;

    if-nez v1, :cond_0

    const-string v1, "<null>"

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mState:Lcom/yftech/bsvservice/IState;

    invoke-interface {v1}, Lcom/yftech/bsvservice/IState;->getName()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " org="

    .line 540
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 541
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mOrgState:Lcom/yftech/bsvservice/IState;

    if-nez v1, :cond_1

    const-string v1, "<null>"

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mOrgState:Lcom/yftech/bsvservice/IState;

    invoke-interface {v1}, Lcom/yftech/bsvservice/IState;->getName()Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " dest="

    .line 542
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 543
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mDstState:Lcom/yftech/bsvservice/IState;

    if-nez v1, :cond_2

    const-string v1, "<null>"

    goto :goto_2

    :cond_2
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mDstState:Lcom/yftech/bsvservice/IState;

    invoke-interface {v1}, Lcom/yftech/bsvservice/IState;->getName()Ljava/lang/String;

    move-result-object v1

    :goto_2
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " what="

    .line 544
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 545
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mSm:Lcom/yftech/bsvservice/StateMachine;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mSm:Lcom/yftech/bsvservice/StateMachine;

    iget v2, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mWhat:I

    invoke-virtual {v1, v2}, Lcom/yftech/bsvservice/StateMachine;->getWhatToString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    :cond_3
    const-string v1, ""

    .line 546
    :goto_3
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 547
    iget v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mWhat:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "(0x"

    .line 548
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 549
    iget v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mWhat:I

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ")"

    .line 550
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    .line 552
    :cond_4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 554
    :goto_4
    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mInfo:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_5

    const-string v1, " "

    .line 555
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 556
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mInfo:Ljava/lang/String;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 558
    :cond_5
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public update(Lcom/yftech/bsvservice/StateMachine;Landroid/os/Message;Ljava/lang/String;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;Lcom/yftech/bsvservice/IState;)V
    .locals 2

    .line 480
    iput-object p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mSm:Lcom/yftech/bsvservice/StateMachine;

    .line 481
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mTime:J

    if-eqz p2, :cond_0

    .line 482
    iget p1, p2, Landroid/os/Message;->what:I

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput p1, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mWhat:I

    .line 483
    iput-object p3, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mInfo:Ljava/lang/String;

    .line 484
    iput-object p4, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mState:Lcom/yftech/bsvservice/IState;

    .line 485
    iput-object p5, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mOrgState:Lcom/yftech/bsvservice/IState;

    .line 486
    iput-object p6, p0, Lcom/yftech/bsvservice/StateMachine$LogRec;->mDstState:Lcom/yftech/bsvservice/IState;

    return-void
.end method
