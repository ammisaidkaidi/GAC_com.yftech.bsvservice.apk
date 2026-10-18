.class public final enum Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;
.super Ljava/lang/Enum;
.source "WatermarkSettingsView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/activity/WatermarkSettingsView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ActionType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

.field public static final enum PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

.field public static final enum RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

.field public static final enum SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 290
    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    const-string v1, "PREVIEW"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    const-string v1, "RECORD"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    new-instance v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    const-string v1, "SNAPSHOT"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    const/4 v0, 0x3

    .line 289
    new-array v0, v0, [Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->PREVIEW:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    aput-object v1, v0, v2

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->RECORD:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    aput-object v1, v0, v3

    sget-object v1, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->SNAPSHOT:Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    aput-object v1, v0, v4

    sput-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->$VALUES:[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 289
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;
    .locals 1

    .line 289
    const-class v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    return-object p0
.end method

.method public static values()[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;
    .locals 1

    .line 289
    sget-object v0, Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->$VALUES:[Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    invoke-virtual {v0}, [Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/yftech/bsvservice/activity/WatermarkSettingsView$ActionType;

    return-object v0
.end method
