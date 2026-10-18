.class Lcom/yftech/bsvservice/CameraOperation$6;
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

    .line 1334
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 1337
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mUrgentRecordTask, mIsRecording="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v2}, Lcom/yftech/bsvservice/CameraOperation;->access$300(Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1338
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$1700(Lcom/yftech/bsvservice/CameraOperation;)V

    .line 1339
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$1800(Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$300(Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1340
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$2002(Lcom/yftech/bsvservice/CameraOperation;Z)Z

    .line 1341
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/16 v1, 0x8

    const/4 v3, 0x1

    invoke-static {v0, v1, v3, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    .line 1342
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$6;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraOperation;->access$1900(Lcom/yftech/bsvservice/CameraOperation;)V

    :cond_0
    return-void
.end method
