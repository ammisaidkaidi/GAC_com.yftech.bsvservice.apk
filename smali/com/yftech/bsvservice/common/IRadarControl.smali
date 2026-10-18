.class public interface abstract Lcom/yftech/bsvservice/common/IRadarControl;
.super Ljava/lang/Object;
.source "IRadarControl.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/common/IRadarControl$IRadarListener;
    }
.end annotation


# virtual methods
.method public abstract getRadarInfo()Lcom/yftech/bsvservice/common/CameraDataDef$RadarInfo;
.end method

.method public abstract isFrontRadarErr()Z
.end method

.method public abstract isRearRadarErr()Z
.end method

.method public abstract requestRadarClose()Z
.end method

.method public abstract requestRadarOpen()Z
.end method

.method public abstract setRadarListener(Lcom/yftech/bsvservice/common/IRadarControl$IRadarListener;)V
.end method
