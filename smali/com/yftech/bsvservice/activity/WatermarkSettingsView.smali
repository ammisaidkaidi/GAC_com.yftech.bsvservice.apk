.class public Lcom/yftech/bsvservice/activity/WatermarkSettingsView;
.super Landroid/widget/FrameLayout;
.source "WatermarkSettingsView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;,
        Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;,
        Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;
    }
.end annotation


# static fields
.field private static final MAX_HEIGHT:I = 0xc8

.field private static final MAX_START_X:I = 0x3d4

.field private static final MAX_START_Y:I = 0x3d4

.field private static final MAX_WIDTH:I = 0x258

.field private static final STEP_HEIGHT:I = 0x32

.field private static final STEP_START_X:I = 0x14

.field private static final STEP_START_Y:I = 0x14

.field private static final STEP_WIDTH:I = 0x32

.field private static final TAG:Ljava/lang/String; = "WatermarkSettingView"


# instance fields
.field private mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

.field private mPreviewHeight:Landroid/widget/EditText;

.field private mPreviewStartX:Landroid/widget/EditText;

.field private mPreviewStartY:Landroid/widget/EditText;

.field private mPreviewWatermarkSwitch:Landroid/widget/Button;

.field private mPreviewWidth:Landroid/widget/EditText;

.field private mRecordHeight:Landroid/widget/EditText;

.field private mRecordStartX:Landroid/widget/EditText;

.field private mRecordStartY:Landroid/widget/EditText;

.field private mRecordWatermarkSwitch:Landroid/widget/Button;

.field private mRecordWidth:Landroid/widget/EditText;

.field private mSnapshotHeight:Landroid/widget/EditText;

.field private mSnapshotStartX:Landroid/widget/EditText;

.field private mSnapshotStartY:Landroid/widget/EditText;

.field private mSnapshotWatermarkSwitch:Landroid/widget/Button;

.field private mSnapshotWidth:Landroid/widget/EditText;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    .line 41
    invoke-direct {p0, p1, v0}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    .line 45
    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 46
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->initView(Landroid/content/Context;)V

    return-void
.end method

.method private addForEditText(Landroid/widget/EditText;II)I
    .locals 0

    .line 108
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->getEditTextNumber(Landroid/widget/EditText;)I

    move-result p0

    add-int/2addr p0, p2

    if-le p0, p3, :cond_0

    move p0, p3

    .line 111
    :cond_0
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return p0
.end method

.method private doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V
    .locals 3

    .line 141
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const/16 v1, 0x3d4

    const/16 v2, 0x14

    if-ne p2, v0, :cond_0

    .line 142
    invoke-direct {p0, p3, v2, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->addForEditText(Landroid/widget/EditText;II)I

    move-result p3

    goto :goto_0

    .line 143
    :cond_0
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    if-ne p2, v0, :cond_1

    .line 144
    invoke-direct {p0, p3, v2, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->addForEditText(Landroid/widget/EditText;II)I

    move-result p3

    goto :goto_0

    .line 145
    :cond_1
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const/16 v1, 0x32

    if-ne p2, v0, :cond_2

    const/16 v0, 0x258

    .line 146
    invoke-direct {p0, p3, v1, v0}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->addForEditText(Landroid/widget/EditText;II)I

    move-result p3

    goto :goto_0

    .line 147
    :cond_2
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    if-ne p2, v0, :cond_3

    const/16 v0, 0xc8

    .line 148
    invoke-direct {p0, p3, v1, v0}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->addForEditText(Landroid/widget/EditText;II)I

    move-result p3

    goto :goto_0

    :cond_3
    const/4 p3, 0x0

    .line 150
    :goto_0
    invoke-direct {p0, p1, p2, p3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->notify(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;I)V

    return-void
.end method

.method private doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V
    .locals 2

    .line 127
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const/16 v1, 0x14

    if-ne p2, v0, :cond_0

    .line 128
    invoke-direct {p0, p3, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->minusForEditText(Landroid/widget/EditText;I)I

    move-result p3

    goto :goto_0

    .line 129
    :cond_0
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    if-ne p2, v0, :cond_1

    .line 130
    invoke-direct {p0, p3, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->minusForEditText(Landroid/widget/EditText;I)I

    move-result p3

    goto :goto_0

    .line 131
    :cond_1
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const/16 v1, 0x32

    if-ne p2, v0, :cond_2

    .line 132
    invoke-direct {p0, p3, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->minusForEditText(Landroid/widget/EditText;I)I

    move-result p3

    goto :goto_0

    .line 133
    :cond_2
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    if-ne p2, v0, :cond_3

    .line 134
    invoke-direct {p0, p3, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->minusForEditText(Landroid/widget/EditText;I)I

    move-result p3

    goto :goto_0

    :cond_3
    const/4 p3, 0x0

    .line 136
    :goto_0
    invoke-direct {p0, p1, p2, p3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->notify(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;I)V

    return-void
.end method

.method private doSwitchWatermark(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/Button;)V
    .locals 2

    .line 154
    invoke-virtual {p3}, Landroid/widget/Button;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    if-eqz v0, :cond_1

    .line 155
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 160
    :cond_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0b0061

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    .line 161
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p3, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    .line 162
    invoke-direct {p0, p1, p2, v0}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->notify(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;I)V

    goto :goto_1

    .line 156
    :cond_1
    :goto_0
    invoke-virtual {p0}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0b0062

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x1

    .line 157
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {p3, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    .line 158
    invoke-direct {p0, p1, p2, v0}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->notify(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;I)V

    :goto_1
    return-void
.end method

.method private getEditTextNumber(Landroid/widget/EditText;)I
    .locals 2

    .line 98
    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p0

    const-string p1, "WatermarkSettingView"

    .line 99
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "text = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p0, :cond_0

    .line 101
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_0

    .line 102
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result p0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private initView(Landroid/content/Context;)V
    .locals 2

    .line 50
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    const v0, 0x7f09002d

    const/4 v1, 0x1

    invoke-virtual {p1, v0, p0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    const p1, 0x7f070085

    .line 51
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070084

    .line 52
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070087

    .line 53
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070086

    .line 54
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070083

    .line 55
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070082

    .line 56
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f07007d

    .line 57
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f07007c

    .line 58
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070080

    .line 59
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewWatermarkSwitch:Landroid/widget/Button;

    .line 60
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewWatermarkSwitch:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f07007e

    .line 61
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewStartX:Landroid/widget/EditText;

    const p1, 0x7f07007f

    .line 62
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewStartY:Landroid/widget/EditText;

    const p1, 0x7f070081

    .line 63
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewWidth:Landroid/widget/EditText;

    const p1, 0x7f07007b

    .line 64
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewHeight:Landroid/widget/EditText;

    const p1, 0x7f070096

    .line 66
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070095

    .line 67
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070098

    .line 68
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070097

    .line 69
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070094

    .line 70
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070093

    .line 71
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f07008e

    .line 72
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f07008d

    .line 73
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f070091

    .line 74
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordWatermarkSwitch:Landroid/widget/Button;

    .line 75
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordWatermarkSwitch:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f07008f

    .line 76
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordStartX:Landroid/widget/EditText;

    const p1, 0x7f070090

    .line 77
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordStartY:Landroid/widget/EditText;

    const p1, 0x7f070092

    .line 78
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordWidth:Landroid/widget/EditText;

    const p1, 0x7f07008c

    .line 79
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordHeight:Landroid/widget/EditText;

    const p1, 0x7f0700c1

    .line 81
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700c0

    .line 82
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700c3

    .line 83
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700c2

    .line 84
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700bf

    .line 85
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700be

    .line 86
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700b9

    .line 87
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700b8

    .line 88
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700bc

    .line 89
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotWatermarkSwitch:Landroid/widget/Button;

    .line 90
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotWatermarkSwitch:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0700ba

    .line 91
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotStartX:Landroid/widget/EditText;

    const p1, 0x7f0700bb

    .line 92
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotStartY:Landroid/widget/EditText;

    const p1, 0x7f0700bd

    .line 93
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotWidth:Landroid/widget/EditText;

    const p1, 0x7f0700b7

    .line 94
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotHeight:Landroid/widget/EditText;

    return-void
.end method

.method private minusForEditText(Landroid/widget/EditText;I)I
    .locals 0

    .line 116
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->getEditTextNumber(Landroid/widget/EditText;)I

    move-result p0

    sub-int/2addr p0, p2

    if-gez p0, :cond_0

    const/4 p0, 0x0

    .line 121
    :cond_0
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return p0
.end method

.method private notify(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;I)V
    .locals 1

    .line 167
    iget-object v0, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    if-eqz v0, :cond_1

    .line 168
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$1;->$SwitchMap$com$yftech$bsvservice$activity$WatermarkSettingsView$ValueType:[I

    invoke-virtual {p2}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->ordinal()I

    move-result p2

    aget p2, v0, p2

    packed-switch p2, :pswitch_data_0

    goto :goto_1

    .line 182
    :pswitch_0
    iget-object p2, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    if-lez p3, :cond_0

    const/4 p3, 0x1

    goto :goto_0

    :cond_0
    const/4 p3, 0x0

    :goto_0
    invoke-interface {p2, p0, p1, p3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;->onStateChanged(Landroid/view/View;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Z)V

    goto :goto_1

    .line 179
    :pswitch_1
    iget-object p2, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    invoke-interface {p2, p0, p1, p3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;->onHeightChanged(Landroid/view/View;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;I)V

    goto :goto_1

    .line 176
    :pswitch_2
    iget-object p2, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    invoke-interface {p2, p0, p1, p3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;->onWidthChanged(Landroid/view/View;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;I)V

    goto :goto_1

    .line 173
    :pswitch_3
    iget-object p2, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    invoke-interface {p2, p0, p1, p3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;->onStartYChanged(Landroid/view/View;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;I)V

    goto :goto_1

    .line 170
    :pswitch_4
    iget-object p2, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    invoke-interface {p2, p0, p1, p3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;->onStartXChanged(Landroid/view/View;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;I)V

    :cond_1
    :goto_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 190
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f070080

    if-eq p1, v0, :cond_2

    const v0, 0x7f070091

    if-eq p1, v0, :cond_1

    const v0, 0x7f0700bc

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    packed-switch p1, :pswitch_data_1

    packed-switch p1, :pswitch_data_2

    packed-switch p1, :pswitch_data_3

    packed-switch p1, :pswitch_data_4

    packed-switch p1, :pswitch_data_5

    goto/16 :goto_0

    .line 254
    :pswitch_0
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotStartY:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 257
    :pswitch_1
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotStartY:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 248
    :pswitch_2
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotStartX:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 251
    :pswitch_3
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotStartX:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 260
    :pswitch_4
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotWidth:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 263
    :pswitch_5
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotWidth:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 266
    :pswitch_6
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotHeight:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 269
    :pswitch_7
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotHeight:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 226
    :pswitch_8
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordStartY:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 229
    :pswitch_9
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordStartY:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 220
    :pswitch_a
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordStartX:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 223
    :pswitch_b
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordStartX:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 232
    :pswitch_c
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordWidth:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 235
    :pswitch_d
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordWidth:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 238
    :pswitch_e
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordHeight:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 241
    :pswitch_f
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordHeight:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto/16 :goto_0

    .line 198
    :pswitch_10
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewStartY:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 201
    :pswitch_11
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewStartY:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 192
    :pswitch_12
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewStartX:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 195
    :pswitch_13
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewStartX:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 204
    :pswitch_14
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewWidth:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 207
    :pswitch_15
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewWidth:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 210
    :pswitch_16
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewHeight:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doMinus(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 213
    :pswitch_17
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewHeight:Landroid/widget/EditText;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doAdd(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/EditText;)V

    goto :goto_0

    .line 272
    :cond_0
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->ON_OFF:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mSnapshotWatermarkSwitch:Landroid/widget/Button;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doSwitchWatermark(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/Button;)V

    goto :goto_0

    .line 244
    :cond_1
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->ON_OFF:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mRecordWatermarkSwitch:Landroid/widget/Button;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doSwitchWatermark(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/Button;)V

    goto :goto_0

    .line 216
    :cond_2
    sget-object p1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->ON_OFF:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    iget-object v1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mPreviewWatermarkSwitch:Landroid/widget/Button;

    invoke-direct {p0, p1, v0, v1}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->doSwitchWatermark(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;Landroid/widget/Button;)V

    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f07007c
        :pswitch_17
        :pswitch_16
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x7f070082
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x7f07008d
        :pswitch_f
        :pswitch_e
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x7f070093
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
    .end packed-switch

    :pswitch_data_4
    .packed-switch 0x7f0700b8
        :pswitch_7
        :pswitch_6
    .end packed-switch

    :pswitch_data_5
    .packed-switch 0x7f0700be
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public registerWatermarkSettingsListener(Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;)V
    .locals 0

    .line 278
    iput-object p1, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    return-void
.end method

.method public unregisterWatermarkSettingsListener()V
    .locals 1

    const/4 v0, 0x0

    .line 282
    iput-object v0, p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView;->mListener:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$WatermarkSettingsListener;

    return-void
.end method
