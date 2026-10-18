.class public Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;
.super Lcom/yftech/vehicle/sdk/CarDeviceManager$CarDeviceListener;
.source "BSVWindow.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/windowutil/BSVWindow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "MyCarDeviceListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/windowutil/BSVWindow;


# direct methods
.method public constructor <init>(Lcom/yftech/bsvservice/windowutil/BSVWindow;)V
    .locals 0

    .line 67
    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;->this$0:Lcom/yftech/bsvservice/windowutil/BSVWindow;

    invoke-direct {p0}, Lcom/yftech/vehicle/sdk/CarDeviceManager$CarDeviceListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onBSVDisplayStateChanged(Lcom/yftech/vehicle/internal/adapter/IBaseApi$EnableState;)V
    .locals 4

    .line 69
    invoke-static {}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->access$000()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onBSVDisplayStateChanged:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 70
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;->this$0:Lcom/yftech/bsvservice/windowutil/BSVWindow;

    sget-object v1, Lcom/yftech/vehicle/internal/adapter/IBaseApi$EnableState;->ENABLED:Lcom/yftech/vehicle/internal/adapter/IBaseApi$EnableState;

    if-ne p1, v1, :cond_0

    const/4 v2, 0x1

    :cond_0
    invoke-static {v0, v2}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->access$102(Lcom/yftech/bsvservice/windowutil/BSVWindow;Z)Z

    .line 71
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;->this$0:Lcom/yftech/bsvservice/windowutil/BSVWindow;

    invoke-static {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->access$100(Lcom/yftech/bsvservice/windowutil/BSVWindow;)Z

    move-result p0

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onDisplayState(Z)V

    return-void
.end method
