.class Lcom/yftech/bsvservice/CameraOperation$MoveUrgentFileTask;
.super Landroid/os/AsyncTask;
.source "CameraOperation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/yftech/bsvservice/CameraOperation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "MoveUrgentFileTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Long;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field private mSp:Lcom/yftech/bsvservice/util/StorageUtil;


# direct methods
.method public constructor <init>(Lcom/yftech/bsvservice/util/StorageUtil;)V
    .locals 0

    .line 1403
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    .line 1404
    iput-object p1, p0, Lcom/yftech/bsvservice/CameraOperation$MoveUrgentFileTask;->mSp:Lcom/yftech/bsvservice/util/StorageUtil;

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 1400
    check-cast p1, [Ljava/lang/Long;

    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/CameraOperation$MoveUrgentFileTask;->doInBackground([Ljava/lang/Long;)Ljava/lang/Void;

    move-result-object p0

    return-object p0
.end method

.method protected varargs doInBackground([Ljava/lang/Long;)Ljava/lang/Void;
    .locals 2

    .line 1408
    iget-object p0, p0, Lcom/yftech/bsvservice/CameraOperation$MoveUrgentFileTask;->mSp:Lcom/yftech/bsvservice/util/StorageUtil;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/yftech/bsvservice/util/StorageUtil;->moveUrgentFileFromNormal(J)V

    const/4 p0, 0x0

    return-object p0
.end method
