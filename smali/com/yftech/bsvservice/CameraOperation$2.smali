.class Lcom/yftech/bsvservice/CameraOperation$2;
.super Landroid/hardware/camera2/CameraCaptureSession$StateCallback;
.source "CameraOperation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/yftech/bsvservice/CameraOperation;->createCaptureSession()Z
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

    .line 286
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onConfigureFailed(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 4

    .line 298
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConfigureFailed"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p1, :cond_0

    .line 300
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraCaptureSession;->close()V

    .line 302
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/yftech/bsvservice/CameraOperation;->access$1002(Lcom/yftech/bsvservice/CameraOperation;Landroid/hardware/camera2/CameraCaptureSession;)Landroid/hardware/camera2/CameraCaptureSession;

    .line 303
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$1202(Lcom/yftech/bsvservice/CameraOperation;Z)Z

    .line 305
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/16 p1, 0xe

    const/16 v0, 0x14

    invoke-static {p0, p1, v2, v0}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    return-void
.end method

.method public onConfigured(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 4

    .line 289
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConfigured"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 290
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$100(Lcom/yftech/bsvservice/CameraOperation;)Landroid/hardware/camera2/CameraDevice;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$900(Lcom/yftech/bsvservice/CameraOperation;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 291
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0, p1}, Lcom/yftech/bsvservice/CameraOperation;->access$1002(Lcom/yftech/bsvservice/CameraOperation;Landroid/hardware/camera2/CameraCaptureSession;)Landroid/hardware/camera2/CameraCaptureSession;

    .line 292
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$1100(Lcom/yftech/bsvservice/CameraOperation;)V

    .line 294
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$2;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$1202(Lcom/yftech/bsvservice/CameraOperation;Z)Z

    return-void
.end method
