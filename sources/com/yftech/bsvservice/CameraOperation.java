package com.yftech.bsvservice;

import android.content.Context;
import android.graphics.Rect;
import android.graphics.SurfaceTexture;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CaptureFailure;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.media.Image;
import android.media.ImageReader;
import android.media.MediaCodec;
import android.media.MediaRecorder;
import android.os.AsyncTask;
import android.os.Handler;
import android.os.SystemProperties;
import android.util.Range;
import android.util.Size;
import android.view.Surface;
import com.autochips.backcar.BackCar;
import com.autochips.metazone.AtcMetazone;
import com.yftech.bsvservice.util.LogUtil;
import com.yftech.bsvservice.util.StorageUtil;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

/* loaded from: /home/user/work/dex/classes.dex */
public class CameraOperation {
    private static final String ATC_BRIGHTNESS_KEY_NAME = "com.atc.color_process.brightness";
    private static final String ATC_CONTRAST_KEY_NAME = "com.atc.color_process.contrast";
    private static final String ATC_HUE_KEY_NAME = "com.atc.color_process.hue";
    private static final String ATC_MIRROR_KEY_NAME = "com.atc.mirror";
    private static final String ATC_SATURATION_KEY_NAME = "com.atc.color_process.saturation";
    private static final String ATC_SOURCEINFO_KEY_NAME = "com.atc.sourceinfo";
    private static final String ATC_WATERMARK_PREVIEW_KEY_NAME = "com.atc.watermark.info.preview";
    private static final String ATC_WATERMARK_RECORD_KEY_NAME = "com.atc.watermark.info.record";
    private static final String ATC_WATERMARK_SNAPSHOT_KEY_NAME = "com.atc.watermark.info.snapshot";
    private static final int AUDIO_CHANNEL_NUM = 2;
    private static final int AUDIO_ENCODE_BIT_RATE = 96000;
    private static final int AUDIO_SAMPLE_RATE = 44100;
    private static final int BRIGHTNESS_ADDR = 65560;
    private static final int CONTRAST_ADDR = 65562;
    private static final int DEFAULT_HEIGHT = 720;
    private static final long DEFAULT_NORMAL_RECORD_TIME = 300000;
    private static final long DEFAULT_URGENT_RECORD_TIME = 30000;
    private static final int DEFAULT_WATERMARK_START_H = 50;
    private static final int DEFAULT_WATERMARK_START_W = 300;
    private static final int DEFAULT_WATERMARK_START_X = 20;
    private static final int DEFAULT_WATERMARK_START_Y = 20;
    private static final int DEFAULT_WIDTH = 1280;
    private static final int FRAMES_MAYBE_WRONG = 30;
    private static final int HUE_ADDR = 65559;
    private static final int H_CUT_ADDR = 65555;
    public static final String IMAGE_TPYE = "image";
    private static final int MEDIA_RECORDER_INFO_RECORDING_SIZE = 895;
    private static final int MEDIA_RECORDER_INFO_WRITE_SLOW = 899;
    private static final int MEDIA_RECORDER_INFO_WRITE_TOO_SLOW = 900;
    private static final int MIR_ADDR = 65546;
    public static final String NORMAL_TYPE = "normal";
    private static final int SATURATION_ADDR = 65561;
    public static final String URGENT_TYPE = "urgent";
    private static final int VIDEO_ENCODE_BIT_RATE = 5242880;
    private static final int VIDEO_FRAME_RATE = 30;
    private static final int W_CUT_ADDR = 65554;
    private static final int X_CUT_ADDR = 65552;
    private static final int Y_CUT_ADDR = 65553;
    private int mActionType;
    private CaptureRequest.Key<int[]> mBrightnessKey;
    private CameraDevice mCameraDevice;
    private int mCameraFPS;
    private final String mCameraId;
    private CameraOperationCallback mCameraOperationCallback;
    private CaptureRequest.Builder mCaptureRequestBuilder;
    private CameraCaptureSession mCaptureSession;
    private Context mContext;
    private CaptureRequest.Key<int[]> mContrastKey;
    private boolean mHaveSignal;
    private CaptureRequest.Key<int[]> mHueKey;
    private ImageReader mImageReader;
    private boolean mIsChangingResolution;
    private volatile boolean mIsNormalPreviewRequested;
    private volatile boolean mIsPreviewing;
    private volatile boolean mIsRecording;
    private volatile boolean mIsUrgentRecording;
    private CaptureRequest.Key<int[]> mMirrorKey;
    private int mMirrorVal;
    private WrappedSurface mNextPreviewSurface;
    private boolean mNoNeedStartRecord;
    private long mNormalRecordStartTime;
    private WrappedSurface mPendingPreviewSurface;
    private volatile boolean mPreviewRequested;
    private WrappedSurface mPreviewSurface;
    private volatile boolean mRecordRequested;
    private MediaRecorder mRecorder;
    private Surface mRecorderSurface;
    private File mRecordingFile;
    private boolean mRespondRVCFirstFrame;
    private CaptureRequest.Key<int[]> mSaturationKey;
    private CaptureResult.Key<int[]> mSourceInfoKey;
    private Timer mStorageCheckerThread;
    private StorageUtil mStorageUtil;
    private Size[] mSupportedResolutions;
    private long mUrgentRecordTriggeredTime;
    private CaptureRequest.Key<int[]> mWatermarkPreviewKey;
    private CaptureRequest.Key<int[]> mWatermarkRecordKey;
    private CaptureRequest.Key<int[]> mWatermarkSnapshotKey;
    private String TAG = "CameraOperation";
    private List<Surface> mSurfaceList = new ArrayList(3);
    private Handler mRecordThreadHandler = new Handler();
    private boolean mUpdateHueFromMetazone = true;
    private boolean mUpdateBrightnessFromMetazone = true;
    private boolean mUpdateSaturationFromMetazone = true;
    private boolean mUpdateContrastFromMetazone = true;
    private int mFramesShouldSkipped = 30;
    private Size mVideoSize = new Size(1280, 720);
    private Rect mCamRect = new Rect();
    private boolean mIsMicOn = true;
    private int mHueValue = 128;
    private int mBrightnessValue = 128;
    private int mSaturationValue = 128;
    private int mContrastValue = 128;
    private boolean[] mWatermarkSwitchs = {false, false, false};
    private int[] mStartXValues = {20, 20, 20};
    private int[] mStartYValues = {20, 20, 20};
    private int[] mWidthValues = {300, 300, 300};
    private int[] mHeightValues = {50, 50, 50};
    private long mVideoDuration = DEFAULT_NORMAL_RECORD_TIME;
    private CameraDevice.StateCallback mStateCallback = new CameraDevice.StateCallback() { // from class: com.yftech.bsvservice.CameraOperation.1
        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public void onClosed(CameraDevice cameraDevice) {
            LogUtil.d(CameraOperation.this.TAG, "onClosed", new Object[0]);
            super.onClosed(cameraDevice);
            CameraOperation.this.mCameraDevice = null;
            CameraOperation.this.mIsPreviewing = false;
            CameraOperation.this.mIsRecording = false;
            CameraOperation.this.notifyOperationCallback(2, true, 0);
        }

        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public void onOpened(CameraDevice cameraDevice) {
            LogUtil.d(CameraOperation.this.TAG, "onOpened", new Object[0]);
            CameraOperation.this.updateCameraCharacter();
            CameraOperation.this.mCameraDevice = cameraDevice;
            CameraOperation.this.notifyOperationCallback(1, true, 0);
        }

        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public void onDisconnected(CameraDevice cameraDevice) {
            LogUtil.d(CameraOperation.this.TAG, "camera disconnected", new Object[0]);
            CameraOperation.this.close();
            CameraOperation.this.notifyOperationCallback(1, false, 6);
        }

        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public void onError(CameraDevice cameraDevice, int i) {
            LogUtil.d(CameraOperation.this.TAG, "camera open error: " + i, new Object[0]);
            if (i == 5 || i == 4) {
                if (CameraOperation.this.mRecorderSurface != null) {
                    CameraOperation.this.mRecorderSurface.release();
                    CameraOperation.this.mRecorderSurface = null;
                }
                CameraOperation.this.setupNewImageReader(CameraOperation.this.mVideoSize.getWidth(), CameraOperation.this.mVideoSize.getHeight());
            }
            CameraOperation.this.close();
            CameraOperation.this.notifyOperationCallback(1, false, 7);
            CameraOperation.this.notifyOperationCallback(14, false, 20);
        }
    };
    private CameraCaptureSession.CaptureCallback mCaptureCallback = new CameraCaptureSession.CaptureCallback() { // from class: com.yftech.bsvservice.CameraOperation.3
        @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
        public void onCaptureProgressed(CameraCaptureSession cameraCaptureSession, CaptureRequest captureRequest, CaptureResult captureResult) {
        }

        @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
        public void onCaptureCompleted(CameraCaptureSession cameraCaptureSession, CaptureRequest captureRequest, TotalCaptureResult totalCaptureResult) {
            int[] iArr;
            if (CameraOperation.this.mRespondRVCFirstFrame) {
                CameraOperation.this.mRespondRVCFirstFrame = false;
                LogUtil.d(CameraOperation.this.TAG, "first frame with rvc mode", new Object[0]);
                new BackCar().sendRVCCompleted();
            }
            if (CameraOperation.this.mSourceInfoKey == null || (iArr = (int[]) totalCaptureResult.get(CameraOperation.this.mSourceInfoKey)) == null || iArr.length < 2) {
                return;
            }
            if (iArr[0] == 0 && iArr[1] == 0) {
                if (CameraOperation.this.mFramesShouldSkipped == 0) {
                    LogUtil.i(CameraOperation.this.TAG, "onCaptureCompleted: INFO_NO_SIGNAL", new Object[0]);
                    CameraOperation.this.notifyOperationCallback(14, false, 15);
                    CameraOperation.access$1510(CameraOperation.this);
                } else if (CameraOperation.this.mFramesShouldSkipped >= 0) {
                    CameraOperation.access$1510(CameraOperation.this);
                }
                CameraOperation.this.mHaveSignal = false;
                return;
            }
            if (iArr[0] <= 0 || iArr[1] <= 0 || CameraOperation.this.mHaveSignal) {
                CameraOperation.this.mFramesShouldSkipped = 30;
                return;
            }
            LogUtil.d(CameraOperation.this.TAG, "signal comes, width = " + iArr[0] + ", height = " + iArr[1], new Object[0]);
            CameraOperation.this.notifyOperationCallback(14, false, 18);
            CameraOperation.this.mFramesShouldSkipped = 30;
            CameraOperation.this.mHaveSignal = true;
        }
    };
    private Runnable mNormalRecordTask = new Runnable() { // from class: com.yftech.bsvservice.CameraOperation.5
        @Override // java.lang.Runnable
        public void run() {
            LogUtil.d(CameraOperation.this.TAG, "mNormalRecordTask, mIsRecording=" + CameraOperation.this.mIsRecording, new Object[0]);
            CameraOperation.this.stopRecycleTask();
            if (CameraOperation.this.mRecordRequested && CameraOperation.this.mIsRecording) {
                CameraOperation.this.goOnRecording();
            }
        }
    };
    private Runnable mUrgentRecordTask = new Runnable() { // from class: com.yftech.bsvservice.CameraOperation.6
        @Override // java.lang.Runnable
        public void run() {
            LogUtil.d(CameraOperation.this.TAG, "mUrgentRecordTask, mIsRecording=" + CameraOperation.this.mIsRecording, new Object[0]);
            CameraOperation.this.stopRecycleTask();
            if (CameraOperation.this.mRecordRequested && CameraOperation.this.mIsRecording) {
                CameraOperation.this.mIsUrgentRecording = false;
                CameraOperation.this.notifyOperationCallback(8, true, 0);
                CameraOperation.this.goOnRecording();
            }
        }
    };
    private Runnable mDelayedUrgentRecordTask = new Runnable() { // from class: com.yftech.bsvservice.CameraOperation.7
        @Override // java.lang.Runnable
        public void run() {
            LogUtil.d(CameraOperation.this.TAG, "mDelayedUrgentRecordTask, mIsRecording=" + CameraOperation.this.mIsRecording, new Object[0]);
            CameraOperation.this.stopRecycleTask();
            CameraOperation.this.mIsUrgentRecording = true;
            new MoveUrgentFileTask(CameraOperation.this.mStorageUtil).execute(Long.valueOf(CameraOperation.this.mUrgentRecordTriggeredTime));
            CameraOperation.this.goOnRecording();
        }
    };
    private ImageReader.OnImageAvailableListener mImageListener = new ImageReader.OnImageAvailableListener() { // from class: com.yftech.bsvservice.CameraOperation.8
        @Override // android.media.ImageReader.OnImageAvailableListener
        public void onImageAvailable(ImageReader imageReader) {
            Image image;
            Exception e;
            File outputFile;
            LogUtil.d(CameraOperation.this.TAG, "onImageAvailable, width = " + imageReader.getWidth() + ", height = " + imageReader.getHeight(), new Object[0]);
            FileOutputStream fileOutputStream = null;
            try {
                image = imageReader.acquireNextImage();
                try {
                    try {
                        outputFile = CameraOperation.this.getOutputFile(CameraOperation.IMAGE_TPYE);
                    } catch (Exception e2) {
                        e = e2;
                    }
                } catch (Throwable th) {
                    th = th;
                }
            } catch (Exception e3) {
                e = e3;
                image = null;
            } catch (Throwable th2) {
                th = th2;
                image = null;
            }
            if (outputFile == null) {
                if (image != null) {
                    image.close();
                    return;
                }
                return;
            }
            ByteBuffer buffer = image.getPlanes()[0].getBuffer();
            byte[] bArr = new byte[buffer.remaining()];
            buffer.get(bArr);
            FileOutputStream fileOutputStream2 = new FileOutputStream(outputFile);
            try {
                fileOutputStream2.write(bArr);
                fileOutputStream2.flush();
                CameraOperation.this.notifyOperationCallback(9, true, 0);
                CameraOperation.this.mStorageUtil.updateFileWithMediaScanner(outputFile);
                try {
                    fileOutputStream2.close();
                } catch (Exception unused) {
                    LogUtil.d(CameraOperation.this.TAG, "image outputstream close fail", new Object[0]);
                }
                if (image == null) {
                    return;
                }
            } catch (Exception e4) {
                e = e4;
                fileOutputStream = fileOutputStream2;
                LogUtil.d(CameraOperation.this.TAG, "write image file fail: " + e.toString(), new Object[0]);
                CameraOperation.this.notifyOperationCallback(9, false, -1);
                if (fileOutputStream != null) {
                    try {
                        fileOutputStream.close();
                    } catch (Exception unused2) {
                        LogUtil.d(CameraOperation.this.TAG, "image outputstream close fail", new Object[0]);
                    }
                }
                if (image == null) {
                    return;
                }
                image.close();
            } catch (Throwable th3) {
                th = th3;
                fileOutputStream = fileOutputStream2;
                if (fileOutputStream != null) {
                    try {
                        fileOutputStream.close();
                    } catch (Exception unused3) {
                        LogUtil.d(CameraOperation.this.TAG, "image outputstream close fail", new Object[0]);
                    }
                }
                if (image != null) {
                    image.close();
                    throw th;
                }
                throw th;
            }
            image.close();
        }
    };
    private MediaRecorder.OnErrorListener mRecorderErrorListener = new MediaRecorder.OnErrorListener() { // from class: com.yftech.bsvservice.CameraOperation.9
        @Override // android.media.MediaRecorder.OnErrorListener
        public void onError(MediaRecorder mediaRecorder, int i, int i2) {
            LogUtil.d(CameraOperation.this.TAG, "onError, what = " + i + ", extra = " + i2, new Object[0]);
            if (100 == i) {
                if (CameraOperation.this.mRecorder != null) {
                    CameraOperation.this.mRecorder.setOnErrorListener(null);
                    CameraOperation.this.mRecorder.setOnInfoListener(null);
                    CameraOperation.this.mRecorder.release();
                    CameraOperation.this.mRecorder = null;
                }
                if (CameraOperation.this.mRecordRequested) {
                    CameraOperation.this.restartRecord();
                }
            }
        }
    };
    private MediaRecorder.OnInfoListener mRecorderInfoListener = new MediaRecorder.OnInfoListener() { // from class: com.yftech.bsvservice.CameraOperation.10
        @Override // android.media.MediaRecorder.OnInfoListener
        public void onInfo(MediaRecorder mediaRecorder, int i, int i2) {
            LogUtil.d(CameraOperation.this.TAG, "onInfo, what = " + i + ", extra = " + i2, new Object[0]);
            if (i == CameraOperation.MEDIA_RECORDER_INFO_WRITE_SLOW) {
                CameraOperation.this.notifyOperationCallback(14, false, 16);
            } else if (i == CameraOperation.MEDIA_RECORDER_INFO_WRITE_TOO_SLOW) {
                CameraOperation.this.notifyOperationCallback(14, false, 17);
            }
        }
    };
    private final boolean mIsBackcarCamera = false;

    /* loaded from: /home/user/work/dex/classes.dex */
    public interface CameraOperationCallback {
        void onOperationFailed(int i, String str, int i2);

        void onOperationSuccess(int i, String str);
    }

    public boolean getWatermarkState() {
        return false;
    }

    static /* synthetic */ int access$1510(CameraOperation cameraOperation) {
        int i = cameraOperation.mFramesShouldSkipped;
        cameraOperation.mFramesShouldSkipped = i - 1;
        return i;
    }

    public CameraOperation(Context context, String str) {
        this.mContext = context;
        this.mStorageUtil = new StorageUtil(context, str);
        this.mCameraId = str;
        getAtcCaptureKeys();
        this.mRecorder = new MediaRecorder();
        this.TAG += str;
    }

    public String getCameraId() {
        return this.mCameraId;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void notifyOperationCallback(int i, boolean z, int i2) {
        if (this.mCameraOperationCallback != null) {
            if (z) {
                this.mCameraOperationCallback.onOperationSuccess(i, this.mCameraId);
            } else {
                this.mCameraOperationCallback.onOperationFailed(i, this.mCameraId, i2);
            }
        }
    }

    public void open() {
        try {
            CameraManager cameraManager = (CameraManager) this.mContext.getSystemService("camera");
            LogUtil.d(this.TAG, "CameraManager openCamera-------->", new Object[0]);
            cameraManager.openCamera(this.mCameraId, this.mStateCallback, (Handler) null);
        } catch (CameraAccessException | IllegalArgumentException | SecurityException e) {
            LogUtil.e(this.TAG, "openCamera error: " + e.toString(), new Object[0]);
            notifyOperationCallback(1, false, 7);
        }
    }

    public void close() {
        LogUtil.d(this.TAG, "close camera " + this.mCameraId, new Object[0]);
        if (this.mIsRecording) {
            stopRecordAndRecycle();
        }
        this.mIsPreviewing = false;
        this.mIsRecording = false;
        this.mIsUrgentRecording = false;
        if (this.mCaptureSession != null) {
            closePreviewSession();
            this.mCaptureSession = null;
        }
        if (this.mCameraDevice != null) {
            LogUtil.d(this.TAG, "CameraDevice close Camera-------->", new Object[0]);
            this.mCameraDevice.close();
            this.mCameraDevice = null;
        }
    }

    private boolean createCaptureSession() {
        this.mSurfaceList.clear();
        try {
            if (this.mPreviewSurface != null && this.mPreviewSurface.isValid()) {
                this.mSurfaceList.add(this.mPreviewSurface.mSurface);
            }
            if (this.mImageReader == null) {
                setupNewImageReader(this.mVideoSize.getWidth(), this.mVideoSize.getHeight());
            }
            Surface surface = this.mImageReader.getSurface();
            if (!this.mSurfaceList.contains(surface)) {
                this.mSurfaceList.add(surface);
            }
            if (this.mRecordRequested && (this.mRecorderSurface != null || prepareRecorderSurface())) {
                this.mSurfaceList.add(this.mRecorderSurface);
            }
            LogUtil.d(this.TAG, "surface list size = " + this.mSurfaceList.size(), new Object[0]);
            if (this.mCameraDevice == null) {
                LogUtil.e(this.TAG, "mCameraDevice null, maybe camera not opened", new Object[0]);
                return false;
            }
            LogUtil.d(this.TAG, "CameraDevice createCaptureSession-------->", new Object[0]);
            this.mCameraDevice.createCaptureSession(this.mSurfaceList, new CameraCaptureSession.StateCallback() { // from class: com.yftech.bsvservice.CameraOperation.2
                @Override // android.hardware.camera2.CameraCaptureSession.StateCallback
                public void onConfigured(CameraCaptureSession cameraCaptureSession) {
                    LogUtil.d(CameraOperation.this.TAG, "onConfigured", new Object[0]);
                    if (CameraOperation.this.mCameraDevice != null && CameraOperation.this.mPreviewRequested) {
                        CameraOperation.this.mCaptureSession = cameraCaptureSession;
                        CameraOperation.this.updatePreviewAndRecord();
                    }
                    CameraOperation.this.mIsChangingResolution = false;
                }

                @Override // android.hardware.camera2.CameraCaptureSession.StateCallback
                public void onConfigureFailed(CameraCaptureSession cameraCaptureSession) {
                    LogUtil.d(CameraOperation.this.TAG, "onConfigureFailed", new Object[0]);
                    if (cameraCaptureSession != null) {
                        cameraCaptureSession.close();
                    }
                    CameraOperation.this.mCaptureSession = null;
                    CameraOperation.this.mIsChangingResolution = false;
                    CameraOperation.this.notifyOperationCallback(14, false, 20);
                }
            }, null);
            return true;
        } catch (CameraAccessException | IllegalArgumentException e) {
            LogUtil.e(this.TAG, "createCaptureSession error: " + e.toString(), new Object[0]);
            close();
            return false;
        }
    }

    public void startPreview() {
        startPreview(this.mNextPreviewSurface);
    }

    public void startPreview(WrappedSurface wrappedSurface) {
        LogUtil.d(this.TAG, "startPreview", new Object[0]);
        if (wrappedSurface == null || !wrappedSurface.mSurface.isValid()) {
            notifyOperationCallback(3, false, -1);
            return;
        }
        LogUtil.d(this.TAG, "surface = " + wrappedSurface + ", isValid=" + wrappedSurface.mSurface.isValid() + ", mPreviewSurface=" + this.mPreviewSurface + ", mPendingPreviewSurface=" + this.mPendingPreviewSurface + ", mPreviewRequested=" + this.mPreviewRequested, new Object[0]);
        if (wrappedSurface == this.mPreviewSurface) {
            LogUtil.d(this.TAG, "same preview surface, skip", new Object[0]);
        }
        if (this.mPendingPreviewSurface == null && wrappedSurface != this.mPreviewSurface && this.mPreviewSurface != null && this.mPreviewRequested && (!wrappedSurface.mIsFromBackcar || !this.mPreviewSurface.mIsFromBackcar)) {
            this.mPendingPreviewSurface = this.mPreviewSurface;
        }
        this.mPreviewRequested = true;
        this.mPreviewSurface = wrappedSurface;
        this.mActionType = 0;
        if (!wrappedSurface.mIsFromBackcar) {
            this.mIsNormalPreviewRequested = true;
        }
        if (wrappedSurface.mIsFromBackcar) {
            this.mRespondRVCFirstFrame = true;
        }
        closePreviewSession();
        if (this.mCaptureSession == null) {
            if (createCaptureSession()) {
                return;
            }
            LogUtil.d(this.TAG, "wait for restore preview", new Object[0]);
            return;
        }
        updatePreviewAndRecord();
    }

    public boolean hasPendingPreviewSurface() {
        return this.mPendingPreviewSurface != null;
    }

    public void stopPreviewWhileQbOff() {
        LogUtil.d(this.TAG, "stopPreviewWhileQbOff, mPendingPreviewSurface=" + this.mPendingPreviewSurface, new Object[0]);
        if (this.mPendingPreviewSurface != null) {
            this.mNextPreviewSurface = this.mPendingPreviewSurface;
        } else {
            this.mNextPreviewSurface = null;
        }
    }

    public boolean isNeedRestoreCamera() {
        LogUtil.d(this.TAG, "isNeedRestoreCamera, mPreviewRequested=" + this.mPreviewRequested + ",mIsPreviewing=" + this.mIsPreviewing + ",mRecordRequested=" + this.mRecordRequested + ",mIsRecording=" + this.mIsRecording, new Object[0]);
        return (this.mPreviewRequested == this.mIsPreviewing && this.mRecordRequested == this.mIsRecording) ? false : true;
    }

    public void restoreCamera() {
        LogUtil.d(this.TAG, "restoreCamera", new Object[0]);
        if (this.mIsRecording) {
            stopRecordAndRecycle();
        }
        closePreviewSession();
        createCaptureSession();
    }

    public void stopPreview(boolean z) {
        LogUtil.d(this.TAG, "stopPreview, mPreviewRequested=" + this.mPreviewRequested + ", mPendingPreviewSurface=" + this.mPendingPreviewSurface + ", isBackcar=" + z, new Object[0]);
        if (!this.mPreviewRequested) {
            notifyOperationCallback(6, true, 0);
            return;
        }
        if (z) {
            if (this.mPendingPreviewSurface != null && this.mPendingPreviewSurface != this.mPreviewSurface) {
                this.mPreviewSurface = this.mPendingPreviewSurface;
                this.mPendingPreviewSurface = null;
                if (this.mRecordRequested && this.mIsRecording) {
                    recreateCaptureSession();
                    return;
                } else {
                    startPreview(this.mPreviewSurface);
                    return;
                }
            }
            if (this.mIsNormalPreviewRequested) {
                LogUtil.d(this.TAG, "do not stop preview when normal preview requested", new Object[0]);
                return;
            }
        } else {
            this.mPreviewRequested = false;
            this.mIsNormalPreviewRequested = false;
            if (this.mRecordRequested && this.mIsRecording) {
                this.mCaptureRequestBuilder.removeTarget(this.mPreviewSurface.mSurface);
                try {
                    this.mCaptureSession.setRepeatingRequest(this.mCaptureRequestBuilder.build(), null, null);
                    return;
                } catch (Exception e) {
                    LogUtil.d(this.TAG, "stopPreview fail: " + e.toString(), new Object[0]);
                    return;
                }
            }
        }
        if (this.mCaptureSession != null) {
            try {
                LogUtil.d(this.TAG, "CaptureSession stopRepeating-------->", new Object[0]);
                this.mCaptureSession.stopRepeating();
            } catch (Exception e2) {
                LogUtil.d(this.TAG, "stopRepeating fail: " + e2.toString(), new Object[0]);
            }
            LogUtil.d(this.TAG, "CaptureSession close-------->", new Object[0]);
            this.mCaptureSession.close();
            this.mSurfaceList.clear();
            this.mCaptureSession = null;
        }
        this.mPendingPreviewSurface = null;
        this.mPreviewSurface = null;
        this.mPreviewRequested = false;
        this.mIsPreviewing = false;
        notifyOperationCallback(6, true, 0);
    }

    private void updateRequest() {
        if (this.mPreviewRequested && this.mIsPreviewing && this.mPreviewSurface != null) {
            try {
                setUpCaptureRequestBuilder();
                this.mCaptureSession.setRepeatingRequest(this.mCaptureRequestBuilder.build(), this.mCaptureCallback, null);
            } catch (Exception e) {
                LogUtil.d(this.TAG, "udpateRequest fail: " + e, new Object[0]);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:20:0x00e6  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public void updatePreviewAndRecord() {
        LogUtil.d(this.TAG, "updatePreviewAndRecord, mRecordRequested=" + this.mRecordRequested + ", mPreviewRequested=" + this.mPreviewRequested, new Object[0]);
        if (this.mRecordRequested || this.mPreviewRequested) {
            boolean z = true;
            try {
                setUpCaptureRequestBuilder();
                LogUtil.d(this.TAG, "CaptureSession setRepeatingRequest-------->", new Object[0]);
                this.mCaptureSession.setRepeatingRequest(this.mCaptureRequestBuilder.build(), this.mCaptureCallback, null);
                try {
                    this.mFramesShouldSkipped = 30;
                    if (this.mIsChangingResolution) {
                        notifyOperationCallback(13, true, 0);
                        this.mIsChangingResolution = false;
                    }
                    if (this.mPreviewRequested) {
                        this.mIsPreviewing = true;
                        notifyOperationCallback(3, true, 0);
                    }
                } catch (IllegalArgumentException e) {
                    e = e;
                    LogUtil.d(this.TAG, "updatePreviewAndRecord fail: " + e.toString(), new Object[0]);
                    if (z) {
                    }
                    this.mNoNeedStartRecord = false;
                } catch (IllegalStateException e2) {
                    e = e2;
                    LogUtil.d(this.TAG, "updatePreviewAndRecord fail: " + e.toString(), new Object[0]);
                    if (z) {
                    }
                    this.mNoNeedStartRecord = false;
                } catch (Exception e3) {
                    e = e3;
                    LogUtil.d(this.TAG, "updatePreviewAndRecord fail: " + e.toString(), new Object[0]);
                    if (this.mCameraOperationCallback != null) {
                        if (this.mRecordRequested) {
                            notifyOperationCallback(this.mIsUrgentRecording ? 5 : 4, false, -1);
                        }
                        if (this.mPreviewRequested && !this.mIsPreviewing) {
                            notifyOperationCallback(3, false, -1);
                        }
                    }
                    if (z) {
                    }
                    this.mNoNeedStartRecord = false;
                }
            } catch (IllegalArgumentException e4) {
                e = e4;
                z = false;
            } catch (IllegalStateException e5) {
                e = e5;
                z = false;
            } catch (Exception e6) {
                e = e6;
                z = false;
            }
            if (z || this.mNoNeedStartRecord) {
                this.mNoNeedStartRecord = false;
            } else {
                if (!this.mRecordRequested || this.mIsRecording) {
                    return;
                }
                startRecordAfterSetRepeatingRequest();
            }
        }
    }

    private void setUpCaptureRequestBuilder() throws CameraAccessException {
        if (this.mRecordRequested) {
            this.mCaptureRequestBuilder = this.mCameraDevice.createCaptureRequest(3);
            this.mCaptureRequestBuilder.addTarget(this.mRecorderSurface);
        } else {
            this.mCaptureRequestBuilder = this.mCameraDevice.createCaptureRequest(1);
        }
        if (this.mPreviewRequested && this.mSurfaceList.contains(this.mPreviewSurface.mSurface)) {
            this.mCaptureRequestBuilder.addTarget(this.mPreviewSurface.mSurface);
        }
        if (this.mPreviewRequested && this.mPreviewSurface.mIsFromBackcar) {
            getMetazoneInfo();
            this.mCaptureRequestBuilder.set(CaptureRequest.SCALER_CROP_REGION, this.mCamRect);
            if (this.mMirrorKey != null) {
                this.mCaptureRequestBuilder.set(this.mMirrorKey, new int[]{this.mMirrorVal, 0, 0, 0});
            }
        }
        if (!this.mPreviewSurface.mIsFromBackcar) {
            LogUtil.d(this.TAG, "set watermark key, params = " + this.mActionType + ", " + this.mWatermarkSwitchs[this.mActionType] + ", " + this.mStartXValues[this.mActionType] + ", " + this.mStartYValues[this.mActionType] + ", " + this.mWidthValues[this.mActionType] + ", " + this.mHeightValues[this.mActionType], new Object[0]);
            if (this.mWatermarkPreviewKey != null) {
                this.mCaptureRequestBuilder.set(this.mWatermarkPreviewKey, new int[]{this.mWatermarkSwitchs[0] ? 1 : 0, this.mStartXValues[0], this.mStartYValues[0], this.mWidthValues[0], this.mHeightValues[0]});
            }
            if (this.mWatermarkRecordKey != null) {
                this.mCaptureRequestBuilder.set(this.mWatermarkRecordKey, new int[]{this.mWatermarkSwitchs[1] ? 1 : 0, this.mStartXValues[1], this.mStartYValues[1], this.mWidthValues[1], this.mHeightValues[1]});
            }
            if (this.mWatermarkSnapshotKey != null) {
                this.mCaptureRequestBuilder.set(this.mWatermarkSnapshotKey, new int[]{this.mWatermarkSwitchs[2] ? 1 : 0, this.mStartXValues[2], this.mStartYValues[2], this.mWidthValues[2], this.mHeightValues[2]});
            }
        } else if (this.mWatermarkPreviewKey != null) {
            this.mCaptureRequestBuilder.set(this.mWatermarkPreviewKey, new int[]{0, this.mStartXValues[0], this.mStartYValues[0], this.mWidthValues[0], this.mHeightValues[0]});
        }
        if (this.mHueKey != null && this.mPreviewSurface.mIsFromBackcar) {
            LogUtil.d(this.TAG, "set hue key, value = " + this.mHueValue, new Object[0]);
            this.mCaptureRequestBuilder.set(this.mHueKey, new int[]{this.mHueValue, 0, 0, 0});
        }
        if (this.mBrightnessKey != null && this.mPreviewSurface.mIsFromBackcar) {
            LogUtil.d(this.TAG, "set brightness key, value = " + this.mBrightnessValue, new Object[0]);
            this.mCaptureRequestBuilder.set(this.mBrightnessKey, new int[]{this.mBrightnessValue, 0, 0, 0});
        }
        if (this.mSaturationKey != null && this.mPreviewSurface.mIsFromBackcar) {
            LogUtil.d(this.TAG, "set saturation key, value = " + this.mSaturationValue, new Object[0]);
            this.mCaptureRequestBuilder.set(this.mSaturationKey, new int[]{this.mSaturationValue, 0, 0, 0});
        }
        if (this.mContrastKey != null && this.mPreviewSurface.mIsFromBackcar) {
            LogUtil.d(this.TAG, "set constrast key, value = " + this.mContrastValue, new Object[0]);
            this.mCaptureRequestBuilder.set(this.mContrastKey, new int[]{this.mContrastValue, 0, 0, 0});
        }
        this.mCaptureRequestBuilder.set(CaptureRequest.CONTROL_MODE, 1);
    }

    private void getMetazoneInfo() {
        int[] iArr = new int[4];
        AtcMetazone.readval(MIR_ADDR, iArr);
        this.mMirrorVal = iArr[0];
        AtcMetazone.readval(X_CUT_ADDR, iArr);
        int i = iArr[0];
        AtcMetazone.readval(Y_CUT_ADDR, iArr);
        int i2 = iArr[0];
        AtcMetazone.readval(W_CUT_ADDR, iArr);
        int i3 = iArr[0];
        AtcMetazone.readval(H_CUT_ADDR, iArr);
        int i4 = iArr[0];
        LogUtil.d(this.TAG, "mirror=" + this.mMirrorVal + ", x = " + i + ", y = " + i2 + ", w = " + i3 + ", h = " + i4, new Object[0]);
        this.mCamRect = new Rect(i, i2, i3 + i, i4 + i2);
        if (this.mUpdateHueFromMetazone) {
            AtcMetazone.readval(HUE_ADDR, iArr);
            this.mHueValue = iArr[0];
        } else {
            this.mUpdateHueFromMetazone = true;
        }
        if (this.mUpdateBrightnessFromMetazone) {
            AtcMetazone.readval(BRIGHTNESS_ADDR, iArr);
            this.mBrightnessValue = iArr[0];
        } else {
            this.mUpdateBrightnessFromMetazone = true;
        }
        if (this.mUpdateSaturationFromMetazone) {
            AtcMetazone.readval(SATURATION_ADDR, iArr);
            this.mSaturationValue = iArr[0];
        } else {
            this.mUpdateSaturationFromMetazone = true;
        }
        if (this.mUpdateContrastFromMetazone) {
            AtcMetazone.readval(CONTRAST_ADDR, iArr);
            this.mContrastValue = iArr[0];
        } else {
            this.mUpdateContrastFromMetazone = true;
        }
        LogUtil.d(this.TAG, "hue = " + this.mHueValue + ", brightness = " + this.mBrightnessValue + ", saturation = " + this.mSaturationValue + ", contrast = " + this.mContrastValue, new Object[0]);
    }

    private void closePreviewSession() {
        LogUtil.d(this.TAG, "closePreviewSession", new Object[0]);
        if (this.mCaptureSession != null) {
            LogUtil.d(this.TAG, "CaptureSession close-------->", new Object[0]);
            this.mCaptureSession.close();
            this.mCaptureSession = null;
        }
        this.mHaveSignal = false;
        this.mSurfaceList.clear();
        this.mIsPreviewing = false;
    }

    private void recreateCaptureSession() {
        this.mNoNeedStartRecord = true;
        closePreviewSession();
        createCaptureSession();
    }

    public synchronized void restartRecord() {
        startRecord(this.mIsUrgentRecording);
    }

    public synchronized void startRecord(boolean z) {
        String str = this.TAG;
        StringBuilder sb = new StringBuilder();
        sb.append("startRecord, type = ");
        sb.append(z ? URGENT_TYPE : NORMAL_TYPE);
        LogUtil.d(str, sb.toString(), new Object[0]);
        this.mRecordRequested = true;
        this.mIsUrgentRecording = z;
        if (this.mIsRecording) {
            if (!this.mIsUrgentRecording) {
                stopRecordAndRecycle();
            } else {
                this.mUrgentRecordTriggeredTime = System.currentTimeMillis();
                long j = this.mUrgentRecordTriggeredTime - this.mNormalRecordStartTime;
                LogUtil.d(this.TAG, "mUrgentRecordTriggeredTime=" + this.mUrgentRecordTriggeredTime + ", timeDiffer=" + j, new Object[0]);
                if (j < DEFAULT_URGENT_RECORD_TIME) {
                    this.mRecordThreadHandler.postDelayed(this.mDelayedUrgentRecordTask, DEFAULT_URGENT_RECORD_TIME - j);
                    notifyOperationCallback(5, true, 0);
                    return;
                } else {
                    stopRecordAndRecycle();
                    this.mNoNeedStartRecord = false;
                }
            }
        }
        closePreviewSession();
        if (!createCaptureSession()) {
            LogUtil.d(this.TAG, "wait for restore record", new Object[0]);
        }
    }

    private void startRecordAfterSetRepeatingRequest() {
        this.mNoNeedStartRecord = false;
        if (!prepareMediaRecorder()) {
            LogUtil.d(this.TAG, "prepareMediaRecorder fail", new Object[0]);
            this.mRecordRequested = false;
            notifyOperationCallback(this.mIsUrgentRecording ? 5 : 4, false, -1);
            return;
        }
        if (!this.mRecordRequested || this.mIsRecording) {
            return;
        }
        try {
            this.mRecorder.start();
            LogUtil.d(this.TAG, "MediaRecorder start", new Object[0]);
            this.mIsRecording = true;
            if (!this.mIsUrgentRecording) {
                notifyOperationCallback(4, true, 0);
                this.mRecordThreadHandler.postDelayed(this.mNormalRecordTask, this.mVideoDuration);
                this.mNormalRecordStartTime = System.currentTimeMillis();
            } else {
                notifyOperationCallback(5, true, 0);
                new MoveUrgentFileTask(this.mStorageUtil).execute(Long.valueOf(System.currentTimeMillis()));
                this.mRecordThreadHandler.postDelayed(this.mUrgentRecordTask, DEFAULT_URGENT_RECORD_TIME);
            }
            startNewRecycleTask();
        } catch (Exception e) {
            LogUtil.d(this.TAG, "MeidaPlayer start fail: " + e.toString(), new Object[0]);
            notifyOperationCallback(this.mIsUrgentRecording ? 5 : 4, false, -1);
        }
    }

    private void stopRecordAndRecycle() {
        LogUtil.d(this.TAG, "stopRecordAndRecycle", new Object[0]);
        if (this.mIsRecording) {
            if (this.mRecordThreadHandler.hasCallbacks(this.mDelayedUrgentRecordTask)) {
                new MoveUrgentFileTask(this.mStorageUtil).execute(Long.valueOf(this.mUrgentRecordTriggeredTime));
            }
            this.mRecordThreadHandler.removeCallbacksAndMessages(null);
            stopRecycleTask();
            try {
                this.mRecorder.stop();
                this.mRecorder.release();
                this.mRecorder = null;
            } catch (Exception e) {
                LogUtil.d(this.TAG, "stopRecordAndRecycle fail:" + e.toString(), new Object[0]);
            }
            this.mIsRecording = false;
        }
    }

    private boolean prepareRecorderSurface() {
        try {
            MediaRecorder mediaRecorder = new MediaRecorder();
            mediaRecorder.setVideoSource(2);
            this.mRecorderSurface = MediaCodec.createPersistentInputSurface();
            mediaRecorder.setInputSurface(this.mRecorderSurface);
            mediaRecorder.setOutputFormat(8);
            mediaRecorder.setVideoEncodingBitRate(VIDEO_ENCODE_BIT_RATE);
            mediaRecorder.setVideoFrameRate(30);
            mediaRecorder.setVideoSize(this.mVideoSize.getWidth(), this.mVideoSize.getHeight());
            mediaRecorder.setOutputFile("/dev/null");
            mediaRecorder.setVideoEncoder(2);
            mediaRecorder.prepare();
            mediaRecorder.reset();
            mediaRecorder.release();
            return true;
        } catch (Exception e) {
            LogUtil.d(this.TAG, "prepareRecordSurface fail: " + e.toString(), new Object[0]);
            this.mRecorderSurface = null;
            return false;
        }
    }

    private boolean prepareMediaRecorder() {
        if (this.mRecorder == null) {
            this.mRecorder = new MediaRecorder();
        } else {
            this.mRecorder.reset();
        }
        this.mRecorder.setOnErrorListener(this.mRecorderErrorListener);
        this.mRecorder.setOnInfoListener(this.mRecorderInfoListener);
        this.mRecorder.setVideoSource(2);
        if (this.mRecorderSurface == null && !prepareRecorderSurface()) {
            return false;
        }
        this.mRecorder.setInputSurface(this.mRecorderSurface);
        if (this.mIsMicOn) {
            this.mRecorder.setAudioSource(1);
        }
        this.mRecorder.setOutputFormat(8);
        File outputFile = getOutputFile(this.mIsUrgentRecording ? URGENT_TYPE : NORMAL_TYPE);
        if (outputFile == null) {
            return false;
        }
        this.mRecordingFile = outputFile;
        this.mRecorder.setOutputFile(outputFile);
        this.mRecorder.setVideoEncodingBitRate(VIDEO_ENCODE_BIT_RATE);
        this.mRecorder.setVideoFrameRate(this.mCameraFPS);
        this.mRecorder.setVideoSize(this.mVideoSize.getWidth(), this.mVideoSize.getHeight());
        this.mRecorder.setVideoEncoder(2);
        this.mRecorder.setVideoEncodingProfileLevel(8, 32768);
        if (this.mIsMicOn) {
            this.mRecorder.setAudioEncodingBitRate(AUDIO_ENCODE_BIT_RATE);
            this.mRecorder.setAudioChannels(2);
            this.mRecorder.setAudioSamplingRate(AUDIO_SAMPLE_RATE);
            this.mRecorder.setAudioEncoder(3);
        }
        try {
            this.mRecorder.prepare();
            return true;
        } catch (Exception unused) {
            return false;
        }
    }

    public synchronized void stopRecord() {
        LogUtil.d(this.TAG, "stopRecord", new Object[0]);
        stopRecordAndRecycle();
        this.mRecordRequested = false;
        notifyOperationCallback(!this.mIsUrgentRecording ? 7 : 8, true, 0);
    }

    public void snapshot() {
        if (this.mCaptureSession != null && this.mCameraDevice != null) {
            try {
                CaptureRequest.Builder createCaptureRequest = this.mCameraDevice.createCaptureRequest(2);
                if (this.mImageReader == null) {
                    setupNewImageReader(this.mVideoSize.getWidth(), this.mVideoSize.getHeight());
                }
                createCaptureRequest.addTarget(this.mImageReader.getSurface());
                if (this.mPreviewRequested && this.mSurfaceList.contains(this.mPreviewSurface.mSurface)) {
                    createCaptureRequest.addTarget(this.mPreviewSurface.mSurface);
                }
                if (this.mRecordRequested) {
                    createCaptureRequest.addTarget(this.mRecorderSurface);
                }
                if (this.mWatermarkSnapshotKey != null) {
                    createCaptureRequest.set(this.mWatermarkSnapshotKey, new int[]{this.mWatermarkSwitchs[2] ? 1 : 0, this.mStartXValues[2], this.mStartYValues[2], this.mWidthValues[2], this.mHeightValues[2]});
                }
                createCaptureRequest.set(CaptureRequest.CONTROL_AF_MODE, 4);
                this.mCaptureSession.capture(createCaptureRequest.build(), new CameraCaptureSession.CaptureCallback() { // from class: com.yftech.bsvservice.CameraOperation.4
                    @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
                    public void onCaptureCompleted(CameraCaptureSession cameraCaptureSession, CaptureRequest captureRequest, TotalCaptureResult totalCaptureResult) {
                        LogUtil.d(CameraOperation.this.TAG, "onCaptureCompleted", new Object[0]);
                    }

                    @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
                    public void onCaptureFailed(CameraCaptureSession cameraCaptureSession, CaptureRequest captureRequest, CaptureFailure captureFailure) {
                        LogUtil.d(CameraOperation.this.TAG, "onCaptureFailed", new Object[0]);
                        CameraOperation.this.notifyOperationCallback(9, false, -1);
                    }
                }, null);
                return;
            } catch (CameraAccessException unused) {
                notifyOperationCallback(9, false, 7);
                return;
            } catch (Exception e) {
                LogUtil.d(this.TAG, "snapshot, " + e, new Object[0]);
                return;
            }
        }
        notifyOperationCallback(9, false, 7);
    }

    private void getAtcCaptureKeys() {
        try {
            CameraManager cameraManager = (CameraManager) this.mContext.getSystemService("camera");
            Iterator<CaptureRequest.Key<?>> it = cameraManager.getCameraCharacteristics(this.mCameraId).getAvailableCaptureRequestKeys().iterator();
            while (it.hasNext()) {
                CaptureRequest.Key<int[]> key = (CaptureRequest.Key) it.next();
                if (ATC_WATERMARK_PREVIEW_KEY_NAME.equals(key.getName())) {
                    this.mWatermarkPreviewKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support preview watermark", new Object[0]);
                } else if (ATC_WATERMARK_RECORD_KEY_NAME.equals(key.getName())) {
                    this.mWatermarkRecordKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support record watermark", new Object[0]);
                } else if (ATC_WATERMARK_SNAPSHOT_KEY_NAME.equals(key.getName())) {
                    this.mWatermarkSnapshotKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support snapshot watermark", new Object[0]);
                } else if (ATC_MIRROR_KEY_NAME.equals(key.getName())) {
                    this.mMirrorKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support mirror", new Object[0]);
                } else if (ATC_HUE_KEY_NAME.equals(key.getName())) {
                    this.mHueKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support hue setting", new Object[0]);
                } else if (ATC_BRIGHTNESS_KEY_NAME.equals(key.getName())) {
                    this.mBrightnessKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support brightness setting", new Object[0]);
                } else if (ATC_SATURATION_KEY_NAME.equals(key.getName())) {
                    this.mSaturationKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support saturation setting", new Object[0]);
                } else if (ATC_CONTRAST_KEY_NAME.equals(key.getName())) {
                    this.mContrastKey = key;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support contrast setting", new Object[0]);
                }
            }
            Iterator<CaptureResult.Key<?>> it2 = cameraManager.getCameraCharacteristics(this.mCameraId).getAvailableCaptureResultKeys().iterator();
            while (it2.hasNext()) {
                CaptureResult.Key<int[]> key2 = (CaptureResult.Key) it2.next();
                if (ATC_SOURCEINFO_KEY_NAME.equals(key2.getName())) {
                    this.mSourceInfoKey = key2;
                    LogUtil.d(this.TAG, "Camera " + this.mCameraId + " support sourceinfo", new Object[0]);
                }
            }
        } catch (Exception e) {
            LogUtil.d(this.TAG, "getAtcCaptureKeys fail: " + e.toString(), new Object[0]);
        }
    }

    private Size[] getSupportResolutions() {
        CameraCharacteristics cameraCharacteristics;
        try {
            cameraCharacteristics = ((CameraManager) this.mContext.getSystemService("camera")).getCameraCharacteristics(this.mCameraId);
        } catch (Exception e) {
            LogUtil.w(this.TAG, "getSupportResolutions fail:" + e, new Object[0]);
            cameraCharacteristics = null;
        }
        getSupportResolutions(cameraCharacteristics);
        return this.mSupportedResolutions;
    }

    private void getSupportResolutions(CameraCharacteristics cameraCharacteristics) {
        Size[] sizeArr = null;
        if (cameraCharacteristics != null) {
            try {
                StreamConfigurationMap streamConfigurationMap = (StreamConfigurationMap) cameraCharacteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
                if (streamConfigurationMap != null) {
                    sizeArr = streamConfigurationMap.getOutputSizes(SurfaceTexture.class);
                }
            } catch (Exception unused) {
            }
        }
        this.mSupportedResolutions = sizeArr;
    }

    private Size getMaximumResolution() {
        Size[] sizeArr = this.mSupportedResolutions;
        Size size = new Size(0, 0);
        if (sizeArr != null && sizeArr.length > 0) {
            Size size2 = size;
            for (Size size3 : sizeArr) {
                if (size3.getWidth() > size2.getWidth() || (size3.getWidth() == size2.getWidth() && size3.getHeight() > size2.getHeight())) {
                    size2 = size3;
                }
            }
            size = size2;
        }
        LogUtil.d(this.TAG, "getMaximumResolution is (" + size.getWidth() + "," + size.getHeight() + ")", new Object[0]);
        return size;
    }

    private boolean checkIfResolutionSupported(Size size) {
        Size[] sizeArr = this.mSupportedResolutions;
        if (sizeArr == null) {
            return false;
        }
        for (Size size2 : sizeArr) {
            if (size2.equals(size)) {
                return true;
            }
        }
        return false;
    }

    /* JADX WARN: Removed duplicated region for block: B:23:0x0085  */
    /* JADX WARN: Removed duplicated region for block: B:27:0x0092  */
    /* JADX WARN: Removed duplicated region for block: B:6:0x0010  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    void getFPS(CameraCharacteristics cameraCharacteristics) {
        Range[] rangeArr;
        Range range = null;
        if (cameraCharacteristics != null) {
            try {
                rangeArr = (Range[]) cameraCharacteristics.get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES);
            } catch (Exception unused) {
            }
            if (rangeArr != null) {
                Range range2 = null;
                for (Range range3 : rangeArr) {
                    LogUtil.d(this.TAG, "FPS range (" + range3.getLower() + "," + range3.getUpper() + ")", new Object[0]);
                    if (range3.getLower() == range3.getUpper() && (range2 == null || ((Integer) range3.getLower()).intValue() > ((Integer) range2.getLower()).intValue() || ((Integer) range3.getUpper()).intValue() > ((Integer) range2.getUpper()).intValue())) {
                        range2 = range3;
                    }
                }
                range = range2;
            }
            if (range == null) {
                this.mCameraFPS = ((Integer) range.getUpper()).intValue();
            } else {
                this.mCameraFPS = 30;
            }
            LogUtil.d(this.TAG, "update FPS to " + this.mCameraFPS, new Object[0]);
        }
        rangeArr = null;
        if (rangeArr != null) {
        }
        if (range == null) {
        }
        LogUtil.d(this.TAG, "update FPS to " + this.mCameraFPS, new Object[0]);
    }

    private void checkAndUpdateResolution(CameraCharacteristics cameraCharacteristics) {
        getSupportResolutions(cameraCharacteristics);
        Size maximumResolution = getMaximumResolution();
        if (this.mVideoSize != null && maximumResolution.getWidth() == this.mVideoSize.getWidth() && maximumResolution.getHeight() == this.mVideoSize.getHeight()) {
            return;
        }
        this.mVideoSize = maximumResolution;
        this.mImageReader = null;
        this.mRecorderSurface = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void updateCameraCharacter() {
        CameraCharacteristics cameraCharacteristics;
        try {
            cameraCharacteristics = ((CameraManager) this.mContext.getSystemService("camera")).getCameraCharacteristics(this.mCameraId);
        } catch (CameraAccessException e) {
            e.printStackTrace();
            cameraCharacteristics = null;
        }
        checkAndUpdateResolution(cameraCharacteristics);
        getFPS(cameraCharacteristics);
    }

    private void setMediaRecorderSyncFlag(boolean z) {
        try {
            if (z) {
                SystemProperties.set("persist.sys.media.recorder.setsync.storage", String.valueOf(1));
            } else {
                SystemProperties.set("persist.sys.media.recorder.setsync.storage", String.valueOf(0));
            }
        } catch (Exception unused) {
            LogUtil.e(this.TAG, "can not set property, please check selinux permission", new Object[0]);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:9:0x0051  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public File getOutputFile(String str) {
        File file;
        int i = IMAGE_TPYE.equals(str) ? 9 : 4;
        try {
            file = this.mStorageUtil.getOutputFile(str);
        } catch (StorageUtil.FileAlreadyExistException unused) {
            LogUtil.d(this.TAG, "FileAlreadyExistException", new Object[0]);
            notifyOperationCallback(i, false, 11);
            file = null;
            if (this.mRecorder != null) {
            }
            return file;
        } catch (StorageUtil.NoSDCardMountedException unused2) {
            LogUtil.d(this.TAG, "NoSDCardMountedException", new Object[0]);
            notifyOperationCallback(i, false, 2);
            file = null;
            if (this.mRecorder != null) {
            }
            return file;
        } catch (StorageUtil.NoUdiskMountedException unused3) {
            LogUtil.d(this.TAG, "NoUdiskMountedException", new Object[0]);
            notifyOperationCallback(i, false, 3);
            file = null;
            if (this.mRecorder != null) {
            }
            return file;
        } catch (StorageUtil.SpaceNotEnoughException unused4) {
            LogUtil.d(this.TAG, "SpaceNotEnoughException", new Object[0]);
            notifyOperationCallback(i, false, 1);
            file = null;
            if (this.mRecorder != null) {
            }
            return file;
        }
        if (this.mRecorder != null) {
            if (URGENT_TYPE.equals(str)) {
                setMediaRecorderSyncFlag(true);
            } else if (NORMAL_TYPE.equals(str)) {
                setMediaRecorderSyncFlag(false);
            }
        }
        return file;
    }

    private void startNewRecycleTask() {
        stopRecycleTask();
        this.mStorageCheckerThread = new Timer();
        this.mStorageCheckerThread.schedule(new RecycleTask(this.mRecordingFile), 0L, 1000L);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void stopRecycleTask() {
        if (this.mStorageCheckerThread != null) {
            this.mStorageCheckerThread.cancel();
            this.mStorageCheckerThread = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setupNewImageReader(int i, int i2) {
        if (this.mImageReader != null) {
            this.mImageReader.close();
        }
        this.mImageReader = ImageReader.newInstance(i, i2, 256, 2);
        this.mImageReader.setOnImageAvailableListener(this.mImageListener, null);
    }

    public void setPreviewSurface(WrappedSurface wrappedSurface) {
        this.mNextPreviewSurface = wrappedSurface;
    }

    public boolean getBackcarState() {
        return this.mIsBackcarCamera;
    }

    public void setResolution(int i, int i2) {
        LogUtil.d(this.TAG, "setResolution, width = " + i + ", height = " + i2, new Object[0]);
        if (this.mVideoSize.getWidth() == i && this.mVideoSize.getHeight() == i2) {
            LogUtil.d(this.TAG, "same resolution,skip", new Object[0]);
            notifyOperationCallback(13, true, 0);
            return;
        }
        if (this.mIsChangingResolution || (this.mCaptureSession == null && (this.mPreviewRequested || this.mRecordRequested))) {
            LogUtil.d(this.TAG, "resolution is changing , return", new Object[0]);
            return;
        }
        Size size = new Size(i, i2);
        if (checkIfResolutionSupported(size)) {
            this.mVideoSize = size;
            setupNewImageReader(i, i2);
            prepareRecorderSurface();
            if (this.mIsRecording) {
                this.mIsChangingResolution = true;
                restartRecord();
                return;
            } else if (this.mIsPreviewing) {
                this.mIsChangingResolution = true;
                startPreview(this.mPreviewSurface);
                return;
            } else {
                notifyOperationCallback(13, true, 0);
                return;
            }
        }
        notifyOperationCallback(13, false, 10);
    }

    public Size getCurrentResolution() {
        return this.mVideoSize;
    }

    public void setVideoDuration(long j) {
        LogUtil.d(this.TAG, "setVideoDurtion, duration = " + j, new Object[0]);
        if (this.mVideoDuration == j) {
            LogUtil.d(this.TAG, "same duration,skip", new Object[0]);
            notifyOperationCallback(12, true, 0);
            return;
        }
        this.mVideoDuration = j;
        if (this.mIsRecording) {
            restartRecord();
        } else {
            notifyOperationCallback(12, true, 0);
        }
    }

    public void setMicOnOff(boolean z) {
        if (this.mIsMicOn == z) {
            return;
        }
        this.mIsMicOn = z;
        if (this.mIsRecording) {
            restartRecord();
        } else {
            notifyOperationCallback(10, true, 0);
        }
    }

    public void setWatermarkOnOff(int i, boolean z) {
        if ((this.mWatermarkPreviewKey == null && i == 0) || ((this.mWatermarkRecordKey == null && i == 1) || (this.mWatermarkSnapshotKey == null && i == 2))) {
            notifyOperationCallback(11, false, 12);
            return;
        }
        this.mActionType = i;
        this.mWatermarkSwitchs[i] = z;
        updateRequest();
        notifyOperationCallback(11, true, 0);
    }

    public void setWatermarkStart(int i, boolean z, int i2, boolean z2, int i3) {
        if (z) {
            this.mStartXValues[i] = i2;
        }
        if (z2) {
            this.mStartYValues[i] = i3;
        }
        this.mActionType = i;
        updateRequest();
    }

    public void setWatermarkSize(int i, boolean z, int i2, boolean z2, int i3) {
        if (z) {
            this.mWidthValues[i] = i2;
        }
        if (z2) {
            this.mHeightValues[i] = i3;
        }
        this.mActionType = i;
        updateRequest();
    }

    public void resetSettings() {
        this.mIsMicOn = true;
        this.mVideoDuration = DEFAULT_NORMAL_RECORD_TIME;
        this.mStartXValues = new int[]{20, 20, 20};
        this.mStartYValues = new int[]{20, 20, 20};
        this.mWidthValues = new int[]{300, 300, 300};
        this.mHeightValues = new int[]{50, 50, 50};
        this.mWatermarkSwitchs[0] = false;
        this.mWatermarkSwitchs[1] = false;
        this.mWatermarkSwitchs[2] = false;
    }

    public void setHue(int i) {
        this.mHueValue = i;
        this.mUpdateHueFromMetazone = false;
        updateRequest();
    }

    public void setBrightness(int i) {
        this.mBrightnessValue = i;
        this.mUpdateBrightnessFromMetazone = false;
        updateRequest();
    }

    public void setSaturation(int i) {
        this.mSaturationValue = i;
        this.mUpdateSaturationFromMetazone = false;
        updateRequest();
    }

    public void setContrast(int i) {
        this.mContrastValue = i;
        this.mUpdateContrastFromMetazone = false;
        updateRequest();
    }

    public boolean isPreviewing() {
        return this.mIsPreviewing;
    }

    public boolean isRecording(boolean z) {
        if (!this.mRecordRequested) {
            return false;
        }
        if (z) {
            return this.mIsUrgentRecording;
        }
        return this.mIsRecording;
    }

    public boolean isPreviewRequest() {
        return this.mPreviewRequested;
    }

    public boolean isRecordRequest() {
        return this.mRecordRequested;
    }

    public List<Size> getResolutions() {
        Size[] supportResolutions = getSupportResolutions();
        if (supportResolutions == null) {
            return new ArrayList();
        }
        return Arrays.asList(supportResolutions);
    }

    public long getDuration() {
        return this.mVideoDuration;
    }

    public boolean getMicState() {
        return this.mIsMicOn;
    }

    public void registerCameraOperationCallback(CameraOperationCallback cameraOperationCallback) {
        this.mCameraOperationCallback = cameraOperationCallback;
    }

    public void unregisterCameraOperationCallback() {
        this.mCameraOperationCallback = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:25:0x0075  */
    /* JADX WARN: Removed duplicated region for block: B:8:0x0047  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public void goOnRecording() {
        boolean z;
        File outputFile = getOutputFile(this.mIsUrgentRecording ? URGENT_TYPE : NORMAL_TYPE);
        if (outputFile != null) {
            try {
                this.mRecorder.setNextOutputFile(outputFile);
                this.mRecordingFile = outputFile;
                z = true;
            } catch (Exception e) {
                LogUtil.d(this.TAG, "setNextOutputFile fail " + e.toString(), new Object[0]);
                notifyOperationCallback(!this.mIsUrgentRecording ? 4 : 5, false, -1);
            }
            if (!z) {
                if (!this.mIsUrgentRecording) {
                    this.mNormalRecordStartTime = System.currentTimeMillis();
                }
                notifyOperationCallback(this.mIsUrgentRecording ? 5 : 4, true, 0);
                this.mRecordThreadHandler.postDelayed(!this.mIsUrgentRecording ? this.mNormalRecordTask : this.mUrgentRecordTask, !this.mIsUrgentRecording ? this.mVideoDuration : DEFAULT_URGENT_RECORD_TIME);
                startNewRecycleTask();
                return;
            }
            stopRecord();
            this.mRecordRequested = false;
            this.mIsRecording = false;
            return;
        }
        z = false;
        if (!z) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class RecycleTask extends TimerTask {
        private int mCounter = 0;
        private File mExceptFile;

        public RecycleTask(File file) {
            this.mExceptFile = file;
        }

        @Override // java.util.TimerTask, java.lang.Runnable
        public void run() {
            LogUtil.d(CameraOperation.this.TAG, "RecycleTask begin, mCounter = " + this.mCounter, new Object[0]);
            if (this.mCounter >= 4) {
                this.mCounter = 0;
                if (!CameraOperation.this.mIsRecording || CameraOperation.this.mIsUrgentRecording) {
                    return;
                }
                File parentFile = this.mExceptFile.getParentFile();
                if (parentFile.exists() && !CameraOperation.this.mStorageUtil.reuseStorageSpace(parentFile, this.mExceptFile) && parentFile.exists()) {
                    CameraOperation.this.stopRecord();
                    CameraOperation.this.mRecordThreadHandler.post(new Runnable() { // from class: com.yftech.bsvservice.CameraOperation.RecycleTask.1
                        @Override // java.lang.Runnable
                        public void run() {
                            CameraOperation.this.notifyOperationCallback(4, false, 1);
                        }
                    });
                    return;
                }
                return;
            }
            this.mCounter++;
            if (!this.mExceptFile.getParentFile().getParentFile().getParentFile().exists() || this.mExceptFile.exists() || CameraOperation.this.mRecorder == null) {
                return;
            }
            CameraOperation.this.mRecordThreadHandler.removeCallbacksAndMessages(null);
            CameraOperation.this.mRecordThreadHandler.post(new Runnable() { // from class: com.yftech.bsvservice.CameraOperation.RecycleTask.2
                @Override // java.lang.Runnable
                public void run() {
                    CameraOperation.this.goOnRecording();
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public static class MoveUrgentFileTask extends AsyncTask<Long, Void, Void> {
        private StorageUtil mSp;

        public MoveUrgentFileTask(StorageUtil storageUtil) {
            this.mSp = storageUtil;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public Void doInBackground(Long... lArr) {
            this.mSp.moveUrgentFileFromNormal(lArr[0].longValue());
            return null;
        }
    }
}
