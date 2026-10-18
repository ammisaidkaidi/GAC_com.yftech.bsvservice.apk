package com.yftech.bsvservice.avm;

import android.media.AudioAttributes;
import android.media.AudioFocusRequest;
import android.media.AudioManager;
import android.os.Handler;
import android.os.SystemProperties;
import android.security.KeyStore;
import com.yftech.bsvservice.util.LogUtil;
import com.yftech.car.data.CarData;
import com.yftech.car.data.CarDataManager;
import com.yftech.vehicle.sdk.CarIcmManager;

/* loaded from: /home/user/work/dex/classes.dex */
public class AudioFocus {
    private static final int KEEP_MUTE_WARNING_CLOSE = 0;
    private static final int KEEP_MUTE_WARNING_DOWN = 2;
    private static final int KEEP_MUTE_WARNING_OPEN = 1;
    private static final String KEY_KEEP_MUTE_WARNING_ENABLE = "Keep_Mute_Warning_Enable";
    private static final String TAG = "AudioFocus";
    AudioFocusRequest mAvmFocusRequest;
    AudioFocusRequest mCanActiveFocusRequest;
    private MyCarDataCallback mCarDataCallback;
    private MyCarIcmListener mCarIcmListener;
    private boolean mIsKeepMuteWarningEnabled;
    private int mKeepMuteWarning;
    AudioFocusRequest mRadarFocusRequest;
    AudioFocusRequest mRvcFocusRequest;
    int mediaVolume = 0;
    boolean bAvmMuteMusicMedia = false;
    boolean bRvcMuteMusicMedia = false;
    boolean bCanActiveMuteMusicMedia = false;
    boolean bIsRequestAvmFocus = false;
    boolean bIsRequestRvcFocus = false;
    boolean bIsRequestRadarFocus = false;
    boolean bIsRequestCanActiveFocus = false;
    AudioManager.OnAudioFocusChangeListener audioFocusChangeListener = new AudioManager.OnAudioFocusChangeListener() { // from class: com.yftech.bsvservice.avm.AudioFocus.1
        @Override // android.media.AudioManager.OnAudioFocusChangeListener
        public void onAudioFocusChange(int i) {
            LogUtil.d(AudioFocus.TAG, "onAudioFocusChange:" + i, new Object[0]);
            switch (i) {
                case -3:
                case -2:
                case -1:
                default:
                    return;
            }
        }
    };
    AudioManager.OnAudioFocusChangeListener radarAudioFocusChangeListener = new AudioManager.OnAudioFocusChangeListener() { // from class: com.yftech.bsvservice.avm.AudioFocus.2
        @Override // android.media.AudioManager.OnAudioFocusChangeListener
        public void onAudioFocusChange(int i) {
            LogUtil.d(AudioFocus.TAG, "radarAudioFocusChangeListener:" + i, new Object[0]);
            switch (i) {
                case -3:
                case -2:
                case -1:
                default:
                    return;
            }
        }
    };
    AudioManager.OnAudioFocusChangeListener avmAudioFocusChangeListener = new AudioManager.OnAudioFocusChangeListener() { // from class: com.yftech.bsvservice.avm.AudioFocus.3
        @Override // android.media.AudioManager.OnAudioFocusChangeListener
        public void onAudioFocusChange(int i) {
            LogUtil.d(AudioFocus.TAG, "avmAudioFocusChangeListener:" + i, new Object[0]);
            switch (i) {
                case -3:
                case -2:
                case -1:
                default:
                    return;
            }
        }
    };
    AudioManager.OnAudioFocusChangeListener canAudioFocusChangeListener = new AudioManager.OnAudioFocusChangeListener() { // from class: com.yftech.bsvservice.avm.AudioFocus.4
        @Override // android.media.AudioManager.OnAudioFocusChangeListener
        public void onAudioFocusChange(int i) {
            LogUtil.d(AudioFocus.TAG, "canAudioFocusChangeListener:" + i, new Object[0]);
            switch (i) {
                case -3:
                case -2:
                case -1:
                default:
                    return;
            }
        }
    };
    private AudioManager m_AudioManager = (AudioManager) KeyStore.getApplicationContext().getSystemService("audio");

    private int getKeepMuteWarning() {
        CarData carData = CarDataManager.get(new CarData(new CarData.CarDataEntry(KEY_KEEP_MUTE_WARNING_ENABLE, 2)));
        if (carData == null || carData.getDataEntry(KEY_KEEP_MUTE_WARNING_ENABLE) == null) {
            return 1;
        }
        int valueInt = carData.getDataEntry(KEY_KEEP_MUTE_WARNING_ENABLE).getValueInt();
        LogUtil.d(TAG, "getKeepMuteWarning value:" + valueInt, new Object[0]);
        return valueInt;
    }

    private int InterruptMediaType() {
        int keepMuteWarning = getKeepMuteWarning();
        this.mKeepMuteWarning = keepMuteWarning;
        LogUtil.d(TAG, "keepMuteWarning:" + keepMuteWarning, new Object[0]);
        int i = 2;
        if (keepMuteWarning == 1) {
            i = 1;
        } else if (keepMuteWarning != 2) {
            i = 0;
        }
        LogUtil.d(TAG, "Interrupt type:" + i, new Object[0]);
        return i;
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    private static class SingletonFactory {
        private static AudioFocus instance = new AudioFocus();

        private SingletonFactory() {
        }
    }

    public static AudioFocus getInstance() {
        return SingletonFactory.instance;
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public class MyCarDataCallback extends CarDataManager.CarDataCallback {
        public MyCarDataCallback() {
        }

        public void onCarDataChanged(CarData carData) {
            if (carData == null || carData.getDataEntry(AudioFocus.KEY_KEEP_MUTE_WARNING_ENABLE) == null) {
                return;
            }
            int valueInt = carData.getDataEntry(AudioFocus.KEY_KEEP_MUTE_WARNING_ENABLE).getValueInt();
            LogUtil.d(AudioFocus.TAG, "onCarDataChanged getKeepMuteWarning value:" + valueInt, new Object[0]);
            if (valueInt != AudioFocus.this.mKeepMuteWarning) {
                AudioFocus.this.mKeepMuteWarning = valueInt;
                LogUtil.d(AudioFocus.TAG, "onCarDataChanged bIsRequestCanActiveFocus:" + AudioFocus.this.bIsRequestCanActiveFocus + ",bIsRequestRvcFocus:" + AudioFocus.this.bIsRequestRvcFocus + ",bIsRequestRadarFocus:" + AudioFocus.this.bIsRequestRadarFocus, new Object[0]);
                if (AudioFocus.this.bIsRequestCanActiveFocus) {
                    AudioFocus.this.abandonCanActiveFocus();
                    AudioFocus.this.requestCanActiveFocus();
                }
                if (AudioFocus.this.bIsRequestRvcFocus) {
                    AudioFocus.this.abondRvcFocus();
                    AudioFocus.this.requestRvcFocus();
                }
                if (AudioFocus.this.bIsRequestRadarFocus) {
                    AudioFocus.this.abandonRadarFocus();
                    AudioFocus.this.requestRadarFocus();
                }
            }
        }
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public class MyCarIcmListener extends CarIcmManager.CarIcmListener {
        public MyCarIcmListener() {
        }

        public void onKeepMuteWarningStateChanged(boolean z) {
            LogUtil.d(AudioFocus.TAG, "onKeepMuteWarningStateChanged  isEnabled:" + z, new Object[0]);
            if (z != AudioFocus.this.mIsKeepMuteWarningEnabled) {
                AudioFocus.this.mIsKeepMuteWarningEnabled = z;
                if (AudioFocus.this.mIsKeepMuteWarningEnabled) {
                    AudioFocus.this.requestCanActiveFocus();
                } else {
                    AudioFocus.this.abandonCanActiveFocus();
                }
            }
        }
    }

    public AudioFocus() {
        this.mCarDataCallback = null;
        this.mCarIcmListener = null;
        this.mKeepMuteWarning = 1;
        this.mIsKeepMuteWarningEnabled = false;
        this.mKeepMuteWarning = getKeepMuteWarning();
        this.mCarDataCallback = new MyCarDataCallback();
        CarDataManager.registerCarDataCallback(this.mCarDataCallback, (Handler) null);
        this.mIsKeepMuteWarningEnabled = CarIcmManager.get().isKeepMuteWarningEnabled();
        this.mCarIcmListener = new MyCarIcmListener();
        CarIcmManager.get().registerListener(this.mCarIcmListener);
        LogUtil.d(TAG, "AudioFocus mKeepMuteWarning :" + this.mKeepMuteWarning + ",mIsKeepMuteWarningEnabled:" + this.mIsKeepMuteWarningEnabled, new Object[0]);
        if (this.mIsKeepMuteWarningEnabled) {
            requestCanActiveFocus();
        } else {
            abandonCanActiveFocus();
        }
    }

    boolean isCarplayCertificate() {
        String str = SystemProperties.get("persist.sys.carplay.certificate", "0");
        LogUtil.d(TAG, " persist.sys.carplay.certificate :" + str, new Object[0]);
        boolean z = str.compareTo("1") == 0;
        LogUtil.d(TAG, " isCarplayCertificate :" + z, new Object[0]);
        return z;
    }

    public synchronized int requestAvmFocus() {
        AudioAttributes build;
        if (isCarplayCertificate()) {
            this.m_AudioManager.adjustStreamVolume(3, -100, 0);
            this.bAvmMuteMusicMedia = true;
            return 0;
        }
        int InterruptMediaType = InterruptMediaType();
        if (InterruptMediaType == 1) {
            build = new AudioAttributes.Builder().setLegacyStreamType(29).build();
        } else if (InterruptMediaType == 2) {
            build = new AudioAttributes.Builder().setLegacyStreamType(14).build();
        } else {
            build = new AudioAttributes.Builder().setLegacyStreamType(12).build();
        }
        this.mAvmFocusRequest = new AudioFocusRequest.Builder(1).setWillPauseWhenDucked(true).setAcceptsDelayedFocusGain(true).setOnAudioFocusChangeListener(this.avmAudioFocusChangeListener).setAudioAttributes(build).build();
        int requestAudioFocus = this.m_AudioManager.requestAudioFocus(this.mAvmFocusRequest);
        LogUtil.d(TAG, "requestAvmFocus ret:" + requestAudioFocus, new Object[0]);
        this.bIsRequestAvmFocus = true;
        return requestAudioFocus;
    }

    public synchronized void abondAvmFocus() {
        if (this.bAvmMuteMusicMedia) {
            this.m_AudioManager.adjustStreamVolume(3, 100, 0);
            this.bAvmMuteMusicMedia = false;
            return;
        }
        if (this.bIsRequestAvmFocus) {
            if (this.mAvmFocusRequest != null) {
                int abandonAudioFocusRequest = this.m_AudioManager.abandonAudioFocusRequest(this.mAvmFocusRequest);
                LogUtil.d(TAG, "abondAvmFocus ret:" + abandonAudioFocusRequest, new Object[0]);
            }
            LogUtil.d(TAG, "audioFocus abondAvmFocus", new Object[0]);
            this.bIsRequestAvmFocus = false;
        }
    }

    public synchronized int requestRvcFocus() {
        AudioAttributes build;
        if (isCarplayCertificate()) {
            this.m_AudioManager.adjustStreamVolume(3, -100, 0);
            this.bRvcMuteMusicMedia = true;
            return 0;
        }
        int InterruptMediaType = InterruptMediaType();
        if (InterruptMediaType == 1) {
            build = new AudioAttributes.Builder().setLegacyStreamType(29).build();
        } else if (InterruptMediaType == 2) {
            build = new AudioAttributes.Builder().setLegacyStreamType(14).build();
        } else {
            build = new AudioAttributes.Builder().setLegacyStreamType(12).build();
        }
        this.mRvcFocusRequest = new AudioFocusRequest.Builder(1).setWillPauseWhenDucked(true).setAcceptsDelayedFocusGain(true).setOnAudioFocusChangeListener(this.audioFocusChangeListener).setAudioAttributes(build).build();
        int requestAudioFocus = this.m_AudioManager.requestAudioFocus(this.mRvcFocusRequest);
        LogUtil.d(TAG, "requestRvcFocus ret:" + requestAudioFocus, new Object[0]);
        this.bIsRequestRvcFocus = true;
        return requestAudioFocus;
    }

    public synchronized void abondRvcFocus() {
        if (this.bRvcMuteMusicMedia) {
            this.m_AudioManager.adjustStreamVolume(3, 100, 0);
            this.bRvcMuteMusicMedia = false;
            return;
        }
        if (this.mRvcFocusRequest != null) {
            int abandonAudioFocusRequest = this.m_AudioManager.abandonAudioFocusRequest(this.mRvcFocusRequest);
            LogUtil.d(TAG, "abondRvcFocus ret:" + abandonAudioFocusRequest, new Object[0]);
        }
        this.bIsRequestRvcFocus = false;
        LogUtil.d(TAG, "audioFocus abondRvcFocus", new Object[0]);
    }

    public synchronized int requestRadarFocus() {
        AudioAttributes build;
        int requestAudioFocus;
        int InterruptMediaType = InterruptMediaType();
        if (InterruptMediaType == 1) {
            build = new AudioAttributes.Builder().setLegacyStreamType(28).build();
        } else if (InterruptMediaType == 2) {
            build = new AudioAttributes.Builder().setLegacyStreamType(30).build();
        } else {
            build = new AudioAttributes.Builder().setLegacyStreamType(4).build();
        }
        this.mRadarFocusRequest = new AudioFocusRequest.Builder(2).setWillPauseWhenDucked(true).setAcceptsDelayedFocusGain(true).setOnAudioFocusChangeListener(this.radarAudioFocusChangeListener).setAudioAttributes(build).build();
        requestAudioFocus = this.m_AudioManager.requestAudioFocus(this.mRadarFocusRequest);
        LogUtil.d(TAG, "requestRadarFocus type:" + requestAudioFocus, new Object[0]);
        this.bIsRequestRadarFocus = true;
        return requestAudioFocus;
    }

    public synchronized void abandonRadarFocus() {
        if (this.mRadarFocusRequest != null) {
            int abandonAudioFocusRequest = this.m_AudioManager.abandonAudioFocusRequest(this.mRadarFocusRequest);
            LogUtil.d(TAG, "abandonRadarFocus ret:" + abandonAudioFocusRequest, new Object[0]);
        }
        LogUtil.d(TAG, "audioFocus abandonRadarFocus", new Object[0]);
        this.bIsRequestRadarFocus = false;
    }

    public synchronized int requestCanActiveFocus() {
        AudioAttributes build;
        if (isCarplayCertificate()) {
            this.m_AudioManager.adjustStreamVolume(3, -100, 0);
            this.bCanActiveMuteMusicMedia = true;
            return 0;
        }
        int InterruptMediaType = InterruptMediaType();
        if (InterruptMediaType == 1) {
            build = new AudioAttributes.Builder().setLegacyStreamType(28).build();
        } else if (InterruptMediaType == 2) {
            build = new AudioAttributes.Builder().setLegacyStreamType(30).build();
        } else {
            build = new AudioAttributes.Builder().setLegacyStreamType(4).build();
        }
        this.mCanActiveFocusRequest = new AudioFocusRequest.Builder(2).setWillPauseWhenDucked(true).setAcceptsDelayedFocusGain(true).setOnAudioFocusChangeListener(this.canAudioFocusChangeListener).setAudioAttributes(build).build();
        int requestAudioFocus = this.m_AudioManager.requestAudioFocus(this.mCanActiveFocusRequest);
        LogUtil.d(TAG, "requestCanActiveFocus type:" + requestAudioFocus, new Object[0]);
        this.bIsRequestCanActiveFocus = true;
        return requestAudioFocus;
    }

    public synchronized void abandonCanActiveFocus() {
        if (this.bCanActiveMuteMusicMedia) {
            this.m_AudioManager.adjustStreamVolume(3, 100, 0);
            this.bCanActiveMuteMusicMedia = false;
            return;
        }
        if (this.bIsRequestCanActiveFocus) {
            if (this.mCanActiveFocusRequest != null) {
                int abandonAudioFocusRequest = this.m_AudioManager.abandonAudioFocusRequest(this.mCanActiveFocusRequest);
                LogUtil.d(TAG, "abandonCanActiveFocus ret:" + abandonAudioFocusRequest, new Object[0]);
            }
            LogUtil.d(TAG, "audioFocus abandonCanActiveFocus", new Object[0]);
            this.bIsRequestCanActiveFocus = false;
        }
    }
}
