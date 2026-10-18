.class public interface abstract Lcom/yftech/bsvservice/avm/AVMMonitor$ICameraMonitorListener;
.super Ljava/lang/Object;
.source "AVMMonitor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/avm/AVMMonitor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "ICameraMonitorListener"
.end annotation


# virtual methods
.method public abstract onCameraMonitorLoading(Z)V
.end method

.method public abstract onCameraMonitorNoSignal()V
.end method

.method public abstract onCameraMonitorReady()V
.end method

.method public abstract onCameraMonitorReqHide()V
.end method

.method public abstract onCameraMonitorReqShow()V
.end method

.method public abstract onCameraMonitorResumeSignal()V
.end method
