package com.yftech.bsvservice.windowutil;

import android.content.Context;
import android.graphics.Canvas;
import android.view.View;

/* loaded from: /home/user/work/dex/classes.dex */
public class CameraSelView extends View {
    private int[][] trapeBottom;
    private int[][] trapeLeft;
    private int[][] trapeRight;
    private int[][] trapeTop;

    public CameraSelView(Context context) {
        super(context);
        this.trapeTop = new int[][]{new int[]{0, 0}, new int[]{384, 0}, new int[]{200, 200}, new int[]{100, 200}};
        this.trapeLeft = new int[][]{new int[]{0, 0}, new int[]{384, 0}, new int[]{200, 200}, new int[]{100, 200}};
        this.trapeRight = new int[][]{new int[]{0, 0}, new int[]{384, 0}, new int[]{200, 200}, new int[]{100, 200}};
        this.trapeBottom = new int[][]{new int[]{0, 0}, new int[]{384, 0}, new int[]{200, 200}, new int[]{100, 200}};
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
    }
}
