package android.support.v4.graphics;

import android.content.Context;
import android.graphics.Typeface;
import android.os.CancellationSignal;
import android.os.ParcelFileDescriptor;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;
import android.support.annotation.RestrictTo;
import android.support.v4.provider.FontsContractCompat;
import android.system.ErrnoException;
import android.system.Os;
import android.system.OsConstants;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@RequiresApi(21)
@RestrictTo({RestrictTo.Scope.LIBRARY_GROUP})
/* loaded from: /home/user/work/dex/classes.dex */
class TypefaceCompatApi21Impl extends TypefaceCompatBaseImpl {
    private static final String TAG = "TypefaceCompatApi21Impl";

    private File getFile(ParcelFileDescriptor parcelFileDescriptor) {
        try {
            String readlink = Os.readlink("/proc/self/fd/" + parcelFileDescriptor.getFd());
            if (OsConstants.S_ISREG(Os.stat(readlink).st_mode)) {
                return new File(readlink);
            }
            return null;
        } catch (ErrnoException unused) {
            return null;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:29:0x0059 A[Catch: all -> 0x005d, Throwable -> 0x0060, TryCatch #4 {Throwable -> 0x0060, blocks: (B:9:0x0018, B:11:0x001e, B:14:0x0025, B:18:0x002f, B:21:0x003c, B:30:0x005c, B:29:0x0059, B:36:0x0055), top: B:8:0x0018 }] */
    /* JADX WARN: Removed duplicated region for block: B:31:0x0050 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:51:0x0068  */
    /* JADX WARN: Removed duplicated region for block: B:61:? A[Catch: IOException -> 0x0077, SYNTHETIC, TRY_LEAVE, TryCatch #1 {IOException -> 0x0077, blocks: (B:7:0x000e, B:16:0x002b, B:23:0x0041, B:55:0x006a, B:52:0x0073, B:59:0x006f, B:53:0x0076), top: B:6:0x000e, inners: #2 }] */
    @Override // android.support.v4.graphics.TypefaceCompatBaseImpl
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public Typeface createFromFontInfo(Context context, CancellationSignal cancellationSignal, @NonNull FontsContractCompat.FontInfo[] fontInfoArr, int i) {
        Throwable th;
        Throwable th2;
        Throwable th3;
        if (fontInfoArr.length < 1) {
            return null;
        }
        try {
            ParcelFileDescriptor openFileDescriptor = context.getContentResolver().openFileDescriptor(findBestInfo(fontInfoArr, i).getUri(), "r", cancellationSignal);
            try {
                try {
                    File file = getFile(openFileDescriptor);
                    if (file != null && file.canRead()) {
                        Typeface createFromFile = Typeface.createFromFile(file);
                        if (openFileDescriptor != null) {
                            openFileDescriptor.close();
                        }
                        return createFromFile;
                    }
                    FileInputStream fileInputStream = new FileInputStream(openFileDescriptor.getFileDescriptor());
                    try {
                        Typeface createFromInputStream = super.createFromInputStream(context, fileInputStream);
                        fileInputStream.close();
                        if (openFileDescriptor != null) {
                            openFileDescriptor.close();
                        }
                        return createFromInputStream;
                    } catch (Throwable th4) {
                        try {
                            throw th4;
                        } catch (Throwable th5) {
                            th2 = th4;
                            th3 = th5;
                            if (th2 != null) {
                                fileInputStream.close();
                                throw th3;
                            }
                            try {
                                fileInputStream.close();
                                throw th3;
                            } catch (Throwable th6) {
                                th2.addSuppressed(th6);
                                throw th3;
                            }
                        }
                    }
                } catch (Throwable th7) {
                    try {
                        throw th7;
                    } catch (Throwable th8) {
                        th = th7;
                        th = th8;
                        if (openFileDescriptor != null) {
                            throw th;
                        }
                        if (th == null) {
                            openFileDescriptor.close();
                            throw th;
                        }
                        try {
                            openFileDescriptor.close();
                            throw th;
                        } catch (Throwable th9) {
                            th.addSuppressed(th9);
                            throw th;
                        }
                    }
                }
            } catch (Throwable th10) {
                th = th10;
                th = null;
                if (openFileDescriptor != null) {
                }
            }
        } catch (IOException unused) {
            return null;
        }
    }
}
