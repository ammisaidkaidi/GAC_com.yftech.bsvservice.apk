.class Lcom/yftech/bsvservice/CameraOperation$RecycleTask$1;
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

    .line 1374
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$RecycleTask$1;->this$1:Lcom/yftech/bsvservice/CameraOperation$RecycleTask;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 1376
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$RecycleTask$1;->this$1:Lcom/yftech/bsvservice/CameraOperation$RecycleTask;

    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$RecycleTask;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 v0, 0x4

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {p0, v0, v1, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    return-void
.end method
