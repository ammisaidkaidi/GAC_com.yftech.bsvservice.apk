.class public Lcom/yftech/bsvservice/windowutil/CameraSelView;
.super Landroid/view/View;
.source "CameraSelView.java"


# instance fields
.field private trapeBottom:[[I

.field private trapeLeft:[[I

.field private trapeRight:[[I

.field private trapeTop:[[I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 6

    .line 14
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x4

    .line 8
    new-array v0, p1, [[I

    const/4 v1, 0x2

    new-array v2, v1, [I

    fill-array-data v2, :array_0

    const/4 v3, 0x0

    aput-object v2, v0, v3

    new-array v2, v1, [I

    fill-array-data v2, :array_1

    const/4 v4, 0x1

    aput-object v2, v0, v4

    new-array v2, v1, [I

    fill-array-data v2, :array_2

    aput-object v2, v0, v1

    new-array v2, v1, [I

    fill-array-data v2, :array_3

    const/4 v5, 0x3

    aput-object v2, v0, v5

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/CameraSelView;->trapeTop:[[I

    .line 9
    new-array v0, p1, [[I

    new-array v2, v1, [I

    fill-array-data v2, :array_4

    aput-object v2, v0, v3

    new-array v2, v1, [I

    fill-array-data v2, :array_5

    aput-object v2, v0, v4

    new-array v2, v1, [I

    fill-array-data v2, :array_6

    aput-object v2, v0, v1

    new-array v2, v1, [I

    fill-array-data v2, :array_7

    aput-object v2, v0, v5

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/CameraSelView;->trapeLeft:[[I

    .line 10
    new-array v0, p1, [[I

    new-array v2, v1, [I

    fill-array-data v2, :array_8

    aput-object v2, v0, v3

    new-array v2, v1, [I

    fill-array-data v2, :array_9

    aput-object v2, v0, v4

    new-array v2, v1, [I

    fill-array-data v2, :array_a

    aput-object v2, v0, v1

    new-array v2, v1, [I

    fill-array-data v2, :array_b

    aput-object v2, v0, v5

    iput-object v0, p0, Lcom/yftech/bsvservice/windowutil/CameraSelView;->trapeRight:[[I

    .line 11
    new-array p1, p1, [[I

    new-array v0, v1, [I

    fill-array-data v0, :array_c

    aput-object v0, p1, v3

    new-array v0, v1, [I

    fill-array-data v0, :array_d

    aput-object v0, p1, v4

    new-array v0, v1, [I

    fill-array-data v0, :array_e

    aput-object v0, p1, v1

    new-array v0, v1, [I

    fill-array-data v0, :array_f

    aput-object v0, p1, v5

    iput-object p1, p0, Lcom/yftech/bsvservice/windowutil/CameraSelView;->trapeBottom:[[I

    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_1
    .array-data 4
        0x180
        0x0
    .end array-data

    :array_2
    .array-data 4
        0xc8
        0xc8
    .end array-data

    :array_3
    .array-data 4
        0x64
        0xc8
    .end array-data

    :array_4
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_5
    .array-data 4
        0x180
        0x0
    .end array-data

    :array_6
    .array-data 4
        0xc8
        0xc8
    .end array-data

    :array_7
    .array-data 4
        0x64
        0xc8
    .end array-data

    :array_8
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_9
    .array-data 4
        0x180
        0x0
    .end array-data

    :array_a
    .array-data 4
        0xc8
        0xc8
    .end array-data

    :array_b
    .array-data 4
        0x64
        0xc8
    .end array-data

    :array_c
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_d
    .array-data 4
        0x180
        0x0
    .end array-data

    :array_e
    .array-data 4
        0xc8
        0xc8
    .end array-data

    :array_f
    .array-data 4
        0x64
        0xc8
    .end array-data
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 0

    .line 19
    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    return-void
.end method
