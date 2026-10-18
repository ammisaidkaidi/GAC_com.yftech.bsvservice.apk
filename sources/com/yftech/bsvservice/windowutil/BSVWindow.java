package com.yftech.bsvservice.windowutil;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.yftech.bsvservice.R;
import com.yftech.bsvservice.avm.AudioFocus;
import com.yftech.bsvservice.avm.AvmControl;
import com.yftech.bsvservice.util.LogUtil;
import com.yftech.vehicle.internal.adapter.IBaseApi;
import com.yftech.vehicle.sdk.CarDeviceManager;
import com.yftech.vehicle.sdk.MpuProjectManager;

/* loaded from: /home/user/work/dex/classes.dex */
public class BSVWindow extends BaseWindow implements View.OnClickListener, View.OnTouchListener {
    private static final boolean DEBUG = true;
    public static final int SURFACE_VIEW_HIGHT = 720;
    public static final int SURFACE_VIEW_WIDTH = 1920;
    public static final int SURFACE_VIEW_X = 0;
    public static final int SURFACE_VIEW_Y = 0;
    private static final String TAG = "BSVWindow";
    private Boolean isShown_nosig;
    private MyCarDeviceListener mCarDeviceListener;
    private Context mContext;
    private RelativeLayout mErrLayout;
    private TextView mErrView;
    Handler mHandler;
    private TextView mHintView;
    private boolean mIsBsvDisplayState;
    private boolean mIsCameraSystemErr;
    private View mOverLayView;
    private CameraPreview mSurfaceView;
    private WindowManager mWindowManager;
    CustomRelativeLayout rootLayout;
    private SurfaceView surfaceView;

    /* loaded from: /home/user/work/dex/classes.dex */
    public class MyCarDeviceListener extends CarDeviceManager.CarDeviceListener {
        public MyCarDeviceListener() {
        }

        public void onBSVDisplayStateChanged(IBaseApi.EnableState enableState) {
            LogUtil.d(BSVWindow.TAG, "onBSVDisplayStateChanged:" + enableState, new Object[0]);
            BSVWindow.this.mIsBsvDisplayState = enableState == IBaseApi.EnableState.ENABLED;
            AvmControl.getInstance().onDisplayState(BSVWindow.this.mIsBsvDisplayState);
        }
    }

    public BSVWindow(Context context) {
        super(context);
        this.mSurfaceView = null;
        this.mOverLayView = null;
        this.surfaceView = null;
        this.mWindowManager = null;
        this.mContext = null;
        this.isShown_nosig = false;
        this.mIsCameraSystemErr = true;
        this.mIsBsvDisplayState = false;
        this.mHandler = new Handler();
        this.mCarDeviceListener = null;
        LogUtil.d(TAG, "MainWindow", new Object[0]);
        this.mContext = context;
        this.mSurfaceView = new CameraPreview(context, this.mAvmControl);
        this.mWindowManager = (WindowManager) this.mContext.getSystemService("window");
        this.mCarDeviceListener = new MyCarDeviceListener();
        CarDeviceManager.get().registerListener(this.mCarDeviceListener);
        IBaseApi.EnableState bSVDisplayState = CarDeviceManager.get().getBSVDisplayState();
        LogUtil.d(TAG, "getBSVDisplayState:" + bSVDisplayState, new Object[0]);
        this.mIsBsvDisplayState = bSVDisplayState == IBaseApi.EnableState.ENABLED;
        this.mCarDeviceListener.onBSVDisplayStateChanged(bSVDisplayState);
        initView();
    }

    public void initView() {
        this.mOverLayView = ((LayoutInflater) this.mContext.getSystemService("layout_inflater")).inflate(R.layout.bsv_main, (ViewGroup) null);
        this.mErrLayout = (RelativeLayout) this.mOverLayView.findViewById(R.id.layout_c);
        this.mErrLayout.setVisibility(4);
        this.mErrView = (TextView) this.mOverLayView.findViewById(R.id.txt_err);
        this.rootLayout = new CustomRelativeLayout(this.mContext);
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(-1, -1);
        layoutParams.addRule(9);
        layoutParams.addRule(10);
        layoutParams.addRule(14);
        this.rootLayout.setLayoutParams(layoutParams);
        this.rootLayout.setOnTouchListener(this);
        RelativeLayout.LayoutParams layoutParams2 = new RelativeLayout.LayoutParams(SURFACE_VIEW_WIDTH, 720);
        layoutParams2.addRule(9);
        layoutParams2.addRule(10);
        layoutParams2.setMarginStart(0);
        layoutParams2.topMargin = 0;
        this.mSurfaceView.setLayoutParams(layoutParams2);
        this.mSurfaceView.setFixedSize(1280, 720);
        this.rootLayout.addView(this.mSurfaceView);
        this.rootLayout.addView(this.mOverLayView);
    }

    public SurfaceView getSurface() {
        return this.mSurfaceView;
    }

    @Override // com.yftech.bsvservice.windowutil.BaseWindow
    public void updateWindow() {
        if (isShow()) {
            if (this.mAvmControl.isAvmSignalErr()) {
                LogUtil.d(TAG, "updateWindow no Signal Err ", new Object[0]);
                this.mErrView.setText(R.string.avm_no_signal);
                this.mErrLayout.setVisibility(0);
                this.mIsCameraSystemErr = true;
            } else {
                LogUtil.d(TAG, "updateWindow no Err ", new Object[0]);
                this.mErrLayout.setVisibility(4);
                this.mIsCameraSystemErr = false;
            }
            LogUtil.d(TAG, "mIsCameraSystemErr:" + this.mIsCameraSystemErr, new Object[0]);
            boolean z = this.mIsCameraSystemErr;
        }
    }

    @Override // com.yftech.bsvservice.windowutil.BaseWindow
    public void showWindow() {
        if (isShow()) {
            LogUtil.d(TAG, "return cause already shown", new Object[0]);
            return;
        }
        super.showWindow();
        LogUtil.d(TAG, "showPopupWindow", new Object[0]);
        WindowManager.LayoutParams upWindowPara = setUpWindowPara(new WindowManager.LayoutParams());
        updateWindow();
        if (AvmControl.getInstance().isBackCar()) {
            AudioFocus.getInstance().requestAvmFocus();
        }
        openScreenBackLight();
        BroadcastWindow(2, true);
        CarDeviceManager.get().setBSVDisplaySwitch(true);
        LogUtil.d(TAG, "setBSVDisplaySwitch true", new Object[0]);
        this.mWindowManager.addView(this.rootLayout, upWindowPara);
        setWindowVisibility(false);
        LogUtil.d(TAG, "add view", new Object[0]);
    }

    @Override // com.yftech.bsvservice.windowutil.BaseWindow
    public void hideWindow() {
        if (isShow() || this.rootLayout.getParent() != null) {
            LogUtil.d(TAG, "hidePopupWindow", new Object[0]);
            restoreScreenBackLight();
            AudioFocus.getInstance().abondAvmFocus();
            BroadcastWindow(2, false);
            CarDeviceManager.get().setBSVDisplaySwitch(false);
            LogUtil.d(TAG, "setBSVDisplaySwitch false", new Object[0]);
            this.mWindowManager.removeViewImmediate(this.rootLayout);
            super.hideWindow();
        }
    }

    @Override // com.yftech.bsvservice.windowutil.BaseWindow
    public boolean setWindowVisibility(boolean z) {
        LogUtil.d(TAG, "setWindowVisibility" + z, new Object[0]);
        if (this.rootLayout == null) {
            return true;
        }
        if (z) {
            this.rootLayout.setScaleX(1.0f);
            this.rootLayout.setScaleY(1.0f);
            return true;
        }
        this.rootLayout.setScaleX(0.0f);
        this.rootLayout.setScaleY(0.0f);
        return true;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        LogUtil.d(TAG, "onClick:" + view.getId(), new Object[0]);
        view.getId();
    }

    public WindowManager.LayoutParams setUpWindowPara(WindowManager.LayoutParams layoutParams) {
        layoutParams.type = 2052;
        layoutParams.flags |= 808;
        layoutParams.format = -3;
        layoutParams.width = -1;
        layoutParams.height = -1;
        layoutParams.gravity = 17;
        return layoutParams;
    }

    @Override // com.yftech.bsvservice.windowutil.BaseWindow, com.yftech.bsvservice.util.DistributedHandler.HandlerPart
    public boolean dispatchHandleMessage(Message message) {
        LogUtil.d(TAG, "dispatchHandleMessage msg:" + message.what, new Object[0]);
        int i = message.what;
        if (i != 210) {
            if (i != 261) {
                if (i != 263) {
                }
            } else if (isShow()) {
                AvmControl.getInstance().isBackCar();
            }
        }
        return super.dispatchHandleMessage(message);
    }

    @Override // android.view.View.OnTouchListener
    public boolean onTouch(View view, MotionEvent motionEvent) {
        switch (motionEvent.getAction()) {
            case 0:
                sendTouchToAVM(motionEvent.getX(), motionEvent.getY(), 1);
                return false;
            case 1:
                sendTouchToAVM(motionEvent.getX(), motionEvent.getY(), 2);
                return false;
            case 2:
                sendTouchToAVM(motionEvent.getX(), motionEvent.getY(), 3);
                return false;
            default:
                return false;
        }
    }

    public boolean sendTouchToAVM(float f, float f2, int i) {
        LogUtil.i(TAG, "sendTouchToAVM onTouch x:" + f + ",y:" + f2 + ",action:" + i, new Object[0]);
        return MpuProjectManager.get().setTouchInfo2Bsv((int) f, (int) f2, i);
    }
}
