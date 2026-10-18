package android.arch.lifecycle;

import android.support.annotation.NonNull;

/* loaded from: /home/user/work/dex/classes.dex */
public interface LifecycleOwner {
    @NonNull
    Lifecycle getLifecycle();
}
