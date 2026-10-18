.class Lcom/yftech/bsvservice/activity/RecordSettingsView$1;
.super Ljava/lang/Object;
.source "RecordSettingsView.java"

# interfaces
.implements Landroid/widget/AdapterView$OnItemSelectedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/yftech/bsvservice/activity/RecordSettingsView;->initView(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/yftech/bsvservice/activity/RecordSettingsView;


# direct methods
.method constructor <init>(Lcom/yftech/bsvservice/activity/RecordSettingsView;)V
    .locals 0

    .line 41
    iput-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView$1;->this$0:Lcom/yftech/bsvservice/activity/RecordSettingsView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemSelected(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    const-string p1, "RecordSettingsView"

    .line 44
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Duration position="

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ", id="

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const/4 p4, 0x0

    new-array p4, p4, [Ljava/lang/Object;

    invoke-static {p1, p2, p4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 45
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView$1;->this$0:Lcom/yftech/bsvservice/activity/RecordSettingsView;

    invoke-static {p1}, Lcom/yftech/bsvservice/activity/RecordSettingsView;->access$000(Lcom/yftech/bsvservice/activity/RecordSettingsView;)Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 46
    iget-object p1, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView$1;->this$0:Lcom/yftech/bsvservice/activity/RecordSettingsView;

    invoke-static {p1}, Lcom/yftech/bsvservice/activity/RecordSettingsView;->access$000(Lcom/yftech/bsvservice/activity/RecordSettingsView;)Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;

    move-result-object p1

    iget-object p2, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView$1;->this$0:Lcom/yftech/bsvservice/activity/RecordSettingsView;

    iget-object p0, p0, Lcom/yftech/bsvservice/activity/RecordSettingsView$1;->this$0:Lcom/yftech/bsvservice/activity/RecordSettingsView;

    invoke-static {p0}, Lcom/yftech/bsvservice/activity/RecordSettingsView;->access$100(Lcom/yftech/bsvservice/activity/RecordSettingsView;)[I

    move-result-object p0

    aget p0, p0, p3

    invoke-interface {p1, p2, p0}, Lcom/yftech/bsvservice/activity/RecordSettingsView$RecordSettingsListener;->onDurationChanged(Landroid/view/View;I)V

    :cond_0
    return-void
.end method

.method public onNothingSelected(Landroid/widget/AdapterView;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;)V"
        }
    .end annotation

    const-string p0, "RecordSettingsView"

    const-string p1, "Duration nothing selected"

    const/4 v0, 0x0

    .line 52
    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
