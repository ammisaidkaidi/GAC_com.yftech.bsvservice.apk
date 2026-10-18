.class Lcom/yftech/bsvservice/BsvService$1;
.super Ljava/lang/Object;
.source "BsvService.java"

# interfaces
.implements Lcom/autochips/backcar/BackCar$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/BsvService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/BsvService;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/BsvService;)V
    .locals 0

    .line 71
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEvent(III)V
    .locals 4

    const-string v0, "BsvService"

    .line 73
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onSignal - event:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v0, 0x1

    if-ne v0, p1, :cond_4

    if-eqz p2, :cond_2

    const-string p1, "BsvService"

    const-string p2, "onSignal():BACKCAR_START"

    .line 76
    new-array p3, v2, [Ljava/lang/Object;

    invoke-static {p1, p2, p3}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$000(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-nez p1, :cond_0

    .line 82
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, v0}, Lcom/yftech/bsvservice/BsvService;->access$102(Lcom/yftech/bsvservice/BsvService;Z)Z

    return-void

    .line 85
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$200(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-nez p1, :cond_1

    .line 86
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, v0}, Lcom/yftech/bsvservice/BsvService;->access$302(Lcom/yftech/bsvservice/BsvService;Z)Z

    const-string p0, "BsvService"

    const-string p1, "start backcar later after qb on"

    .line 87
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 90
    :cond_1
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, v0}, Lcom/yftech/bsvservice/BsvService;->access$402(Lcom/yftech/bsvservice/BsvService;Z)Z

    .line 91
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getDeviceType()I

    .line 97
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/avm/AvmControl;->onBackcarChange(Z)V

    goto/16 :goto_0

    :cond_2
    const-string p1, "BsvService"

    const-string p2, "onSignal():BACKCAR_STOP"

    .line 99
    new-array p3, v2, [Ljava/lang/Object;

    invoke-static {p1, p2, p3}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 100
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$300(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 101
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/BsvService;->access$302(Lcom/yftech/bsvservice/BsvService;Z)Z

    const-string p0, "BsvService"

    const-string p1, "cancel stop backcar"

    .line 102
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 105
    :cond_3
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getDeviceType()I

    .line 115
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0, v2}, Lcom/yftech/bsvservice/BsvService;->access$402(Lcom/yftech/bsvservice/BsvService;Z)Z

    .line 116
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0, v2}, Lcom/yftech/bsvservice/avm/AvmControl;->onBackcarChange(Z)V

    goto/16 :goto_0

    :cond_4
    if-nez p1, :cond_7

    .line 119
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1, v0}, Lcom/yftech/bsvservice/BsvService;->access$002(Lcom/yftech/bsvservice/BsvService;Z)Z

    const-string p1, "sys.bsvservice.run.state"

    const-string p2, "1"

    .line 121
    invoke-static {p1, p2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "BsvService"

    const-string p2, "set sys.bsvservice.run.state 1"

    .line 122
    new-array p3, v2, [Ljava/lang/Object;

    invoke-static {p1, p2, p3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 124
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1}, Lcom/yftech/bsvservice/BsvService;->access$100(Lcom/yftech/bsvservice/BsvService;)Z

    move-result p1

    if-eqz p1, :cond_5

    .line 128
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1, v2}, Lcom/yftech/bsvservice/BsvService;->access$102(Lcom/yftech/bsvservice/BsvService;Z)Z

    .line 129
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    const/4 p2, 0x0

    iput-object p2, p1, Lcom/yftech/bsvservice/BsvService;->mAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 130
    iget-object p1, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p1, p2}, Lcom/yftech/bsvservice/BsvService;->access$502(Lcom/yftech/bsvservice/BsvService;Landroid/media/AudioManager;)Landroid/media/AudioManager;

    .line 132
    :cond_5
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService$1;->this$0:Lcom/yftech/bsvservice/BsvService;

    invoke-static {p0}, Lcom/yftech/bsvservice/BsvService;->access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->notifyExitArm2()V

    .line 134
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->getDeviceType()I

    move-result p0

    const/4 p1, 0x2

    if-ne p0, p1, :cond_6

    .line 135
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraReqShow()V

    :cond_6
    const-string p0, "BsvService"

    const-string p1, "exit arm2 backcar"

    .line 137
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_7
    const/4 p0, 0x3

    if-ne p0, p1, :cond_9

    const-string p0, "BsvService"

    .line 139
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "param2 ="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p3, :cond_8

    const-string p0, "BsvService"

    const-string p1, "handle ARM2 start backcar"

    .line 141
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_8
    const-string p0, "BsvService"

    const-string p1, "handle ARM2 stop backcar"

    .line 144
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_9
    const-string p0, "BsvService"

    const-string p1, "do nothing"

    .line 148
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method
