package com.yftech.bsvservice;

import android.os.Parcel;
import android.os.Parcelable;

/* loaded from: /home/user/work/dex/classes.dex */
public class Resolution implements Parcelable {
    public static final Parcelable.Creator<Resolution> CREATOR = new Parcelable.Creator<Resolution>() { // from class: com.yftech.bsvservice.Resolution.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public Resolution createFromParcel(Parcel parcel) {
            return new Resolution(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public Resolution[] newArray(int i) {
            return new Resolution[i];
        }
    };
    private int mHeight;
    private int mWidth;

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public Resolution(int i, int i2) {
        this.mWidth = i;
        this.mHeight = i2;
    }

    protected Resolution(Parcel parcel) {
        this.mWidth = parcel.readInt();
        this.mHeight = parcel.readInt();
    }

    public int getWidth() {
        return this.mWidth;
    }

    public int getHeight() {
        return this.mHeight;
    }

    public String toString() {
        return this.mWidth + "x" + this.mHeight;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeInt(this.mWidth);
        parcel.writeInt(this.mHeight);
    }

    public void readFromParcel(Parcel parcel) {
        this.mWidth = parcel.readInt();
        this.mHeight = parcel.readInt();
    }
}
