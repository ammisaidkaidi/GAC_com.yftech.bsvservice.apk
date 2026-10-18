.class public Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;
.super Lcom/yftech/vehicle/sdk/CarIcmManager$CarIcmListener;
.source "AudioFocus.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/avm/AudioFocus;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "MyCarIcmListener"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/avm/AudioFocus;


# direct methods
.method public constructor <init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V
    .locals 0

    .line 118
    iput-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-direct {p0}, Lcom/yftech/vehicle/sdk/CarIcmManager$CarIcmListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onKeepMuteWarningStateChanged(Z)V
    .locals 3

    .line 120
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$100()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onKeepMuteWarningStateChanged  isEnabled:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 121
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-static {v0}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$300(Lcom/yftech/bsvservice/avm/AudioFocus;)Z

    move-result v0

    if-eq p1, v0, :cond_1

    .line 122
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-static {v0, p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$302(Lcom/yftech/bsvservice/avm/AudioFocus;Z)Z

    .line 123
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-static {p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$300(Lcom/yftech/bsvservice/avm/AudioFocus;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 124
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->requestCanActiveFocus()I

    goto :goto_0

    .line 126
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->abandonCanActiveFocus()V

    :cond_1
    :goto_0
    return-void
.end method
