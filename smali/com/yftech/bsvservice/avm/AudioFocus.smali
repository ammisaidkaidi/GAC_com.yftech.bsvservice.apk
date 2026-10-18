.class public Lcom/yftech/bsvservice/avm/AudioFocus;
.super Ljava/lang/Object;
.source "AudioFocus.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;,
        Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;,
        Lcom/yftech/bsvservice/avm/AudioFocus$SingletonFactory;
    }
.end annotation


# static fields
.field private static final KEEP_MUTE_WARNING_CLOSE:I = 0x0

.field private static final KEEP_MUTE_WARNING_DOWN:I = 0x2

.field private static final KEEP_MUTE_WARNING_OPEN:I = 0x1

.field private static final KEY_KEEP_MUTE_WARNING_ENABLE:Ljava/lang/String; = "Keep_Mute_Warning_Enable"

.field private static final TAG:Ljava/lang/String; = "AudioFocus"


# instance fields
.field audioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

.field avmAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

.field bAvmMuteMusicMedia:Z

.field bCanActiveMuteMusicMedia:Z

.field bIsRequestAvmFocus:Z

.field bIsRequestCanActiveFocus:Z

.field bIsRequestRadarFocus:Z

.field bIsRequestRvcFocus:Z

.field bRvcMuteMusicMedia:Z

.field canAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

.field mAvmFocusRequest:Landroid/media/AudioFocusRequest;

.field mCanActiveFocusRequest:Landroid/media/AudioFocusRequest;

.field private mCarDataCallback:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;

.field private mCarIcmListener:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;

.field private mIsKeepMuteWarningEnabled:Z

.field private mKeepMuteWarning:I

.field mRadarFocusRequest:Landroid/media/AudioFocusRequest;

.field mRvcFocusRequest:Landroid/media/AudioFocusRequest;

.field private m_AudioManager:Landroid/media/AudioManager;

.field mediaVolume:I

.field radarAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    .line 132
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 32
    iput v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mediaVolume:I

    .line 33
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bAvmMuteMusicMedia:Z

    .line 34
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bRvcMuteMusicMedia:Z

    .line 35
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bCanActiveMuteMusicMedia:Z

    .line 37
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestAvmFocus:Z

    .line 38
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRvcFocus:Z

    .line 39
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRadarFocus:Z

    .line 40
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestCanActiveFocus:Z

    const/4 v1, 0x0

    .line 41
    iput-object v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCarDataCallback:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;

    .line 42
    iput-object v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCarIcmListener:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;

    const/4 v2, 0x1

    .line 43
    iput v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mKeepMuteWarning:I

    .line 44
    iput-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mIsKeepMuteWarningEnabled:Z

    .line 162
    new-instance v2, Lcom/yftech/bsvservice/avm/AudioFocus$1;

    invoke-direct {v2, p0}, Lcom/yftech/bsvservice/avm/AudioFocus$1;-><init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V

    iput-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->audioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 180
    new-instance v2, Lcom/yftech/bsvservice/avm/AudioFocus$2;

    invoke-direct {v2, p0}, Lcom/yftech/bsvservice/avm/AudioFocus$2;-><init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V

    iput-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->radarAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 198
    new-instance v2, Lcom/yftech/bsvservice/avm/AudioFocus$3;

    invoke-direct {v2, p0}, Lcom/yftech/bsvservice/avm/AudioFocus$3;-><init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V

    iput-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->avmAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 216
    new-instance v2, Lcom/yftech/bsvservice/avm/AudioFocus$4;

    invoke-direct {v2, p0}, Lcom/yftech/bsvservice/avm/AudioFocus$4;-><init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V

    iput-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->canAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 133
    invoke-static {}, Landroid/security/KeyStore;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "audio"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/media/AudioManager;

    iput-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    .line 135
    invoke-direct {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->getKeepMuteWarning()I

    move-result v2

    iput v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mKeepMuteWarning:I

    .line 136
    new-instance v2, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;

    invoke-direct {v2, p0}, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;-><init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V

    iput-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCarDataCallback:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;

    .line 137
    iget-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCarDataCallback:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarDataCallback;

    invoke-static {v2, v1}, Lcom/yftech/car/data/CarDataManager;->registerCarDataCallback(Lcom/yftech/car/data/CarDataManager$CarDataCallback;Landroid/os/Handler;)V

    .line 139
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarIcmManager;->get()Lcom/yftech/vehicle/sdk/CarIcmManager;

    move-result-object v1

    invoke-virtual {v1}, Lcom/yftech/vehicle/sdk/CarIcmManager;->isKeepMuteWarningEnabled()Z

    move-result v1

    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mIsKeepMuteWarningEnabled:Z

    .line 140
    new-instance v1, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;

    invoke-direct {v1, p0}, Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;-><init>(Lcom/yftech/bsvservice/avm/AudioFocus;)V

    iput-object v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCarIcmListener:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;

    .line 141
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarIcmManager;->get()Lcom/yftech/vehicle/sdk/CarIcmManager;

    move-result-object v1

    iget-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCarIcmListener:Lcom/yftech/bsvservice/avm/AudioFocus$MyCarIcmListener;

    invoke-virtual {v1, v2}, Lcom/yftech/vehicle/sdk/CarIcmManager;->registerListener(Lcom/yftech/vehicle/sdk/CarIcmManager$CarIcmListener;)V

    .line 143
    sget-object v1, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AudioFocus mKeepMuteWarning :"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mKeepMuteWarning:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ",mIsKeepMuteWarningEnabled:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v3, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mIsKeepMuteWarningEnabled:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v2, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 144
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mIsKeepMuteWarningEnabled:Z

    if-eqz v0, :cond_0

    .line 145
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->requestCanActiveFocus()I

    goto :goto_0

    .line 147
    :cond_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->abandonCanActiveFocus()V

    :goto_0
    return-void
.end method

.method private InterruptMediaType()I
    .locals 4

    .line 60
    invoke-direct {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->getKeepMuteWarning()I

    move-result v0

    .line 61
    iput v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mKeepMuteWarning:I

    .line 62
    sget-object p0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "keepMuteWarning:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p0, 0x2

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    move p0, v1

    goto :goto_0

    :cond_0
    if-ne v0, p0, :cond_1

    goto :goto_0

    :cond_1
    move p0, v2

    .line 71
    :goto_0
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Interrupt type:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return p0
.end method

.method static synthetic access$100()Ljava/lang/String;
    .locals 1

    .line 17
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$200(Lcom/yftech/bsvservice/avm/AudioFocus;)I
    .locals 0

    .line 17
    iget p0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mKeepMuteWarning:I

    return p0
.end method

.method static synthetic access$202(Lcom/yftech/bsvservice/avm/AudioFocus;I)I
    .locals 0

    .line 17
    iput p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mKeepMuteWarning:I

    return p1
.end method

.method static synthetic access$300(Lcom/yftech/bsvservice/avm/AudioFocus;)Z
    .locals 0

    .line 17
    iget-boolean p0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mIsKeepMuteWarningEnabled:Z

    return p0
.end method

.method static synthetic access$302(Lcom/yftech/bsvservice/avm/AudioFocus;Z)Z
    .locals 0

    .line 17
    iput-boolean p1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mIsKeepMuteWarningEnabled:Z

    return p1
.end method

.method public static getInstance()Lcom/yftech/bsvservice/avm/AudioFocus;
    .locals 1

    .line 85
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus$SingletonFactory;->access$000()Lcom/yftech/bsvservice/avm/AudioFocus;

    move-result-object v0

    return-object v0
.end method

.method private getKeepMuteWarning()I
    .locals 3

    .line 49
    new-instance p0, Lcom/yftech/car/data/CarData;

    new-instance v0, Lcom/yftech/car/data/CarData$CarDataEntry;

    const-string v1, "Keep_Mute_Warning_Enable"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/yftech/car/data/CarData$CarDataEntry;-><init>(Ljava/lang/String;I)V

    invoke-direct {p0, v0}, Lcom/yftech/car/data/CarData;-><init>(Lcom/yftech/car/data/CarData$CarDataEntry;)V

    invoke-static {p0}, Lcom/yftech/car/data/CarDataManager;->get(Lcom/yftech/car/data/CarData;)Lcom/yftech/car/data/CarData;

    move-result-object p0

    if-eqz p0, :cond_0

    const-string v0, "Keep_Mute_Warning_Enable"

    .line 50
    invoke-virtual {p0, v0}, Lcom/yftech/car/data/CarData;->getDataEntry(Ljava/lang/String;)Lcom/yftech/car/data/CarData$CarDataEntry;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v0, "Keep_Mute_Warning_Enable"

    .line 51
    invoke-virtual {p0, v0}, Lcom/yftech/car/data/CarData;->getDataEntry(Ljava/lang/String;)Lcom/yftech/car/data/CarData$CarDataEntry;

    move-result-object p0

    invoke-virtual {p0}, Lcom/yftech/car/data/CarData$CarDataEntry;->getValueInt()I

    move-result p0

    .line 52
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getKeepMuteWarning value:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const/4 p0, 0x1

    :goto_0
    return p0
.end method


# virtual methods
.method public declared-synchronized abandonCanActiveFocus()V
    .locals 5

    monitor-enter p0

    .line 434
    :try_start_0
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bCanActiveMuteMusicMedia:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 435
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    const/4 v2, 0x3

    const/16 v3, 0x64

    invoke-virtual {v0, v2, v3, v1}, Landroid/media/AudioManager;->adjustStreamVolume(III)V

    .line 436
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bCanActiveMuteMusicMedia:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 437
    monitor-exit p0

    return-void

    .line 439
    :cond_0
    :try_start_1
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestCanActiveFocus:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v0, :cond_1

    monitor-exit p0

    return-void

    .line 440
    :cond_1
    :try_start_2
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCanActiveFocusRequest:Landroid/media/AudioFocusRequest;

    if-eqz v0, :cond_2

    .line 441
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCanActiveFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->abandonAudioFocusRequest(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 442
    sget-object v2, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "abandonCanActiveFocus ret:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 445
    :cond_2
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    const-string v2, "audioFocus abandonCanActiveFocus"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 446
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestCanActiveFocus:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 447
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 433
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized abandonRadarFocus()V
    .locals 5

    monitor-enter p0

    .line 386
    :try_start_0
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRadarFocusRequest:Landroid/media/AudioFocusRequest;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 387
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRadarFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->abandonAudioFocusRequest(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 388
    sget-object v2, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "abandonRadarFocus ret:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 391
    :cond_0
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    const-string v2, "audioFocus abandonRadarFocus"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 392
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRadarFocus:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 393
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 385
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized abondAvmFocus()V
    .locals 5

    monitor-enter p0

    .line 279
    :try_start_0
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bAvmMuteMusicMedia:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 280
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    const/4 v2, 0x3

    const/16 v3, 0x64

    invoke-virtual {v0, v2, v3, v1}, Landroid/media/AudioManager;->adjustStreamVolume(III)V

    .line 281
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bAvmMuteMusicMedia:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 282
    monitor-exit p0

    return-void

    .line 284
    :cond_0
    :try_start_1
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestAvmFocus:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v0, :cond_1

    monitor-exit p0

    return-void

    .line 285
    :cond_1
    :try_start_2
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mAvmFocusRequest:Landroid/media/AudioFocusRequest;

    if-eqz v0, :cond_2

    .line 286
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mAvmFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->abandonAudioFocusRequest(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 287
    sget-object v2, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "abondAvmFocus ret:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 290
    :cond_2
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    const-string v2, "audioFocus abondAvmFocus"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 291
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestAvmFocus:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 292
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 278
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized abondRvcFocus()V
    .locals 5

    monitor-enter p0

    .line 338
    :try_start_0
    iget-boolean v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bRvcMuteMusicMedia:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 339
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    const/4 v2, 0x3

    const/16 v3, 0x64

    invoke-virtual {v0, v2, v3, v1}, Landroid/media/AudioManager;->adjustStreamVolume(III)V

    .line 340
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bRvcMuteMusicMedia:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 341
    monitor-exit p0

    return-void

    .line 343
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRvcFocusRequest:Landroid/media/AudioFocusRequest;

    if-eqz v0, :cond_1

    .line 344
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRvcFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v2}, Landroid/media/AudioManager;->abandonAudioFocusRequest(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 345
    sget-object v2, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "abondRvcFocus ret:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 347
    :cond_1
    iput-boolean v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRvcFocus:Z

    .line 349
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    const-string v2, "audioFocus abondRvcFocus"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 350
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    .line 337
    monitor-exit p0

    throw v0
.end method

.method isCarplayCertificate()Z
    .locals 4

    const-string p0, "persist.sys.carplay.certificate"

    const-string v0, "0"

    .line 153
    invoke-static {p0, v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 154
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " persist.sys.carplay.certificate :"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v0, "1"

    .line 155
    invoke-virtual {p0, v0}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    if-nez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    move p0, v2

    .line 158
    :goto_0
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " isCarplayCertificate :"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return p0
.end method

.method public declared-synchronized requestAvmFocus()I
    .locals 6

    monitor-enter p0

    .line 237
    :try_start_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->isCarplayCertificate()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    .line 241
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    const/4 v3, 0x3

    const/16 v4, -0x64

    invoke-virtual {v0, v3, v4, v1}, Landroid/media/AudioManager;->adjustStreamVolume(III)V

    .line 242
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bAvmMuteMusicMedia:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 243
    monitor-exit p0

    return v1

    .line 249
    :cond_0
    :try_start_1
    invoke-direct {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->InterruptMediaType()I

    move-result v0

    if-ne v0, v2, :cond_1

    .line 251
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0x1d

    .line 252
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 253
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v3, 0x2

    if-ne v0, v3, :cond_2

    .line 255
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0xe

    .line 256
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 257
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    .line 259
    :cond_2
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0xc

    .line 260
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 261
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    .line 264
    :goto_0
    new-instance v3, Landroid/media/AudioFocusRequest$Builder;

    invoke-direct {v3, v2}, Landroid/media/AudioFocusRequest$Builder;-><init>(I)V

    .line 265
    invoke-virtual {v3, v2}, Landroid/media/AudioFocusRequest$Builder;->setWillPauseWhenDucked(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    .line 266
    invoke-virtual {v3, v2}, Landroid/media/AudioFocusRequest$Builder;->setAcceptsDelayedFocusGain(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->avmAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 267
    invoke-virtual {v3, v4}, Landroid/media/AudioFocusRequest$Builder;->setOnAudioFocusChangeListener(Landroid/media/AudioManager$OnAudioFocusChangeListener;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    .line 268
    invoke-virtual {v3, v0}, Landroid/media/AudioFocusRequest$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v0

    .line 269
    invoke-virtual {v0}, Landroid/media/AudioFocusRequest$Builder;->build()Landroid/media/AudioFocusRequest;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mAvmFocusRequest:Landroid/media/AudioFocusRequest;

    .line 270
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v3, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mAvmFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v3}, Landroid/media/AudioManager;->requestAudioFocus(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 272
    sget-object v3, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "requestAvmFocus ret:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v4, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 273
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestAvmFocus:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 274
    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    .line 236
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized requestCanActiveFocus()I
    .locals 6

    monitor-enter p0

    .line 397
    :try_start_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->isCarplayCertificate()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    .line 398
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    const/4 v3, 0x3

    const/16 v4, -0x64

    invoke-virtual {v0, v3, v4, v1}, Landroid/media/AudioManager;->adjustStreamVolume(III)V

    .line 399
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bCanActiveMuteMusicMedia:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 400
    monitor-exit p0

    return v1

    .line 406
    :cond_0
    :try_start_1
    invoke-direct {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->InterruptMediaType()I

    move-result v0

    const/4 v3, 0x2

    if-ne v0, v2, :cond_1

    .line 408
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v4, 0x1c

    .line 409
    invoke-virtual {v0, v4}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 410
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    :cond_1
    if-ne v0, v3, :cond_2

    .line 412
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v4, 0x1e

    .line 413
    invoke-virtual {v0, v4}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 414
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    .line 416
    :cond_2
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/4 v4, 0x4

    .line 417
    invoke-virtual {v0, v4}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 418
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    .line 420
    :goto_0
    new-instance v4, Landroid/media/AudioFocusRequest$Builder;

    invoke-direct {v4, v3}, Landroid/media/AudioFocusRequest$Builder;-><init>(I)V

    .line 421
    invoke-virtual {v4, v2}, Landroid/media/AudioFocusRequest$Builder;->setWillPauseWhenDucked(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    .line 422
    invoke-virtual {v3, v2}, Landroid/media/AudioFocusRequest$Builder;->setAcceptsDelayedFocusGain(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->canAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 423
    invoke-virtual {v3, v4}, Landroid/media/AudioFocusRequest$Builder;->setOnAudioFocusChangeListener(Landroid/media/AudioManager$OnAudioFocusChangeListener;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    .line 424
    invoke-virtual {v3, v0}, Landroid/media/AudioFocusRequest$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v0

    .line 425
    invoke-virtual {v0}, Landroid/media/AudioFocusRequest$Builder;->build()Landroid/media/AudioFocusRequest;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCanActiveFocusRequest:Landroid/media/AudioFocusRequest;

    .line 426
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v3, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mCanActiveFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v3}, Landroid/media/AudioManager;->requestAudioFocus(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 428
    sget-object v3, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "requestCanActiveFocus type:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v4, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 429
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestCanActiveFocus:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 430
    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    .line 396
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized requestRadarFocus()I
    .locals 5

    monitor-enter p0

    .line 358
    :try_start_0
    invoke-direct {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->InterruptMediaType()I

    move-result v0

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    .line 360
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0x1c

    .line 361
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 362
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    :cond_0
    if-ne v0, v1, :cond_1

    .line 364
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0x1e

    .line 365
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 366
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    .line 368
    :cond_1
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/4 v3, 0x4

    .line 369
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 370
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    .line 372
    :goto_0
    new-instance v3, Landroid/media/AudioFocusRequest$Builder;

    invoke-direct {v3, v1}, Landroid/media/AudioFocusRequest$Builder;-><init>(I)V

    .line 373
    invoke-virtual {v3, v2}, Landroid/media/AudioFocusRequest$Builder;->setWillPauseWhenDucked(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v1

    .line 374
    invoke-virtual {v1, v2}, Landroid/media/AudioFocusRequest$Builder;->setAcceptsDelayedFocusGain(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v1

    iget-object v3, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->radarAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 375
    invoke-virtual {v1, v3}, Landroid/media/AudioFocusRequest$Builder;->setOnAudioFocusChangeListener(Landroid/media/AudioManager$OnAudioFocusChangeListener;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v1

    .line 376
    invoke-virtual {v1, v0}, Landroid/media/AudioFocusRequest$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v0

    .line 377
    invoke-virtual {v0}, Landroid/media/AudioFocusRequest$Builder;->build()Landroid/media/AudioFocusRequest;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRadarFocusRequest:Landroid/media/AudioFocusRequest;

    .line 378
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v1, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRadarFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->requestAudioFocus(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 380
    sget-object v1, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "requestRadarFocus type:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 381
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRadarFocus:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 382
    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    .line 353
    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized requestRvcFocus()I
    .locals 6

    monitor-enter p0

    .line 297
    :try_start_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->isCarplayCertificate()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    .line 298
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    const/4 v3, 0x3

    const/16 v4, -0x64

    invoke-virtual {v0, v3, v4, v1}, Landroid/media/AudioManager;->adjustStreamVolume(III)V

    .line 299
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bRvcMuteMusicMedia:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 300
    monitor-exit p0

    return v1

    .line 306
    :cond_0
    :try_start_1
    invoke-direct {p0}, Lcom/yftech/bsvservice/avm/AudioFocus;->InterruptMediaType()I

    move-result v0

    if-ne v0, v2, :cond_1

    .line 308
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0x1d

    .line 309
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 310
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v3, 0x2

    if-ne v0, v3, :cond_2

    .line 312
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0xe

    .line 313
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 314
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    goto :goto_0

    .line 316
    :cond_2
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v3, 0xc

    .line 317
    invoke-virtual {v0, v3}, Landroid/media/AudioAttributes$Builder;->setLegacyStreamType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 318
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    .line 320
    :goto_0
    new-instance v3, Landroid/media/AudioFocusRequest$Builder;

    invoke-direct {v3, v2}, Landroid/media/AudioFocusRequest$Builder;-><init>(I)V

    .line 321
    invoke-virtual {v3, v2}, Landroid/media/AudioFocusRequest$Builder;->setWillPauseWhenDucked(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    .line 322
    invoke-virtual {v3, v2}, Landroid/media/AudioFocusRequest$Builder;->setAcceptsDelayedFocusGain(Z)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->audioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 323
    invoke-virtual {v3, v4}, Landroid/media/AudioFocusRequest$Builder;->setOnAudioFocusChangeListener(Landroid/media/AudioManager$OnAudioFocusChangeListener;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v3

    .line 324
    invoke-virtual {v3, v0}, Landroid/media/AudioFocusRequest$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/AudioFocusRequest$Builder;

    move-result-object v0

    .line 325
    invoke-virtual {v0}, Landroid/media/AudioFocusRequest$Builder;->build()Landroid/media/AudioFocusRequest;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRvcFocusRequest:Landroid/media/AudioFocusRequest;

    .line 326
    iget-object v0, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->m_AudioManager:Landroid/media/AudioManager;

    iget-object v3, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->mRvcFocusRequest:Landroid/media/AudioFocusRequest;

    invoke-virtual {v0, v3}, Landroid/media/AudioManager;->requestAudioFocus(Landroid/media/AudioFocusRequest;)I

    move-result v0

    .line 331
    sget-object v3, Lcom/yftech/bsvservice/avm/AudioFocus;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "requestRvcFocus ret:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v4, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 332
    iput-boolean v2, p0, Lcom/yftech/bsvservice/avm/AudioFocus;->bIsRequestRvcFocus:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 333
    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    .line 296
    monitor-exit p0

    throw v0
.end method
