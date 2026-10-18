.class public Lcom/yftech/bsvservice/common/Archiver;
.super Ljava/lang/Object;
.source "Archiver.java"


# static fields
.field public static final BRIGHT_NESS:Ljava/lang/String; = "bright_ness"

.field public static final SHARED_PREFERENCE_NAME:Ljava/lang/String; = "avm_data"


# instance fields
.field private mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    iput-object p1, p0, Lcom/yftech/bsvservice/common/Archiver;->mContext:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public decodeIntForKey(Ljava/lang/String;)I
    .locals 2

    .line 29
    iget-object p0, p0, Lcom/yftech/bsvservice/common/Archiver;->mContext:Landroid/content/Context;

    const-string v0, "avm_data"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 30
    invoke-interface {p0, p1, v1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p0

    return p0
.end method

.method public encodeIntForKey(ILjava/lang/String;)Z
    .locals 2

    .line 15
    iget-object v0, p0, Lcom/yftech/bsvservice/common/Archiver;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 16
    :cond_0
    iget-object p0, p0, Lcom/yftech/bsvservice/common/Archiver;->mContext:Landroid/content/Context;

    const-string v0, "avm_data"

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 17
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    .line 18
    invoke-interface {p0, p2, p1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 19
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    const/4 p0, 0x1

    return p0
.end method

.method public isContains(Ljava/lang/String;)Z
    .locals 2

    .line 24
    iget-object p0, p0, Lcom/yftech/bsvservice/common/Archiver;->mContext:Landroid/content/Context;

    const-string v0, "avm_data"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 25
    invoke-interface {p0, p1}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method
