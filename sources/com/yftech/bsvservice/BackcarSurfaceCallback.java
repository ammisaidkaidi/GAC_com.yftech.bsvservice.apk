package com.yftech.bsvservice;

import android.view.SurfaceHolder;
import com.yftech.bsvservice.util.LogUtil;

/* loaded from: /home/user/work/dex/classes.dex */
public class BackcarSurfaceCallback implements SurfaceHolder.Callback {
    private static final String TAG = "BackcarSurfaceCallback";
    String mCameraId;
    private BsvServiceImpl mService;

    public BackcarSurfaceCallback(String str, BsvServiceImpl bsvServiceImpl) {
        this.mCameraId = str;
        this.mService = bsvServiceImpl;
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
        LogUtil.d(TAG, "surfaceCreated, surface = " + surfaceHolder.getSurface(), new Object[0]);
        this.mService.startPreview(this.mCameraId, surfaceHolder.getSurface(), this.mService.isBackCar());
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
        LogUtil.d(TAG, "surfaceChanged, width=" + i2 + ", height=" + i3, new Object[0]);
    }

    @Override // android.view.SurfaceHolder.Callback
    public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
        LogUtil.d(TAG, "surfaceDestroyed, surface = " + surfaceHolder.getSurface(), new Object[0]);
    }
}
