package com.yftech.bsvservice.util;

import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.os.Process;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.lang.Thread;

/* loaded from: /home/user/work/dex/classes.dex */
public class AudioTrackManager {
    private static final int AUDIO_FORMAT = 2;
    private static final int CHANNEL_CONFIG = 4;
    private static final int SAMPLE_RATE = 48000;
    private static final int STREAM_TYPE = 28;
    public static final String TAG = "AudioTrackManager";
    private static AudioTrackManager mInstance;
    private AudioTrack audioTrack;
    private int bufferSize;
    private DataInputStream dis;
    private Thread playThread;
    private boolean isStart = false;
    Runnable recordRunnable = new Runnable() { // from class: com.yftech.bsvservice.util.AudioTrackManager.1
        @Override // java.lang.Runnable
        public void run() {
            try {
                Process.setThreadPriority(-19);
                byte[] bArr = new byte[AudioTrackManager.this.bufferSize];
                while (AudioTrackManager.this.dis.available() > 0) {
                    int read = AudioTrackManager.this.dis.read(bArr);
                    if (read != -3 && read != -2 && read != 0 && read != -1) {
                        AudioTrackManager.this.audioTrack.play();
                        AudioTrackManager.this.audioTrack.write(bArr, 0, read);
                    }
                }
                AudioTrackManager.this.stopPlay();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };

    public AudioTrackManager() {
        AudioAttributes build = new AudioAttributes.Builder().setLegacyStreamType(28).build();
        AudioFormat build2 = new AudioFormat.Builder().setSampleRate(SAMPLE_RATE).setChannelMask(4).setEncoding(2).build();
        this.bufferSize = AudioTrack.getMinBufferSize(SAMPLE_RATE, 2, 2);
        this.audioTrack = new AudioTrack(build, build2, this.bufferSize * 2, 1, 0);
    }

    public static AudioTrackManager getInstance() {
        if (mInstance == null) {
            synchronized (AudioTrackManager.class) {
                if (mInstance == null) {
                    mInstance = new AudioTrackManager();
                }
            }
        }
        return mInstance;
    }

    private void destroyThread() {
        try {
            try {
                this.isStart = false;
                if (this.playThread != null && Thread.State.RUNNABLE == this.playThread.getState()) {
                    try {
                        Thread.sleep(500L);
                        this.playThread.interrupt();
                    } catch (Exception unused) {
                        this.playThread = null;
                    }
                }
                this.playThread = null;
            } finally {
                this.playThread = null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void startThread() {
        destroyThread();
        this.isStart = true;
        if (this.playThread == null) {
            this.playThread = new Thread(this.recordRunnable);
            this.playThread.start();
        }
    }

    private void setPath(String str) throws Exception {
        this.dis = new DataInputStream(new FileInputStream(new File(str)));
    }

    public void startPlay(String str) {
        try {
            setPath(str);
            startThread();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void stopPlay() {
        try {
            destroyThread();
            if (this.audioTrack != null) {
                this.audioTrack.pause();
                this.audioTrack.flush();
                this.audioTrack.release();
                this.audioTrack = null;
            }
            if (this.dis != null) {
                this.dis.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
