package com.yftech.bsvservice;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.util.Size;
import com.yftech.bsvservice.CameraOperation;
import com.yftech.bsvservice.util.DVRConst;
import com.yftech.bsvservice.util.LogUtil;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/* loaded from: /home/user/work/dex/classes.dex */
public class CameraStateMachine extends StateMachine {
    public static final int MSG_CAMERA_CLOSED = 7;
    public static final int MSG_CAMERA_OPENED = 6;
    public static final int MSG_CLOSE_CAMERA = -1;
    public static final int MSG_MEDIA_EJECTED = 17;
    public static final int MSG_MEDIA_MOUNTED = -17;
    public static final int MSG_OPEN_CAMERA = 1;
    public static final int MSG_PREVIEWING = 12;
    public static final int MSG_PREVIEW_STOPPED = 14;
    public static final int MSG_QB_OFF = -16;
    public static final int MSG_QB_ON = 16;
    public static final int MSG_RECORDING = 13;
    public static final int MSG_RECORD_STOPPED = 15;
    public static final int MSG_RESET_SETTINGS = 26;
    public static final int MSG_RESTORE_CAMERA = 27;
    public static final int MSG_SET_BRIGHTNESS = 19;
    public static final int MSG_SET_CONTRAST = 21;
    public static final int MSG_SET_DURATION = 9;
    public static final int MSG_SET_HEIGHT = 25;
    public static final int MSG_SET_HUE = 18;
    public static final int MSG_SET_MIC = 10;
    public static final int MSG_SET_RESOLUTION = 8;
    public static final int MSG_SET_SATURATION = 20;
    public static final int MSG_SET_STARTX = 22;
    public static final int MSG_SET_STARTY = 23;
    public static final int MSG_SET_WATERMARK = 11;
    public static final int MSG_SET_WIDTH = 24;
    public static final int MSG_SNAPSHOT = 5;
    public static final int MSG_START_PREVIEW = 2;
    public static final int MSG_START_RECORD = 3;
    public static final int MSG_START_URGENT = 4;
    public static final int MSG_STOP_PREVIEW = -2;
    public static final int MSG_STOP_RECORD = -3;
    public static final int MSG_STOP_URGENT = -4;
    private static final String TAG = "CameraStateMachine";
    private CameraOperation mActiveCamera;
    private String mActiveCameraId;
    private StateMachineCallback mCallback;
    private ArrayList<CameraOperation> mCameraOperations;
    private State mClosedState;
    private State mClosingState;
    private Context mContext;
    private boolean mIsRecordingBeforeMediaEjected;
    private State mOpenedState;
    private State mOpeningState;
    private CameraOperation.CameraOperationCallback mOperationCallback;
    private Handler mOutsideHandler;
    private State mPreviewingAndRecordingState;
    private State mPreviewingState;
    private State mQBOffState;
    private State mRecordingState;
    private Handler mServiceThread;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public interface StateMachineCallback {
        void onOperationFail(String str, int i, int i2);

        void onOperationSuccess(String str, int i);
    }

    public CameraStateMachine(Context context, String str) {
        super(TAG);
        this.mOutsideHandler = new Handler();
        this.mCameraOperations = new ArrayList<>();
        this.mOperationCallback = new CameraOperation.CameraOperationCallback() { // from class: com.yftech.bsvservice.CameraStateMachine.1
            @Override // com.yftech.bsvservice.CameraOperation.CameraOperationCallback
            public void onOperationSuccess(int i, String str2) {
                LogUtil.d(CameraStateMachine.TAG, "onOperationSuccess: " + i + ", id = " + str2, new Object[0]);
                switch (i) {
                    case 1:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(6, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 2:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(7, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 3:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(12, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 4:
                        CameraStateMachine.this.sendMessage(13, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 5:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(13, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 6:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(14, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 7:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(15, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 8:
                        CameraStateMachine.this.sendMessage(15, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                }
                CameraStateMachine.this.mServiceThread.sendMessage(Message.obtain(CameraStateMachine.this.mServiceThread, i, 0, 0, str2));
            }

            @Override // com.yftech.bsvservice.CameraOperation.CameraOperationCallback
            public void onOperationFailed(int i, String str2, int i2) {
                LogUtil.d(CameraStateMachine.TAG, "onOperationFailed: " + i + ", id = " + str2, new Object[0]);
                switch (i) {
                    case 1:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(7, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                    case 3:
                        CameraStateMachine.this.sendMessageAtFrontOfQueue(14, CameraStateMachine.this.getCameraOperation(str2));
                        break;
                }
                CameraStateMachine.this.mServiceThread.sendMessage(Message.obtain(CameraStateMachine.this.mServiceThread, i, i2, 0, str2));
            }
        };
        this.mServiceThread = new Handler() { // from class: com.yftech.bsvservice.CameraStateMachine.2
            @Override // android.os.Handler
            public void handleMessage(Message message) {
                super.handleMessage(message);
                String str2 = (String) message.obj;
                if (CameraStateMachine.this.mCallback != null) {
                    if (message.arg1 != 0) {
                        CameraStateMachine.this.mCallback.onOperationFail(str2, message.what, message.arg1);
                    } else {
                        CameraStateMachine.this.mCallback.onOperationSuccess(str2, message.what);
                    }
                }
            }
        };
        this.mContext = context;
        this.mActiveCameraId = str;
        initStates();
    }

    private void initStates() {
        this.mClosedState = new ClosedState();
        this.mOpeningState = new OpeningState();
        this.mOpenedState = new OpenedState();
        this.mClosingState = new ClosingState();
        this.mQBOffState = new QBOffState();
        this.mPreviewingState = new PreviewingState();
        this.mRecordingState = new RecordingState();
        this.mPreviewingAndRecordingState = new PreviewingAndRecordingState();
        addState(this.mClosedState);
        addState(this.mOpeningState);
        addState(this.mOpenedState);
        addState(this.mClosingState);
        addState(this.mQBOffState);
        addState(this.mPreviewingState, this.mOpenedState);
        addState(this.mRecordingState, this.mOpenedState);
        addState(this.mPreviewingAndRecordingState, this.mOpenedState);
        setInitialState(this.mClosedState);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void handleSetParamMessage(CameraOperation cameraOperation, Message message) {
        int i = message.what;
        switch (i) {
            case 8:
                cameraOperation.setResolution(message.arg1, message.arg2);
                return;
            case 9:
                cameraOperation.setVideoDuration(message.arg1);
                return;
            case 10:
                cameraOperation.setMicOnOff(message.arg1 == 1);
                return;
            case 11:
                cameraOperation.setWatermarkOnOff(message.arg1, message.arg2 == 1);
                return;
            default:
                switch (i) {
                    case 22:
                        cameraOperation.setWatermarkStart(message.arg1, true, message.arg2, false, 0);
                        return;
                    case 23:
                        cameraOperation.setWatermarkStart(message.arg1, false, 0, true, message.arg2);
                        return;
                    case 24:
                        cameraOperation.setWatermarkSize(message.arg1, true, message.arg2, false, 0);
                        return;
                    case 25:
                        cameraOperation.setWatermarkSize(message.arg1, false, 0, true, message.arg2);
                        return;
                    case 26:
                        cameraOperation.resetSettings();
                        return;
                    default:
                        return;
                }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class ClosedState extends State {
        private ClosedState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter ClosedState", new Object[0]);
            CameraStateMachine.this.getCameraOperation(CameraStateMachine.this.mActiveCameraId);
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            if (CameraStateMachine.this.hasTheOppositeMessage(message.what, cameraOperation) || CameraStateMachine.this.hasTheSameMessage(message.what, cameraOperation)) {
                return true;
            }
            if (CameraStateMachine.this.hasMessages(-16)) {
                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mQBOffState);
                ((QBOffState) CameraStateMachine.this.mQBOffState).mIsCameraClosed = true;
                CameraStateMachine.this.deferMessage(message);
                return true;
            }
            int i = message.what;
            if (i != 5) {
                switch (i) {
                    case -3:
                    case -2:
                        break;
                    default:
                        switch (i) {
                            case 2:
                            case 3:
                                break;
                            default:
                                switch (i) {
                                    default:
                                        switch (i) {
                                            case 22:
                                            case 23:
                                            case 24:
                                            case 25:
                                            case 26:
                                                break;
                                            default:
                                                LogUtil.d(CameraStateMachine.TAG, "illegal mesage " + message.what + " appear in " + getClass().getSimpleName(), new Object[0]);
                                                break;
                                        }
                                    case 8:
                                    case 9:
                                    case 10:
                                    case 11:
                                        CameraStateMachine.this.handleSetParamMessage(cameraOperation, message);
                                        break;
                                }
                        }
                }
                return true;
            }
            if ((CameraStateMachine.this.mActiveCamera == null || cameraOperation == CameraStateMachine.this.mActiveCamera) && cameraOperation != null && (cameraOperation.getBackcarState() || !CameraStateMachine.this.hasMessages(message.what))) {
                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mOpeningState);
                CameraStateMachine.this.mActiveCamera = cameraOperation;
                cameraOperation.open();
            }
            CameraStateMachine.this.deferMessage(message);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class OpeningState extends State {
        private OpeningState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter OpeningState", new Object[0]);
        }

        /* JADX WARN: Removed duplicated region for block: B:25:0x0106 A[FALL_THROUGH] */
        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        /*
            Code decompiled incorrectly, please refer to instructions dump.
        */
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            if (CameraStateMachine.this.hasTheOppositeMessage(message.what, cameraOperation) || CameraStateMachine.this.hasTheSameMessage(message.what, cameraOperation)) {
                return true;
            }
            int i = message.what;
            if (i != 17) {
                switch (i) {
                    case CameraStateMachine.MSG_MEDIA_MOUNTED /* -17 */:
                    case CameraStateMachine.MSG_QB_OFF /* -16 */:
                        break;
                    default:
                        switch (i) {
                            default:
                                switch (i) {
                                    default:
                                        switch (i) {
                                            case 5:
                                                break;
                                            case 6:
                                                CameraStateMachine.this.mActiveCamera = cameraOperation;
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mOpenedState);
                                                break;
                                            case 7:
                                                CameraStateMachine.this.mActiveCamera = null;
                                                CameraStateMachine.this.removeTheSameMessages(2, cameraOperation);
                                                CameraStateMachine.this.removeTheSameMessages(3, cameraOperation);
                                                CameraStateMachine.this.removeTheSameMessages(4, cameraOperation);
                                                CameraStateMachine.this.removeTheSameMessages(5, cameraOperation);
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosedState);
                                                break;
                                            default:
                                                switch (i) {
                                                    case 22:
                                                    case 23:
                                                    case 24:
                                                    case 25:
                                                    case 26:
                                                        break;
                                                    case 27:
                                                        CameraStateMachine.this.deferMessage(message);
                                                        break;
                                                    default:
                                                        LogUtil.d(CameraStateMachine.TAG, "illegal mesage " + message.what + " appear in " + getClass().getSimpleName(), new Object[0]);
                                                        break;
                                                }
                                            case 8:
                                            case 9:
                                            case 10:
                                            case 11:
                                                CameraStateMachine.this.handleSetParamMessage(cameraOperation, message);
                                                break;
                                        }
                                    case 2:
                                    case 3:
                                        CameraStateMachine.this.deferMessage(message);
                                        break;
                                }
                            case -3:
                            case -2:
                                break;
                        }
                        return true;
                }
            }
            CameraStateMachine.this.deferMessage(message);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class OpenedState extends State {
        private OpenedState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter OpenedState", new Object[0]);
        }

        /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
        /* JADX WARN: Removed duplicated region for block: B:35:0x011b  */
        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        /*
            Code decompiled incorrectly, please refer to instructions dump.
        */
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            if (CameraStateMachine.this.hasTheOppositeMessage(message.what, cameraOperation) || CameraStateMachine.this.hasTheSameMessage(message.what, cameraOperation)) {
                return true;
            }
            int i = message.what;
            if (i != 17) {
                switch (i) {
                    case CameraStateMachine.MSG_MEDIA_MOUNTED /* -17 */:
                        break;
                    case CameraStateMachine.MSG_QB_OFF /* -16 */:
                        if (CameraStateMachine.this.mActiveCamera.isPreviewRequest() && !CameraStateMachine.this.hasTheOppositeMessage(2, CameraStateMachine.this.mActiveCamera)) {
                            CameraStateMachine.this.sendMessage(2, CameraStateMachine.this.mActiveCamera);
                        }
                        if (CameraStateMachine.this.mActiveCamera.isRecordRequest() && !CameraStateMachine.this.hasTheOppositeMessage(3, CameraStateMachine.this.mActiveCamera)) {
                            CameraStateMachine.this.sendMessage(3, CameraStateMachine.this.mActiveCamera);
                        }
                        CameraStateMachine.this.mActiveCamera.close();
                        CameraStateMachine.this.transitionTo(CameraStateMachine.this.mQBOffState);
                        return true;
                    default:
                        switch (i) {
                            case -4:
                            case -3:
                                if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                    CameraStateMachine.this.deferMessage(message);
                                } else if (cameraOperation != null) {
                                    cameraOperation.stopRecord();
                                }
                                return true;
                            case -2:
                                if (cameraOperation == CameraStateMachine.this.mActiveCamera) {
                                    if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                        cameraOperation.close();
                                        CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                    } else if (cameraOperation != null) {
                                        cameraOperation.stopPreview(message.arg1 == 1);
                                    }
                                } else {
                                    CameraStateMachine.this.deferMessage(message);
                                }
                                return true;
                            default:
                                switch (i) {
                                    case 2:
                                        if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                            if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                                CameraStateMachine.this.mActiveCamera.close();
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                            }
                                            CameraStateMachine.this.deferMessage(message);
                                        } else if (cameraOperation != null && (cameraOperation.getBackcarState() || !CameraStateMachine.this.hasMessages(2))) {
                                            cameraOperation.startPreview();
                                        } else {
                                            CameraStateMachine.this.deferMessage(message);
                                        }
                                        return true;
                                    case 3:
                                    case 4:
                                        if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                            if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                                CameraStateMachine.this.mActiveCamera.close();
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                            }
                                            CameraStateMachine.this.deferMessage(message);
                                        } else if (cameraOperation != null && (cameraOperation.getBackcarState() || !CameraStateMachine.this.hasMessages(2))) {
                                            cameraOperation.startRecord(message.what != 3);
                                        } else {
                                            CameraStateMachine.this.deferMessage(message);
                                        }
                                        return true;
                                    case 5:
                                        if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                            if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                                CameraStateMachine.this.mActiveCamera.close();
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                            }
                                            CameraStateMachine.this.deferMessage(message);
                                        } else if (cameraOperation != null) {
                                            cameraOperation.snapshot();
                                        }
                                        return true;
                                    default:
                                        switch (i) {
                                            case 7:
                                                LogUtil.d(CameraStateMachine.TAG, "camera close when opened", new Object[0]);
                                                CameraStateMachine.this.sendMessage(27, CameraStateMachine.this.mActiveCamera);
                                                if (cameraOperation != null) {
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mOpeningState);
                                                    cameraOperation.open();
                                                    break;
                                                }
                                                break;
                                            case 8:
                                            case 9:
                                            case 10:
                                            case 11:
                                                CameraStateMachine.this.handleSetParamMessage(cameraOperation, message);
                                                break;
                                            case 12:
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mPreviewingState);
                                                break;
                                            case 13:
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mRecordingState);
                                                break;
                                            case 14:
                                                if (cameraOperation != null) {
                                                    cameraOperation.close();
                                                }
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                                break;
                                            default:
                                                switch (i) {
                                                    case 22:
                                                    case 23:
                                                    case 24:
                                                    case 25:
                                                    case 26:
                                                        break;
                                                    case 27:
                                                        if (cameraOperation != null && cameraOperation.isNeedRestoreCamera()) {
                                                            if (CameraStateMachine.this.hasPendingStateMessage(cameraOperation)) {
                                                                LogUtil.d(CameraStateMachine.TAG, "restore after other message handled", new Object[0]);
                                                                CameraStateMachine.this.sendMessage(27, CameraStateMachine.this.mActiveCamera);
                                                                break;
                                                            } else {
                                                                cameraOperation.restoreCamera();
                                                                break;
                                                            }
                                                        }
                                                        break;
                                                    default:
                                                        LogUtil.d(CameraStateMachine.TAG, "illegal mesage " + message.what + " appear in " + getClass().getSimpleName(), new Object[0]);
                                                        break;
                                                }
                                        }
                                        return true;
                                }
                        }
                }
            }
            CameraStateMachine.this.deferMessage(message);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class ClosingState extends State {
        private ClosingState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter ClosingState", new Object[0]);
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            if (CameraStateMachine.this.hasTheOppositeMessage(message.what, cameraOperation) || CameraStateMachine.this.hasTheSameMessage(message.what, cameraOperation)) {
                return true;
            }
            int i = message.what;
            if (i == -16) {
                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mQBOffState);
            } else {
                if (i != 5) {
                    switch (i) {
                        case 2:
                        case 3:
                            break;
                        default:
                            switch (i) {
                                case 7:
                                    CameraStateMachine.this.mActiveCamera = null;
                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosedState);
                                    break;
                                default:
                                    switch (i) {
                                        case 22:
                                        case 23:
                                        case 24:
                                        case 25:
                                        case 26:
                                            break;
                                        default:
                                            LogUtil.d(CameraStateMachine.TAG, "illegal mesage " + message.what + " appear in " + getClass().getSimpleName(), new Object[0]);
                                            break;
                                    }
                                case 8:
                                case 9:
                                case 10:
                                case 11:
                                    CameraStateMachine.this.handleSetParamMessage(cameraOperation, message);
                                    break;
                            }
                    }
                }
                CameraStateMachine.this.deferMessage(message);
            }
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class RecordingState extends State {
        private RecordingState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter RecordingState", new Object[0]);
        }

        /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
        /* JADX WARN: Removed duplicated region for block: B:33:0x0103  */
        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        /*
            Code decompiled incorrectly, please refer to instructions dump.
        */
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            if (CameraStateMachine.this.hasTheOppositeMessage(message.what, cameraOperation) || CameraStateMachine.this.hasTheSameMessage(message.what, cameraOperation)) {
                return true;
            }
            int i = message.what;
            if (i != 5) {
                if (i == 15) {
                    if (cameraOperation != null) {
                        cameraOperation.close();
                    }
                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                } else if (i != 17) {
                    switch (i) {
                        case CameraStateMachine.MSG_MEDIA_MOUNTED /* -17 */:
                            break;
                        case CameraStateMachine.MSG_QB_OFF /* -16 */:
                            if (!CameraStateMachine.this.hasTheOppositeMessage(3, CameraStateMachine.this.mActiveCamera)) {
                                CameraStateMachine.this.sendMessage(3, CameraStateMachine.this.mActiveCamera);
                            }
                            if (CameraStateMachine.this.mActiveCamera.isPreviewRequest() && !CameraStateMachine.this.hasTheOppositeMessage(2, CameraStateMachine.this.mActiveCamera)) {
                                CameraStateMachine.this.sendMessage(2, CameraStateMachine.this.mActiveCamera);
                            }
                            CameraStateMachine.this.mActiveCamera.close();
                            CameraStateMachine.this.transitionTo(CameraStateMachine.this.mQBOffState);
                            break;
                        default:
                            switch (i) {
                                case -3:
                                    if (cameraOperation == CameraStateMachine.this.mActiveCamera) {
                                        if (cameraOperation != null) {
                                            cameraOperation.stopRecord();
                                            break;
                                        }
                                    } else {
                                        CameraStateMachine.this.deferMessage(message);
                                        break;
                                    }
                                    break;
                                case -2:
                                    CameraStateMachine.this.deferMessage(message);
                                    break;
                                default:
                                    switch (i) {
                                        case 2:
                                            if (cameraOperation == CameraStateMachine.this.mActiveCamera) {
                                                if (cameraOperation != null) {
                                                    cameraOperation.startPreview();
                                                    break;
                                                }
                                            } else {
                                                if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                                    CameraOperation cameraOperation2 = CameraStateMachine.this.mActiveCamera;
                                                    cameraOperation2.stopRecord();
                                                    if (!CameraStateMachine.this.hasTheOppositeMessage(2, cameraOperation2)) {
                                                        CameraStateMachine.this.sendMessage(CameraStateMachine.this.obtainMessage(2, cameraOperation2));
                                                    }
                                                    cameraOperation2.close();
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                                }
                                                CameraStateMachine.this.deferMessage(message);
                                                break;
                                            }
                                            break;
                                        case 3:
                                            if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                                if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                                    CameraOperation cameraOperation3 = CameraStateMachine.this.mActiveCamera;
                                                    cameraOperation3.stopRecord();
                                                    if (!CameraStateMachine.this.hasTheOppositeMessage(3, cameraOperation3)) {
                                                        CameraStateMachine.this.sendMessage(CameraStateMachine.this.obtainMessage(3, cameraOperation3));
                                                    }
                                                    cameraOperation3.close();
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                                }
                                                CameraStateMachine.this.deferMessage(message);
                                                break;
                                            }
                                            break;
                                        default:
                                            switch (i) {
                                                case 7:
                                                    LogUtil.d(CameraStateMachine.TAG, "camera close when recording", new Object[0]);
                                                    CameraStateMachine.this.sendMessage(27, CameraStateMachine.this.mActiveCamera);
                                                    if (cameraOperation != null) {
                                                        CameraStateMachine.this.transitionTo(CameraStateMachine.this.mOpeningState);
                                                        cameraOperation.open();
                                                        break;
                                                    }
                                                    break;
                                                case 8:
                                                case 9:
                                                case 10:
                                                case 11:
                                                    CameraStateMachine.this.handleSetParamMessage(cameraOperation, message);
                                                    break;
                                                case 12:
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mPreviewingAndRecordingState);
                                                    break;
                                                default:
                                                    switch (i) {
                                                        case 22:
                                                        case 23:
                                                        case 24:
                                                        case 25:
                                                        case 26:
                                                            break;
                                                        case 27:
                                                            if (cameraOperation != null && cameraOperation.isNeedRestoreCamera()) {
                                                                if (CameraStateMachine.this.hasPendingStateMessage(cameraOperation)) {
                                                                    LogUtil.d(CameraStateMachine.TAG, "restore after other message handled", new Object[0]);
                                                                    CameraStateMachine.this.sendMessage(27, CameraStateMachine.this.mActiveCamera);
                                                                    break;
                                                                } else {
                                                                    cameraOperation.restoreCamera();
                                                                    break;
                                                                }
                                                            }
                                                            break;
                                                        default:
                                                            LogUtil.d(CameraStateMachine.TAG, "illegal mesage " + message.what + " appear in " + getClass().getSimpleName(), new Object[0]);
                                                            break;
                                                    }
                                            }
                                    }
                            }
                    }
                } else if (CameraStateMachine.this.mActiveCamera.isRecordRequest()) {
                    CameraStateMachine.this.mIsRecordingBeforeMediaEjected = true;
                    CameraStateMachine.this.mActiveCamera.stopRecord();
                } else {
                    CameraStateMachine.this.mIsRecordingBeforeMediaEjected = false;
                }
            } else if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                CameraStateMachine.this.deferMessage(message);
            } else if (cameraOperation != null) {
                cameraOperation.snapshot();
            }
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class PreviewingState extends State {
        private PreviewingState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter PreviewingState", new Object[0]);
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            if (!CameraStateMachine.this.hasTheOppositeMessage(message.what, cameraOperation)) {
                if (CameraStateMachine.this.hasTheSameMessage(message.what, cameraOperation)) {
                    return true;
                }
            } else {
                if (message.what != -2 || message.arg1 != 0) {
                    return true;
                }
                LogUtil.d(CameraStateMachine.TAG, "stop preview before start backcar", new Object[0]);
            }
            int i = message.what;
            switch (i) {
                case CameraStateMachine.MSG_MEDIA_MOUNTED /* -17 */:
                    if (CameraStateMachine.this.mIsRecordingBeforeMediaEjected) {
                        CameraStateMachine.this.mActiveCamera.startRecord(false);
                    }
                    CameraStateMachine.this.mIsRecordingBeforeMediaEjected = false;
                    return true;
                case CameraStateMachine.MSG_QB_OFF /* -16 */:
                    if (!CameraStateMachine.this.hasTheOppositeMessage(2, CameraStateMachine.this.mActiveCamera)) {
                        CameraStateMachine.this.sendMessage(2, CameraStateMachine.this.mActiveCamera);
                    }
                    if (CameraStateMachine.this.mActiveCamera.isRecordRequest() && !CameraStateMachine.this.hasTheOppositeMessage(3, CameraStateMachine.this.mActiveCamera)) {
                        CameraStateMachine.this.sendMessage(3, CameraStateMachine.this.mActiveCamera);
                    }
                    CameraStateMachine.this.mActiveCamera.close();
                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mQBOffState);
                    return true;
                default:
                    switch (i) {
                        case -3:
                            CameraStateMachine.this.deferMessage(message);
                            return true;
                        case -2:
                            if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                CameraStateMachine.this.deferMessage(message);
                            } else if (cameraOperation != null) {
                                cameraOperation.stopPreview(message.arg1 == 1);
                            }
                            return true;
                        default:
                            switch (i) {
                                case 2:
                                    if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                        if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                            CameraStateMachine.this.mActiveCamera.stopPreview(message.arg1 == 1);
                                            if (!CameraStateMachine.this.hasTheOppositeMessage(2, CameraStateMachine.this.mActiveCamera)) {
                                                CameraStateMachine.this.sendMessage(2, CameraStateMachine.this.mActiveCamera);
                                            }
                                            if (CameraStateMachine.this.mActiveCamera.isRecordRequest() && !CameraStateMachine.this.hasTheOppositeMessage(3, CameraStateMachine.this.mActiveCamera)) {
                                                CameraStateMachine.this.sendMessage(3, CameraStateMachine.this.mActiveCamera);
                                            }
                                            CameraStateMachine.this.mActiveCamera.close();
                                            CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                        }
                                        CameraStateMachine.this.deferMessage(message);
                                    } else if (cameraOperation != null) {
                                        cameraOperation.startPreview();
                                    }
                                    return true;
                                case 3:
                                case 4:
                                    if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                        if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                            CameraStateMachine.this.mActiveCamera.stopPreview(message.arg1 == 1);
                                            if (!CameraStateMachine.this.hasTheOppositeMessage(message.what, CameraStateMachine.this.mActiveCamera)) {
                                                CameraStateMachine.this.sendMessage(CameraStateMachine.this.obtainMessage(message.what, CameraStateMachine.this.mActiveCamera));
                                            }
                                            CameraStateMachine.this.mActiveCamera.close();
                                            CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                            CameraStateMachine.this.deferMessage(message);
                                        } else {
                                            CameraStateMachine.this.deferMessage(message);
                                        }
                                    } else if (cameraOperation != null) {
                                        cameraOperation.startRecord(message.what != 3);
                                    }
                                    return true;
                                case 5:
                                    if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                        CameraStateMachine.this.deferMessage(message);
                                    } else if (cameraOperation != null) {
                                        cameraOperation.snapshot();
                                    }
                                    return true;
                                default:
                                    switch (i) {
                                        case 7:
                                            LogUtil.d(CameraStateMachine.TAG, "camera close when previewing", new Object[0]);
                                            CameraStateMachine.this.sendMessage(27, CameraStateMachine.this.mActiveCamera);
                                            if (cameraOperation != null) {
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mOpeningState);
                                                cameraOperation.open();
                                                break;
                                            }
                                            break;
                                        default:
                                            switch (i) {
                                                case 13:
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mPreviewingAndRecordingState);
                                                    break;
                                                case 14:
                                                    if (cameraOperation != null) {
                                                        cameraOperation.close();
                                                    }
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                                    break;
                                                default:
                                                    switch (i) {
                                                        case 17:
                                                            if (CameraStateMachine.this.mActiveCamera.isRecordRequest()) {
                                                                CameraStateMachine.this.mIsRecordingBeforeMediaEjected = true;
                                                                break;
                                                            } else {
                                                                CameraStateMachine.this.mIsRecordingBeforeMediaEjected = false;
                                                                break;
                                                            }
                                                        case 18:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setHue(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 19:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setBrightness(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 20:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setSaturation(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 21:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setContrast(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 22:
                                                        case 23:
                                                        case 24:
                                                        case 25:
                                                        case 26:
                                                            break;
                                                        case 27:
                                                            if (cameraOperation != null && cameraOperation.isNeedRestoreCamera()) {
                                                                if (CameraStateMachine.this.hasPendingStateMessage(cameraOperation)) {
                                                                    LogUtil.d(CameraStateMachine.TAG, "restore after other message handled", new Object[0]);
                                                                    CameraStateMachine.this.sendMessage(27, CameraStateMachine.this.mActiveCamera);
                                                                    break;
                                                                } else {
                                                                    cameraOperation.restoreCamera();
                                                                    break;
                                                                }
                                                            }
                                                            break;
                                                        default:
                                                            LogUtil.d(CameraStateMachine.TAG, "illegal mesage " + message.what + " appear in " + getClass().getSimpleName(), new Object[0]);
                                                            break;
                                                    }
                                            }
                                        case 8:
                                        case 9:
                                        case 10:
                                        case 11:
                                            CameraStateMachine.this.handleSetParamMessage(cameraOperation, message);
                                            break;
                                    }
                                    return true;
                            }
                    }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class PreviewingAndRecordingState extends State {
        private PreviewingAndRecordingState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter PreviewingAndRecordingState", new Object[0]);
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            if (CameraStateMachine.this.hasTheOppositeMessage(message.what, cameraOperation) || CameraStateMachine.this.hasTheSameMessage(message.what, cameraOperation)) {
                return true;
            }
            int i = message.what;
            switch (i) {
                case CameraStateMachine.MSG_MEDIA_MOUNTED /* -17 */:
                    CameraStateMachine.this.mIsRecordingBeforeMediaEjected = false;
                    return true;
                case CameraStateMachine.MSG_QB_OFF /* -16 */:
                    if (!CameraStateMachine.this.hasTheOppositeMessage(2, CameraStateMachine.this.mActiveCamera)) {
                        CameraStateMachine.this.sendMessage(2, CameraStateMachine.this.mActiveCamera);
                    }
                    if (!CameraStateMachine.this.hasTheOppositeMessage(3, CameraStateMachine.this.mActiveCamera)) {
                        CameraStateMachine.this.sendMessage(3, CameraStateMachine.this.mActiveCamera);
                    }
                    CameraStateMachine.this.mActiveCamera.close();
                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mQBOffState);
                    return true;
                default:
                    switch (i) {
                        case -3:
                            if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                CameraStateMachine.this.deferMessage(message);
                            } else {
                                CameraStateMachine.this.removeMessages(13);
                                if (cameraOperation != null) {
                                    cameraOperation.stopRecord();
                                }
                            }
                            return true;
                        case -2:
                            if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                CameraStateMachine.this.deferMessage(message);
                            } else if (cameraOperation != null) {
                                cameraOperation.stopPreview(message.arg1 == 1);
                            }
                            return true;
                        default:
                            switch (i) {
                                case 2:
                                    if (cameraOperation == CameraStateMachine.this.mActiveCamera) {
                                        if (cameraOperation != null) {
                                            cameraOperation.startPreview();
                                            break;
                                        }
                                    }
                                    break;
                                case 3:
                                    if (cameraOperation != CameraStateMachine.this.mActiveCamera) {
                                        if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                            CameraStateMachine.this.mActiveCamera.stopPreview(message.arg1 == 1);
                                            if (!CameraStateMachine.this.hasTheOppositeMessage(2, CameraStateMachine.this.mActiveCamera)) {
                                                CameraStateMachine.this.sendMessage(2, CameraStateMachine.this.mActiveCamera);
                                            }
                                            CameraStateMachine.this.mActiveCamera.stopRecord();
                                            if (!CameraStateMachine.this.hasTheOppositeMessage(3, CameraStateMachine.this.mActiveCamera)) {
                                                CameraStateMachine.this.sendMessage(3, CameraStateMachine.this.mActiveCamera);
                                            }
                                            CameraStateMachine.this.mActiveCamera.close();
                                            CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                        }
                                        CameraStateMachine.this.deferMessage(message);
                                        break;
                                    }
                                    break;
                                case 4:
                                    if (cameraOperation == CameraStateMachine.this.mActiveCamera) {
                                        if (cameraOperation != null) {
                                            cameraOperation.startRecord(true);
                                            break;
                                        }
                                    } else {
                                        if (cameraOperation != null && cameraOperation.getBackcarState()) {
                                            CameraStateMachine.this.mActiveCamera.stopPreview(message.arg1 == 1);
                                            if (!CameraStateMachine.this.hasTheOppositeMessage(2, CameraStateMachine.this.mActiveCamera)) {
                                                CameraStateMachine.this.sendMessage(2, CameraStateMachine.this.mActiveCamera);
                                            }
                                            CameraStateMachine.this.mActiveCamera.stopRecord();
                                            if (!CameraStateMachine.this.hasTheOppositeMessage(3, CameraStateMachine.this.mActiveCamera)) {
                                                CameraStateMachine.this.sendMessage(3, CameraStateMachine.this.mActiveCamera);
                                            }
                                            CameraStateMachine.this.mActiveCamera.close();
                                            CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosingState);
                                        }
                                        CameraStateMachine.this.deferMessage(message);
                                        break;
                                    }
                                    break;
                                case 5:
                                    if (cameraOperation == CameraStateMachine.this.mActiveCamera) {
                                        if (cameraOperation != null) {
                                            cameraOperation.snapshot();
                                            break;
                                        }
                                    } else {
                                        CameraStateMachine.this.deferMessage(message);
                                        break;
                                    }
                                    break;
                                default:
                                    switch (i) {
                                        case 7:
                                            LogUtil.d(CameraStateMachine.TAG, "camera close when previewing recording", new Object[0]);
                                            CameraStateMachine.this.sendMessage(27, CameraStateMachine.this.mActiveCamera);
                                            if (cameraOperation != null) {
                                                CameraStateMachine.this.transitionTo(CameraStateMachine.this.mOpeningState);
                                                cameraOperation.open();
                                                break;
                                            }
                                            break;
                                        default:
                                            switch (i) {
                                                case 14:
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mRecordingState);
                                                    break;
                                                case 15:
                                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mPreviewingState);
                                                    break;
                                                default:
                                                    switch (i) {
                                                        case 17:
                                                            if (CameraStateMachine.this.mActiveCamera.isRecordRequest()) {
                                                                CameraStateMachine.this.mIsRecordingBeforeMediaEjected = true;
                                                                CameraStateMachine.this.mActiveCamera.stopRecord();
                                                                break;
                                                            } else {
                                                                CameraStateMachine.this.mIsRecordingBeforeMediaEjected = false;
                                                                break;
                                                            }
                                                        case 18:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setHue(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 19:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setBrightness(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 20:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setSaturation(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 21:
                                                            if (cameraOperation != null) {
                                                                cameraOperation.setContrast(message.arg1);
                                                                break;
                                                            }
                                                            break;
                                                        case 22:
                                                        case 23:
                                                        case 24:
                                                        case 25:
                                                        case 26:
                                                            break;
                                                        case 27:
                                                            LogUtil.d(CameraStateMachine.TAG, "don't need to restore", new Object[0]);
                                                            break;
                                                        default:
                                                            LogUtil.d(CameraStateMachine.TAG, "illegal mesage " + message.what + " appear in " + getClass().getSimpleName(), new Object[0]);
                                                            break;
                                                    }
                                            }
                                        case 8:
                                        case 9:
                                        case 10:
                                        case 11:
                                            CameraStateMachine.this.handleSetParamMessage(cameraOperation, message);
                                            break;
                                    }
                            }
                            return true;
                    }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public class QBOffState extends State {
        boolean mIsCameraClosed;
        boolean mIsQbOn;

        private QBOffState() {
        }

        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public void enter() {
            LogUtil.d(CameraStateMachine.TAG, "enter QBOffState", new Object[0]);
        }

        /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
        @Override // com.yftech.bsvservice.State, com.yftech.bsvservice.IState
        public boolean processMessage(Message message) {
            LogUtil.d(CameraStateMachine.TAG, getClass().getSimpleName() + " processMessage " + message.what, new Object[0]);
            CameraOperation cameraOperation = (CameraOperation) message.obj;
            StringBuilder sb = new StringBuilder();
            sb.append("camera id is ");
            sb.append(cameraOperation != null ? cameraOperation.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            sb.append(", mActiveCameraId = ");
            sb.append(CameraStateMachine.this.mActiveCamera != null ? CameraStateMachine.this.mActiveCamera.getCameraId() : DVRConst.UNKOWN_CAMERA_ID);
            LogUtil.d(CameraStateMachine.TAG, sb.toString(), new Object[0]);
            int i = message.what;
            if (i == -2) {
                if (cameraOperation != null && !cameraOperation.hasPendingPreviewSurface()) {
                    CameraStateMachine.this.removeTheSameMessages(2, cameraOperation);
                }
                if (cameraOperation != null) {
                    cameraOperation.stopPreviewWhileQbOff();
                }
            } else if (i == 7) {
                if (this.mIsQbOn) {
                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosedState);
                    this.mIsCameraClosed = false;
                    this.mIsQbOn = false;
                } else {
                    this.mIsCameraClosed = true;
                }
            } else {
                switch (i) {
                    case CameraStateMachine.MSG_MEDIA_MOUNTED /* -17 */:
                        break;
                    case CameraStateMachine.MSG_QB_OFF /* -16 */:
                        this.mIsQbOn = false;
                        break;
                    default:
                        switch (i) {
                            case 12:
                                CameraStateMachine.this.sendMessage(2, cameraOperation);
                                break;
                            case 13:
                                CameraStateMachine.this.sendMessage(3, cameraOperation);
                                break;
                            case 14:
                            case 15:
                            case 17:
                                break;
                            case 16:
                                if (this.mIsCameraClosed) {
                                    CameraStateMachine.this.transitionTo(CameraStateMachine.this.mClosedState);
                                    this.mIsQbOn = false;
                                    this.mIsCameraClosed = false;
                                    break;
                                } else {
                                    this.mIsQbOn = true;
                                    break;
                                }
                            default:
                                CameraStateMachine.this.deferMessage(message);
                                break;
                        }
                }
            }
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public synchronized CameraOperation getCameraOperation(String str) {
        this.mCameraOperations.removeAll(Collections.singleton(null));
        Iterator<CameraOperation> it = this.mCameraOperations.iterator();
        while (it.hasNext()) {
            CameraOperation next = it.next();
            if (next != null && next.getCameraId().equals(str)) {
                return next;
            }
        }
        CameraOperation cameraOperation = new CameraOperation(this.mContext, str);
        cameraOperation.registerCameraOperationCallback(this.mOperationCallback);
        this.mCameraOperations.add(cameraOperation);
        return cameraOperation;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void removeTheSameMessages(int i, CameraOperation cameraOperation) {
        if (hasMessages(i, cameraOperation)) {
            removeMessages(i, cameraOperation);
        }
        if (hasDeferredMessages(i, cameraOperation)) {
            removeDeferredMessages(i, cameraOperation);
        }
    }

    private void removeTheOppositeMessages(int i, CameraOperation cameraOperation) {
        int i2 = -i;
        if (hasMessages(i2, cameraOperation)) {
            removeMessages(i2, cameraOperation);
        }
        if (hasDeferredMessages(i2, cameraOperation)) {
            removeDeferredMessages(i2, cameraOperation);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean hasTheOppositeMessage(int i, CameraOperation cameraOperation) {
        return hasTheSameMessage(-i, cameraOperation);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean hasTheSameMessage(int i, CameraOperation cameraOperation) {
        return hasMessages(i, cameraOperation) || hasDeferredMessages(i, cameraOperation);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean hasPendingStateMessage(CameraOperation cameraOperation) {
        return hasTheSameMessage(2, cameraOperation) || hasTheSameMessage(-2, cameraOperation) || hasTheSameMessage(14, cameraOperation) || hasTheSameMessage(12, cameraOperation) || hasTheSameMessage(3, cameraOperation) || hasTheSameMessage(-3, cameraOperation) || hasTheSameMessage(15, cameraOperation) || hasTheSameMessage(13, cameraOperation) || hasTheSameMessage(4, cameraOperation) || hasTheSameMessage(-4, cameraOperation);
    }

    public void startPreview(String str, WrappedSurface wrappedSurface) {
        LogUtil.d(TAG, "startPreview id:" + str, new Object[0]);
        CameraOperation cameraOperation = getCameraOperation(str);
        cameraOperation.setPreviewSurface(wrappedSurface);
        sendMessage(2, cameraOperation);
    }

    public void stopPreview(String str, boolean z) {
        LogUtil.d(TAG, "stopPreview id:" + str, new Object[0]);
        sendMessage(-2, z ? 1 : 0, 0, getCameraOperation(str));
    }

    public void startRecord(String str, boolean z) {
        LogUtil.d(TAG, "startRecord id:" + str + " isUrgent:" + z, new Object[0]);
        CameraOperation cameraOperation = getCameraOperation(str);
        removeTheOppositeMessages(3, cameraOperation);
        removeTheSameMessages(3, cameraOperation);
        sendMessage(z ? 4 : 3, cameraOperation);
    }

    public void stopRecord(String str) {
        LogUtil.d(TAG, "stopRecord id:" + str, new Object[0]);
        CameraOperation cameraOperation = getCameraOperation(str);
        removeTheOppositeMessages(-3, cameraOperation);
        removeTheSameMessages(-3, cameraOperation);
        sendMessage(-3, cameraOperation);
    }

    public void snapshot(String str) {
        LogUtil.d(TAG, "snapshot id:" + str, new Object[0]);
        sendMessage(5, getCameraOperation(str));
    }

    public void setResolution(String str, int i, int i2) {
        LogUtil.d(TAG, "setResolution id:" + str, new Object[0]);
        sendMessage(8, i, i2, getCameraOperation(str));
    }

    public void setDuration(String str, long j) {
        LogUtil.d(TAG, "setDuration id:" + str, new Object[0]);
        sendMessage(9, (int) j, 0, getCameraOperation(str));
    }

    public void setMic(String str, boolean z) {
        LogUtil.d(TAG, "setMic id:" + str, new Object[0]);
        sendMessage(10, z ? 1 : 0, 0, getCameraOperation(str));
    }

    public void setWaterMark(String str, int i, boolean z) {
        LogUtil.d(TAG, "setWaterMark id:" + str, new Object[0]);
        sendMessage(11, i, z ? 1 : 0, getCameraOperation(str));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWatermarkStartX(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkStartX", new Object[0]);
        sendMessage(22, i, i2, getCameraOperation(str));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWatermarkStartY(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkStartY", new Object[0]);
        sendMessage(23, i, i2, getCameraOperation(str));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWatermarkWidth(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkStartWidth", new Object[0]);
        sendMessage(24, i, i2, getCameraOperation(str));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void resetSettings(String str) {
        LogUtil.d(TAG, "resetSettings id = " + str, new Object[0]);
        sendMessage(26, 0, 0, getCameraOperation(str));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setWatermarkHeight(String str, int i, int i2) {
        LogUtil.d(TAG, "setWatermarkStartHeight", new Object[0]);
        sendMessage(25, i, i2, getCameraOperation(str));
    }

    public void setHue(String str, int i) {
        LogUtil.d(TAG, "setHue, value = " + i, new Object[0]);
        sendMessage(18, i, 0, getCameraOperation(str));
    }

    public void setBrightness(String str, int i) {
        LogUtil.d(TAG, "setBrightness, value = " + i, new Object[0]);
        sendMessage(19, i, 0, getCameraOperation(str));
    }

    public void setSaturation(String str, int i) {
        LogUtil.d(TAG, "setSaturation, value = " + i, new Object[0]);
        sendMessage(20, i, 0, getCameraOperation(str));
    }

    public void setContrast(String str, int i) {
        LogUtil.d(TAG, "setContrast, value = " + i, new Object[0]);
        sendMessage(21, i, 0, getCameraOperation(str));
    }

    public boolean getPreviewState(String str) {
        return getCameraOperation(str).isPreviewing();
    }

    public boolean getRecordingState(String str, boolean z) {
        return getCameraOperation(str).isRecording(z);
    }

    public List<Size> getResolutions(String str) {
        return getCameraOperation(str).getResolutions();
    }

    public boolean getMicState(String str) {
        return getCameraOperation(str).getMicState();
    }

    public boolean getWatermarkState(String str) {
        return getCameraOperation(str).getWatermarkState();
    }

    public long getDuration(String str) {
        return getCameraOperation(str).getDuration();
    }

    public Size getCurrentResolution(String str) {
        return getCameraOperation(str).getCurrentResolution();
    }

    public void registerCallback(StateMachineCallback stateMachineCallback) {
        this.mCallback = stateMachineCallback;
    }

    public void unregisterCallback(StateMachineCallback stateMachineCallback) {
        this.mCallback = null;
    }
}
