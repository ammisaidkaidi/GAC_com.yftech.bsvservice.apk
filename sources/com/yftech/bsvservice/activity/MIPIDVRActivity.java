package com.yftech.bsvservice.activity;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.content.res.Configuration;
import android.os.Bundle;
import android.os.UserHandle;
import android.view.View;
import com.yftech.bsvservice.R;
import com.yftech.bsvservice.util.DVRConst;
import com.yftech.bsvservice.util.LogUtil;
import java.util.List;

/* loaded from: /home/user/work/dex/classes.dex */
public class MIPIDVRActivity extends Activity implements View.OnClickListener {
    private static final String TAG = "MIPIDVRActivity";
    private String mFrontMIPICameraId = DVRConst.MIPI_CAMERA_ID_FRONT;
    private String mBackMIPICameraId = "0";

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        LogUtil.i(TAG, "onCreate ", new Object[0]);
        requestWindowFeature(1);
        getWindow().setFlags(1024, 1024);
        setContentView(R.layout.activity_mipidvr);
    }

    @Override // android.app.Activity
    protected void onPause() {
        super.onPause();
        LogUtil.i(TAG, "onPause ", new Object[0]);
    }

    @Override // android.app.Activity
    protected void onStart() {
        super.onStart();
        LogUtil.d(TAG, "onStart", new Object[0]);
    }

    @Override // android.app.Activity
    protected void onStop() {
        super.onStop();
        LogUtil.d(TAG, "onStop", new Object[0]);
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        LogUtil.i(TAG, "onResume ", new Object[0]);
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        LogUtil.i(TAG, "onDestroy ", new Object[0]);
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        LogUtil.d(TAG, "onConfigurationChanged, newConfig.locale.language=" + configuration.locale.getLanguage(), new Object[0]);
        super.onConfigurationChanged(configuration);
        getResources().updateConfiguration(configuration, null);
    }

    private void sendHXBroadCast() {
        Intent intent = new Intent();
        intent.setAction("com.yftech.bsvservice.AVM_SHOW");
        List<ResolveInfo> queryBroadcastReceivers = getPackageManager().queryBroadcastReceivers(intent, 0);
        if (queryBroadcastReceivers == null || queryBroadcastReceivers.size() < 1) {
            return;
        }
        for (ResolveInfo resolveInfo : queryBroadcastReceivers) {
            Intent intent2 = new Intent(intent);
            ComponentName componentName = new ComponentName(resolveInfo.activityInfo.applicationInfo.packageName, resolveInfo.activityInfo.name);
            LogUtil.e(TAG, "packageName " + resolveInfo.activityInfo.applicationInfo.packageName + ",Receiver:" + resolveInfo.activityInfo.name, new Object[0]);
            intent2.setComponent(componentName);
            sendBroadcastAsUser(intent2, UserHandle.ALL);
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        LogUtil.w(TAG, "can not ust click!!!", new Object[0]);
    }
}
