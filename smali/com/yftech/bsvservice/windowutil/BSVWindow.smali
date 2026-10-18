.class public Lcom/yftech/bsvservice/windowutil/BSVWindow;
.super Lcom/yftech/bsvservice/windowutil/BaseWindow;
.source "BSVWindow.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;
    }
.end annotation


# static fields
.field private static final DEBUG:Z = true

.field public static final SURFACE_VIEW_HIGHT:I = 0x2d0

.field public static final SURFACE_VIEW_WIDTH:I = 0x780

.field public static final SURFACE_VIEW_X:I = 0x0

.field public static final SURFACE_VIEW_Y:I = 0x0

.field private static final TAG:Ljava/lang/String; = "BSVWindow"


# instance fields
.field private isShown_nosig:Ljava/lang/Boolean;

.field private mCarDeviceListener:Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;

.field private mContext:Landroid/content/Context;

.field private mErrLayout:Landroid/widget/RelativeLayout;

.field private mErrView:Landroid/widget/TextView;

.field mHandler:Landroid/os/Handler;

.field private mHintView:Landroid/widget/TextView;

.field private mIsBsvDisplayState:Z

.field private mIsCameraSystemErr:Z

.field private mOverLayView:Landroid/view/View;

.field private mSurfaceView:Lcom/yftech/bsvservice/windowutil/CameraPreview;

.field private mWindowManager:Landroid/view/WindowManager;

.field rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

.field private surfaceView:Landroid/view/SurfaceView;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 5

    .line 76
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/windowutil/BaseWindow;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    .line 42
    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mSurfaceView:Lcom/yftech/bsvservice/windowutil/CameraPreview;

    .line 43
    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mOverLayView:Landroid/view/View;

    .line 44
    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->surfaceView:Landroid/view/SurfaceView;

    .line 45
    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mWindowManager:Landroid/view/WindowManager;

    .line 46
    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    .line 47
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    iput-object v2, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->isShown_nosig:Ljava/lang/Boolean;

    const/4 v2, 0x1

    .line 60
    iput-boolean v2, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsCameraSystemErr:Z

    .line 61
    iput-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsBsvDisplayState:Z

    .line 63
    new-instance v3, Landroid/os/Handler;

    invoke-direct {v3}, Landroid/os/Handler;-><init>()V

    iput-object v3, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mHandler:Landroid/os/Handler;

    .line 65
    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mCarDeviceListener:Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;

    .line 77
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v3, "MainWindow"

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v0, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mContext:Landroid/content/Context;

    .line 80
    new-instance v0, Lcom/yftech/bsvservice/windowutil/CameraPreview;

    iget-object v3, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-direct {v0, p1, v3}, Lcom/yftech/bsvservice/windowutil/CameraPreview;-><init>(Landroid/content/Context;Lcom/yftech/bsvservice/avm/AvmControl;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mSurfaceView:Lcom/yftech/bsvservice/windowutil/CameraPreview;

    .line 81
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mContext:Landroid/content/Context;

    const-string v0, "window"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/WindowManager;

    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mWindowManager:Landroid/view/WindowManager;

    .line 82
    new-instance p1, Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;

    invoke-direct {p1, p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;-><init>(Lcom/yftech/bsvservice/windowutil/BSVWindow;)V

    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mCarDeviceListener:Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;

    .line 83
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->get()Lcom/yftech/vehicle/sdk/CarDeviceManager;

    move-result-object p1

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mCarDeviceListener:Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;

    invoke-virtual {p1, v0}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->registerListener(Lcom/yftech/vehicle/sdk/CarDeviceManager$CarDeviceListener;)V

    .line 84
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->get()Lcom/yftech/vehicle/sdk/CarDeviceManager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->getBSVDisplayState()Lcom/yftech/vehicle/internal/adapter/IBaseApi$EnableState;

    move-result-object p1

    .line 85
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getBSVDisplayState:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v0, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 86
    sget-object v0, Lcom/yftech/vehicle/internal/adapter/IBaseApi$EnableState;->ENABLED:Lcom/yftech/vehicle/internal/adapter/IBaseApi$EnableState;

    if-ne p1, v0, :cond_0

    move v1, v2

    :cond_0
    iput-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsBsvDisplayState:Z

    .line 87
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mCarDeviceListener:Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;

    invoke-virtual {v0, p1}, Lcom/yftech/bsvservice/windowutil/BSVWindow$MyCarDeviceListener;->onBSVDisplayStateChanged(Lcom/yftech/vehicle/internal/adapter/IBaseApi$EnableState;)V

    .line 88
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->initView()V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    .line 32
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/yftech/bsvservice/windowutil/BSVWindow;)Z
    .locals 0

    .line 32
    iget-boolean p0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsBsvDisplayState:Z

    return p0
.end method

.method static synthetic access$102(Lcom/yftech/bsvservice/windowutil/BSVWindow;Z)Z
    .locals 0

    .line 32
    iput-boolean p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsBsvDisplayState:Z

    return p1
.end method


# virtual methods
.method public dispatchHandleMessage(Landroid/os/Message;)Z
    .locals 3

    .line 249
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "dispatchHandleMessage msg:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 250
    iget v0, p1, Landroid/os/Message;->what:I

    const/16 v1, 0xd2

    if-eq v0, v1, :cond_1

    const/16 v1, 0x105

    if-eq v0, v1, :cond_0

    const/16 v1, 0x107

    if-eq v0, v1, :cond_1

    const/16 v1, 0x109

    goto :goto_0

    .line 252
    :cond_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->isShow()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 253
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->isBackCar()Z

    move-result v0

    .line 271
    :cond_1
    :goto_0
    invoke-super {p0, p1}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->dispatchHandleMessage(Landroid/os/Message;)Z

    move-result p0

    return p0
.end method

.method public getSurface()Landroid/view/SurfaceView;
    .locals 0

    .line 123
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mSurfaceView:Lcom/yftech/bsvservice/windowutil/CameraPreview;

    return-object p0
.end method

.method public hideWindow()V
    .locals 4

    .line 179
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->isShow()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    invoke-virtual {v0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 180
    :cond_0
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v1, "hidePopupWindow"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 181
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->restoreScreenBackLight()V

    .line 182
    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->getInstance()Lcom/yftech/bsvservice/avm/AudioFocus;

    move-result-object v0

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AudioFocus;->abondAvmFocus()V

    const/4 v0, 0x2

    .line 183
    invoke-virtual {p0, v0, v2}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->BroadcastWindow(IZ)V

    .line 185
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->get()Lcom/yftech/vehicle/sdk/CarDeviceManager;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->setBSVDisplaySwitch(Z)Z

    .line 186
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v1, "setBSVDisplaySwitch false"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 187
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mWindowManager:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V

    .line 188
    invoke-super {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->hideWindow()V

    :cond_1
    return-void
.end method

.method public initView()V
    .locals 5

    .line 92
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mContext:Landroid/content/Context;

    const-string v1, "layout_inflater"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    const v1, 0x7f090020

    const/4 v2, 0x0

    .line 93
    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mOverLayView:Landroid/view/View;

    .line 95
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mOverLayView:Landroid/view/View;

    const v1, 0x7f070065

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mErrLayout:Landroid/widget/RelativeLayout;

    .line 96
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mErrLayout:Landroid/widget/RelativeLayout;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 97
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mOverLayView:Landroid/view/View;

    const v1, 0x7f0700e5

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mErrView:Landroid/widget/TextView;

    .line 100
    new-instance v0, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    iget-object v1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    .line 101
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v1}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    const/16 v1, 0x9

    .line 102
    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    const/16 v2, 0xa

    .line 103
    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    const/16 v3, 0xe

    .line 105
    invoke-virtual {v0, v3}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 106
    iget-object v3, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    invoke-virtual {v3, v0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 107
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 109
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v3, 0x2d0

    const/16 v4, 0x780

    invoke-direct {v0, v4, v3}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 110
    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 111
    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    const/4 v1, 0x0

    .line 112
    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;->setMarginStart(I)V

    .line 114
    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 115
    iget-object v1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mSurfaceView:Lcom/yftech/bsvservice/windowutil/CameraPreview;

    invoke-virtual {v1, v0}, Lcom/yftech/bsvservice/windowutil/CameraPreview;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 116
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mSurfaceView:Lcom/yftech/bsvservice/windowutil/CameraPreview;

    const/16 v1, 0x500

    invoke-virtual {v0, v1, v3}, Lcom/yftech/bsvservice/windowutil/CameraPreview;->setFixedSize(II)V

    .line 117
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    iget-object v1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mSurfaceView:Lcom/yftech/bsvservice/windowutil/CameraPreview;

    invoke-virtual {v0, v1}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->addView(Landroid/view/View;)V

    .line 118
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mOverLayView:Landroid/view/View;

    invoke-virtual {v0, p0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->addView(Landroid/view/View;)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 209
    sget-object p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onClick:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 210
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    return-void
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1

    .line 277
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 283
    :pswitch_0
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result p2

    const/4 v0, 0x3

    invoke-virtual {p0, p1, p2, v0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->sendTouchToAVM(FFI)Z

    goto :goto_0

    .line 287
    :pswitch_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result p2

    const/4 v0, 0x2

    invoke-virtual {p0, p1, p2, v0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->sendTouchToAVM(FFI)Z

    goto :goto_0

    .line 279
    :pswitch_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result p2

    const/4 v0, 0x1

    invoke-virtual {p0, p1, p2, v0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->sendTouchToAVM(FFI)Z

    :goto_0
    const/4 p0, 0x0

    return p0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public sendTouchToAVM(FFI)Z
    .locals 2

    .line 297
    sget-object p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "sendTouchToAVM onTouch x:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v1, ",y:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v1, ",action:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 298
    invoke-static {}, Lcom/yftech/vehicle/sdk/MpuProjectManager;->get()Lcom/yftech/vehicle/sdk/MpuProjectManager;

    move-result-object p0

    float-to-int p1, p1

    float-to-int p2, p2

    invoke-virtual {p0, p1, p2, p3}, Lcom/yftech/vehicle/sdk/MpuProjectManager;->setTouchInfo2Bsv(III)Z

    move-result p0

    return p0
.end method

.method public setUpWindowPara(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;
    .locals 0

    const/16 p0, 0x804

    .line 218
    iput p0, p1, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 225
    iget p0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit16 p0, p0, 0x328

    iput p0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/4 p0, -0x3

    .line 239
    iput p0, p1, Landroid/view/WindowManager$LayoutParams;->format:I

    const/4 p0, -0x1

    .line 240
    iput p0, p1, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 241
    iput p0, p1, Landroid/view/WindowManager$LayoutParams;->height:I

    const/16 p0, 0x11

    .line 242
    iput p0, p1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    return-object p1
.end method

.method public setWindowVisibility(Z)Z
    .locals 3

    .line 194
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setWindowVisibility"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 195
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    .line 197
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->setScaleX(F)V

    .line 198
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->setScaleY(F)V

    goto :goto_0

    .line 200
    :cond_0
    iget-object p1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->setScaleX(F)V

    .line 201
    iget-object p0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;->setScaleY(F)V

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method public showWindow()V
    .locals 5

    .line 155
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->isShow()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 156
    sget-object p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v0, "return cause already shown"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 159
    :cond_0
    invoke-super {p0}, Lcom/yftech/bsvservice/windowutil/BaseWindow;->showWindow()V

    .line 160
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v2, "showPopupWindow"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 161
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    invoke-virtual {p0, v0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->setUpWindowPara(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 162
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->updateWindow()V

    .line 164
    invoke-static {}, Lcom/yftech/bsvservice/avm/AvmControl;->getInstance()Lcom/yftech/bsvservice/avm/AvmControl;

    move-result-object v2

    invoke-virtual {v2}, Lcom/yftech/bsvservice/avm/AvmControl;->isBackCar()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {}, Lcom/yftech/bsvservice/avm/AudioFocus;->getInstance()Lcom/yftech/bsvservice/avm/AudioFocus;

    move-result-object v2

    invoke-virtual {v2}, Lcom/yftech/bsvservice/avm/AudioFocus;->requestAvmFocus()I

    .line 165
    :cond_1
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->openScreenBackLight()V

    const/4 v2, 0x2

    const/4 v3, 0x1

    .line 166
    invoke-virtual {p0, v2, v3}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->BroadcastWindow(IZ)V

    .line 168
    invoke-static {}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->get()Lcom/yftech/vehicle/sdk/CarDeviceManager;

    move-result-object v2

    invoke-virtual {v2, v3}, Lcom/yftech/vehicle/sdk/CarDeviceManager;->setBSVDisplaySwitch(Z)Z

    .line 169
    sget-object v2, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v3, "setBSVDisplaySwitch true"

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 171
    iget-object v2, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mWindowManager:Landroid/view/WindowManager;

    iget-object v3, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->rootLayout:Lcom/yftech/bsvservice/windowutil/CustomRelativeLayout;

    invoke-interface {v2, v3, v0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 174
    invoke-virtual {p0, v1}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->setWindowVisibility(Z)Z

    .line 175
    sget-object p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v0, "add view"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public updateWindow()V
    .locals 4

    .line 131
    invoke-virtual {p0}, Lcom/yftech/bsvservice/windowutil/BSVWindow;->isShow()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 133
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mAvmControl:Lcom/yftech/bsvservice/avm/AvmControl;

    invoke-virtual {v0}, Lcom/yftech/bsvservice/avm/AvmControl;->isAvmSignalErr()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 134
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v2, "updateWindow no Signal Err "

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 135
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mErrView:Landroid/widget/TextView;

    const v2, 0x7f0b0056

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    .line 136
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mErrLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    const/4 v0, 0x1

    .line 137
    iput-boolean v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsCameraSystemErr:Z

    goto :goto_0

    .line 139
    :cond_1
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    const-string v2, "updateWindow no Err "

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 140
    iget-object v0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mErrLayout:Landroid/widget/RelativeLayout;

    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 141
    iput-boolean v1, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsCameraSystemErr:Z

    .line 144
    :goto_0
    sget-object v0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mIsCameraSystemErr:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v3, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsCameraSystemErr:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    iget-boolean p0, p0, Lcom/yftech/bsvservice/windowutil/BSVWindow;->mIsCameraSystemErr:Z

    return-void
.end method
