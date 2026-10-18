.class Lcom/yftech/bsvservice/CameraOperation$9;
.super Ljava/lang/Object;
.source "CameraOperation.java"

# interfaces
.implements Landroid/media/MediaRecorder$OnErrorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraOperation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/CameraOperation;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/CameraOperation;)V
    .locals 0

    .line 1451
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Landroid/media/MediaRecorder;II)V
    .locals 2

    .line 1454
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onError, what = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", extra = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p1, p3, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 p1, 0x64

    if-ne p1, p2, :cond_1

    .line 1456
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$2400(Lcom/yftech/bsvservice/CameraOperation;)Landroid/media/MediaRecorder;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 1457
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$2400(Lcom/yftech/bsvservice/CameraOperation;)Landroid/media/MediaRecorder;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/media/MediaRecorder;->setOnErrorListener(Landroid/media/MediaRecorder$OnErrorListener;)V

    .line 1458
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$2400(Lcom/yftech/bsvservice/CameraOperation;)Landroid/media/MediaRecorder;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/media/MediaRecorder;->setOnInfoListener(Landroid/media/MediaRecorder$OnInfoListener;)V

    .line 1459
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$2400(Lcom/yftech/bsvservice/CameraOperation;)Landroid/media/MediaRecorder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/media/MediaRecorder;->release()V

    .line 1460
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1, p2}, Lcom/yftech/bsvservice/CameraOperation;->access$2402(Lcom/yftech/bsvservice/CameraOperation;Landroid/media/MediaRecorder;)Landroid/media/MediaRecorder;

    .line 1462
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$1800(Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 1463
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$9;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/CameraOperation;->restartRecord()V

    :cond_1
    return-void
.end method
