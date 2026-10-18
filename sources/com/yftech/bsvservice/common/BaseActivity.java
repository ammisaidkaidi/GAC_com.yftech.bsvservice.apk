package com.yftech.bsvservice.common;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import com.yftech.bsvservice.util.HandlerThreadHandler;

/* loaded from: /home/user/work/dex/classes.dex */
public class BaseActivity extends Activity {
    private static boolean DEBUG = false;
    private static final String TAG = "BaseActivity";
    private Handler mWorkerHandler;
    private final Handler mUIHandler = new Handler(Looper.getMainLooper());
    private final Thread mUiThread = this.mUIHandler.getLooper().getThread();
    private long mWorkerThreadID = -1;

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        if (this.mWorkerHandler == null) {
            this.mWorkerHandler = HandlerThreadHandler.createHandler(TAG);
            this.mWorkerThreadID = this.mWorkerHandler.getLooper().getThread().getId();
        }
    }

    @Override // android.app.Activity
    protected void onPause() {
        super.onPause();
    }

    @Override // android.app.Activity
    protected synchronized void onDestroy() {
        if (this.mWorkerHandler != null) {
            try {
                this.mWorkerHandler.getLooper().quit();
            } catch (Exception unused) {
            }
            this.mWorkerHandler = null;
        }
        super.onDestroy();
    }

    public final void runOnUiThread(Runnable runnable, long j) {
        if (runnable == null) {
            return;
        }
        this.mUIHandler.removeCallbacks(runnable);
        if (j > 0 || Thread.currentThread() != this.mUiThread) {
            this.mUIHandler.postDelayed(runnable, j);
            return;
        }
        try {
            runnable.run();
        } catch (Exception e) {
            Log.w(TAG, e);
        }
    }

    public final void removeFromUiThread(Runnable runnable) {
        if (runnable == null) {
            return;
        }
        this.mUIHandler.removeCallbacks(runnable);
    }

    protected final synchronized void queueEvent(Runnable runnable, long j) {
        if (runnable != null) {
            if (this.mWorkerHandler != null) {
                try {
                    this.mWorkerHandler.removeCallbacks(runnable);
                    if (j > 0) {
                        this.mWorkerHandler.postDelayed(runnable, j);
                    } else if (this.mWorkerThreadID == Thread.currentThread().getId()) {
                        runnable.run();
                    } else {
                        this.mWorkerHandler.post(runnable);
                    }
                } catch (Exception unused) {
                }
            }
        }
    }

    protected final synchronized void removeEvent(Runnable runnable) {
        if (runnable == null) {
            return;
        }
        try {
            this.mWorkerHandler.removeCallbacks(runnable);
        } catch (Exception unused) {
        }
    }
}
