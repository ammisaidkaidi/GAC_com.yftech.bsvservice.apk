.class Lcom/yftech/bsvservice/avm/AvmControl$1;
.super Ljava/lang/Object;
.source "AvmControl.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/avm/AvmControl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/avm/AvmControl;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/avm/AvmControl;)V
    .locals 0

    .line 676
    iput-object p1, p0, Lcom/yftech/bsvservice/avm/AvmControl$1;->this$0:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 684
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl$1;->this$0:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-static {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->access$200(Lcom/yftech/bsvservice/avm/AvmControl;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 685
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl$1;->this$0:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/avm/AvmControl;->onDisplayState(Z)V

    goto :goto_0

    .line 687
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl$1;->this$0:Lcom/yftech/bsvservice/avm/AvmControl;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/yftech/bsvservice/avm/AvmControl;->onDisplayState(Z)V

    .line 689
    :goto_0
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AvmControl$1;->this$0:Lcom/yftech/bsvservice/avm/AvmControl;

    iget-object v2, p0, Lcom/yftech/bsvservice/avm/AvmControl$1;->this$0:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-static {v2}, Lcom/yftech/bsvservice/avm/AvmControl;->access$200(Lcom/yftech/bsvservice/avm/AvmControl;)Z

    move-result v2

    xor-int/2addr v1, v2

    invoke-static {v0, v1}, Lcom/yftech/bsvservice/avm/AvmControl;->access$202(Lcom/yftech/bsvservice/avm/AvmControl;Z)Z

    .line 690
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AvmControl$1;->this$0:Lcom/yftech/bsvservice/avm/AvmControl;

    const/16 v0, 0x2710

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->postDelayHandler(I)V

    return-void
.end method
