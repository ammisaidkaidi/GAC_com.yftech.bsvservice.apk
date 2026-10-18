package com.yftech.bsvservice.util;

import android.support.annotation.NonNull;
import android.text.TextUtils;
import android.util.Log;

/* loaded from: /home/user/work/dex/classes.dex */
public class LogUtil {
    private static final boolean FORCE_DEBUG = true;
    private static final String SEPARATOR = "- ";
    private static final String TAG = "[YF_BsvService]";

    private LogUtil() {
    }

    public static void v(@NonNull String str, @NonNull String str2, @NonNull Object... objArr) {
        println(2, TAG, str, str2, objArr);
    }

    public static void d(@NonNull String str, @NonNull String str2, @NonNull Object... objArr) {
        println(3, TAG, str, str2, objArr);
    }

    public static void i(@NonNull String str, @NonNull String str2, @NonNull Object... objArr) {
        println(4, TAG, str, str2, objArr);
    }

    public static void w(@NonNull String str, @NonNull String str2, @NonNull Object... objArr) {
        println(5, TAG, str, str2, objArr);
    }

    public static void e(@NonNull String str, @NonNull String str2, @NonNull Object... objArr) {
        println(6, TAG, str, str2, objArr);
    }

    public static void e(@NonNull String str, @NonNull String str2, @NonNull Throwable th) {
        if (TextUtils.isEmpty(str2)) {
            return;
        }
        println(6, TAG, str, str2 + "\n" + Log.getStackTraceString(th), new Object[0]);
    }

    private static void println(int i, @NonNull String str, @NonNull String str2, @NonNull String str3, @NonNull Object... objArr) {
        boolean z = objArr == null || objArr.length > 0;
        if (i < 4) {
            Log.isLoggable(str2, i);
        }
        String str4 = SEPARATOR + str2;
        if (!TextUtils.isEmpty(str3)) {
            StringBuilder sb = new StringBuilder();
            sb.append(str4);
            sb.append(SEPARATOR);
            if (z) {
                str3 = String.format(str3, objArr);
            }
            sb.append(str3);
            str4 = sb.toString();
        }
        Log.println(i, str, str4);
    }
}
