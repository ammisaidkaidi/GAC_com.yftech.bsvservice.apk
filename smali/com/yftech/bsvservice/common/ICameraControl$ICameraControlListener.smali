.class public interface abstract Lcom/yftech/bsvservice/common/ICameraControl$ICameraControlListener;
.super Ljava/lang/Object;
.source "ICameraControl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/common/ICameraControl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "ICameraControlListener"
.end annotation


# virtual methods
.method public abstract onAPADrvReq(Lcom/yftech/bsvservice/common/CameraDataDef$APAInfo;)V
.end method

.method public abstract onCameraCommTimeOut(Z)V
.end method

.method public abstract onCameraOpStateErr(Z)V
.end method

.method public abstract onCameraReqHide()V
.end method

.method public abstract onCameraReqShow()V
.end method

.method public abstract onCameraSystemErr(Z)V
.end method

.method public abstract onDisplayState(Z)V
.end method

.method public abstract onGearStateChange(I)V
.end method

.method public abstract onSteerWheelAngel(F)V
.end method
