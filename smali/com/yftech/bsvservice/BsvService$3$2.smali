.class Lcom/yftech/bsvservice/BsvService$3$2;
.super Ljava/lang/Object;
.source "BsvService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/yftech/bsvservice/BsvService$3;->onUserSwitchComplete(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/yftech/bsvservice/BsvService$3;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/BsvService$3;)V
    .locals 0

    .line 221
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvService$3$2;->this$1:Lcom/yftech/bsvservice/BsvService$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 223
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService$3$2;->this$1:Lcom/yftech/bsvservice/BsvService$3;

    iget-object v0, v0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {v0}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object v0

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$3$2;->this$1:Lcom/yftech/bsvservice/BsvService$3;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$3;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0}, Lcom/yftech/bsvservice/BsvService;->access$800(Lcom/yftech/bsvservice/BsvService;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->startBackcar(Ljava/lang/String;)V

    return-void
.end method
