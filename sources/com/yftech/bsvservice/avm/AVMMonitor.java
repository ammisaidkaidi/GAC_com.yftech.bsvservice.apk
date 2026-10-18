package com.yftech.bsvservice.avm;

/* loaded from: /home/user/work/dex/classes.dex */
public class AVMMonitor {

    /* loaded from: /home/user/work/dex/classes.dex */
    public interface ICameraMonitorListener {
        void onCameraMonitorLoading(boolean z);

        void onCameraMonitorNoSignal();

        void onCameraMonitorReady();

        void onCameraMonitorReqHide();

        void onCameraMonitorReqShow();

        void onCameraMonitorResumeSignal();
    }
}
