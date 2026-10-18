.class Lcom/yftech/bsvservice/avm/AudioFocus$SingletonFactory;
.super Ljava/lang/Object;
.source "AudioFocus.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/avm/AudioFocus;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SingletonFactory"
.end annotation


# static fields
.field private static instance:Lcom/yftech/bsvservice/avm/AudioFocus;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 76
    new-instance v0, Lcom/yftech/bsvservice/avm/AudioFocus;

    invoke-direct {v0}, Lcom/yftech/bsvservice/avm/AudioFocus;-><init>()V

    sput-object v0, Lcom/yftech/bsvservice/avm/AudioFocus$SingletonFactory;->instance:Lcom/yftech/bsvservice/avm/AudioFocus;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/yftech/bsvservice/avm/AudioFocus;
    .locals 1

    .line 75
    sget-object v0, Lcom/yftech/bsvservice/avm/AudioFocus$SingletonFactory;->instance:Lcom/yftech/bsvservice/avm/AudioFocus;

    return-object v0
.end method
