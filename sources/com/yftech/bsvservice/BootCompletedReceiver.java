package com.yftech.bsvservice;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.yftech.bsvservice.avm.AvmControl;
import com.yftech.bsvservice.util.LogUtil;

/* loaded from: /home/user/work/dex/classes.dex */
public class BootCompletedReceiver extends BroadcastReceiver {
    private String TAG = "BootCompletedReceiver";

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        LogUtil.d(this.TAG, "onReceive action: " + action, new Object[0]);
        if (action.equals("android.intent.action.BOOT_COMPLETED")) {
            if (context != null) {
                context.startForegroundService(new Intent(context, (Class<?>) BsvService.class));
            }
        } else if (action.equals("com.yftech.bsvservice.AVM_SHOW")) {
            LogUtil.d(this.TAG, "receive com.yftech.bsvservice.AVM_SHOW", new Object[0]);
            AvmControl.getInstance().userRequestShowAvm();
        } else if (action.equals("android.intent.action.LOCALE_CHANGED")) {
            LogUtil.d(this.TAG, "android.intent.action.LOCALE_CHANGED", new Object[0]);
            if (AvmControl.getInstance().getWindow() != null) {
                AvmControl.getInstance().getWindow().updateWindow();
            }
        }
    }
}
