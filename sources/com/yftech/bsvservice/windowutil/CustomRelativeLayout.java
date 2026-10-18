package com.yftech.bsvservice.windowutil;

import android.content.Context;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.widget.RelativeLayout;
import com.yftech.bsvservice.util.LogUtil;

/* loaded from: /home/user/work/dex/classes.dex */
public class CustomRelativeLayout extends RelativeLayout {
    private OnKeyEventListener mKeyListener;

    /* loaded from: /home/user/work/dex/classes.dex */
    public interface OnKeyEventListener {
        boolean dispatchKeyEvent(KeyEvent keyEvent);
    }

    public void setOnKeyEventListener(OnKeyEventListener onKeyEventListener) {
        this.mKeyListener = onKeyEventListener;
    }

    public CustomRelativeLayout(Context context) {
        super(context);
    }

    public CustomRelativeLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    public CustomRelativeLayout(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
    }

    public CustomRelativeLayout(Context context, AttributeSet attributeSet, int i, int i2) {
        super(context, attributeSet, i, i2);
    }

    @Override // android.view.ViewGroup, android.view.View
    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        LogUtil.d("CustomRelativeLayout", "key:" + keyEvent.getKeyCode(), new Object[0]);
        if (this.mKeyListener == null) {
            return true;
        }
        this.mKeyListener.dispatchKeyEvent(keyEvent);
        return true;
    }
}
