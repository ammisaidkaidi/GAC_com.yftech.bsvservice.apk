.class public Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;
.super Lcom/yftech/car/data/CarDataManager$CarDataCallback;
.source "AudioFocus.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/avm/AudioFocus;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "MyCarDataCallback"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/avm/AudioFocus;


# direct methods
.method public constructor <init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V
    .locals 0

    .line 89
    iput-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-direct {p0}, Lcom/yftech/car/data/CarDataManager$CarDataCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onCarDataChanged(Lcom/yftech/car/data/CarData;)V
    .locals 4

    if-eqz p1, :cond_2

    const-string v0, "Keep_Mute_Warning_Enable"

    .line 92
    invoke-virtual {p1, v0}, Lcom/yftech/car/data/CarData;->getDataEntry(Ljava/lang/String;)Lcom/yftech/car/data/CarData$CarDataEntry;

    move-result-object v0

    if-eqz v0, :cond_2

    const-string v0, "Keep_Mute_Warning_Enable"

    .line 93
    invoke-virtual {p1, v0}, Lcom/yftech/car/data/CarData;->getDataEntry(Ljava/lang/String;)Lcom/yftech/car/data/CarData$CarDataEntry;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/car/data/CarData$CarDataEntry;->getValueInt()I

    move-result p1

    .line 94
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$100()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onCarDataChanged getKeepMuteWarning value:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 95
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-static {v0}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$200(Lcom/yftech/bsvservice/avm/AudioFocus;)I

    move-result v0

    if-eq p1, v0, :cond_2

    .line 96
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-static {v0, p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$202(Lcom/yftech/bsvservice/avm/AudioFocus;I)I

    .line 97
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->access$100()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onCarDataChanged bIsRequestCanActiveFocus:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    iget-boolean v1, v1, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestCanActiveFocus:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ",bIsRequestRvcFocus:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    iget-boolean v1, v1, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRvcFocus:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ",bIsRequestRadarFocus:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    iget-boolean v1, v1, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRadarFocus:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 100
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    iget-boolean p1, p1, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestCanActiveFocus:Z

    if-eqz p1, :cond_0

    .line 101
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->abandonCanActiveFocus()V

    .line 102
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->requestCanActiveFocus()I

    .line 104
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    iget-boolean p1, p1, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRvcFocus:Z

    if-eqz p1, :cond_1

    .line 105
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->abondRvcFocus()V

    .line 106
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->requestRvcFocus()I

    .line 108
    :cond_1
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    iget-boolean p1, p1, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRadarFocus:Z

    if-eqz p1, :cond_2

    .line 109
    iget-object p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AudioFocus;->abandonRadarFocus()V

    .line 110
    iget-object p0, p0, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;->this$0:Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->requestRadarFocus()I

    :cond_2
    return-void
.end method
