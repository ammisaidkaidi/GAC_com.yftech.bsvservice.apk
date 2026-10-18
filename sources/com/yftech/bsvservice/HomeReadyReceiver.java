package com.yftech.bsvservice;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.yftech.bsvservice.util.LogUtil;

/* loaded from: /home/user/work/dex/classes.dex */
public class HomeReadyReceiver extends BroadcastReceiver {
    private String ACTION_HOME_READY = "autochips.intent.action.HOME_READY";
    private String TAG = "HomeReadyReceiver";

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        LogUtil.d(this.TAG, "onReceive action: " + action, new Object[0]);
        if (!action.equals(this.ACTION_HOME_READY) || context == null) {
            return;
        }
        context.startForegroundService(new Intent(context, (Class<?>) BsvService.class));
    }
}
