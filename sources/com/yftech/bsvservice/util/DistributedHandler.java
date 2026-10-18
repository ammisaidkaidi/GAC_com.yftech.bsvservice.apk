package com.yftech.bsvservice.util;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import java.util.ArrayList;
import java.util.List;

/* loaded from: /home/user/work/dex/classes.dex */
public class DistributedHandler extends Handler {
    private static final String TAG = "DistributedHandler";
    private List<HandlerPart> handlerParts;

    /* loaded from: /home/user/work/dex/classes.dex */
    public interface HandlerPart {
        boolean dispatchHandleMessage(Message message);
    }

    public DistributedHandler() {
    }

    public DistributedHandler(Looper looper) {
        super(looper);
    }

    @Override // android.os.Handler
    public void handleMessage(Message message) {
        try {
            int size = this.handlerParts != null ? this.handlerParts.size() : 0;
            for (int i = 0; i < size; i++) {
                if (this.handlerParts.get(i).dispatchHandleMessage(message)) {
                    return;
                }
            }
        } catch (Throwable th) {
            LogUtil.e(TAG, "handleMessage = " + message.what + ",", th);
        }
    }

    public void addHandlerPart(HandlerPart handlerPart) {
        if (this.handlerParts == null) {
            this.handlerParts = new ArrayList();
        }
        if (this.handlerParts.contains(handlerPart)) {
            return;
        }
        this.handlerParts.add(handlerPart);
    }

    public void removeHandlerPart(HandlerPart handlerPart) {
        if (this.handlerParts != null) {
            this.handlerParts.remove(handlerPart);
        }
    }
}
