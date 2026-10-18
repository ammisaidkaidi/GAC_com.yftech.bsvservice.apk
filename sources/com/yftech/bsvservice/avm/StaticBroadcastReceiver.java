package com.yftech.bsvservice.avm;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.yftech.bsvservice.util.LogUtil;

/* loaded from: /home/user/work/dex/classes.dex */
public class StaticBroadcastReceiver extends BroadcastReceiver {
    private static final boolean DEBUG = true;
    private static final String TAG = "StaticBroadcastReceiver";

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        if (intent.getAction() != null) {
            if (intent.getAction().equals("com.yftech.action.AVM.CALIBRATION")) {
                LogUtil.d(TAG, "onReceive com.yftech.action.AVM.CALIBRATION", new Object[0]);
                return;
            }
            if (intent.getAction().equals("android.intent.action.ACTION_SHUTDOWN")) {
                LogUtil.d(TAG, "Intent.ACTION_SHUTDOWN", new Object[0]);
                AvmControl.getInstance().hideAvm();
                return;
            } else {
                if (intent.getAction().equals("com.yftech.bsvservice.SHOW_STATE")) {
                    LogUtil.d(TAG, "com.yftech.bsvservice.SHOW_STATE", new Object[0]);
                    return;
                }
                return;
            }
        }
        LogUtil.d(TAG, "intent.getAction() != null", new Object[0]);
    }
}
