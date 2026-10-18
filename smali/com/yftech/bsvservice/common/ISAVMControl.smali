.class public interface abstract Lcom/yftech/bsvservice/common/ISAVMControl;
.super Ljava/lang/Object;
.source "ISAVMControl.java"

# interfaces
.implements Lcom/yftech/bsvservice/common/ICameraControl;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/common/ISAVMControl$ISAVMControlListener;
    }
.end annotation


# virtual methods
.method public abstract replyAPAShowState(Z)Z
.end method

.method public abstract sendTouchToAVM(FFI)Z
.end method

.method public abstract setSAVMControlListener(Lcom/yftech/bsvservice/common/ISAVMControl$ISAVMControlListener;)V
.end method
