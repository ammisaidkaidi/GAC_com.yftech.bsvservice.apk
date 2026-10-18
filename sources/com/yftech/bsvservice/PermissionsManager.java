package com.yftech.bsvservice;

import android.app.Activity;
import android.net.Uri;
import android.os.Environment;
import android.os.storage.StorageManager;
import android.os.storage.StorageVolume;
import com.yftech.bsvservice.util.LogUtil;
import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

/* loaded from: /home/user/work/dex/classes.dex */
public class PermissionsManager {
    public static final int CAMERA_REQUEST_CODE = 110;
    public static final int EXTERNAL_STORAGE_ACCESS_REQ_CODE = 130;
    private static final String TAG = "PermissionsManager";
    public static final int VIDEO_REQUEST_CODE = 120;
    private static StorageVolume externalVolume;
    private static Method getPath;
    private static StorageManager storageManager;
    private Uri ext_sd_uri;
    public static final String[] CAMERA_PERMISSIONS = {"android.permission.CAMERA"};
    public static final String[] VIDEO_PERMISSIONS = {"android.permission.CAMERA", "android.permission.RECORD_AUDIO", "android.permission.WRITE_EXTERNAL_STORAGE"};
    private static ArrayList<String> permissons = new ArrayList<>();

    private static void requestCameraPermission(Activity activity) {
        permissons.add("android.permission.CAMERA");
        activity.requestPermissions((String[]) permissons.toArray(new String[permissons.size()]), 110);
    }

    public static void requesetExtCardPermission(Activity activity) {
        storageManager = (StorageManager) activity.getApplication().getSystemService("storage");
        LogUtil.e(TAG, "onCreate()1", new Object[0]);
        List<StorageVolume> storageVolumes = storageManager.getStorageVolumes();
        LogUtil.e(TAG, "onCreate()2", new Object[0]);
        try {
            for (StorageVolume storageVolume : storageVolumes) {
                LogUtil.e(TAG, "onCreate()3", new Object[0]);
                if ("mounted".equalsIgnoreCase(storageVolume.getState())) {
                    LogUtil.e(TAG, "onCreate()4", new Object[0]);
                    getPath = storageVolume.getClass().getMethod("getPath", new Class[0]);
                    String str = (String) getPath.invoke(storageVolume, new Object[0]);
                    LogUtil.e(TAG, str, new Object[0]);
                    if (Environment.isExternalStorageRemovable(new File(str))) {
                        LogUtil.i(TAG, "This is external card", new Object[0]);
                        activity.startActivityForResult(storageVolume.createAccessIntent(null), EXTERNAL_STORAGE_ACCESS_REQ_CODE);
                        externalVolume = storageVolume;
                    }
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e2) {
            e2.printStackTrace();
        } catch (InvocationTargetException e3) {
            e3.printStackTrace();
        }
    }

    private static void requestVideoRecordPermission(Activity activity) {
        permissons.add("android.permission.CAMERA");
        permissons.add("android.permission.WRITE_EXTERNAL_STORAGE");
        permissons.add("android.permission.RECORD_AUDIO");
        activity.requestPermissions((String[]) permissons.toArray(new String[permissons.size()]), 120);
    }

    public static boolean checkCameraPermission(Activity activity) {
        if (hasPermissionGranted(activity, CAMERA_PERMISSIONS)) {
            return true;
        }
        requestCameraPermission(activity);
        return false;
    }

    public static boolean checkVideoRecordPermission(Activity activity) {
        if (hasPermissionGranted(activity, VIDEO_PERMISSIONS)) {
            return true;
        }
        requestVideoRecordPermission(activity);
        return false;
    }

    private static boolean hasPermissionGranted(Activity activity, String[] strArr) {
        for (String str : strArr) {
            if (activity.checkSelfPermission(str) != 0) {
                return false;
            }
        }
        return true;
    }
}
