.class final enum Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;
.super Ljava/lang/Enum;
.source "WatermarkSettingsView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/activity/WatermarkSettingsView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "ValueType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

.field public static final enum HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

.field public static final enum ON_OFF:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

.field public static final enum START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

.field public static final enum START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

.field public static final enum WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .line 286
    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const-string v1, "START_X"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const-string v1, "START_Y"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const-string v1, "WIDTH"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const-string v1, "HEIGHT"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const-string v1, "ON_OFF"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->ON_OFF:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    const/4 v0, 0x5

    .line 285
    new-array v0, v0, [Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_X:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    aput-object v1, v0, v2

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->START_Y:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    aput-object v1, v0, v3

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->WIDTH:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    aput-object v1, v0, v4

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->HEIGHT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    aput-object v1, v0, v5

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->ON_OFF:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    aput-object v1, v0, v6

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->$VALUES:[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 285
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;
    .locals 1

    .line 285
    const-class v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    return-object p0
.end method

.method public static values()[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;
    .locals 1

    .line 285
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->$VALUES:[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    invoke-virtual {v0}, [Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ValueType;

    return-object v0
.end method
