.class public interface abstract Lcom/yftech/bsvservice/common/ISAVMControl$ISAVMControlListener;
.super Ljava/lang/Object;
.source "ISAVMControl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/common/ISAVMControl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "ISAVMControlListener"
.end annotation


# virtual methods
.method public abstract onSAvmCameraInputErr(I)V
.end method

.method public abstract onSAvmEOLTestModeChange(Z)V
.end method

.method public abstract onSAvmGuideLineChange(I)V
.end method

.method public abstract onSAvmGuideLineErr(Z)V
.end method

.method public abstract onSAvmRadarErr(Z)V
.end method

.method public abstract onSAvmSingleViewChange(I)V
.end method
