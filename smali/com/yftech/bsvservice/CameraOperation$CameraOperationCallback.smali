.class public interface abstract Lcom/yftech/bsvservice/CameraOperation$CameraOperationCallback;
.super Ljava/lang/Object;
.source "CameraOperation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraOperation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "CameraOperationCallback"
.end annotation


# virtual methods
.method public abstract onOperationFailed(ILjava/lang/String;I)V
.end method

.method public abstract onOperationSuccess(ILjava/lang/String;)V
.end method
