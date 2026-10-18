package com.yftech.bsvservice.util;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.SystemProperties;
import android.os.storage.StorageManager;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/* loaded from: /home/user/work/dex/classes.dex */
public class StorageUtil {
    private static final String IMAGE_SUFFIX = ".jpg";
    private static final int MAX_FILE_NUM = 149;
    private static final int MAX_NORMAL_SIZE = 8192;
    private static final int MAX_URGENT_SIZE = 2048;
    private static final int MIN_IMAGE_SIZE = 2;
    private static final int MIN_NORMAL_SIZE = 50;
    private static final int MIN_URGENT_SIZE = 50;
    private static final String MNT_MEDIA_RW = "/mnt/media_rw";
    private static final int REUSE_NORMAL_SIZE = 100;
    private static final String ROOT_DIR = "AtcCamera";
    private static final String SDCARD_MARK = "sdcard";
    private static final String STORAGE = "/storage";
    private static final String STORAGE_NUM = "atccamera.storage.num";
    private static final String TAG = "StorageUtil";
    private static final String UDISK1_MARK = "udisk1";
    private static final String UDISK2_MARK = "udisk2";
    private static final String UDISK3_MARK = "udisk3";
    private static final String VIDEO_SUFFIX = ".ts";
    public static volatile String sCurrentPath;
    private final String IMAGE_DIR;
    private final String NORMAL_DIR;
    private final String URGENT_DIR;
    private String mCameraTag;
    private Context mContext;
    private StorageManager mSm;
    private SpaceReusePolicy mNormalPolicy = new DefaultNormalReusePolicy();
    private SpaceReusePolicy mUrgentPolicy = new DefaultUrgentReusePolicy();
    private SpaceReusePolicy mImagePolicy = new DefaultImageReusePolicy();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public interface SpaceReusePolicy {
        boolean enoughSpaceAfterReuse(File file);

        void ensureFileNumWithinLimits(File file);
    }

    public StorageUtil(Context context, String str) {
        this.mSm = (StorageManager) context.getSystemService("storage");
        this.mContext = context;
        this.NORMAL_DIR = "normal_cam" + str;
        this.URGENT_DIR = "urgent_cam" + str;
        this.IMAGE_DIR = "image_cam" + str;
        this.mCameraTag = "_cam" + str;
    }

    public boolean setNormalPolicy(SpaceReusePolicy spaceReusePolicy) {
        if (spaceReusePolicy == null) {
            return false;
        }
        this.mNormalPolicy = spaceReusePolicy;
        return true;
    }

    public boolean setUrgentPolicy(SpaceReusePolicy spaceReusePolicy) {
        if (spaceReusePolicy == null) {
            return false;
        }
        this.mUrgentPolicy = spaceReusePolicy;
        return true;
    }

    public boolean setImagePolicy(SpaceReusePolicy spaceReusePolicy) {
        if (spaceReusePolicy == null) {
            return false;
        }
        this.mImagePolicy = spaceReusePolicy;
        return true;
    }

    private SpaceReusePolicy getSpaceReusePolicy(String str) {
        if (this.NORMAL_DIR.equalsIgnoreCase(str)) {
            return this.mNormalPolicy;
        }
        if (this.URGENT_DIR.equalsIgnoreCase(str)) {
            return this.mUrgentPolicy;
        }
        return this.mImagePolicy;
    }

    private boolean isVolumeMounted(String str) {
        String[] volumePaths = this.mSm.getVolumePaths();
        if (volumePaths != null && volumePaths.length > 0) {
            int length = volumePaths.length;
            for (int i = 1; i < length; i++) {
                if (volumePaths[i] != null && volumePaths[i].contains(str)) {
                    LogUtil.i(TAG, "path: " + volumePaths[i], new Object[0]);
                    if ("mounted".equals(this.mSm.getVolumeState(volumePaths[i]))) {
                        sCurrentPath = toPrivatePath(volumePaths[i]);
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public static String toPublicPath(String str) {
        if (str != null) {
            return str.replaceFirst(MNT_MEDIA_RW, STORAGE);
        }
        return null;
    }

    public static String toPrivatePath(String str) {
        if (str != null) {
            return str.replaceFirst(STORAGE, MNT_MEDIA_RW);
        }
        return null;
    }

    public int getDirSize(File file) {
        int dirSize;
        if (file == null || !file.exists()) {
            return 0;
        }
        File[] listFiles = file.listFiles();
        if (listFiles != null && listFiles.length > 0) {
            int i = 0;
            for (File file2 : listFiles) {
                if (file2.isFile()) {
                    dirSize = (int) (file2.length() / 1024);
                } else {
                    dirSize = getDirSize(file2);
                }
                i += dirSize;
            }
            return i;
        }
        LogUtil.d(TAG, "no file in " + file.getAbsolutePath(), new Object[0]);
        return 0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public File getRootDir() throws NoSDCardMountedException, NoUdiskMountedException, FileAlreadyExistException {
        int i = SystemProperties.getInt(STORAGE_NUM, 0);
        if (i == 1) {
            if (!isVolumeMounted(UDISK1_MARK)) {
                throw new NoUdiskMountedException();
            }
        } else if (i == 2) {
            if (!isVolumeMounted(UDISK2_MARK)) {
                throw new NoUdiskMountedException();
            }
        } else if (i == 3) {
            if (!isVolumeMounted(UDISK3_MARK)) {
                throw new NoUdiskMountedException();
            }
        } else if (!isVolumeMounted(SDCARD_MARK)) {
            throw new NoSDCardMountedException();
        }
        File file = new File(sCurrentPath, ROOT_DIR);
        if (!file.exists()) {
            file.mkdirs();
        } else if (file.isFile()) {
            throw new FileAlreadyExistException(ROOT_DIR);
        }
        return file;
    }

    public File getOutputFile(String str) throws NoSDCardMountedException, NoUdiskMountedException, SpaceNotEnoughException, FileAlreadyExistException {
        File rootDir = getRootDir();
        String str2 = str + this.mCameraTag;
        File file = new File(rootDir, str2);
        if (!file.exists()) {
            file.mkdirs();
        } else if (file.isFile()) {
            throw new FileAlreadyExistException(str2);
        }
        SpaceReusePolicy spaceReusePolicy = getSpaceReusePolicy(str2);
        spaceReusePolicy.ensureFileNumWithinLimits(file);
        if (spaceReusePolicy.enoughSpaceAfterReuse(file)) {
            return createFile(file, str2);
        }
        throw new SpaceNotEnoughException();
    }

    private File createFile(File file, String str) {
        File file2;
        LogUtil.d(TAG, "createFile()", new Object[0]);
        if (file == null) {
            LogUtil.d(TAG, "createFile fail, parentDir is null", new Object[0]);
            return null;
        }
        String format = new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(new Date());
        if (this.IMAGE_DIR.equalsIgnoreCase(str)) {
            file2 = new File(file, format + IMAGE_SUFFIX);
        } else {
            file2 = new File(file, format + VIDEO_SUFFIX);
        }
        LogUtil.d(TAG, "createNewFile start", new Object[0]);
        try {
            file2.createNewFile();
            LogUtil.d(TAG, "createNewFile end", new Object[0]);
            if (!this.IMAGE_DIR.equalsIgnoreCase(str)) {
                updateFileWithMediaScanner(file2);
            }
            return file2;
        } catch (IOException e) {
            LogUtil.e(TAG, "createNewFile error ," + e, new Object[0]);
            return null;
        }
    }

    public void updateFileWithMediaScanner(File file) {
        File file2 = new File(file.getAbsolutePath().replaceFirst(MNT_MEDIA_RW, STORAGE));
        LogUtil.d(TAG, "updateFile:" + file2, new Object[0]);
        Intent intent = new Intent("android.intent.action.MEDIA_SCANNER_SCAN_FILE");
        intent.setData(Uri.fromFile(file2));
        this.mContext.sendBroadcast(intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void getAllFilesOfDir(File file, List<FileWithLastModifiedTime> list) {
        File[] listFiles = file.listFiles();
        if (listFiles == null || listFiles.length == 0) {
            return;
        }
        for (File file2 : listFiles) {
            if (file2.isFile()) {
                FileWithLastModifiedTime fileWithLastModifiedTime = new FileWithLastModifiedTime();
                fileWithLastModifiedTime.file = file2;
                long j = 0;
                try {
                    j = file2.lastModified();
                } catch (Exception e) {
                    LogUtil.d(TAG, "getAllFilesOfDir fail: " + e, new Object[0]);
                }
                fileWithLastModifiedTime.lastModifiedTime = j;
                list.add(fileWithLastModifiedTime);
            }
        }
    }

    public boolean reuseStorageSpace(File file, File file2) {
        LogUtil.d(TAG, "reusePath = " + file.getAbsolutePath(), new Object[0]);
        int freeSpace = (int) ((file.getFreeSpace() / 1024) / 1024);
        int dirSize = getDirSize(file) / 1024;
        LogUtil.d(TAG, "before reuseStorageSpace, freeSize = " + freeSpace + ", spaceUsed = " + dirSize, new Object[0]);
        if (dirSize > 8092) {
            deleteOldFiles(file, file2, (dirSize - 8192) + 100);
        } else if (freeSpace < 100) {
            deleteOldFiles(file, file2, 100 - freeSpace);
        }
        int freeSpace2 = (int) ((file.getFreeSpace() / 1024) / 1024);
        int dirSize2 = getDirSize(file) / 1024;
        LogUtil.d(TAG, "after reuseStorageSpace, freeSize = " + freeSpace2 + ", spaceUsed = " + dirSize2, new Object[0]);
        return dirSize2 <= 8142 && freeSpace2 >= 50;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public static class FileComparator implements Comparator<FileWithLastModifiedTime> {
        private FileComparator() {
        }

        @Override // java.util.Comparator
        public int compare(FileWithLastModifiedTime fileWithLastModifiedTime, FileWithLastModifiedTime fileWithLastModifiedTime2) {
            if (fileWithLastModifiedTime == fileWithLastModifiedTime2) {
                return 0;
            }
            if (fileWithLastModifiedTime == null) {
                return -1;
            }
            if (fileWithLastModifiedTime2 != null && fileWithLastModifiedTime.lastModifiedTime <= fileWithLastModifiedTime2.lastModifiedTime) {
                return fileWithLastModifiedTime.lastModifiedTime < fileWithLastModifiedTime2.lastModifiedTime ? -1 : 0;
            }
            return 1;
        }
    }

    public boolean deleteOldFiles(File file, File file2, int i) {
        if (file == null || file.isFile() || !file.exists()) {
            LogUtil.d(TAG, "deleteEarliestFile fail, dir is null or is not a directory", new Object[0]);
            return false;
        }
        LinkedList linkedList = new LinkedList();
        getAllFilesOfDir(file, linkedList);
        if (linkedList.size() == 0 || (linkedList.size() == 1 && file2 != null && linkedList.get(0).file.getAbsolutePath().equals(file2.getAbsolutePath()))) {
            return false;
        }
        Collections.sort(linkedList, new FileComparator());
        int size = linkedList.size();
        int i2 = 0;
        for (int i3 = 0; i3 < size; i3++) {
            File file3 = linkedList.get(i3).file;
            if (file2 == null || !file3.getAbsolutePath().equals(file2.getAbsolutePath())) {
                int length = (int) ((file3.length() / 1024) / 1024);
                LogUtil.d(TAG, "delete file: " + file3.getAbsolutePath(), new Object[0]);
                try {
                    FileOutputStream fileOutputStream = new FileOutputStream(file3);
                    fileOutputStream.write(0);
                    fileOutputStream.flush();
                    fileOutputStream.close();
                    file3.delete();
                    updateFileWithMediaScanner(file3);
                    i2 += length;
                    if (i2 >= i) {
                        return true;
                    }
                } catch (Exception e) {
                    LogUtil.d(TAG, "deleteFile fail: " + e, new Object[0]);
                }
            }
        }
        return false;
    }

    public boolean deleteOldFiles(List<FileWithLastModifiedTime> list, int i) {
        Collections.sort(list, new FileComparator());
        int size = list.size();
        int i2 = 0;
        for (int i3 = 0; i3 < size; i3++) {
            File file = list.get(i3).file;
            LogUtil.d(TAG, "delete file: " + file.getAbsolutePath(), new Object[0]);
            try {
                FileOutputStream fileOutputStream = new FileOutputStream(file);
                fileOutputStream.write(0);
                fileOutputStream.flush();
                fileOutputStream.close();
                file.delete();
                updateFileWithMediaScanner(file);
                i2++;
            } catch (Exception e) {
                LogUtil.d(TAG, "deleteFile fail: " + e, new Object[0]);
            }
            if (i2 >= i) {
                return true;
            }
        }
        return false;
    }

    public void moveUrgentFileFromNormal(long j) {
        try {
            File rootDir = getRootDir();
            File file = new File(rootDir, this.NORMAL_DIR);
            File file2 = new File(rootDir, this.URGENT_DIR);
            if (file.exists()) {
                if (!file2.exists()) {
                    file2.mkdirs();
                }
                moveUrgentFilesInCertainTime(file, j - 30000, j + 30000);
            }
        } catch (Exception e) {
            LogUtil.d(TAG, "copy file fail: " + e, new Object[0]);
        }
    }

    private void moveUrgentFilesInCertainTime(File file, long j, long j2) {
        File[] listFiles = file.listFiles();
        if (listFiles == null || listFiles.length <= 0) {
            return;
        }
        for (File file2 : listFiles) {
            String absolutePath = file2.getAbsolutePath();
            boolean endsWith = absolutePath.endsWith(VIDEO_SUFFIX);
            if (file2.isFile() && endsWith) {
                long lastModified = file2.lastModified();
                if (j <= lastModified && lastModified <= j2) {
                    File file3 = new File(absolutePath.replace(this.NORMAL_DIR, this.URGENT_DIR));
                    file2.renameTo(file3);
                    updateFileWithMediaScanner(file3);
                    updateFileWithMediaScanner(file2);
                }
            }
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    class DefaultNormalReusePolicy implements SpaceReusePolicy {
        DefaultNormalReusePolicy() {
        }

        @Override // com.yftech.bsvservice.util.StorageUtil.SpaceReusePolicy
        public boolean enoughSpaceAfterReuse(File file) {
            int freeSpace = (int) ((file.getFreeSpace() / 1024) / 1024);
            int dirSize = StorageUtil.this.getDirSize(file) / 1024;
            LogUtil.d(StorageUtil.TAG, "enoughSpaceAtferReuse, freeSpace=" + freeSpace + ", spaceUsed=" + dirSize, new Object[0]);
            return dirSize > 8142 ? StorageUtil.this.deleteOldFiles(file, null, (dirSize + (-8192)) + 50) && ((int) ((file.getFreeSpace() / 1024) / 1024)) >= 50 : freeSpace >= 50 || StorageUtil.this.deleteOldFiles(file, null, 50 - freeSpace);
        }

        @Override // com.yftech.bsvservice.util.StorageUtil.SpaceReusePolicy
        public void ensureFileNumWithinLimits(File file) {
            LinkedList linkedList = new LinkedList();
            StorageUtil.this.getAllFilesOfDir(file, linkedList);
            int size = linkedList.size();
            LogUtil.d(StorageUtil.TAG, "isFileNumWithinLimitsAfterReuse, fileNum = " + size, new Object[0]);
            if (size > StorageUtil.MAX_FILE_NUM) {
                StorageUtil.this.deleteOldFiles(linkedList, size - StorageUtil.MAX_FILE_NUM);
            }
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    class DefaultUrgentReusePolicy implements SpaceReusePolicy {
        DefaultUrgentReusePolicy() {
        }

        @Override // com.yftech.bsvservice.util.StorageUtil.SpaceReusePolicy
        public boolean enoughSpaceAfterReuse(File file) {
            File file2;
            int freeSpace = (int) ((file.getFreeSpace() / 1024) / 1024);
            int dirSize = StorageUtil.this.getDirSize(file) / 1024;
            LogUtil.d(StorageUtil.TAG, "enoughSpaceAtferReuse, freeSpace=" + freeSpace + ", spaceUsed=" + dirSize, new Object[0]);
            if (dirSize > 1998) {
                return false;
            }
            if (freeSpace >= 50) {
                return true;
            }
            try {
                file2 = new File(StorageUtil.this.getRootDir(), StorageUtil.this.NORMAL_DIR);
            } catch (Exception e) {
                LogUtil.d(StorageUtil.TAG, e.toString(), new Object[0]);
                file2 = null;
            }
            return file2 != null && StorageUtil.this.deleteOldFiles(file2, null, 50 - freeSpace);
        }

        @Override // com.yftech.bsvservice.util.StorageUtil.SpaceReusePolicy
        public void ensureFileNumWithinLimits(File file) {
            LogUtil.d(StorageUtil.TAG, "isFileNumWithinLimitsAfterReuse", new Object[0]);
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    class DefaultImageReusePolicy implements SpaceReusePolicy {
        DefaultImageReusePolicy() {
        }

        @Override // com.yftech.bsvservice.util.StorageUtil.SpaceReusePolicy
        public boolean enoughSpaceAfterReuse(File file) {
            return ((int) ((file.getFreeSpace() / 1024) / 1024)) >= 2;
        }

        @Override // com.yftech.bsvservice.util.StorageUtil.SpaceReusePolicy
        public void ensureFileNumWithinLimits(File file) {
            LogUtil.d(StorageUtil.TAG, "isFileNumWithinLimitsAfterReuse", new Object[0]);
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public static class NoSDCardMountedException extends Exception {
        public NoSDCardMountedException() {
            super("there is no SD card mounted");
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public static class NoUdiskMountedException extends Exception {
        public NoUdiskMountedException() {
            super("there is no UDISK mounted");
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public static class SpaceNotEnoughException extends Exception {
        public SpaceNotEnoughException() {
            super("storage free space is nout enough");
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public static class FileAlreadyExistException extends Exception {
        public FileAlreadyExistException(String str) {
            super(str);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public static class FileWithLastModifiedTime {
        File file;
        long lastModifiedTime;

        private FileWithLastModifiedTime() {
        }
    }
}
