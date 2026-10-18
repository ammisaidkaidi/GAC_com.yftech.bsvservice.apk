.class Lcom/yftech/bsvservice/CameraOperation$RecycleTask$2;
.super Ljava/lang/Object;
.source "CameraOperation.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/yftech/bsvservice/CameraOperation$RecycleTask;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/yftech/bsvservice/CameraOperation$RecycleTask;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/CameraOperation$RecycleTask;)V
    .locals 0

    .line 1389
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$RecycleTask$2;->this$1:Lcom/yftech/bsvservice/CameraOperation$RecycleTask;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    .line 1391
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$RecycleTask$2;->this$1:Lcom/yftech/bsvservice/CameraOperation$RecycleTask;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$RecycleTask;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraOperation;->access$1900(Lcom/yftech/bsvservice/CameraOperation;)V

    return-void
.end method
