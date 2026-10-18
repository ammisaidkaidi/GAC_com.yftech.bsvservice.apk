.class public Lcom/yftech/bsvservice/BsvService;
.super Landroid/app/Service;
.source "BsvService.java"


# static fields
.field private static final ACTION_PREQB_OFF:Ljava/lang/String; = "autochips.intent.action.PREQB_POWEROFF"

.field private static final ACTION_PREQB_ON:Ljava/lang/String; = "autochips.intent.action.PREQB_POWERON"

.field private static final ACTION_QB_OFF:Ljava/lang/String; = "autochips.intent.action.QB_POWEROFF"

.field private static final ACTION_QB_ON:Ljava/lang/String; = "autochips.intent.action.QB_POWERON"

.field private static final ADDR_RVC_CAMERA_ID:I = 0x1002d

.field private static final BC_TYPE_ADDR:I = 0x10009

.field private static final NOTIFICATION_CHANNEL_ID_SERVICE:Ljava/lang/String; = "BsvService"

.field private static final NOTIFICATION_ID:I = 0x69

.field private static final TAG:Ljava/lang/String; = "BsvService"

.field private static final TYPE_RVC:I

.field private static gInst:Lcom/yftech/bsvservice/BsvService;


# instance fields
.field private isMetalogoRun:Z

.field mAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

.field private mAudioManager:Landroid/media/AudioManager;

.field private mBackcar:Lcom/autochips/backcar/BackCar;

.field private mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

.field private mCurrentBackcarCameraId:Ljava/lang/String;

.field private mCurrentUserId:I

.field private final mDefaultUncaughtExceptionHandler:Ljava/lang/Thread$UncaughtExceptionHandler;

.field private mHandler:Landroid/os/Handler;

.field private mHasShownTouchInputFilterView:Z

.field private mIsArm2Exited:Z

.field private mIsBackcarOn:Z

.field private mIsQBOn:Z

.field private mIsRVCMode:Z

.field private mListenerSignal:Lcom/autochips/backcar/BackCar$Listener;

.field private mMountUnmountBroadcastReceiver:Landroid/content/BroadcastReceiver;

.field private mNeedStartBackcarAfterQBOn:Z

.field mQBReceiver:Landroid/content/BroadcastReceiver;

.field mUserSwitchObserver:Landroid/app/IUserSwitchObserver;

.field metaZoneCheckRunnable:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 36
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    const/4 v0, 0x1

    .line 55
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvService;->mIsQBOn:Z

    const/4 v0, 0x0

    .line 58
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvService;->mIsBackcarOn:Z

    .line 59
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvService;->mIsRVCMode:Z

    .line 60
    invoke-static {}, Landroid/os/UserHandle;->myUserId()I

    move-result v1

    iput v1, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentUserId:I

    .line 61
    invoke-static {}, Ljava/lang/Thread;->getDefaultUncaughtExceptionHandler()Ljava/lang/Thread$UncaughtExceptionHandler;

    move-result-object v1

    iput-object v1, p0, Lcom/yftech/bsvservice/BsvService;->mDefaultUncaughtExceptionHandler:Ljava/lang/Thread$UncaughtExceptionHandler;

    .line 62
    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    iput-object v1, p0, Lcom/yftech/bsvservice/BsvService;->mHandler:Landroid/os/Handler;

    .line 69
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvService;->isMetalogoRun:Z

    .line 71
    new-instance v0, Lcom/yftech/bsvservice/BsvService$1;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$1;-><init>(Lcom/yftech/bsvservice/BsvService;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mListenerSignal:Lcom/autochips/backcar/BackCar$Listener;

    .line 190
    new-instance v0, Lcom/yftech/bsvservice/BsvService$2;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$2;-><init>(Lcom/yftech/bsvservice/BsvService;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 196
    new-instance v0, Lcom/yftech/bsvservice/BsvService$3;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$3;-><init>(Lcom/yftech/bsvservice/BsvService;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mUserSwitchObserver:Landroid/app/IUserSwitchObserver;

    .line 365
    new-instance v0, Lcom/yftech/bsvservice/BsvService$5;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$5;-><init>(Lcom/yftech/bsvservice/BsvService;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->metaZoneCheckRunnable:Ljava/lang/Runnable;

    .line 507
    new-instance v0, Lcom/yftech/bsvservice/BsvService$6;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$6;-><init>(Lcom/yftech/bsvservice/BsvService;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mMountUnmountBroadcastReceiver:Landroid/content/BroadcastReceiver;

    .line 545
    new-instance v0, Lcom/yftech/bsvservice/BsvService$7;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$7;-><init>(Lcom/yftech/bsvservice/BsvService;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mQBReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method private abandonAudioFocusWhenArm2Exit()V
    .locals 3

    .line 243
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mAudioManager:Landroid/media/AudioManager;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    new-instance v1, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v1}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/4 v2, 0x6

    .line 244
    invoke-virtual {v1, v2}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v1

    .line 245
    invoke-virtual {v1}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v1

    .line 243
    invoke-virtual {v0, p0, v1}, Landroid/media/AudioManager;->abandonAudioFocus(Landroid/media/AudioManager$OnAudioFocusChangeListener;Landroid/media/AudioAttributes;)I

    return-void
.end method

.method static synthetic access$000(Lcom/yftech/bsvservice/BsvService;)Z
    .locals 0

    .line 36
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvService;->mIsArm2Exited:Z

    return p0
.end method

.method static synthetic access$002(Lcom/yftech/bsvservice/BsvService;Z)Z
    .locals 0

    .line 36
    iput-boolean p1, p0, Lcom/yftech/bsvservice/BsvService;->mIsArm2Exited:Z

    return p1
.end method

.method static synthetic access$100(Lcom/yftech/bsvservice/BsvService;)Z
    .locals 0

    .line 36
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvService;->mHasShownTouchInputFilterView:Z

    return p0
.end method

.method static synthetic access$1000(Lcom/yftech/bsvservice/BsvService;)Ljava/lang/Thread$UncaughtExceptionHandler;
    .locals 0

    .line 36
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mDefaultUncaughtExceptionHandler:Ljava/lang/Thread$UncaughtExceptionHandler;

    return-object p0
.end method

.method static synthetic access$102(Lcom/yftech/bsvservice/BsvService;Z)Z
    .locals 0

    .line 36
    iput-boolean p1, p0, Lcom/yftech/bsvservice/BsvService;->mHasShownTouchInputFilterView:Z

    return p1
.end method

.method static synthetic access$1100(Lcom/yftech/bsvservice/BsvService;)Z
    .locals 0

    .line 36
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvService;->isMetalogoRun:Z

    return p0
.end method

.method static synthetic access$1102(Lcom/yftech/bsvservice/BsvService;Z)Z
    .locals 0

    .line 36
    iput-boolean p1, p0, Lcom/yftech/bsvservice/BsvService;->isMetalogoRun:Z

    return p1
.end method

.method static synthetic access$1200(Lcom/yftech/bsvservice/BsvService;)Z
    .locals 0

    .line 36
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvService;->mIsRVCMode:Z

    return p0
.end method

.method static synthetic access$1300(Lcom/yftech/bsvservice/BsvService;)Lcom/autochips/backcar/BackCar;
    .locals 0

    .line 36
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mBackcar:Lcom/autochips/backcar/BackCar;

    return-object p0
.end method

.method static synthetic access$200(Lcom/yftech/bsvservice/BsvService;)Z
    .locals 0

    .line 36
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvService;->mIsQBOn:Z

    return p0
.end method

.method static synthetic access$202(Lcom/yftech/bsvservice/BsvService;Z)Z
    .locals 0

    .line 36
    iput-boolean p1, p0, Lcom/yftech/bsvservice/BsvService;->mIsQBOn:Z

    return p1
.end method

.method static synthetic access$300(Lcom/yftech/bsvservice/BsvService;)Z
    .locals 0

    .line 36
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvService;->mNeedStartBackcarAfterQBOn:Z

    return p0
.end method

.method static synthetic access$302(Lcom/yftech/bsvservice/BsvService;Z)Z
    .locals 0

    .line 36
    iput-boolean p1, p0, Lcom/yftech/bsvservice/BsvService;->mNeedStartBackcarAfterQBOn:Z

    return p1
.end method

.method static synthetic access$400(Lcom/yftech/bsvservice/BsvService;)Z
    .locals 0

    .line 36
    iget-boolean p0, p0, Lcom/yftech/bsvservice/BsvService;->mIsBackcarOn:Z

    return p0
.end method

.method static synthetic access$402(Lcom/yftech/bsvservice/BsvService;Z)Z
    .locals 0

    .line 36
    iput-boolean p1, p0, Lcom/yftech/bsvservice/BsvService;->mIsBackcarOn:Z

    return p1
.end method

.method static synthetic access$502(Lcom/yftech/bsvservice/BsvService;Landroid/media/AudioManager;)Landroid/media/AudioManager;
    .locals 0

    .line 36
    iput-object p1, p0, Lcom/yftech/bsvservice/BsvService;->mAudioManager:Landroid/media/AudioManager;

    return-object p1
.end method

.method static synthetic access$600(Lcom/yftech/bsvservice/BsvService;)Lcom/yftech/bsvservice/BsvServiceImpl;
    .locals 0

    .line 36
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    return-object p0
.end method

.method static synthetic access$700(Lcom/yftech/bsvservice/BsvService;)I
    .locals 0

    .line 36
    iget p0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentUserId:I

    return p0
.end method

.method static synthetic access$702(Lcom/yftech/bsvservice/BsvService;I)I
    .locals 0

    .line 36
    iput p1, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentUserId:I

    return p1
.end method

.method static synthetic access$800(Lcom/yftech/bsvservice/BsvService;)Ljava/lang/String;
    .locals 0

    .line 36
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$900(Lcom/yftech/bsvservice/BsvService;)Landroid/os/Handler;
    .locals 0

    .line 36
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mHandler:Landroid/os/Handler;

    return-object p0
.end method

.method private getBackcarCameraId()Z
    .locals 3

    .line 276
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    .line 279
    :cond_0
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->isRvcMode()Z

    move-result v0

    const/4 v2, 0x0

    if-nez v0, :cond_1

    const-string p0, "BsvService"

    const-string v0, "not ARM1 RVC,skip"

    .line 280
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return v2

    .line 283
    :cond_1
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->getBackCarCameraID()I

    move-result v0

    if-gez v0, :cond_2

    const/4 v0, 0x0

    .line 285
    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    return v2

    .line 288
    :cond_2
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    return v1
.end method

.method private getCameraId()Ljava/lang/String;
    .locals 2

    const-string p0, "null"

    const/4 v0, 0x4

    .line 469
    new-array v0, v0, [I

    const v1, 0x10009

    .line 470
    invoke-static {v1, v0}, Lcom/autochips/metazone/AtcMetazone;->readval(I[I)I

    return-object p0
.end method

.method public static getInstance()Lcom/yftech/bsvservice/BsvService;
    .locals 1

    .line 66
    sget-object v0, Lcom/yftech/bsvservice/BsvService;->gInst:Lcom/yftech/bsvservice/BsvService;

    return-object v0
.end method

.method private initChannel()V
    .locals 4

    const-string v0, "notification"

    .line 475
    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/BsvService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    .line 476
    new-instance v0, Landroid/app/NotificationChannel;

    const-string v1, "BsvService"

    const-string v2, "BsvService"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    invoke-virtual {p0, v0}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    return-void
.end method

.method private isRVCMode()Z
    .locals 3

    .line 314
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->isRvcMode()Z

    move-result v0

    if-nez v0, :cond_0

    const-string p0, "BsvService"

    const-string v0, "not ARM1 RVC!"

    const/4 v1, 0x0

    .line 316
    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v2}, Lcom/yftech/bsvservice/util/LogUtil;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return v1

    :cond_0
    const/4 v0, 0x1

    .line 319
    iput-boolean v0, p0, Lcom/yftech/bsvservice/BsvService;->mIsRVCMode:Z

    return v0
.end method

.method private registerMountUnmountReceiver()V
    .locals 2

    .line 489
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "android.intent.action.MEDIA_BAD_REMOVAL"

    .line 490
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_CHECKING"

    .line 491
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_MOUNTED"

    .line 492
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_NOFS"

    .line 493
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_REMOVED"

    .line 494
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_SHARED"

    .line 495
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_UNMOUNTABLE"

    .line 496
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_UNMOUNTED"

    .line 497
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_EJECT"

    .line 498
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "file"

    .line 499
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addDataScheme(Ljava/lang/String;)V

    .line 500
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvService;->mMountUnmountBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/yftech/bsvservice/BsvService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method private registerQBReceiver()V
    .locals 2

    .line 531
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "autochips.intent.action.QB_POWEROFF"

    .line 532
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "autochips.intent.action.QB_POWERON"

    .line 533
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "autochips.intent.action.PREQB_POWEROFF"

    .line 534
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "autochips.intent.action.PREQB_POWERON"

    .line 535
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.ACTION_SHUTDOWN"

    .line 536
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 537
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvService;->mQBReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/yftech/bsvservice/BsvService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method private requestBackcarAudioFocusForArm2()V
    .locals 4

    .line 236
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mAudioManager:Landroid/media/AudioManager;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mAudioFocusChangeListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    new-instance v1, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v1}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/4 v2, 0x6

    .line 237
    invoke-virtual {v1, v2}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v1

    .line 238
    invoke-virtual {v1}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x4

    .line 236
    invoke-virtual {v0, p0, v1, v3, v2}, Landroid/media/AudioManager;->requestAudioFocus(Landroid/media/AudioManager$OnAudioFocusChangeListener;Landroid/media/AudioAttributes;II)I

    move-result p0

    const-string v0, "BsvService"

    .line 239
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "requestBackcarAudioFocusForArm2, "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method private setUncaughtExceptionHandler()V
    .locals 1

    .line 352
    new-instance v0, Lcom/yftech/bsvservice/BsvService$4;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvService$4;-><init>(Lcom/yftech/bsvservice/BsvService;)V

    invoke-static {v0}, Ljava/lang/Thread;->setDefaultUncaughtExceptionHandler(Ljava/lang/Thread$UncaughtExceptionHandler;)V

    return-void
.end method

.method private startForegroundNotification()V
    .locals 2

    .line 480
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->initChannel()V

    .line 481
    new-instance v0, Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v1, "BsvService"

    invoke-direct {v0, p0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    const-string v1, "BsvService"

    .line 482
    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v1, "BsvService is running"

    .line 483
    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const/high16 v1, 0x7f0a0000

    .line 484
    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 485
    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const/16 v1, 0x69

    invoke-virtual {p0, v1, v0}, Lcom/yftech/bsvservice/BsvService;->startForeground(ILandroid/app/Notification;)V

    return-void
.end method

.method private unRegisterMountUnmountReceiver()V
    .locals 1

    .line 504
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mMountUnmountBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/BsvService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method

.method private unregisterQBReceiver()V
    .locals 1

    .line 541
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mQBReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/BsvService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method


# virtual methods
.method public isPreviewStarted()Z
    .locals 1

    .line 184
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 185
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->isPreviewStarted(Ljava/lang/String;)Z

    move-result p0

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 2

    const-string p1, "BsvService"

    const-string v0, "onBind"

    const/4 v1, 0x0

    .line 456
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 457
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    return-object p0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 2

    .line 462
    invoke-super {p0, p1}, Landroid/app/Service;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 463
    invoke-virtual {p0}, Lcom/yftech/bsvservice/BsvService;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 464
    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->updateBackcarUi()V

    return-void
.end method

.method public onCreate()V
    .locals 4

    const-string v0, "BsvService"

    const-string v1, "onCreate"

    const/4 v2, 0x0

    .line 394
    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 395
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 396
    sput-object p0, Lcom/yftech/bsvservice/BsvService;->gInst:Lcom/yftech/bsvservice/BsvService;

    .line 397
    new-instance v0, Lcom/yftech/bsvservice/BsvServiceImpl;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    const-string v0, "audio"

    .line 398
    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/BsvService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mAudioManager:Landroid/media/AudioManager;

    .line 399
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->startForegroundNotification()V

    .line 400
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->registerMountUnmountReceiver()V

    .line 401
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->registerQBReceiver()V

    .line 402
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->setUncaughtExceptionHandler()V

    .line 403
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->isRVCMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 404
    new-instance v0, Lcom/autochips/backcar/BackCar;

    invoke-direct {v0}, Lcom/autochips/backcar/BackCar;-><init>()V

    iput-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBackcar:Lcom/autochips/backcar/BackCar;

    .line 405
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 406
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 v1, 0x1

    .line 407
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 v1, 0x3

    .line 408
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 409
    iget-object v1, p0, Lcom/yftech/bsvservice/BsvService;->mBackcar:Lcom/autochips/backcar/BackCar;

    iget-object v2, p0, Lcom/yftech/bsvservice/BsvService;->mListenerSignal:Lcom/autochips/backcar/BackCar$Listener;

    invoke-virtual {v1, v2, v0}, Lcom/autochips/backcar/BackCar;->setListener(Lcom/autochips/backcar/BackCar$Listener;Ljava/util/ArrayList;)Z

    .line 411
    new-instance v0, Ljava/lang/Thread;

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvService;->metaZoneCheckRunnable:Ljava/lang/Runnable;

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 412
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 421
    :cond_0
    :try_start_0
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v0

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mUserSwitchObserver:Landroid/app/IUserSwitchObserver;

    const-string v1, "com.yftech.bsvservice"

    invoke-interface {v0, p0, v1}, Landroid/app/IActivityManager;->registerUserSwitchObserver(Landroid/app/IUserSwitchObserver;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onDestroy()V
    .locals 4

    const-string v0, "BsvService"

    const-string v1, "onDestroy"

    const/4 v2, 0x0

    .line 434
    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 435
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 436
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    invoke-virtual {v0}, Lcom/yftech/bsvservice/BsvServiceImpl;->release()V

    .line 437
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->unRegisterMountUnmountReceiver()V

    .line 438
    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->unregisterQBReceiver()V

    .line 440
    :try_start_0
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v0

    iget-object v1, p0, Lcom/yftech/bsvservice/BsvService;->mUserSwitchObserver:Landroid/app/IUserSwitchObserver;

    invoke-interface {v0, v1}, Landroid/app/IActivityManager;->unregisterUserSwitchObserver(Landroid/app/IUserSwitchObserver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 443
    :catch_0
    iget-boolean v0, p0, Lcom/yftech/bsvservice/BsvService;->mIsRVCMode:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 444
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBackcar:Lcom/autochips/backcar/BackCar;

    invoke-virtual {v0, v1, v1}, Lcom/autochips/backcar/BackCar;->setListener(Lcom/autochips/backcar/BackCar$Listener;Ljava/util/ArrayList;)Z

    .line 446
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mDefaultUncaughtExceptionHandler:Ljava/lang/Thread$UncaughtExceptionHandler;

    invoke-static {v0}, Ljava/lang/Thread;->setDefaultUncaughtExceptionHandler(Ljava/lang/Thread$UncaughtExceptionHandler;)V

    .line 447
    iput-object v1, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    const/4 v0, 0x1

    .line 448
    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/BsvService;->stopForeground(Z)V

    const-string p0, "sys.avmservice.run.state"

    const-string v0, "0"

    .line 450
    invoke-static {p0, v0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string p0, "BsvService"

    const-string v0, "set sys.avmservice.run.state 0"

    .line 451
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    const-string p0, "BsvService"

    const-string p1, "onStartCommand"

    const/4 p2, 0x0

    .line 428
    new-array p2, p2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p0, 0x1

    return p0
.end method

.method public startBackCar()V
    .locals 2

    .line 170
    iget v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentUserId:I

    invoke-static {}, Landroid/os/UserHandle;->myUserId()I

    move-result v1

    if-ne v0, v1, :cond_0

    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->getBackcarCameraId()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 171
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->startBackcar(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public startUserPreview()V
    .locals 2

    .line 155
    iget v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentUserId:I

    invoke-static {}, Landroid/os/UserHandle;->myUserId()I

    move-result v1

    if-ne v0, v1, :cond_0

    invoke-direct {p0}, Lcom/yftech/bsvservice/BsvService;->getBackcarCameraId()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 156
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->startUserPreview(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public stopBackCar()V
    .locals 1

    .line 177
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 178
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->stopBackcar(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public stopUserPreview()V
    .locals 1

    .line 163
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 164
    iget-object v0, p0, Lcom/yftech/bsvservice/BsvService;->mBsvServiceImpl:Lcom/yftech/bsvservice/BsvServiceImpl;

    iget-object p0, p0, Lcom/yftech/bsvservice/BsvService;->mCurrentBackcarCameraId:Ljava/lang/String;

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/BsvServiceImpl;->stopUserPreview(Ljava/lang/String;)V

    :cond_0
    return-void
.end method
