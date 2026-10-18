.class public Lcom/yftech/bsvservice/util/StorageUtil;
.super Ljava/lang/Object;
.source "StorageUtil.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;,
        Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;,
        Lcom/yftech/bsvservice/util/StorageUtil$SpaceNotEnoughException;,
        Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;,
        Lcom/yftech/bsvservice/util/StorageUtil$NoSDCardMountedException;,
        Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;,
        Lcom/yftech/bsvservice/util/StorageUtil$DefaultImageReusePolicy;,
        Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;,
        Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;,
        Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;
    }
.end annotation


# static fields
.field private static final IMAGE_SUFFIX:Ljava/lang/String; = ".jpg"

.field private static final MAX_FILE_NUM:I = 0x95

.field private static final MAX_NORMAL_SIZE:I = 0x2000

.field private static final MAX_URGENT_SIZE:I = 0x800

.field private static final MIN_IMAGE_SIZE:I = 0x2

.field private static final MIN_NORMAL_SIZE:I = 0x32

.field private static final MIN_URGENT_SIZE:I = 0x32

.field private static final MNT_MEDIA_RW:Ljava/lang/String; = "/mnt/media_rw"

.field private static final REUSE_NORMAL_SIZE:I = 0x64

.field private static final ROOT_DIR:Ljava/lang/String; = "AtcCamera"

.field private static final SDCARD_MARK:Ljava/lang/String; = "sdcard"

.field private static final STORAGE:Ljava/lang/String; = "/storage"

.field private static final STORAGE_NUM:Ljava/lang/String; = "atccamera.storage.num"

.field private static final TAG:Ljava/lang/String; = "StorageUtil"

.field private static final UDISK1_MARK:Ljava/lang/String; = "udisk1"

.field private static final UDISK2_MARK:Ljava/lang/String; = "udisk2"

.field private static final UDISK3_MARK:Ljava/lang/String; = "udisk3"

.field private static final VIDEO_SUFFIX:Ljava/lang/String; = ".ts"

.field public static volatile sCurrentPath:Ljava/lang/String;


# instance fields
.field private final IMAGE_DIR:Ljava/lang/String;

.field private final NORMAL_DIR:Ljava/lang/String;

.field private final URGENT_DIR:Ljava/lang/String;

.field private mCameraTag:Ljava/lang/String;

.field private mContext:Landroid/content/Context;

.field private mImagePolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

.field private mNormalPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

.field private mSm:Landroid/os/storage/StorageManager;

.field private mUrgentPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    new-instance v0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/util/StorageUtil$DefaultNormalReusePolicy;-><init>(Lcom/yftech/bsvservice/util/StorageUtil;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mNormalPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    .line 52
    new-instance v0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/util/StorageUtil$DefaultUrgentReusePolicy;-><init>(Lcom/yftech/bsvservice/util/StorageUtil;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mUrgentPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    .line 53
    new-instance v0, Lcom/yftech/bsvservice/util/StorageUtil$DefaultImageReusePolicy;

    invoke-direct {v0, p0}, Lcom/yftech/bsvservice/util/StorageUtil$DefaultImageReusePolicy;-><init>(Lcom/yftech/bsvservice/util/StorageUtil;)V

    iput-object v0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mImagePolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    const-string v0, "storage"

    .line 60
    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/storage/StorageManager;

    iput-object v0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mSm:Landroid/os/storage/StorageManager;

    .line 61
    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mContext:Landroid/content/Context;

    .line 62
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "normal_cam"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->NORMAL_DIR:Ljava/lang/String;

    .line 63
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "urgent_cam"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->URGENT_DIR:Ljava/lang/String;

    .line 64
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "image_cam"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->IMAGE_DIR:Ljava/lang/String;

    .line 65
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "_cam"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mCameraTag:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$200(Lcom/yftech/bsvservice/util/StorageUtil;Ljava/io/File;Ljava/util/List;)V
    .locals 0

    .line 20
    invoke-direct {p0, p1, p2}, Lcom/yftech/bsvservice/util/StorageUtil;->getAllFilesOfDir(Ljava/io/File;Ljava/util/List;)V

    return-void
.end method

.method static synthetic access$300(Lcom/yftech/bsvservice/util/StorageUtil;)Ljava/io/File;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/yftech/bsvservice/util/StorageUtil$NoSDCardMountedException;,
            Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;,
            Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;
        }
    .end annotation

    .line 20
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil;->getRootDir()Ljava/io/File;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400(Lcom/yftech/bsvservice/util/StorageUtil;)Ljava/lang/String;
    .locals 0

    .line 20
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->NORMAL_DIR:Ljava/lang/String;

    return-object p0
.end method

.method private createFile(Ljava/io/File;Ljava/lang/String;)Ljava/io/File;
    .locals 5

    const-string v0, "StorageUtil"

    const-string v1, "createFile()"

    const/4 v2, 0x0

    .line 210
    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v0, 0x0

    if-nez p1, :cond_0

    const-string p0, "StorageUtil"

    const-string p1, "createFile fail, parentDir is null"

    .line 212
    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v0

    .line 215
    :cond_0
    new-instance v1, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyyMMdd_HHmmssSSS"

    invoke-direct {v1, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v1

    .line 217
    iget-object v3, p0, Lcom/yftech/bsvservice/util/StorageUtil;->IMAGE_DIR:Ljava/lang/String;

    invoke-virtual {v3, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 218
    new-instance v3, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".jpg"

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_0

    .line 220
    :cond_1
    new-instance v3, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".ts"

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    :goto_0
    const-string p1, "StorageUtil"

    const-string v1, "createNewFile start"

    .line 222
    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {p1, v1, v4}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 224
    :try_start_0
    invoke-virtual {v3}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    const-string p1, "StorageUtil"

    const-string v0, "createNewFile end"

    .line 229
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 231
    iget-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->IMAGE_DIR:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 232
    invoke-virtual {p0, v3}, Lcom/yftech/bsvservice/util/StorageUtil;->updateFileWithMediaScanner(Ljava/io/File;)V

    :cond_2
    return-object v3

    :catch_0
    move-exception p0

    const-string p1, "StorageUtil"

    .line 226
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "createNewFile error ,"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    new-array p2, v2, [Ljava/lang/Object;

    invoke-static {p1, p0, p2}, Lcom/yftech/bsvservice/util/LogUtil;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v0
.end method

.method private getAllFilesOfDir(Ljava/io/File;Ljava/util/List;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;",
            ">;)V"
        }
    .end annotation

    .line 248
    invoke-virtual {p1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_1

    .line 249
    array-length p1, p0

    if-eqz p1, :cond_1

    .line 250
    array-length p1, p0

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-ge v1, p1, :cond_1

    aget-object v2, p0, v1

    .line 251
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 252
    new-instance v3, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;

    const/4 v4, 0x0

    invoke-direct {v3, v4}, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;-><init>(Lcom/yftech/bsvservice/util/StorageUtil$1;)V

    .line 253
    iput-object v2, v3, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->file:Ljava/io/File;

    const-wide/16 v4, 0x0

    .line 256
    :try_start_0
    invoke-virtual {v2}, Ljava/io/File;->lastModified()J

    move-result-wide v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-wide v4, v6

    goto :goto_1

    :catch_0
    move-exception v2

    const-string v6, "StorageUtil"

    .line 258
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getAllFilesOfDir fail: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v7, v0, [Ljava/lang/Object;

    invoke-static {v6, v2, v7}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 260
    :goto_1
    iput-wide v4, v3, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->lastModifiedTime:J

    .line 261
    invoke-interface {p2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method private getRootDir()Ljava/io/File;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/yftech/bsvservice/util/StorageUtil$NoSDCardMountedException;,
            Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;,
            Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;
        }
    .end annotation

    const-string v0, "atccamera.storage.num"

    const/4 v1, 0x0

    .line 160
    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    const-string v0, "udisk1"

    .line 162
    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/util/StorageUtil;->isVolumeMounted(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    .line 163
    :cond_0
    new-instance p0, Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;

    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;-><init>()V

    throw p0

    :cond_1
    const/4 v1, 0x2

    if-ne v0, v1, :cond_3

    const-string v0, "udisk2"

    .line 166
    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/util/StorageUtil;->isVolumeMounted(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_2

    goto :goto_0

    .line 167
    :cond_2
    new-instance p0, Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;

    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;-><init>()V

    throw p0

    :cond_3
    const/4 v1, 0x3

    if-ne v0, v1, :cond_5

    const-string v0, "udisk3"

    .line 170
    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/util/StorageUtil;->isVolumeMounted(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_4

    goto :goto_0

    .line 171
    :cond_4
    new-instance p0, Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;

    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;-><init>()V

    throw p0

    :cond_5
    const-string v0, "sdcard"

    .line 174
    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/util/StorageUtil;->isVolumeMounted(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_8

    .line 178
    :goto_0
    new-instance p0, Ljava/io/File;

    sget-object v0, Lcom/yftech/bsvservice/util/StorageUtil;->sCurrentPath:Ljava/lang/String;

    const-string v1, "AtcCamera"

    invoke-direct {p0, v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 179
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_6

    .line 180
    invoke-virtual {p0}, Ljava/io/File;->mkdirs()Z

    goto :goto_1

    .line 181
    :cond_6
    invoke-virtual {p0}, Ljava/io/File;->isFile()Z

    move-result v0

    if-nez v0, :cond_7

    :goto_1
    return-object p0

    .line 182
    :cond_7
    new-instance p0, Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;

    const-string v0, "AtcCamera"

    invoke-direct {p0, v0}, Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 175
    :cond_8
    new-instance p0, Lcom/yftech/bsvservice/util/StorageUtil$NoSDCardMountedException;

    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil$NoSDCardMountedException;-><init>()V

    throw p0
.end method

.method private getSpaceReusePolicy(Ljava/lang/String;)Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;
    .locals 1

    .line 93
    iget-object v0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->NORMAL_DIR:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 94
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mNormalPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    return-object p0

    .line 95
    :cond_0
    iget-object v0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->URGENT_DIR:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 96
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mUrgentPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    return-object p0

    .line 98
    :cond_1
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mImagePolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    return-object p0
.end method

.method private isVolumeMounted(Ljava/lang/String;)Z
    .locals 8

    .line 103
    iget-object v0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mSm:Landroid/os/storage/StorageManager;

    invoke-virtual {v0}, Landroid/os/storage/StorageManager;->getVolumePaths()[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 104
    array-length v2, v0

    if-lez v2, :cond_1

    .line 105
    array-length v2, v0

    const/4 v3, 0x1

    move v4, v3

    :goto_0
    if-ge v4, v2, :cond_1

    .line 107
    aget-object v5, v0, v4

    if-eqz v5, :cond_0

    aget-object v5, v0, v4

    invoke-virtual {v5, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v5, "StorageUtil"

    .line 108
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "path: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v7, v0, v4

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-array v7, v1, [Ljava/lang/Object;

    invoke-static {v5, v6, v7}, Lcom/yftech/bsvservice/util/LogUtil;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 109
    iget-object v5, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mSm:Landroid/os/storage/StorageManager;

    aget-object v6, v0, v4

    invoke-virtual {v5, v6}, Landroid/os/storage/StorageManager;->getVolumeState(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "mounted"

    .line 110
    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 111
    aget-object p0, v0, v4

    invoke-static {p0}, Lcom/yftech/bsvservice/util/StorageUtil;->toPrivatePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/yftech/bsvservice/util/StorageUtil;->sCurrentPath:Ljava/lang/String;

    return v3

    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    return v1
.end method

.method private moveUrgentFilesInCertainTime(Ljava/io/File;JJ)V
    .locals 7

    .line 389
    invoke-virtual {p1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 390
    array-length v0, p1

    if-lez v0, :cond_2

    .line 391
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_2

    aget-object v2, p1, v1

    .line 392
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    const-string v4, ".ts"

    .line 393
    invoke-virtual {v3, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    .line 394
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v5

    if-eqz v5, :cond_1

    if-nez v4, :cond_0

    goto :goto_1

    .line 397
    :cond_0
    invoke-virtual {v2}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    cmp-long v6, p2, v4

    if-gtz v6, :cond_1

    cmp-long v4, v4, p4

    if-gtz v4, :cond_1

    .line 399
    iget-object v4, p0, Lcom/yftech/bsvservice/util/StorageUtil;->NORMAL_DIR:Ljava/lang/String;

    iget-object v5, p0, Lcom/yftech/bsvservice/util/StorageUtil;->URGENT_DIR:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 400
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 401
    invoke-virtual {v2, v4}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    .line 402
    invoke-virtual {p0, v4}, Lcom/yftech/bsvservice/util/StorageUtil;->updateFileWithMediaScanner(Ljava/io/File;)V

    .line 403
    invoke-virtual {p0, v2}, Lcom/yftech/bsvservice/util/StorageUtil;->updateFileWithMediaScanner(Ljava/io/File;)V

    :cond_1
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method public static toPrivatePath(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-eqz p0, :cond_0

    const-string v0, "/storage"

    const-string v1, "/mnt/media_rw"

    .line 130
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static toPublicPath(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-eqz p0, :cond_0

    const-string v0, "/mnt/media_rw"

    const-string v1, "/storage"

    .line 122
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method


# virtual methods
.method public deleteOldFiles(Ljava/io/File;Ljava/io/File;I)Z
    .locals 10

    const/4 v0, 0x0

    if-eqz p1, :cond_6

    .line 309
    invoke-virtual {p1}, Ljava/io/File;->isFile()Z

    move-result v1

    if-nez v1, :cond_6

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_3

    .line 313
    :cond_0
    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    .line 314
    invoke-direct {p0, p1, v1}, Lcom/yftech/bsvservice/util/StorageUtil;->getAllFilesOfDir(Ljava/io/File;Ljava/util/List;)V

    .line 315
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result p1

    if-eqz p1, :cond_5

    .line 316
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result p1

    const/4 v2, 0x1

    if-ne p1, v2, :cond_1

    if-eqz p2, :cond_1

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;

    iget-object p1, p1, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->file:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    goto/16 :goto_2

    .line 319
    :cond_1
    new-instance p1, Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;

    const/4 v3, 0x0

    invoke-direct {p1, v3}, Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;-><init>(Lcom/yftech/bsvservice/util/StorageUtil$1;)V

    invoke-static {v1, p1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 321
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result p1

    move v3, v0

    move v4, v3

    :goto_0
    if-ge v3, p1, :cond_4

    .line 323
    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;

    iget-object v5, v5, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->file:Ljava/io/File;

    if-eqz p2, :cond_2

    .line 324
    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    goto :goto_1

    .line 326
    :cond_2
    invoke-virtual {v5}, Ljava/io/File;->length()J

    move-result-wide v6

    const-wide/16 v8, 0x400

    div-long/2addr v6, v8

    div-long/2addr v6, v8

    long-to-int v6, v6

    const-string v7, "StorageUtil"

    .line 327
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "delete file: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    new-array v9, v0, [Ljava/lang/Object;

    invoke-static {v7, v8, v9}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 329
    :try_start_0
    new-instance v7, Ljava/io/FileOutputStream;

    invoke-direct {v7, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 330
    invoke-virtual {v7, v0}, Ljava/io/FileOutputStream;->write(I)V

    .line 331
    invoke-virtual {v7}, Ljava/io/FileOutputStream;->flush()V

    .line 332
    invoke-virtual {v7}, Ljava/io/FileOutputStream;->close()V

    .line 333
    invoke-virtual {v5}, Ljava/io/File;->delete()Z

    .line 334
    invoke-virtual {p0, v5}, Lcom/yftech/bsvservice/util/StorageUtil;->updateFileWithMediaScanner(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v4, v6

    if-lt v4, p3, :cond_3

    return v2

    :catch_0
    move-exception v5

    const-string v6, "StorageUtil"

    .line 336
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "deleteFile fail: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-array v7, v0, [Ljava/lang/Object;

    invoke-static {v6, v5, v7}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_3
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_4
    return v0

    :cond_5
    :goto_2
    return v0

    :cond_6
    :goto_3
    const-string p0, "StorageUtil"

    const-string p1, "deleteEarliestFile fail, dir is null or is not a directory"

    .line 310
    new-array p2, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return v0
.end method

.method public deleteOldFiles(Ljava/util/List;I)Z
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;",
            ">;I)Z"
        }
    .end annotation

    .line 348
    new-instance v0, Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/yftech/bsvservice/util/StorageUtil$FileComparator;-><init>(Lcom/yftech/bsvservice/util/StorageUtil$1;)V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 350
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x0

    move v2, v1

    move v3, v2

    :goto_0
    if-ge v2, v0, :cond_1

    .line 352
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;

    iget-object v4, v4, Lcom/yftech/bsvservice/util/StorageUtil$FileWithLastModifiedTime;->file:Ljava/io/File;

    const-string v5, "StorageUtil"

    .line 353
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "delete file: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-array v7, v1, [Ljava/lang/Object;

    invoke-static {v5, v6, v7}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 355
    :try_start_0
    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 356
    invoke-virtual {v5, v1}, Ljava/io/FileOutputStream;->write(I)V

    .line 357
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->flush()V

    .line 358
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V

    .line 359
    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    .line 360
    invoke-virtual {p0, v4}, Lcom/yftech/bsvservice/util/StorageUtil;->updateFileWithMediaScanner(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v3, v3, 0x1

    if-lt v3, p2, :cond_0

    const/4 p0, 0x1

    return p0

    :catch_0
    move-exception v4

    const-string v5, "StorageUtil"

    .line 362
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "deleteFile fail: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v6, v1, [Ljava/lang/Object;

    invoke-static {v5, v4, v6}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return v1
.end method

.method public getDirSize(Ljava/io/File;)I
    .locals 7

    const/4 v0, 0x0

    if-eqz p1, :cond_3

    .line 138
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 139
    invoke-virtual {p1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 140
    array-length v2, v1

    if-lez v2, :cond_2

    .line 141
    array-length p1, v1

    move v2, v0

    :goto_0
    if-ge v0, p1, :cond_1

    aget-object v3, v1, v0

    .line 142
    invoke-virtual {v3}, Ljava/io/File;->isFile()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 143
    invoke-virtual {v3}, Ljava/io/File;->length()J

    move-result-wide v3

    const-wide/16 v5, 0x400

    div-long/2addr v3, v5

    long-to-int v3, v3

    add-int/2addr v2, v3

    goto :goto_1

    .line 146
    :cond_0
    invoke-virtual {p0, v3}, Lcom/yftech/bsvservice/util/StorageUtil;->getDirSize(Ljava/io/File;)I

    move-result v3

    add-int/2addr v2, v3

    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v0, v2

    goto :goto_2

    :cond_2
    const-string p0, "StorageUtil"

    .line 150
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "no file in "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-array v1, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_3
    :goto_2
    return v0
.end method

.method public getOutputFile(Ljava/lang/String;)Ljava/io/File;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/yftech/bsvservice/util/StorageUtil$NoSDCardMountedException;,
            Lcom/yftech/bsvservice/util/StorageUtil$NoUdiskMountedException;,
            Lcom/yftech/bsvservice/util/StorageUtil$SpaceNotEnoughException;,
            Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;
        }
    .end annotation

    .line 192
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil;->getRootDir()Ljava/io/File;

    move-result-object v0

    .line 193
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mCameraTag:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 194
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 195
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 196
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    goto :goto_0

    .line 197
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v0

    if-nez v0, :cond_2

    .line 200
    :goto_0
    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/util/StorageUtil;->getSpaceReusePolicy(Ljava/lang/String;)Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    move-result-object v0

    .line 201
    invoke-interface {v0, v1}, Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;->ensureFileNumWithinLimits(Ljava/io/File;)V

    .line 202
    invoke-interface {v0, v1}, Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;->enoughSpaceAfterReuse(Ljava/io/File;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 203
    invoke-direct {p0, v1, p1}, Lcom/yftech/bsvservice/util/StorageUtil;->createFile(Ljava/io/File;Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    return-object p0

    .line 205
    :cond_1
    new-instance p0, Lcom/yftech/bsvservice/util/StorageUtil$SpaceNotEnoughException;

    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil$SpaceNotEnoughException;-><init>()V

    throw p0

    .line 198
    :cond_2
    new-instance p0, Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;

    invoke-direct {p0, p1}, Lcom/yftech/bsvservice/util/StorageUtil$FileAlreadyExistException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public moveUrgentFileFromNormal(J)V
    .locals 7

    .line 374
    :try_start_0
    invoke-direct {p0}, Lcom/yftech/bsvservice/util/StorageUtil;->getRootDir()Ljava/io/File;

    move-result-object v0

    .line 375
    new-instance v2, Ljava/io/File;

    iget-object v1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->NORMAL_DIR:Ljava/lang/String;

    invoke-direct {v2, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 376
    new-instance v1, Ljava/io/File;

    iget-object v3, p0, Lcom/yftech/bsvservice/util/StorageUtil;->URGENT_DIR:Ljava/lang/String;

    invoke-direct {v1, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 377
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 378
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 379
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    :cond_0
    const-wide/16 v0, 0x7530

    sub-long v3, p1, v0

    add-long v5, p1, v0

    move-object v1, p0

    .line 381
    invoke-direct/range {v1 .. v6}, Lcom/yftech/bsvservice/util/StorageUtil;->moveUrgentFilesInCertainTime(Ljava/io/File;JJ)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    const-string p1, "StorageUtil"

    .line 384
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "copy file fail: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    invoke-static {p1, p0, p2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public reuseStorageSpace(Ljava/io/File;Ljava/io/File;)Z
    .locals 8

    const-string v0, "StorageUtil"

    .line 268
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "reusePath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 269
    invoke-virtual {p1}, Ljava/io/File;->getFreeSpace()J

    move-result-wide v0

    const-wide/16 v3, 0x400

    div-long/2addr v0, v3

    div-long/2addr v0, v3

    long-to-int v0, v0

    .line 270
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/StorageUtil;->getDirSize(Ljava/io/File;)I

    move-result v1

    div-int/lit16 v1, v1, 0x400

    const-string v5, "StorageUtil"

    .line 271
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "before reuseStorageSpace, freeSize = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v7, ", spaceUsed = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {v5, v6, v7}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 v5, 0x64

    const/16 v6, 0x1f9c

    if-le v1, v6, :cond_0

    add-int/lit16 v1, v1, -0x2000

    add-int/2addr v1, v5

    .line 273
    invoke-virtual {p0, p1, p2, v1}, Lcom/yftech/bsvservice/util/StorageUtil;->deleteOldFiles(Ljava/io/File;Ljava/io/File;I)Z

    goto :goto_0

    :cond_0
    if-ge v0, v5, :cond_1

    sub-int/2addr v5, v0

    .line 275
    invoke-virtual {p0, p1, p2, v5}, Lcom/yftech/bsvservice/util/StorageUtil;->deleteOldFiles(Ljava/io/File;Ljava/io/File;I)Z

    .line 277
    :cond_1
    :goto_0
    invoke-virtual {p1}, Ljava/io/File;->getFreeSpace()J

    move-result-wide v0

    div-long/2addr v0, v3

    div-long/2addr v0, v3

    long-to-int p2, v0

    .line 278
    invoke-virtual {p0, p1}, Lcom/yftech/bsvservice/util/StorageUtil;->getDirSize(Ljava/io/File;)I

    move-result p0

    div-int/lit16 p0, p0, 0x400

    const-string p1, "StorageUtil"

    .line 279
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "after reuseStorageSpace, freeSize = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", spaceUsed = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 p1, 0x1fce

    if-gt p0, p1, :cond_3

    const/16 p0, 0x32

    if-ge p2, p0, :cond_2

    goto :goto_1

    :cond_2
    const/4 p0, 0x1

    return p0

    :cond_3
    :goto_1
    return v2
.end method

.method public setImagePolicy(Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;)Z
    .locals 0

    if-nez p1, :cond_0

    const/4 p0, 0x0

    return p0

    .line 88
    :cond_0
    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mImagePolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    const/4 p0, 0x1

    return p0
.end method

.method public setNormalPolicy(Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;)Z
    .locals 0

    if-nez p1, :cond_0

    const/4 p0, 0x0

    return p0

    .line 72
    :cond_0
    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mNormalPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    const/4 p0, 0x1

    return p0
.end method

.method public setUrgentPolicy(Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;)Z
    .locals 0

    if-nez p1, :cond_0

    const/4 p0, 0x0

    return p0

    .line 80
    :cond_0
    iput-object p1, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mUrgentPolicy:Lcom/yftech/bsvservice/util/StorageUtil$SpaceReusePolicy;

    const/4 p0, 0x1

    return p0
.end method

.method public updateFileWithMediaScanner(Ljava/io/File;)V
    .locals 3

    .line 238
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    const-string v0, "/mnt/media_rw"

    const-string v1, "/storage"

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 239
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const-string p1, "StorageUtil"

    .line 240
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "updateFile:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p1, v1, v2}, Lcom/yftech/bsvservice/util/LogUtil;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 241
    new-instance p1, Landroid/content/Intent;

    const-string v1, "android.intent.action.MEDIA_SCANNER_SCAN_FILE"

    invoke-direct {p1, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 242
    invoke-static {v0}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 243
    iget-object p0, p0, Lcom/yftech/bsvservice/util/StorageUtil;->mContext:Landroid/content/Context;

    invoke-virtual {p0, p1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method
