.class Lcom/yftech/bsvservice/CameraOperation$7;
.super Ljava/lang/Object;
.source "CameraOperation.java"

# interfaces
.implements Ljava/lang/Runnable;


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

    .line 1347
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 1350
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mDelayedUrgentRecordTask, mIsRecording="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v2}, Lcom/yftech/bsvservice/CameraOperation;->access$300(Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1351
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$1700(Lcom/yftech/bsvservice/CameraOperation;)V

    .line 1352
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/yftech/bsvservice/CameraOperation;->access$2002(Lcom/yftech/bsvservice/CameraOperation;Z)Z

    .line 1353
    new-instance v0, Lcom/yftech/bsvservice/CameraOperation$MoveUrgentFileTask;

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v3}, Lcom/yftech/bsvservice/CameraOperation;->access$2200(Lcom/yftech/bsvservice/CameraOperation;)Lcom/yftech/bsvservice/util/StorageUtil;

    move-result-object v3

    invoke-direct {v0, v3}, Lcom/yftech/bsvservice/CameraOperation$MoveUrgentFileTask;-><init>(Lcom/yftech/bsvservice/util/StorageUtil;)V

    new-array v1, v1, [Ljava/lang/Long;

    iget-object v3, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v3}, Lcom/yftech/bsvservice/CameraOperation;->access$2100(Lcom/yftech/bsvservice/CameraOperation;)J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/CameraOperation$MoveUrgentFileTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 1354
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$7;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraOperation;->access$1900(Lcom/yftech/bsvservice/CameraOperation;)V

    return-void
.end method
