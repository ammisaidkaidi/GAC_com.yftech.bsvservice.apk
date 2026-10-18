package com.yftech.bsvservice.activity;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import com.yftech.bsvservice.R;

/* loaded from: /home/user/work/dex/classes.dex */
public class WatermarkSettingsView extends FrameLayout implements View.OnClickListener {
    private static final int MAX_HEIGHT = 200;
    private static final int MAX_START_X = 980;
    private static final int MAX_START_Y = 980;
    private static final int MAX_WIDTH = 600;
    private static final int STEP_HEIGHT = 50;
    private static final int STEP_START_X = 20;
    private static final int STEP_START_Y = 20;
    private static final int STEP_WIDTH = 50;
    private static final String TAG = "WatermarkSettingView";
    private WatermarkSettingsListener mListener;
    private EditText mPreviewHeight;
    private EditText mPreviewStartX;
    private EditText mPreviewStartY;
    private Button mPreviewWatermarkSwitch;
    private EditText mPreviewWidth;
    private EditText mRecordHeight;
    private EditText mRecordStartX;
    private EditText mRecordStartY;
    private Button mRecordWatermarkSwitch;
    private EditText mRecordWidth;
    private EditText mSnapshotHeight;
    private EditText mSnapshotStartX;
    private EditText mSnapshotStartY;
    private Button mSnapshotWatermarkSwitch;
    private EditText mSnapshotWidth;

    /* loaded from: /home/user/work/dex/classes.dex */
    public enum ActionType {
        PREVIEW,
        RECORD,
        SNAPSHOT
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: /home/user/work/dex/classes.dex */
    public enum ValueType {
        START_X,
        START_Y,
        WIDTH,
        HEIGHT,
        ON_OFF
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public interface WatermarkSettingsListener {
        void onHeightChanged(View view, ActionType actionType, int i);

        void onStartXChanged(View view, ActionType actionType, int i);

        void onStartYChanged(View view, ActionType actionType, int i);

        void onStateChanged(View view, ActionType actionType, boolean z);

        void onWidthChanged(View view, ActionType actionType, int i);
    }

    public WatermarkSettingsView(Context context) {
        this(context, null);
    }

    public WatermarkSettingsView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        initView(context);
    }

    private void initView(Context context) {
        LayoutInflater.from(context).inflate(R.layout.watermark_settings_layout, (ViewGroup) this, true);
        findViewById(R.id.preview_x_minus).setOnClickListener(this);
        findViewById(R.id.preview_x_add).setOnClickListener(this);
        findViewById(R.id.preview_y_minus).setOnClickListener(this);
        findViewById(R.id.preview_y_add).setOnClickListener(this);
        findViewById(R.id.preview_width_minus).setOnClickListener(this);
        findViewById(R.id.preview_width_add).setOnClickListener(this);
        findViewById(R.id.preview_height_minus).setOnClickListener(this);
        findViewById(R.id.preview_height_add).setOnClickListener(this);
        this.mPreviewWatermarkSwitch = (Button) findViewById(R.id.preview_watermark_switch);
        this.mPreviewWatermarkSwitch.setOnClickListener(this);
        this.mPreviewStartX = (EditText) findViewById(R.id.preview_startx);
        this.mPreviewStartY = (EditText) findViewById(R.id.preview_starty);
        this.mPreviewWidth = (EditText) findViewById(R.id.preview_width);
        this.mPreviewHeight = (EditText) findViewById(R.id.preview_height);
        findViewById(R.id.record_x_minus).setOnClickListener(this);
        findViewById(R.id.record_x_add).setOnClickListener(this);
        findViewById(R.id.record_y_minus).setOnClickListener(this);
        findViewById(R.id.record_y_add).setOnClickListener(this);
        findViewById(R.id.record_width_minus).setOnClickListener(this);
        findViewById(R.id.record_width_add).setOnClickListener(this);
        findViewById(R.id.record_height_minus).setOnClickListener(this);
        findViewById(R.id.record_height_add).setOnClickListener(this);
        this.mRecordWatermarkSwitch = (Button) findViewById(R.id.record_watermark_switch);
        this.mRecordWatermarkSwitch.setOnClickListener(this);
        this.mRecordStartX = (EditText) findViewById(R.id.record_startx);
        this.mRecordStartY = (EditText) findViewById(R.id.record_starty);
        this.mRecordWidth = (EditText) findViewById(R.id.record_width);
        this.mRecordHeight = (EditText) findViewById(R.id.record_height);
        findViewById(R.id.snapshot_x_minus).setOnClickListener(this);
        findViewById(R.id.snapshot_x_add).setOnClickListener(this);
        findViewById(R.id.snapshot_y_minus).setOnClickListener(this);
        findViewById(R.id.snapshot_y_add).setOnClickListener(this);
        findViewById(R.id.snapshot_width_minus).setOnClickListener(this);
        findViewById(R.id.snapshot_width_add).setOnClickListener(this);
        findViewById(R.id.snapshot_height_minus).setOnClickListener(this);
        findViewById(R.id.snapshot_height_add).setOnClickListener(this);
        this.mSnapshotWatermarkSwitch = (Button) findViewById(R.id.snapshot_watermark_switch);
        this.mSnapshotWatermarkSwitch.setOnClickListener(this);
        this.mSnapshotStartX = (EditText) findViewById(R.id.snapshot_startx);
        this.mSnapshotStartY = (EditText) findViewById(R.id.snapshot_starty);
        this.mSnapshotWidth = (EditText) findViewById(R.id.snapshot_width);
        this.mSnapshotHeight = (EditText) findViewById(R.id.snapshot_height);
    }

    private int getEditTextNumber(EditText editText) {
        String obj = editText.getText().toString();
        Log.d(TAG, "text = " + obj);
        if (obj == null || obj.isEmpty()) {
            return 0;
        }
        return Integer.valueOf(obj).intValue();
    }

    private int addForEditText(EditText editText, int i, int i2) {
        int editTextNumber = getEditTextNumber(editText) + i;
        if (editTextNumber > i2) {
            editTextNumber = i2;
        }
        editText.setText(String.valueOf(editTextNumber));
        return editTextNumber;
    }

    private int minusForEditText(EditText editText, int i) {
        int editTextNumber = getEditTextNumber(editText) - i;
        if (editTextNumber < 0) {
            editTextNumber = 0;
        }
        editText.setText(String.valueOf(editTextNumber));
        return editTextNumber;
    }

    private void doMinus(ActionType actionType, ValueType valueType, EditText editText) {
        int minusForEditText;
        if (valueType == ValueType.START_X) {
            minusForEditText = minusForEditText(editText, 20);
        } else if (valueType == ValueType.START_Y) {
            minusForEditText = minusForEditText(editText, 20);
        } else if (valueType == ValueType.WIDTH) {
            minusForEditText = minusForEditText(editText, 50);
        } else {
            minusForEditText = valueType == ValueType.HEIGHT ? minusForEditText(editText, 50) : 0;
        }
        notify(actionType, valueType, minusForEditText);
    }

    private void doAdd(ActionType actionType, ValueType valueType, EditText editText) {
        int addForEditText;
        if (valueType == ValueType.START_X) {
            addForEditText = addForEditText(editText, 20, 980);
        } else if (valueType == ValueType.START_Y) {
            addForEditText = addForEditText(editText, 20, 980);
        } else if (valueType == ValueType.WIDTH) {
            addForEditText = addForEditText(editText, 50, 600);
        } else {
            addForEditText = valueType == ValueType.HEIGHT ? addForEditText(editText, 50, MAX_HEIGHT) : 0;
        }
        notify(actionType, valueType, addForEditText);
    }

    private void doSwitchWatermark(ActionType actionType, ValueType valueType, Button button) {
        Boolean bool = (Boolean) button.getTag();
        if (bool == null || !bool.booleanValue()) {
            button.setText(getContext().getString(R.string.is_on));
            button.setTag(true);
            notify(actionType, valueType, 1);
        } else {
            button.setText(getContext().getString(R.string.is_off));
            button.setTag(false);
            notify(actionType, valueType, 0);
        }
    }

    private void notify(ActionType actionType, ValueType valueType, int i) {
        if (this.mListener != null) {
            switch (valueType) {
                case START_X:
                    this.mListener.onStartXChanged(this, actionType, i);
                    return;
                case START_Y:
                    this.mListener.onStartYChanged(this, actionType, i);
                    return;
                case WIDTH:
                    this.mListener.onWidthChanged(this, actionType, i);
                    return;
                case HEIGHT:
                    this.mListener.onHeightChanged(this, actionType, i);
                    return;
                case ON_OFF:
                    this.mListener.onStateChanged(this, actionType, i > 0);
                    return;
                default:
                    return;
            }
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id == 2131165312) {
            doSwitchWatermark(ActionType.PREVIEW, ValueType.ON_OFF, this.mPreviewWatermarkSwitch);
            return;
        }
        if (id == 2131165329) {
            doSwitchWatermark(ActionType.RECORD, ValueType.ON_OFF, this.mRecordWatermarkSwitch);
            return;
        }
        if (id != 2131165372) {
            switch (id) {
                case R.id.preview_height_add /* 2131165308 */:
                    doAdd(ActionType.PREVIEW, ValueType.HEIGHT, this.mPreviewHeight);
                    return;
                case R.id.preview_height_minus /* 2131165309 */:
                    doMinus(ActionType.PREVIEW, ValueType.HEIGHT, this.mPreviewHeight);
                    return;
                default:
                    switch (id) {
                        case R.id.preview_width_add /* 2131165314 */:
                            doAdd(ActionType.PREVIEW, ValueType.WIDTH, this.mPreviewWidth);
                            return;
                        case R.id.preview_width_minus /* 2131165315 */:
                            doMinus(ActionType.PREVIEW, ValueType.WIDTH, this.mPreviewWidth);
                            return;
                        case R.id.preview_x_add /* 2131165316 */:
                            doAdd(ActionType.PREVIEW, ValueType.START_X, this.mPreviewStartX);
                            return;
                        case R.id.preview_x_minus /* 2131165317 */:
                            doMinus(ActionType.PREVIEW, ValueType.START_X, this.mPreviewStartX);
                            return;
                        case R.id.preview_y_add /* 2131165318 */:
                            doAdd(ActionType.PREVIEW, ValueType.START_Y, this.mPreviewStartY);
                            return;
                        case R.id.preview_y_minus /* 2131165319 */:
                            doMinus(ActionType.PREVIEW, ValueType.START_Y, this.mPreviewStartY);
                            return;
                        default:
                            switch (id) {
                                case R.id.record_height_add /* 2131165325 */:
                                    doAdd(ActionType.RECORD, ValueType.HEIGHT, this.mRecordHeight);
                                    return;
                                case R.id.record_height_minus /* 2131165326 */:
                                    doMinus(ActionType.RECORD, ValueType.HEIGHT, this.mRecordHeight);
                                    return;
                                default:
                                    switch (id) {
                                        case R.id.record_width_add /* 2131165331 */:
                                            doAdd(ActionType.RECORD, ValueType.WIDTH, this.mRecordWidth);
                                            return;
                                        case R.id.record_width_minus /* 2131165332 */:
                                            doMinus(ActionType.RECORD, ValueType.WIDTH, this.mRecordWidth);
                                            return;
                                        case R.id.record_x_add /* 2131165333 */:
                                            doAdd(ActionType.RECORD, ValueType.START_X, this.mRecordStartX);
                                            return;
                                        case R.id.record_x_minus /* 2131165334 */:
                                            doMinus(ActionType.RECORD, ValueType.START_X, this.mRecordStartX);
                                            return;
                                        case R.id.record_y_add /* 2131165335 */:
                                            doAdd(ActionType.RECORD, ValueType.START_Y, this.mRecordStartY);
                                            return;
                                        case R.id.record_y_minus /* 2131165336 */:
                                            doMinus(ActionType.RECORD, ValueType.START_Y, this.mRecordStartY);
                                            return;
                                        default:
                                            switch (id) {
                                                case R.id.snapshot_height_add /* 2131165368 */:
                                                    doAdd(ActionType.SNAPSHOT, ValueType.HEIGHT, this.mSnapshotHeight);
                                                    return;
                                                case R.id.snapshot_height_minus /* 2131165369 */:
                                                    doMinus(ActionType.SNAPSHOT, ValueType.HEIGHT, this.mSnapshotHeight);
                                                    return;
                                                default:
                                                    switch (id) {
                                                        case R.id.snapshot_width_add /* 2131165374 */:
                                                            doAdd(ActionType.SNAPSHOT, ValueType.WIDTH, this.mSnapshotWidth);
                                                            return;
                                                        case R.id.snapshot_width_minus /* 2131165375 */:
                                                            doMinus(ActionType.SNAPSHOT, ValueType.WIDTH, this.mSnapshotWidth);
                                                            return;
                                                        case R.id.snapshot_x_add /* 2131165376 */:
                                                            doAdd(ActionType.SNAPSHOT, ValueType.START_X, this.mSnapshotStartX);
                                                            return;
                                                        case R.id.snapshot_x_minus /* 2131165377 */:
                                                            doMinus(ActionType.SNAPSHOT, ValueType.START_X, this.mSnapshotStartX);
                                                            return;
                                                        case R.id.snapshot_y_add /* 2131165378 */:
                                                            doAdd(ActionType.SNAPSHOT, ValueType.START_Y, this.mSnapshotStartY);
                                                            return;
                                                        case R.id.snapshot_y_minus /* 2131165379 */:
                                                            doMinus(ActionType.SNAPSHOT, ValueType.START_Y, this.mSnapshotStartY);
                                                            return;
                                                        default:
                                                            return;
                                                    }
                                            }
                                    }
                            }
                    }
            }
        }
        doSwitchWatermark(ActionType.SNAPSHOT, ValueType.ON_OFF, this.mSnapshotWatermarkSwitch);
    }

    public void registerWatermarkSettingsListener(WatermarkSettingsListener watermarkSettingsListener) {
        this.mListener = watermarkSettingsListener;
    }

    public void unregisterWatermarkSettingsListener() {
        this.mListener = null;
    }
}
