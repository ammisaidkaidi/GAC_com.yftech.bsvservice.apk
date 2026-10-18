package com.yftech.bsvservice.common;

import android.content.Context;
import android.content.SharedPreferences;

/* loaded from: /home/user/work/dex/classes.dex */
public class Archiver {
    public static final String BRIGHT_NESS = "bright_ness";
    public static final String SHARED_PREFERENCE_NAME = "avm_data";
    private Context mContext;

    public Archiver(Context context) {
        this.mContext = context;
    }

    public boolean encodeIntForKey(int i, String str) {
        if (this.mContext == null) {
            return false;
        }
        SharedPreferences.Editor edit = this.mContext.getSharedPreferences(SHARED_PREFERENCE_NAME, 0).edit();
        edit.putInt(str, i);
        edit.apply();
        return true;
    }

    public boolean isContains(String str) {
        return this.mContext.getSharedPreferences(SHARED_PREFERENCE_NAME, 0).contains(str);
    }

    public int decodeIntForKey(String str) {
        return this.mContext.getSharedPreferences(SHARED_PREFERENCE_NAME, 0).getInt(str, 0);
    }
}
