.class public Lcom/yftech/bsvservice/util/AudioTrackManager;
.super Ljava/lang/Object;
.source "AudioTrackManager.java"


# static fields
.field private static final AUDIO_FORMAT:I = 0x2

.field private static final CHANNEL_CONFIG:I = 0x4

.field private static final SAMPLE_RATE:I = 0xbb80

.field private static final STREAM_TYPE:I = 0x1c

.field public static final TAG:Ljava/lang/String; = "AudioTrackManager"

.field private static mInstance:Lcom/yftech/bsvservice/util/AudioTrackManager;


# instance fields
.field private audioTrack:Landroid/media/AudioTrack;

.field private bufferSize:I

.field private dis:Ljava/io/DataInputStream;

.field private isStart:Z

.field private playThread:Ljava/lang/Thread;

.field recordRunnable:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 8

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 22
    iput-boolean v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->isStart:Z

    .line 97
    new-instance v0, Lcom/yftech/bsvservice/util/AudioTrackManager$1;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/util/AudioTrackManager$1;-><init>(Lcom/yftech/bsvservice/util/AudioTrackManager;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->recordRunnable:Ljava/lang/Runnable;

    .line 28
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v1, 0x1c

    .line 31
    invoke-virtual {v0, v1}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 32
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v2

    .line 33
    new-instance v0, Landroid/media/AudioFormat$Builder;

    invoke-direct {v0}, Landroid/media/AudioFormat$Builder;-><init>()V

    const v1, 0xbb80

    .line 34
    invoke-virtual {v0, v1}, Landroid/media/AudioFormat$Builder;->setSampleRate(I)Landroid/media/AudioFormat$Builder;

    move-result-object v0

    const/4 v3, 0x4

    .line 35
    invoke-virtual {v0, v3}, Landroid/media/AudioFormat$Builder;->setChannelMask(I)Landroid/media/AudioFormat$Builder;

    move-result-object v0

    const/4 v3, 0x2

    .line 36
    invoke-virtual {v0, v3}, Landroid/media/AudioFormat$Builder;->setEncoding(I)Landroid/media/AudioFormat$Builder;

    move-result-object v0

    .line 37
    invoke-virtual {v0}, Landroid/media/AudioFormat$Builder;->build()Landroid/media/AudioFormat;

    move-result-object v0

    .line 38
    invoke-static {v1, v3, v3}, Landroid/media/AudioTrack;->getMinBufferSize(III)I

    move-result v1

    iput v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->bufferSize:I

    .line 41
    new-instance v7, Landroid/media/AudioTrack;

    iget v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->bufferSize:I

    mul-int/lit8 v4, v1, 0x2

    const/4 v5, 0x1

    const/4 v6, 0x0

    move-object v1, v7

    move-object v3, v0

    invoke-direct/range {v1 .. v6}, Landroid/media/AudioTrack;-><init>(Landroid/media/AudioAttributes;Landroid/media/AudioFormat;III)V

    iput-object v7, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->audioTrack:Landroid/media/AudioTrack;

    return-void
.end method

.method static synthetic access$000(Lcom/yftech/bsvservice/util/AudioTrackManager;)I
    .locals 0

    .line 10
    iget p0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->bufferSize:I

    return p0
.end method

.method static synthetic access$100(Lcom/yftech/bsvservice/util/AudioTrackManager;)Ljava/io/DataInputStream;
    .locals 0

    .line 10
    iget-object p0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->dis:Ljava/io/DataInputStream;

    return-object p0
.end method

.method static synthetic access$200(Lcom/yftech/bsvservice/util/AudioTrackManager;)Landroid/media/AudioTrack;
    .locals 0

    .line 10
    iget-object p0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->audioTrack:Landroid/media/AudioTrack;

    return-object p0
.end method

.method private destroyThread()V
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 65
    :try_start_0
    iput-boolean v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->isStart:Z

    .line 66
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    if-eqz v0, :cond_0

    sget-object v0, Ljava/lang/Thread$State;->RUNNABLE:Ljava/lang/Thread$State;

    iget-object v2, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    invoke-virtual {v2}, Ljava/lang/Thread;->getState()Ljava/lang/Thread$State;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v0, v2, :cond_0

    const-wide/16 v2, 0x1f4

    .line 68
    :try_start_1
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V

    .line 69
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 71
    :catch_0
    :try_start_2
    iput-object v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    .line 74
    :cond_0
    :goto_0
    iput-object v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    .line 76
    :try_start_3
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 78
    :goto_1
    iput-object v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    return-void

    :goto_2
    iput-object v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    .line 79
    throw v0
.end method

.method public static getInstance()Lcom/yftech/bsvservice/util/AudioTrackManager;
    .locals 2

    .line 50
    sget-object v0, Lcom/yftech/bsvservice/util/AudioTrackManager;->mInstance:Lcom/yftech/bsvservice/util/AudioTrackManager;

    if-nez v0, :cond_1

    .line 51
    const-class v0, Lcom/yftech/bsvservice/util/AudioTrackManager;

    monitor-enter v0

    .line 52
    :try_start_0
    sget-object v1, Lcom/yftech/bsvservice/util/AudioTrackManager;->mInstance:Lcom/yftech/bsvservice/util/AudioTrackManager;

    if-nez v1, :cond_0

    .line 53
    new-instance v1, Lcom/yftech/bsvservice/util/AudioTrackManager;

    invoke-direct {v1}, Lcom/yftech/bsvservice/util/AudioTrackManager;-><init>()V

    sput-object v1, Lcom/yftech/bsvservice/util/AudioTrackManager;->mInstance:Lcom/yftech/bsvservice/util/AudioTrackManager;

    .line 55
    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 57
    :cond_1
    :goto_0
    sget-object v0, Lcom/yftech/bsvservice/util/AudioTrackManager;->mInstance:Lcom/yftech/bsvservice/util/AudioTrackManager;

    return-object v0
.end method

.method private setPath(Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 129
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 130
    new-instance p1, Ljava/io/DataInputStream;

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {p1, v1}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    iput-object p1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->dis:Ljava/io/DataInputStream;

    return-void
.end method

.method private startThread()V
    .locals 2

    .line 86
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/AudioTrackManager;->destroyThread()V

    const/4 v0, 0x1

    .line 87
    iput-boolean v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->isStart:Z

    .line 88
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    if-nez v0, :cond_0

    .line 89
    new-instance v0, Ljava/lang/Thread;

    iget-object v1, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->recordRunnable:Ljava/lang/Runnable;

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    .line 90
    iget-object p0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->playThread:Ljava/lang/Thread;

    invoke-virtual {p0}, Ljava/lang/Thread;->start()V

    :cond_0
    return-void
.end method


# virtual methods
.method public startPlay(Ljava/lang/String;)V
    .locals 0

    .line 140
    :try_start_0
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/util/AudioTrackManager;->setPath(Ljava/lang/String;)V

    .line 141
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/AudioTrackManager;->startThread()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 143
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public stopPlay()V
    .locals 1

    .line 152
    :try_start_0
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/AudioTrackManager;->destroyThread()V

    .line 153
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->audioTrack:Landroid/media/AudioTrack;

    if-eqz v0, :cond_0

    .line 155
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->audioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->pause()V

    .line 156
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->audioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->flush()V

    .line 157
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->audioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->release()V

    const/4 v0, 0x0

    .line 158
    iput-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->audioTrack:Landroid/media/AudioTrack;

    .line 160
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->dis:Ljava/io/DataInputStream;

    if-eqz v0, :cond_1

    .line 161
    iget-object p0, p0, Lcom/yftech/bsvservice/util/AudioTrackManager;->dis:Ljava/io/DataInputStream;

    invoke-virtual {p0}, Ljava/io/DataInputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 164
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    :goto_0
    return-void
.end method
