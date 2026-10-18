.class Lcom/yftech/bsvservice/CameraOperation$1;
.super Landroid/hardware/camera2/CameraDevice$StateCallback;
.source "CameraOperation.java"


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

    .line 179
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraDevice$StateCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed(Landroid/hardware/camera2/CameraDevice;)V
    .locals 4

    .line 182
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 183
    invoke-super {p0, p1}, Landroid/hardware/camera2/CameraDevice$StateCallback;->onClosed(Landroid/hardware/camera2/CameraDevice;)V

    .line 184
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/yftech/bsvservice/CameraOperation;->access$102(Lcom/yftech/bsvservice/CameraOperation;Landroid/hardware/camera2/CameraDevice;)Landroid/hardware/camera2/CameraDevice;

    .line 185
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$202(Lcom/yftech/bsvservice/CameraOperation;Z)Z

    .line 186
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$302(Lcom/yftech/bsvservice/CameraOperation;Z)Z

    .line 187
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 p1, 0x2

    const/4 v0, 0x1

    invoke-static {p0, p1, v0, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    return-void
.end method

.method public onDisconnected(Landroid/hardware/camera2/CameraDevice;)V
    .locals 3

    .line 200
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "camera disconnected"

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 201
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 202
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 p1, 0x1

    const/4 v0, 0x6

    invoke-static {p0, p1, v1, v0}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    return-void
.end method

.method public onError(Landroid/hardware/camera2/CameraDevice;I)V
    .locals 3

    .line 207
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "camera open error: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p1, 0x5

    if-eq p2, p1, :cond_0

    const/4 p1, 0x4

    if-ne p2, p1, :cond_2

    .line 210
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$600(Lcom/yftech/bsvservice/CameraOperation;)Landroid/view/Surface;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 211
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p1}, Lcom/yftech/bsvservice/CameraOperation;->access$600(Lcom/yftech/bsvservice/CameraOperation;)Landroid/view/Surface;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Surface;->release()V

    .line 212
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lcom/yftech/bsvservice/CameraOperation;->access$602(Lcom/yftech/bsvservice/CameraOperation;Landroid/view/Surface;)Landroid/view/Surface;

    .line 214
    :cond_1
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    iget-object p2, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p2}, Lcom/yftech/bsvservice/CameraOperation;->access$700(Lcom/yftech/bsvservice/CameraOperation;)Landroid/util/Size;

    move-result-object p2

    invoke-virtual {p2}, Landroid/util/Size;->getWidth()I

    move-result p2

    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$700(Lcom/yftech/bsvservice/CameraOperation;)Landroid/util/Size;

    move-result-object v0

    invoke-virtual {v0}, Landroid/util/Size;->getHeight()I

    move-result v0

    invoke-static {p1, p2, v0}, Lcom/yftech/bsvservice/CameraOperation;->access$800(Lcom/yftech/bsvservice/CameraOperation;II)V

    .line 216
    :cond_2
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/CameraOperation;->close()V

    .line 217
    iget-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 p2, 0x1

    const/4 v0, 0x7

    invoke-static {p1, p2, v1, v0}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    .line 219
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/16 p1, 0xe

    const/16 p2, 0x14

    invoke-static {p0, p1, v1, p2}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    return-void
.end method

.method public onOpened(Landroid/hardware/camera2/CameraDevice;)V
    .locals 4

    .line 192
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onOpened"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 193
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$500(Lcom/yftech/bsvservice/CameraOperation;)V

    .line 194
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0, p1}, Lcom/yftech/bsvservice/CameraOperation;->access$102(Lcom/yftech/bsvservice/CameraOperation;Landroid/hardware/camera2/CameraDevice;)Landroid/hardware/camera2/CameraDevice;

    .line 195
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$1;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 p1, 0x1

    invoke-static {p0, p1, p1, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    return-void
.end method
