.class public Lcom/yftech/bsvservice/activity/RecordSettingsView;
.super Landroid/widget/FrameLayout;
.source "RecordSettingsView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "RecordSettingsView"


# instance fields
.field private mDurationSpinner:Landroid/widget/Spinner;

.field private mDurations:[I

.field private mListener:Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;

.field private mResolutionSpinner:Landroid/widget/Spinner;

.field private mResolutions:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/Resolution;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    .line 28
    invoke-direct {p0, p1, v0}, Lcom/yftech/bsvservice/activity/RecordSettingsView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    .line 32
    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p2, 0x3

    .line 24
    new-array p2, p2, [I

    fill-array-data p2, :array_0

    iput-object p2, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mDurations:[I

    .line 33
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/activity/RecordSettingsView;->initView(Landroid/content/Context;)V

    return-void

    nop

    :array_0
    .array-data 4
        0x3
        0x5
        0xa
    .end array-data
.end method

.method static synthetic access$000(Lcom/yftech/bsvservice/activity/RecordSettingsView;)Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mListener:Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;

    return-object p0
.end method

.method static synthetic access$100(Lcom/yftech/bsvservice/activity/RecordSettingsView;)[I
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mDurations:[I

    return-object p0
.end method

.method static synthetic access$200(Lcom/yftech/bsvservice/activity/RecordSettingsView;)Ljava/util/List;
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mResolutions:Ljava/util/List;

    return-object p0
.end method

.method private getMaximumResolution(Ljava/util/List;)I
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/Resolution;",
            ">;)I"
        }
    .end annotation

    .line 88
    new-instance p0, Lcom/yftech/bsvservice/Resolution;

    const/4 v0, 0x0

    invoke-direct {p0, v0, v0}, Lcom/yftech/bsvservice/Resolution;-><init>(II)V

    if-eqz p1, :cond_3

    .line 89
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_3

    move-object v1, p0

    move p0, v0

    move v2, p0

    .line 90
    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    if-ge p0, v3, :cond_2

    .line 91
    invoke-interface {p1, p0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/yftech/bsvservice/Resolution;

    .line 92
    invoke-virtual {v3}, Lcom/yftech/bsvservice/Resolution;->getWidth()I

    move-result v4

    invoke-virtual {v1}, Lcom/yftech/bsvservice/Resolution;->getWidth()I

    move-result v5

    if-le v4, v5, :cond_0

    goto :goto_1

    .line 95
    :cond_0
    invoke-virtual {v3}, Lcom/yftech/bsvservice/Resolution;->getWidth()I

    move-result v4

    invoke-virtual {v1}, Lcom/yftech/bsvservice/Resolution;->getWidth()I

    move-result v5

    if-ne v4, v5, :cond_1

    invoke-virtual {v3}, Lcom/yftech/bsvservice/Resolution;->getHeight()I

    move-result v4

    invoke-virtual {v1}, Lcom/yftech/bsvservice/Resolution;->getHeight()I

    move-result v5

    if-le v4, v5, :cond_1

    :goto_1
    move v2, p0

    move-object v1, v3

    :cond_1
    add-int/lit8 p0, p0, 0x1

    goto :goto_0

    :cond_2
    move-object p0, v1

    goto :goto_2

    :cond_3
    move v2, v0

    :goto_2
    const-string p1, "RecordSettingsView"

    .line 101
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getMaximumResolution is ("

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/Resolution;->getWidth()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ","

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/Resolution;->getHeight()I

    move-result p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p0, ")"

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p1, p0, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return v2
.end method

.method private getResolutionStr(Ljava/util/List;)[Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/Resolution;",
            ">;)[",
            "Ljava/lang/String;"
        }
    .end annotation

    if-eqz p1, :cond_2

    .line 75
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p0

    if-nez p0, :cond_0

    goto :goto_1

    .line 78
    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p0

    new-array p0, p0, [Ljava/lang/String;

    const/4 v0, 0x0

    move v1, v0

    .line 79
    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 80
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/yftech/bsvservice/Resolution;

    const-string v3, "%d*%d"

    const/4 v4, 0x2

    .line 81
    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2}, Lcom/yftech/bsvservice/Resolution;->getWidth()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v0

    invoke-virtual {v2}, Lcom/yftech/bsvservice/Resolution;->getHeight()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const/4 v5, 0x1

    aput-object v2, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, p0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-object p0

    :cond_2
    :goto_1
    const/4 p0, 0x0

    return-object p0
.end method

.method private initView(Landroid/content/Context;)V
    .locals 6

    .line 37
    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const/4 v1, 0x1

    const v2, 0x7f090028

    invoke-virtual {v0, v2, p0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    const v2, 0x7f0700c5

    .line 38
    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/Spinner;

    iput-object v2, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mDurationSpinner:Landroid/widget/Spinner;

    const v2, 0x7f0700c6

    .line 39
    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Spinner;

    iput-object v0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mResolutionSpinner:Landroid/widget/Spinner;

    .line 40
    iget-object v0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mDurationSpinner:Landroid/widget/Spinner;

    new-instance v2, Landroid/widget/ArrayAdapter;

    const-string v3, "3min"

    const-string v4, "5min"

    const-string v5, "10min"

    filled-new-array {v3, v4, v5}, [Ljava/lang/String;

    move-result-object v3

    const v4, 0x1090009

    invoke-direct {v2, p1, v4, v3}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I[Ljava/lang/Object;)V

    invoke-virtual {v0, v2}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    .line 41
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mDurationSpinner:Landroid/widget/Spinner;

    new-instance v0, Lcom/yftech/bsvservice/activity/RecordSettingsView$1;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/activity/RecordSettingsView$1;-><init>(Lcom/yftech/bsvservice/activity/RecordSettingsView;)V

    invoke-virtual {p1, v0}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    .line 55
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mDurationSpinner:Landroid/widget/Spinner;

    invoke-virtual {p1, v1}, Landroid/widget/Spinner;->setSelection(I)V

    .line 56
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mResolutionSpinner:Landroid/widget/Spinner;

    new-instance v0, Lcom/yftech/bsvservice/activity/RecordSettingsView$2;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/activity/RecordSettingsView$2;-><init>(Lcom/yftech/bsvservice/activity/RecordSettingsView;)V

    invoke-virtual {p1, v0}, Landroid/widget/Spinner;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    return-void
.end method


# virtual methods
.method public registerRecordSettingsListener(Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;)V
    .locals 0

    .line 117
    iput-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mListener:Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;

    return-void
.end method

.method public unregisterRecordSettingsListener()V
    .locals 1

    const/4 v0, 0x0

    .line 121
    iput-object v0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mListener:Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;

    return-void
.end method

.method public updateResolution(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/Resolution;",
            ">;)V"
        }
    .end annotation

    .line 107
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/activity/RecordSettingsView;->getResolutionStr(Ljava/util/List;)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 109
    iput-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mResolutions:Ljava/util/List;

    .line 110
    iget-object v1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mResolutionSpinner:Landroid/widget/Spinner;

    new-instance v2, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Lcom/yftech/bsvservice/activity/RecordSettingsView;->getContext()Landroid/content/Context;

    move-result-object v3

    const v4, 0x1090009

    invoke-direct {v2, v3, v4, v0}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;I[Ljava/lang/Object;)V

    invoke-virtual {v1, v2}, Landroid/widget/Spinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    .line 111
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/activity/RecordSettingsView;->getMaximumResolution(Ljava/util/List;)I

    move-result p1

    .line 112
    iget-object p0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView;->mResolutionSpinner:Landroid/widget/Spinner;

    invoke-virtual {p0, p1}, Landroid/widget/Spinner;->setSelection(I)V

    :cond_0
    return-void
.end method
