package com.yftech.bsvservice;

import android.view.Surface;

/* loaded from: /home/user/work/dex/classes.dex */
public class WrappedSurface {
    boolean mIsFromBackcar;
    Surface mSurface;

    public WrappedSurface(Surface surface, boolean z) {
        this.mSurface = surface;
        this.mIsFromBackcar = z;
    }

    public boolean isValid() {
        return this.mSurface.isValid();
    }

    public String toString() {
        return this.mSurface.toString();
    }
}
