.class Lcom/yftech/bsvservice/CameraOperation$8;
.super Ljava/lang/Object;
.source "CameraOperation.java"

# interfaces
.implements Landroid/media/ImageReader$OnImageAvailableListener;


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

    .line 1413
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onImageAvailable(Landroid/media/ImageReader;)V
    .locals 7

    .line 1416
    iget-object v0, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onImageAvailable, width = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Landroid/media/ImageReader;->getWidth()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", height = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Landroid/media/ImageReader;->getHeight()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 v0, 0x9

    const/4 v1, 0x0

    .line 1420
    :try_start_0
    invoke-virtual {p1}, Landroid/media/ImageReader;->acquireNextImage()Landroid/media/Image;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 1421
    :try_start_1
    iget-object v3, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const-string v4, "image"

    invoke-static {v3, v4}, Lcom/yftech/bsvservice/CameraOperation;->access$2500(Lcom/yftech/bsvservice/CameraOperation;Ljava/lang/String;)Ljava/io/File;

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-nez v3, :cond_1

    if-eqz p1, :cond_0

    .line 1445
    invoke-virtual {p1}, Landroid/media/Image;->close()V

    :cond_0
    return-void

    .line 1425
    :cond_1
    :try_start_2
    invoke-virtual {p1}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v4

    aget-object v4, v4, v2

    invoke-virtual {v4}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    .line 1426
    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v5

    new-array v5, v5, [B

    .line 1427
    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 1428
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1429
    :try_start_3
    invoke-virtual {v4, v5}, Ljava/io/OutputStream;->write([B)V

    .line 1430
    invoke-virtual {v4}, Ljava/io/OutputStream;->flush()V

    .line 1431
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 v5, 0x1

    invoke-static {v1, v0, v5, v2}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V

    .line 1432
    iget-object v1, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v1}, Lcom/yftech/bsvservice/CameraOperation;->access$2200(Lcom/yftech/bsvservice/CameraOperation;)Lcom/yftech/bsvservice/util/StorageUtil;

    move-result-object v1

    invoke-virtual {v1, v3}, Lcom/yftech/bsvservice/util/StorageUtil;->updateFileWithMediaScanner(Ljava/io/File;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1439
    :try_start_4
    invoke-virtual {v4}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0

    .line 1441
    :catch_0
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "image outputstream close fail"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    if-eqz p1, :cond_3

    goto :goto_3

    :catchall_0
    move-exception v0

    move-object v1, v4

    goto :goto_4

    :catch_1
    move-exception v1

    move-object v3, v1

    move-object v1, v4

    goto :goto_1

    :catchall_1
    move-exception v0

    goto :goto_4

    :catch_2
    move-exception v3

    goto :goto_1

    :catchall_2
    move-exception v0

    move-object p1, v1

    goto :goto_4

    :catch_3
    move-exception p1

    move-object v3, p1

    move-object p1, v1

    .line 1434
    :goto_1
    :try_start_5
    iget-object v4, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {v4}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "write image file fail: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v5, v2, [Ljava/lang/Object;

    invoke-static {v4, v3, v5}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1435
    iget-object v3, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    const/4 v4, -0x1

    invoke-static {v3, v0, v2, v4}, Lcom/yftech/bsvservice/CameraOperation;->access$400(Lcom/yftech/bsvservice/CameraOperation;IZI)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    if-eqz v1, :cond_2

    .line 1439
    :try_start_6
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_4

    goto :goto_2

    .line 1441
    :catch_4
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "image outputstream close fail"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_2
    :goto_2
    if-eqz p1, :cond_3

    .line 1445
    :goto_3
    invoke-virtual {p1}, Landroid/media/Image;->close()V

    :cond_3
    return-void

    :goto_4
    if-eqz v1, :cond_4

    .line 1439
    :try_start_7
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_5

    .line 1441
    :catch_5
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$8;->this$0:Lcom/yftech/bsvservice/CameraOperation;

    invoke-static {p0}, Lcom/yftech/bsvservice/CameraOperation;->access$000(Lcom/yftech/bsvservice/CameraOperation;)Ljava/lang/String;

    move-result-object p0

    const-string v1, "image outputstream close fail"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    :goto_5
    if-eqz p1, :cond_5

    .line 1445
    invoke-virtual {p1}, Landroid/media/Image;->close()V

    .line 1447
    :cond_5
    throw v0
.end method
