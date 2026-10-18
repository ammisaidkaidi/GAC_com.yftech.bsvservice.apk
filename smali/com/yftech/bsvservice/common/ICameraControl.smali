.class public interface abstract Lcom/yftech/bsvservice/common/ICameraControl;
.super Ljava/lang/Object;
.source "ICameraControl.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/common/ICameraControl$ICameraControlListener;
    }
.end annotation


# virtual methods
.method public abstract getSteerWheelAngle()F
.end method

.method public abstract isCameraOpErr()Z
.end method

.method public abstract isCommTimeOut()Z
.end method

.method public abstract requestCanSync()Z
.end method

.method public abstract requestHide()Z
.end method

.method public abstract requestShow()Z
.end method

.method public abstract setCameraControlListener(Lcom/yftech/bsvservice/common/ICameraControl$ICameraControlListener;)V
.end method
