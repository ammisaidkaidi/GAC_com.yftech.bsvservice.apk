.class Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;
.super Ljava/lang/Object;
.source "StateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/StateMachine$SmHandler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "StateInfo"
.end annotation


# instance fields
.field active:Z

.field parentStateInfo:Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;

.field state:Lcom/yftech/bsvservice/State;

.field final synthetic this$0:Lcom/yftech/bsvservice/StateMachine$SmHandler;


# direct methods
.method private constructor <init>(Lcom/yftech/bsvservice/StateMachine$SmHandler;)V
    .locals 0

    .line 723
    iput-object p1, p0, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;->this$0:Lcom/yftech/bsvservice/StateMachine$SmHandler;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/yftech/bsvservice/StateMachine$SmHandler;Lcom/yftech/bsvservice/StateMachine$1;)V
    .locals 0

    .line 723
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;-><init>(Lcom/yftech/bsvservice/StateMachine$SmHandler;)V

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 2

    .line 738
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "state="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;->state:Lcom/yftech/bsvservice/State;

    invoke-virtual {v1}, Lcom/yftech/bsvservice/State;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ",active="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;->active:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ",parent="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;->parentStateInfo:Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;

    if-nez v1, :cond_0

    const-string p0, "null"

    goto :goto_0

    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;->parentStateInfo:Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;

    iget-object p0, p0, Lcom/yftech/bsvservice/StateMachine$SmHandler$StateInfo;->state:Lcom/yftech/bsvservice/State;

    .line 739
    invoke-virtual {p0}, Lcom/yftech/bsvservice/State;->getName()Ljava/lang/String;

    move-result-object p0

    :goto_0
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
