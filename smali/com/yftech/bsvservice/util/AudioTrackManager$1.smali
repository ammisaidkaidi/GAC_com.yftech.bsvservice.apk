.class Lcom/yftech/bsvservice/util/AudioTrackManager$1;
.super Ljava/lang/Object;
.source "AudioTrackManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/util/AudioTrackManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/util/AudioTrackManager;)V
    .locals 0

    .line 97
    iput-object p1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;->this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    const/16 v0, -0x13

    .line 101
    :try_start_0
    invoke-static {v0}, Landroid/os/Process;->setThreadPriority(I)V

    .line 102
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;->this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-static {v0}, Lcom/yftech/bsvservice/util/AudioTrackManager;->access$000(Lcom/yftech/bsvservice/util/AudioTrackManager;)I

    move-result v0

    new-array v0, v0, [B

    .line 104
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;->this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-static {v1}, Lcom/yftech/bsvservice/util/AudioTrackManager;->access$100(Lcom/yftech/bsvservice/util/AudioTrackManager;)Ljava/io/DataInputStream;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/DataInputStream;->available()I

    move-result v1

    if-lez v1, :cond_2

    .line 105
    iget-object v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;->this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-static {v1}, Lcom/yftech/bsvservice/util/AudioTrackManager;->access$100(Lcom/yftech/bsvservice/util/AudioTrackManager;)Ljava/io/DataInputStream;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/io/DataInputStream;->read([B)I

    move-result v1

    const/4 v2, -0x3

    if-eq v1, v2, :cond_0

    const/4 v2, -0x2

    if-ne v1, v2, :cond_1

    goto :goto_0

    :cond_1
    if-eqz v1, :cond_0

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 110
    iget-object v2, p0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;->this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-static {v2}, Lcom/yftech/bsvservice/util/AudioTrackManager;->access$200(Lcom/yftech/bsvservice/util/AudioTrackManager;)Landroid/media/AudioTrack;

    move-result-object v2

    invoke-virtual {v2}, Landroid/media/AudioTrack;->play()V

    .line 111
    iget-object v2, p0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;->this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-static {v2}, Lcom/yftech/bsvservice/util/AudioTrackManager;->access$200(Lcom/yftech/bsvservice/util/AudioTrackManager;)Landroid/media/AudioTrack;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v0, v3, v1}, Landroid/media/AudioTrack;->write([BII)I

    goto :goto_0

    .line 114
    :cond_2
    iget-object p0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;->this$0:Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/util/AudioTrackManager;->stopPlay()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p0

    .line 116
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_1
    return-void
.end method
