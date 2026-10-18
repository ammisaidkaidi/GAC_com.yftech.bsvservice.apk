package com.yftech.bsvservice.common;

import java.nio.ByteBuffer;

/* loaded from: /home/user/work/dex/classes.dex */
public interface IMcuCommListener {
    void onMcuMessageCallBack(ByteBuffer byteBuffer, int i);
}
