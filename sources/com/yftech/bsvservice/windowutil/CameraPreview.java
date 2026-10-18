package com.yftech.bsvservice.windowutil;

import android.content.Context;
import android.content.res.Configuration;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import com.yftech.bsvservice.avm.AvmControl;
import com.yftech.bsvservice.util.LogUtil;

/* loaded from: /home/user/work/dex/classes.dex */
public class CameraPreview extends SurfaceView implements SurfaceHolder.Callback {
    private static final String TAG = "CameraPreview";
    private AvmControl mControl;
    SurfaceHolder surfaceHolder;

    public CameraPreview(Context context, AvmControl avmControl) {
        super(context);
        this.surfaceHolder = getHolder();
        this.surfaceHolder.addCallback(this);
        this.mControl = avmControl;
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
        LogUtil.d(TAG, "surfaceCreated ", new Object[0]);
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
        LogUtil.d(TAG, "surfaceDestroyed ", new Object[0]);
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
        LogUtil.d(TAG, "surfaceChanged  width=" + i2 + " height=" + i3, new Object[0]);
    }

    @Override // android.view.View
    protected void onConfigurationChanged(Configuration configuration) {
        LogUtil.d(TAG, "onConfigurationChanged newConfig.orientation=" + configuration.orientation, new Object[0]);
        super.onConfigurationChanged(configuration);
    }

    public void setFixedSize(int i, int i2) {
        LogUtil.d(TAG, "setFixedSize width=" + i + ",high:" + i2, new Object[0]);
        this.surfaceHolder.setFixedSize(i, i2);
    }
}
