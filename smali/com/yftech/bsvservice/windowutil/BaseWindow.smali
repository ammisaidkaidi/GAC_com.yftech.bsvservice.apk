.class public Lcom/yftech/bsvservice/windowutil/BaseWindow;
.super Ljava/lang/Object;
.source "BaseWindow.java"

# interfaces
.implements Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;


# static fields
.field protected static final RVC_CAMERA_SIGNAL_STATE:Ljava/lang/String; = "rvc_camera_signal_state"

.field protected static final RVC_CAMERA_SIGNAL_STATE_ERR:I = 0x0

.field protected static final RVC_CAMERA_SIGNAL_STATE_OK:I = 0x1

.field private static final TAG:Ljava/lang/String; = "BaseWindow"


# instance fields
.field exitAvmFirstShow:Ljava/lang/Runnable;

.field private isAvmRequestCameraOpen:Z

.field private isFirstOpenCamera:Z

.field private isOnFirstOpenCameraState:Z

.field private isShown:Ljava/lang/Boolean;

.field private isUpdateVisibility:Z

.field protected mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

.field private mCameraState:I

.field private mCarHandler:Landroid/os/Handler;

.field private mContext:Landroid/content/Context;

.field private mIsRestoreScreenBackLight:Z

.field private mIsVisibility:Ljava/lang/Boolean;

.field updateVisibilityRunnable:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 36
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    iput-object v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isShown:Ljava/lang/Boolean;

    .line 37
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    iput-object v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsVisibility:Ljava/lang/Boolean;

    const/4 v1, 0x0

    .line 38
    iput-object v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mContext:Landroid/content/Context;

    .line 40
    iput-boolean v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    .line 41
    iput-boolean v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsRestoreScreenBackLight:Z

    const/4 v1, 0x1

    .line 43
    iput v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCameraState:I

    .line 45
    new-instance v2, Landroid/os/Handler;

    invoke-direct {v2}, Landroid/os/Handler;-><init>()V

    iput-object v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    .line 102
    new-instance v2, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;

    invoke-direct {v2, p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow$1;-><init>(Lcom/yftech/bsvservice/windowutil/BaseWindow;)V

    iput-object v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    .line 115
    new-instance v2, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;

    invoke-direct {v2, p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow$2;-><init>(Lcom/yftech/bsvservice/windowutil/BaseWindow;)V

    iput-object v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->exitAvmFirstShow:Ljava/lang/Runnable;

    .line 197
    iput-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    .line 198
    iput-boolean v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    .line 199
    iput-boolean v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isAvmRequestCameraOpen:Z

    .line 48
    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mContext:Landroid/content/Context;

    .line 49
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    .line 50
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getMainHandler()Lcom/yftech/bsvservice/util/DistributedHandler;

    move-result-object p1

    invoke-virtual {p1, p0}, Lcom/yftech/bsvservice/util/DistributedHandler;->addHandlerPart(Lcom/yftech/bsvservice/util/DistributedHandler$HandlerPart;)V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    .line 28
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Z
    .locals 0

    .line 28
    iget-boolean p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    return p0
.end method

.method static synthetic access$102(Lcom/yftech/bsvservice/windowutil/BaseWindow;Z)Z
    .locals 0

    .line 28
    iput-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    return p1
.end method

.method static synthetic access$200(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Z
    .locals 0

    .line 28
    iget-boolean p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    return p0
.end method

.method static synthetic access$202(Lcom/yftech/bsvservice/windowutil/BaseWindow;Z)Z
    .locals 0

    .line 28
    iput-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    return p1
.end method

.method static synthetic access$300(Lcom/yftech/bsvservice/windowutil/BaseWindow;)I
    .locals 0

    .line 28
    iget p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCameraState:I

    return p0
.end method

.method static synthetic access$400(Lcom/yftech/bsvservice/windowutil/BaseWindow;)Landroid/os/Handler;
    .locals 0

    .line 28
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    return-object p0
.end method

.method private onAvmHideWindow()V
    .locals 3

    .line 181
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onAvmHideWindow mCameraState:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCameraState:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 183
    iget v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCameraState:I

    if-nez v0, :cond_0

    .line 185
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraReqHide()V

    .line 191
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->hideWindow()V

    goto :goto_0

    .line 193
    :cond_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->hideWindow()V

    :goto_0
    return-void
.end method

.method private sendHXBroadCast(IZ)V
    .locals 7

    .line 368
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "com.yftech.bsvservice.SHOW_STATE"

    .line 369
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "type"

    .line 370
    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p1, "isShow"

    .line 371
    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 372
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mContext:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p1

    const/4 p2, 0x0

    .line 374
    invoke-virtual {p1, v0, p2}, Landroid/content/pm/PackageManager;->queryBroadcastReceivers(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 375
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    if-lt v1, v2, :cond_0

    .line 376
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/pm/ResolveInfo;

    .line 377
    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2, v0}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    .line 378
    new-instance v3, Landroid/content/ComponentName;

    iget-object v4, v1, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v4, v4, Landroid/content/pm/ActivityInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v4, v4, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    iget-object v5, v1, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v5, v5, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-direct {v3, v4, v5}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 381
    sget-object v4, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "packageName "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v6, v1, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v6, v6, Landroid/content/pm/ActivityInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v6, v6, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, ",Receiver:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, v1, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v1, v1, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v5, p2, [Ljava/lang/Object;

    invoke-static {v4, v1, v5}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 382
    invoke-virtual {v2, v3}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 383
    iget-object v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mContext:Landroid/content/Context;

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_0

    .line 386
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mContext:Landroid/content/Context;

    sget-object p1, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {p0, v0, p1}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    return-void
.end method


# virtual methods
.method public BroadcastWindow(IZ)V
    .locals 2

    if-eqz p2, :cond_0

    const-string v0, "sys.bsvservice.show.state"

    const-string v1, "1"

    .line 391
    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const-string v0, "sys.bsvservice.show.state"

    const-string v1, "0"

    .line 393
    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 395
    :goto_0
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->sendHXBroadCast(IZ)V

    return-void
.end method

.method public dispatchHandleMessage(Landroid/os/Message;)Z
    .locals 7

    .line 202
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "dispatchHandleMessage msg:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 203
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0xd4

    if-eq v0, v1, :cond_12

    const/16 v1, 0xd8

    if-eq v0, v1, :cond_11

    const/16 v1, 0xfa

    if-eq v0, v1, :cond_13

    const/16 v1, 0xff

    const/4 v3, 0x2

    const/4 v4, 0x1

    if-eq v0, v1, :cond_c

    const/16 v1, 0x109

    const-wide/16 v5, 0x1388

    if-eq v0, v1, :cond_2

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_2

    .line 343
    :pswitch_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateWindow()V

    .line 345
    iget p1, p1, Landroid/os/Message;->what:I

    const/16 v0, 0xcc

    if-ne p1, v0, :cond_0

    .line 346
    invoke-virtual {p0, v2}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setCameraState(I)Z

    goto/16 :goto_2

    .line 348
    :cond_0
    invoke-virtual {p0, v4}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setCameraState(I)Z

    goto/16 :goto_2

    .line 206
    :pswitch_1
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getDeviceType()I

    move-result p1

    if-ne p1, v3, :cond_1

    .line 208
    sget-object p1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isFirstOpenCamera :"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 209
    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    if-eqz p1, :cond_13

    .line 210
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->showWindow()V

    .line 211
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->exitAvmFirstShow:Ljava/lang/Runnable;

    invoke-virtual {p1, v0, v5, v6}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 212
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    .line 213
    iput-boolean v4, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    goto/16 :goto_2

    .line 216
    :cond_1
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->showWindow()V

    .line 217
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    .line 219
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 221
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, p0, v5, v6}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto/16 :goto_2

    .line 294
    :pswitch_2
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->hideWindow()V

    goto/16 :goto_2

    .line 226
    :cond_2
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->getDeviceType()I

    move-result v0

    if-ne v0, v3, :cond_13

    .line 227
    iget p1, p1, Landroid/os/Message;->arg1:I

    if-ne p1, v4, :cond_8

    .line 230
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getAvmReqOnOff()I

    move-result p1

    if-eqz p1, :cond_3

    move p1, v4

    goto :goto_0

    :cond_3
    move p1, v2

    .line 231
    :goto_0
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Avm request show isPreviewStarted:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-nez p1, :cond_6

    .line 234
    sget-object p1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isOnFirstOpenCameraState:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ",isFirstOpenCamera :"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ", arm1 is not exit!!!"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 236
    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    if-eqz p1, :cond_4

    goto/16 :goto_2

    .line 240
    :cond_4
    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    if-nez p1, :cond_5

    .line 241
    iput-boolean v4, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    .line 242
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraReqHide()V

    .line 243
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraReqShow()V

    .line 244
    iput-boolean v4, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isAvmRequestCameraOpen:Z

    .line 245
    sget-object p1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onCameraReqShow(),isOnFirstOpenCameraState:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v0, v2, [Ljava/lang/Object;

    invoke-static {p1, p0, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_2

    .line 247
    :cond_5
    sget-object p1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "11Avm request show, isOnFirstOpenCameraState:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v0, v2, [Ljava/lang/Object;

    invoke-static {p1, p0, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_2

    .line 253
    :cond_6
    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    if-eqz p1, :cond_7

    .line 254
    sget-object p1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "22Avm request show, isOnFirstOpenCameraState:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 261
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    .line 263
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 265
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, p0, v5, v6}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto/16 :goto_2

    .line 267
    :cond_7
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->showWindow()V

    .line 268
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    .line 270
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 272
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, p0, v5, v6}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto/16 :goto_2

    .line 278
    :cond_8
    sget-object p1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Avm request hide,isFirstOpenCamera:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ",isOnFirstOpenCameraState:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ",isAvmRequestCameraOpen:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isAvmRequestCameraOpen:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ",mIsVisibility:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsVisibility:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 280
    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isFirstOpenCamera:Z

    if-nez p1, :cond_a

    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    if-eqz p1, :cond_9

    goto :goto_1

    .line 288
    :cond_9
    invoke-direct {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->onAvmHideWindow()V

    goto/16 :goto_2

    .line 282
    :cond_a
    :goto_1
    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isAvmRequestCameraOpen:Z

    if-eqz p1, :cond_b

    .line 283
    invoke-direct {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->onAvmHideWindow()V

    goto/16 :goto_2

    .line 284
    :cond_b
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsVisibility:Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-eqz p1, :cond_13

    .line 285
    invoke-direct {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->onAvmHideWindow()V

    goto/16 :goto_2

    .line 299
    :cond_c
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->getDeviceType()I

    move-result p1

    if-ne p1, v3, :cond_10

    .line 300
    sget-object p1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isOnFirstOpenCameraState :"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 302
    iget-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    if-eqz p1, :cond_f

    .line 303
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isOnFirstOpenCameraState:Z

    .line 304
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->exitAvmFirstShow:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 305
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->isAvmDisplay()Z

    move-result p1

    if-nez p1, :cond_e

    .line 306
    iget p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCameraState:I

    if-nez p1, :cond_d

    .line 307
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/bsvservice/avm/AvmControl;->onCameraReqHide()V

    .line 309
    :cond_d
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->hideWindow()V

    goto :goto_2

    .line 312
    :cond_e
    invoke-virtual {p0, v4}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setWindowVisibility(Z)Z

    .line 313
    iput-boolean v4, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    .line 315
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    goto :goto_2

    .line 319
    :cond_f
    invoke-virtual {p0, v4}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setWindowVisibility(Z)Z

    .line 320
    iput-boolean v4, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    .line 322
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    goto :goto_2

    .line 326
    :cond_10
    invoke-virtual {p0, v4}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->setWindowVisibility(Z)Z

    .line 327
    iput-boolean v4, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isUpdateVisibility:Z

    .line 329
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCarHandler:Landroid/os/Handler;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateVisibilityRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    goto :goto_2

    .line 353
    :cond_11
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateWindow()V

    goto :goto_2

    .line 337
    :cond_12
    :pswitch_3
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->updateWindow()V

    :cond_13
    :goto_2
    return v2

    nop

    :pswitch_data_0
    .packed-switch 0xc9
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_3
    .end packed-switch
.end method

.method public getAvmControl()Lcom/yftech/bsvservice/avm/AvmControl;
    .locals 0

    .line 58
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    return-object p0
.end method

.method public hideWindow()V
    .locals 2

    const/4 v0, 0x0

    .line 72
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    iput-object v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsVisibility:Ljava/lang/Boolean;

    .line 73
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isShown:Ljava/lang/Boolean;

    return-void
.end method

.method public isShow()Z
    .locals 0

    .line 80
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isShown:Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    return p0
.end method

.method openScreenBackLight()V
    .locals 5

    .line 140
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    const-string v1, "openScreenBackLight"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    invoke-static {}, Lcom/yftech/car/screen/CarScreenManager;->getInstance()Lcom/yftech/car/screen/CarScreenManager;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 142
    invoke-virtual {v0}, Lcom/yftech/car/screen/CarScreenManager;->isOpenScreenBrightness()Z

    move-result v1

    if-nez v1, :cond_0

    .line 143
    sget-object v1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isOpenScreenBrightness:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Lcom/yftech/car/screen/CarScreenManager;->isOpenScreenBrightness()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 144
    invoke-virtual {v0, v2}, Lcom/yftech/car/screen/CarScreenManager;->openScreenBrightness(I)Z

    const/4 v0, 0x1

    .line 145
    iput-boolean v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsRestoreScreenBackLight:Z

    goto :goto_0

    .line 147
    :cond_0
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsRestoreScreenBackLight:Z

    :goto_0
    return-void
.end method

.method restoreScreenBackLight()V
    .locals 4

    .line 155
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "restoreScreenBackLight,mIsRestoreScreenBackLight:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsRestoreScreenBackLight:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 156
    invoke-static {}, Lcom/yftech/car/screen/CarScreenManager;->getInstance()Lcom/yftech/car/screen/CarScreenManager;

    move-result-object v0

    .line 157
    iget-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsRestoreScreenBackLight:Z

    if-eqz v1, :cond_0

    if-eqz v0, :cond_0

    .line 159
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    const-string v1, "no closeScreenBrightness"

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-wide/16 v0, 0x14

    .line 161
    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 163
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 166
    :cond_0
    :goto_0
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsRestoreScreenBackLight:Z

    return-void
.end method

.method public setCameraState(I)Z
    .locals 4

    .line 172
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "rvc_camera_signal_state"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-result v0

    .line 173
    sget-object v1, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "set rvc camera value:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ",ret: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 174
    iput p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mCameraState:I

    return v0
.end method

.method public setWindowVisibility(Z)Z
    .locals 3

    .line 87
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWindowVisibility:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 88
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->mIsVisibility:Ljava/lang/Boolean;

    const/4 p0, 0x1

    return p0
.end method

.method public showWindow()V
    .locals 1

    const/4 v0, 0x1

    .line 65
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->isShown:Ljava/lang/Boolean;

    return-void
.end method

.method public updateWindow()V
    .locals 2

    .line 99
    sget-object p0, Lcom/yftech/bsvservice/windowutil/BaseWindow;->TAG:Ljava/lang/String;

    const-string v0, "updateWindow"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
