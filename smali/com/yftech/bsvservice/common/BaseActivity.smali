.class public Lcom/yftech/bsvservice/common/BaseActivity;
.super Landroid/app/Activity;
.source "BaseActivity.java"


# static fields
.field private static DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "BaseActivity"


# instance fields
.field private final mUIHandler:Landroid/os/Handler;

.field private final mUiThread:Ljava/lang/Thread;

.field private mWorkerHandler:Landroid/os/Handler;

.field private mWorkerThreadID:J


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 15
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 19
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mUIHandler:Landroid/os/Handler;

    .line 20
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mUIHandler:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mUiThread:Ljava/lang/Thread;

    const-wide/16 v0, -0x1

    .line 23
    iput-wide v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerThreadID:J

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    .line 27
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 29
    iget-object p1, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    if-nez p1, :cond_0

    .line 30
    sget-object p1, Lcom/yftech/bsvservice/common/BaseActivity;->TAG:Ljava/lang/String;

    invoke-static {p1}, Lcom/yftech/bsvservice/util/HandlerThreadHandler;->createHandler(Ljava/lang/String;)Lcom/yftech/bsvservice/util/HandlerThreadHandler;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    .line 31
    iget-object p1, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    invoke-virtual {p1}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object p1

    invoke-virtual {p1}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Thread;->getId()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerThreadID:J

    :cond_0
    return-void
.end method

.method protected declared-synchronized onDestroy()V
    .locals 1

    monitor-enter p0

    .line 43
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 45
    :try_start_1
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->quit()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    const/4 v0, 0x0

    .line 49
    :try_start_2
    iput-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    .line 51
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 52
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 42
    monitor-exit p0

    throw v0
.end method

.method protected onPause()V
    .locals 0

    .line 37
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    return-void
.end method

.method protected final declared-synchronized queueEvent(Ljava/lang/Runnable;J)V
    .locals 2

    monitor-enter p0

    if-eqz p1, :cond_3

    .line 76
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    goto :goto_1

    .line 78
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    invoke-virtual {v0, p1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-lez v0, :cond_1

    .line 80
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    invoke-virtual {v0, p1, p2, p3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    .line 81
    :cond_1
    iget-wide p2, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerThreadID:J

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getId()J

    move-result-wide v0

    cmp-long p2, p2, v0

    if-nez p2, :cond_2

    .line 82
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 84
    :cond_2
    iget-object p2, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    invoke-virtual {p2, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 89
    :catch_0
    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    .line 75
    monitor-exit p0

    throw p1

    .line 76
    :cond_3
    :goto_1
    monitor-exit p0

    return-void
.end method

.method protected final declared-synchronized removeEvent(Ljava/lang/Runnable;)V
    .locals 1

    monitor-enter p0

    if-nez p1, :cond_0

    .line 92
    monitor-exit p0

    return-void

    .line 94
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mWorkerHandler:Landroid/os/Handler;

    invoke-virtual {v0, p1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 91
    monitor-exit p0

    throw p1

    .line 98
    :catch_0
    :goto_0
    monitor-exit p0

    return-void
.end method

.method public final removeFromUiThread(Ljava/lang/Runnable;)V
    .locals 0

    if-nez p1, :cond_0

    return-void

    .line 72
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mUIHandler:Landroid/os/Handler;

    invoke-virtual {p0, p1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method

.method public final runOnUiThread(Ljava/lang/Runnable;J)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    .line 58
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mUIHandler:Landroid/os/Handler;

    invoke-virtual {v0, p1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-gtz v0, :cond_2

    .line 59
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    iget-object v1, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mUiThread:Ljava/lang/Thread;

    if-eq v0, v1, :cond_1

    goto :goto_0

    .line 63
    :cond_1
    :try_start_0
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p0

    .line 65
    sget-object p1, Lcom/yftech/bsvservice/common/BaseActivity;->TAG:Ljava/lang/String;

    invoke-static {p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 60
    :cond_2
    :goto_0
    iget-object p0, p0, Lcom/yftech/bsvservice/common/BaseActivity;->mUIHandler:Landroid/os/Handler;

    invoke-virtual {p0, p1, p2, p3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :goto_1
    return-void
.end method
