package android.support.constraint.solver.widgets;

import android.support.constraint.solver.ArrayRow;
import android.support.constraint.solver.Cache;
import android.support.constraint.solver.LinearSystem;
import android.support.constraint.solver.SolverVariable;
import android.support.constraint.solver.widgets.ConstraintAnchor;
import java.util.ArrayList;

/* loaded from: /home/user/work/dex/classes.dex */
public class ConstraintWidget {
    private static final boolean AUTOTAG_CENTER = false;
    public static final int CHAIN_PACKED = 2;
    public static final int CHAIN_SPREAD = 0;
    public static final int CHAIN_SPREAD_INSIDE = 1;
    public static float DEFAULT_BIAS = 0.5f;
    protected static final int DIRECT = 2;
    public static final int GONE = 8;
    public static final int HORIZONTAL = 0;
    public static final int INVISIBLE = 4;
    public static final int MATCH_CONSTRAINT_SPREAD = 0;
    public static final int MATCH_CONSTRAINT_WRAP = 1;
    protected static final int SOLVER = 1;
    public static final int UNKNOWN = -1;
    public static final int VERTICAL = 1;
    public static final int VISIBLE = 0;
    protected ArrayList<ConstraintAnchor> mAnchors;
    ConstraintAnchor mBaseline;
    int mBaselineDistance;
    ConstraintAnchor mBottom;
    boolean mBottomHasCentered;
    ConstraintAnchor mCenter;
    ConstraintAnchor mCenterX;
    ConstraintAnchor mCenterY;
    private Object mCompanionWidget;
    private int mContainerItemSkip;
    private String mDebugName;
    protected float mDimensionRatio;
    protected int mDimensionRatioSide;
    int mDistToBottom;
    int mDistToLeft;
    int mDistToRight;
    int mDistToTop;
    private int mDrawHeight;
    private int mDrawWidth;
    private int mDrawX;
    private int mDrawY;
    int mHeight;
    float mHorizontalBiasPercent;
    boolean mHorizontalChainFixedPosition;
    int mHorizontalChainStyle;
    DimensionBehaviour mHorizontalDimensionBehaviour;
    ConstraintWidget mHorizontalNextWidget;
    public int mHorizontalResolution;
    float mHorizontalWeight;
    boolean mHorizontalWrapVisited;
    ConstraintAnchor mLeft;
    boolean mLeftHasCentered;
    int mMatchConstraintDefaultHeight;
    int mMatchConstraintDefaultWidth;
    int mMatchConstraintMaxHeight;
    int mMatchConstraintMaxWidth;
    int mMatchConstraintMinHeight;
    int mMatchConstraintMinWidth;
    protected int mMinHeight;
    protected int mMinWidth;
    protected int mOffsetX;
    protected int mOffsetY;
    ConstraintWidget mParent;
    ConstraintAnchor mRight;
    boolean mRightHasCentered;
    private int mSolverBottom;
    private int mSolverLeft;
    private int mSolverRight;
    private int mSolverTop;
    ConstraintAnchor mTop;
    boolean mTopHasCentered;
    private String mType;
    float mVerticalBiasPercent;
    boolean mVerticalChainFixedPosition;
    int mVerticalChainStyle;
    DimensionBehaviour mVerticalDimensionBehaviour;
    ConstraintWidget mVerticalNextWidget;
    public int mVerticalResolution;
    float mVerticalWeight;
    boolean mVerticalWrapVisited;
    private int mVisibility;
    int mWidth;
    private int mWrapHeight;
    private int mWrapWidth;
    protected int mX;
    protected int mY;

    /* loaded from: /home/user/work/dex/classes.dex */
    public enum ContentAlignment {
        BEGIN,
        MIDDLE,
        END,
        TOP,
        VERTICAL_MIDDLE,
        BOTTOM,
        LEFT,
        RIGHT
    }

    /* loaded from: /home/user/work/dex/classes.dex */
    public enum DimensionBehaviour {
        FIXED,
        WRAP_CONTENT,
        MATCH_CONSTRAINT,
        MATCH_PARENT
    }

    public void connectedTo(ConstraintWidget constraintWidget) {
    }

    public void reset() {
        this.mLeft.reset();
        this.mTop.reset();
        this.mRight.reset();
        this.mBottom.reset();
        this.mBaseline.reset();
        this.mCenterX.reset();
        this.mCenterY.reset();
        this.mCenter.reset();
        this.mParent = null;
        this.mWidth = 0;
        this.mHeight = 0;
        this.mDimensionRatio = 0.0f;
        this.mDimensionRatioSide = -1;
        this.mX = 0;
        this.mY = 0;
        this.mDrawX = 0;
        this.mDrawY = 0;
        this.mDrawWidth = 0;
        this.mDrawHeight = 0;
        this.mOffsetX = 0;
        this.mOffsetY = 0;
        this.mBaselineDistance = 0;
        this.mMinWidth = 0;
        this.mMinHeight = 0;
        this.mWrapWidth = 0;
        this.mWrapHeight = 0;
        this.mHorizontalBiasPercent = DEFAULT_BIAS;
        this.mVerticalBiasPercent = DEFAULT_BIAS;
        this.mHorizontalDimensionBehaviour = DimensionBehaviour.FIXED;
        this.mVerticalDimensionBehaviour = DimensionBehaviour.FIXED;
        this.mCompanionWidget = null;
        this.mContainerItemSkip = 0;
        this.mVisibility = 0;
        this.mDebugName = null;
        this.mType = null;
        this.mHorizontalWrapVisited = false;
        this.mVerticalWrapVisited = false;
        this.mHorizontalChainStyle = 0;
        this.mVerticalChainStyle = 0;
        this.mHorizontalChainFixedPosition = false;
        this.mVerticalChainFixedPosition = false;
        this.mHorizontalWeight = 0.0f;
        this.mVerticalWeight = 0.0f;
        this.mHorizontalResolution = -1;
        this.mVerticalResolution = -1;
    }

    public ConstraintWidget() {
        this.mHorizontalResolution = -1;
        this.mVerticalResolution = -1;
        this.mMatchConstraintDefaultWidth = 0;
        this.mMatchConstraintDefaultHeight = 0;
        this.mMatchConstraintMinWidth = 0;
        this.mMatchConstraintMaxWidth = 0;
        this.mMatchConstraintMinHeight = 0;
        this.mMatchConstraintMaxHeight = 0;
        this.mLeft = new ConstraintAnchor(this, ConstraintAnchor.Type.LEFT);
        this.mTop = new ConstraintAnchor(this, ConstraintAnchor.Type.TOP);
        this.mRight = new ConstraintAnchor(this, ConstraintAnchor.Type.RIGHT);
        this.mBottom = new ConstraintAnchor(this, ConstraintAnchor.Type.BOTTOM);
        this.mBaseline = new ConstraintAnchor(this, ConstraintAnchor.Type.BASELINE);
        this.mCenterX = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_X);
        this.mCenterY = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_Y);
        this.mCenter = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER);
        this.mAnchors = new ArrayList<>();
        this.mParent = null;
        this.mWidth = 0;
        this.mHeight = 0;
        this.mDimensionRatio = 0.0f;
        this.mDimensionRatioSide = -1;
        this.mSolverLeft = 0;
        this.mSolverTop = 0;
        this.mSolverRight = 0;
        this.mSolverBottom = 0;
        this.mX = 0;
        this.mY = 0;
        this.mDrawX = 0;
        this.mDrawY = 0;
        this.mDrawWidth = 0;
        this.mDrawHeight = 0;
        this.mOffsetX = 0;
        this.mOffsetY = 0;
        this.mBaselineDistance = 0;
        this.mHorizontalBiasPercent = DEFAULT_BIAS;
        this.mVerticalBiasPercent = DEFAULT_BIAS;
        this.mHorizontalDimensionBehaviour = DimensionBehaviour.FIXED;
        this.mVerticalDimensionBehaviour = DimensionBehaviour.FIXED;
        this.mContainerItemSkip = 0;
        this.mVisibility = 0;
        this.mDebugName = null;
        this.mType = null;
        this.mHorizontalChainStyle = 0;
        this.mVerticalChainStyle = 0;
        this.mHorizontalWeight = 0.0f;
        this.mVerticalWeight = 0.0f;
        this.mHorizontalNextWidget = null;
        this.mVerticalNextWidget = null;
        addAnchors();
    }

    public ConstraintWidget(int i, int i2, int i3, int i4) {
        this.mHorizontalResolution = -1;
        this.mVerticalResolution = -1;
        this.mMatchConstraintDefaultWidth = 0;
        this.mMatchConstraintDefaultHeight = 0;
        this.mMatchConstraintMinWidth = 0;
        this.mMatchConstraintMaxWidth = 0;
        this.mMatchConstraintMinHeight = 0;
        this.mMatchConstraintMaxHeight = 0;
        this.mLeft = new ConstraintAnchor(this, ConstraintAnchor.Type.LEFT);
        this.mTop = new ConstraintAnchor(this, ConstraintAnchor.Type.TOP);
        this.mRight = new ConstraintAnchor(this, ConstraintAnchor.Type.RIGHT);
        this.mBottom = new ConstraintAnchor(this, ConstraintAnchor.Type.BOTTOM);
        this.mBaseline = new ConstraintAnchor(this, ConstraintAnchor.Type.BASELINE);
        this.mCenterX = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_X);
        this.mCenterY = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER_Y);
        this.mCenter = new ConstraintAnchor(this, ConstraintAnchor.Type.CENTER);
        this.mAnchors = new ArrayList<>();
        this.mParent = null;
        this.mWidth = 0;
        this.mHeight = 0;
        this.mDimensionRatio = 0.0f;
        this.mDimensionRatioSide = -1;
        this.mSolverLeft = 0;
        this.mSolverTop = 0;
        this.mSolverRight = 0;
        this.mSolverBottom = 0;
        this.mX = 0;
        this.mY = 0;
        this.mDrawX = 0;
        this.mDrawY = 0;
        this.mDrawWidth = 0;
        this.mDrawHeight = 0;
        this.mOffsetX = 0;
        this.mOffsetY = 0;
        this.mBaselineDistance = 0;
        this.mHorizontalBiasPercent = DEFAULT_BIAS;
        this.mVerticalBiasPercent = DEFAULT_BIAS;
        this.mHorizontalDimensionBehaviour = DimensionBehaviour.FIXED;
        this.mVerticalDimensionBehaviour = DimensionBehaviour.FIXED;
        this.mContainerItemSkip = 0;
        this.mVisibility = 0;
        this.mDebugName = null;
        this.mType = null;
        this.mHorizontalChainStyle = 0;
        this.mVerticalChainStyle = 0;
        this.mHorizontalWeight = 0.0f;
        this.mVerticalWeight = 0.0f;
        this.mHorizontalNextWidget = null;
        this.mVerticalNextWidget = null;
        this.mX = i;
        this.mY = i2;
        this.mWidth = i3;
        this.mHeight = i4;
        addAnchors();
        forceUpdateDrawPosition();
    }

    public ConstraintWidget(int i, int i2) {
        this(0, 0, i, i2);
    }

    public void resetSolverVariables(Cache cache) {
        this.mLeft.resetSolverVariable(cache);
        this.mTop.resetSolverVariable(cache);
        this.mRight.resetSolverVariable(cache);
        this.mBottom.resetSolverVariable(cache);
        this.mBaseline.resetSolverVariable(cache);
        this.mCenter.resetSolverVariable(cache);
        this.mCenterX.resetSolverVariable(cache);
        this.mCenterY.resetSolverVariable(cache);
    }

    public void resetGroups() {
        int size = this.mAnchors.size();
        for (int i = 0; i < size; i++) {
            this.mAnchors.get(i).mGroup = Integer.MAX_VALUE;
        }
    }

    private void addAnchors() {
        this.mAnchors.add(this.mLeft);
        this.mAnchors.add(this.mTop);
        this.mAnchors.add(this.mRight);
        this.mAnchors.add(this.mBottom);
        this.mAnchors.add(this.mCenterX);
        this.mAnchors.add(this.mCenterY);
        this.mAnchors.add(this.mBaseline);
    }

    public boolean isRoot() {
        return this.mParent == null;
    }

    public boolean isRootContainer() {
        return (this instanceof ConstraintWidgetContainer) && (this.mParent == null || !(this.mParent instanceof ConstraintWidgetContainer));
    }

    public boolean isInsideConstraintLayout() {
        ConstraintWidget parent = getParent();
        if (parent == null) {
            return false;
        }
        while (parent != null) {
            if (parent instanceof ConstraintWidgetContainer) {
                return true;
            }
            parent = parent.getParent();
        }
        return false;
    }

    public boolean hasAncestor(ConstraintWidget constraintWidget) {
        ConstraintWidget parent = getParent();
        if (parent == constraintWidget) {
            return true;
        }
        if (parent == constraintWidget.getParent()) {
            return false;
        }
        while (parent != null) {
            if (parent == constraintWidget || parent == constraintWidget.getParent()) {
                return true;
            }
            parent = parent.getParent();
        }
        return false;
    }

    public WidgetContainer getRootWidgetContainer() {
        while (this.getParent() != null) {
            this = this.getParent();
        }
        if (this instanceof WidgetContainer) {
            return (WidgetContainer) this;
        }
        return null;
    }

    public ConstraintWidget getParent() {
        return this.mParent;
    }

    public void setParent(ConstraintWidget constraintWidget) {
        this.mParent = constraintWidget;
    }

    public String getType() {
        return this.mType;
    }

    public void setType(String str) {
        this.mType = str;
    }

    public void setVisibility(int i) {
        this.mVisibility = i;
    }

    public int getVisibility() {
        return this.mVisibility;
    }

    public String getDebugName() {
        return this.mDebugName;
    }

    public void setDebugName(String str) {
        this.mDebugName = str;
    }

    public void setDebugSolverName(LinearSystem linearSystem, String str) {
        this.mDebugName = str;
        SolverVariable createObjectVariable = linearSystem.createObjectVariable(this.mLeft);
        SolverVariable createObjectVariable2 = linearSystem.createObjectVariable(this.mTop);
        SolverVariable createObjectVariable3 = linearSystem.createObjectVariable(this.mRight);
        SolverVariable createObjectVariable4 = linearSystem.createObjectVariable(this.mBottom);
        createObjectVariable.setName(str + ".left");
        createObjectVariable2.setName(str + ".top");
        createObjectVariable3.setName(str + ".right");
        createObjectVariable4.setName(str + ".bottom");
        if (this.mBaselineDistance > 0) {
            linearSystem.createObjectVariable(this.mBaseline).setName(str + ".baseline");
        }
    }

    public String toString() {
        String str;
        String str2;
        StringBuilder sb = new StringBuilder();
        if (this.mType != null) {
            str = "type: " + this.mType + " ";
        } else {
            str = "";
        }
        sb.append(str);
        if (this.mDebugName != null) {
            str2 = "id: " + this.mDebugName + " ";
        } else {
            str2 = "";
        }
        sb.append(str2);
        sb.append("(");
        sb.append(this.mX);
        sb.append(", ");
        sb.append(this.mY);
        sb.append(") - (");
        sb.append(this.mWidth);
        sb.append(" x ");
        sb.append(this.mHeight);
        sb.append(")");
        sb.append(" wrap: (");
        sb.append(this.mWrapWidth);
        sb.append(" x ");
        sb.append(this.mWrapHeight);
        sb.append(")");
        return sb.toString();
    }

    int getInternalDrawX() {
        return this.mDrawX;
    }

    int getInternalDrawY() {
        return this.mDrawY;
    }

    public int getInternalDrawRight() {
        return this.mDrawX + this.mDrawWidth;
    }

    public int getInternalDrawBottom() {
        return this.mDrawY + this.mDrawHeight;
    }

    public int getX() {
        return this.mX;
    }

    public int getY() {
        return this.mY;
    }

    public int getWidth() {
        if (this.mVisibility == 8) {
            return 0;
        }
        return this.mWidth;
    }

    public int getOptimizerWrapWidth() {
        int i;
        int i2 = this.mWidth;
        if (this.mHorizontalDimensionBehaviour != DimensionBehaviour.MATCH_CONSTRAINT) {
            return i2;
        }
        if (this.mMatchConstraintDefaultWidth == 1) {
            i = Math.max(this.mMatchConstraintMinWidth, i2);
        } else if (this.mMatchConstraintMinWidth > 0) {
            i = this.mMatchConstraintMinWidth;
            this.mWidth = i;
        } else {
            i = 0;
        }
        return (this.mMatchConstraintMaxWidth <= 0 || this.mMatchConstraintMaxWidth >= i) ? i : this.mMatchConstraintMaxWidth;
    }

    public int getOptimizerWrapHeight() {
        int i;
        int i2 = this.mHeight;
        if (this.mVerticalDimensionBehaviour != DimensionBehaviour.MATCH_CONSTRAINT) {
            return i2;
        }
        if (this.mMatchConstraintDefaultHeight == 1) {
            i = Math.max(this.mMatchConstraintMinHeight, i2);
        } else if (this.mMatchConstraintMinHeight > 0) {
            i = this.mMatchConstraintMinHeight;
            this.mHeight = i;
        } else {
            i = 0;
        }
        return (this.mMatchConstraintMaxHeight <= 0 || this.mMatchConstraintMaxHeight >= i) ? i : this.mMatchConstraintMaxHeight;
    }

    public int getWrapWidth() {
        return this.mWrapWidth;
    }

    public int getHeight() {
        if (this.mVisibility == 8) {
            return 0;
        }
        return this.mHeight;
    }

    public int getWrapHeight() {
        return this.mWrapHeight;
    }

    public int getDrawX() {
        return this.mDrawX + this.mOffsetX;
    }

    public int getDrawY() {
        return this.mDrawY + this.mOffsetY;
    }

    public int getDrawWidth() {
        return this.mDrawWidth;
    }

    public int getDrawHeight() {
        return this.mDrawHeight;
    }

    public int getDrawBottom() {
        return getDrawY() + this.mDrawHeight;
    }

    public int getDrawRight() {
        return getDrawX() + this.mDrawWidth;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public int getRootX() {
        return this.mX + this.mOffsetX;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public int getRootY() {
        return this.mY + this.mOffsetY;
    }

    public int getMinWidth() {
        return this.mMinWidth;
    }

    public int getMinHeight() {
        return this.mMinHeight;
    }

    public int getLeft() {
        return getX();
    }

    public int getTop() {
        return getY();
    }

    public int getRight() {
        return getX() + this.mWidth;
    }

    public int getBottom() {
        return getY() + this.mHeight;
    }

    public float getHorizontalBiasPercent() {
        return this.mHorizontalBiasPercent;
    }

    public float getVerticalBiasPercent() {
        return this.mVerticalBiasPercent;
    }

    public boolean hasBaseline() {
        return this.mBaselineDistance > 0;
    }

    public int getBaselineDistance() {
        return this.mBaselineDistance;
    }

    public Object getCompanionWidget() {
        return this.mCompanionWidget;
    }

    public ArrayList<ConstraintAnchor> getAnchors() {
        return this.mAnchors;
    }

    public void setX(int i) {
        this.mX = i;
    }

    public void setY(int i) {
        this.mY = i;
    }

    public void setOrigin(int i, int i2) {
        this.mX = i;
        this.mY = i2;
    }

    public void setOffset(int i, int i2) {
        this.mOffsetX = i;
        this.mOffsetY = i2;
    }

    public void setGoneMargin(ConstraintAnchor.Type type, int i) {
        switch (type) {
            case LEFT:
                this.mLeft.mGoneMargin = i;
                return;
            case TOP:
                this.mTop.mGoneMargin = i;
                return;
            case RIGHT:
                this.mRight.mGoneMargin = i;
                return;
            case BOTTOM:
                this.mBottom.mGoneMargin = i;
                return;
            default:
                return;
        }
    }

    public void updateDrawPosition() {
        int i = this.mX;
        int i2 = this.mY;
        int i3 = this.mX + this.mWidth;
        int i4 = this.mY + this.mHeight;
        this.mDrawX = i;
        this.mDrawY = i2;
        this.mDrawWidth = i3 - i;
        this.mDrawHeight = i4 - i2;
    }

    public void forceUpdateDrawPosition() {
        int i = this.mX;
        int i2 = this.mY;
        int i3 = this.mX + this.mWidth;
        int i4 = this.mY + this.mHeight;
        this.mDrawX = i;
        this.mDrawY = i2;
        this.mDrawWidth = i3 - i;
        this.mDrawHeight = i4 - i2;
    }

    public void setDrawOrigin(int i, int i2) {
        this.mDrawX = i - this.mOffsetX;
        this.mDrawY = i2 - this.mOffsetY;
        this.mX = this.mDrawX;
        this.mY = this.mDrawY;
    }

    public void setDrawX(int i) {
        this.mDrawX = i - this.mOffsetX;
        this.mX = this.mDrawX;
    }

    public void setDrawY(int i) {
        this.mDrawY = i - this.mOffsetY;
        this.mY = this.mDrawY;
    }

    public void setDrawWidth(int i) {
        this.mDrawWidth = i;
    }

    public void setDrawHeight(int i) {
        this.mDrawHeight = i;
    }

    public void setWidth(int i) {
        this.mWidth = i;
        if (this.mWidth < this.mMinWidth) {
            this.mWidth = this.mMinWidth;
        }
    }

    public void setHeight(int i) {
        this.mHeight = i;
        if (this.mHeight < this.mMinHeight) {
            this.mHeight = this.mMinHeight;
        }
    }

    public void setHorizontalMatchStyle(int i, int i2, int i3) {
        this.mMatchConstraintDefaultWidth = i;
        this.mMatchConstraintMinWidth = i2;
        this.mMatchConstraintMaxWidth = i3;
    }

    public void setVerticalMatchStyle(int i, int i2, int i3) {
        this.mMatchConstraintDefaultHeight = i;
        this.mMatchConstraintMinHeight = i2;
        this.mMatchConstraintMaxHeight = i3;
    }

    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:38:0x0084 -> B:31:0x0085). Please report as a decompilation issue!!! */
    public void setDimensionRatio(String str) {
        float f;
        int i = 0;
        if (str == null || str.length() == 0) {
            this.mDimensionRatio = 0.0f;
            return;
        }
        int i2 = -1;
        int length = str.length();
        int indexOf = str.indexOf(44);
        int i3 = 0;
        if (indexOf > 0 && indexOf < length - 1) {
            String substring = str.substring(0, indexOf);
            if (substring.equalsIgnoreCase("W")) {
                i2 = 0;
            } else if (substring.equalsIgnoreCase("H")) {
                i2 = 1;
            }
            i3 = indexOf + 1;
        }
        int indexOf2 = str.indexOf(58);
        if (indexOf2 >= 0 && indexOf2 < length - 1) {
            String substring2 = str.substring(i3, indexOf2);
            String substring3 = str.substring(indexOf2 + 1);
            if (substring2.length() > 0 && substring3.length() > 0) {
                float parseFloat = Float.parseFloat(substring2);
                float parseFloat2 = Float.parseFloat(substring3);
                if (parseFloat > 0.0f && parseFloat2 > 0.0f) {
                    if (i2 == 1) {
                        f = Math.abs(parseFloat2 / parseFloat);
                    } else {
                        f = Math.abs(parseFloat / parseFloat2);
                    }
                }
            }
            f = i;
        } else {
            String substring4 = str.substring(i3);
            if (substring4.length() > 0) {
                f = Float.parseFloat(substring4);
            }
            f = i;
        }
        i = (f > i ? 1 : (f == i ? 0 : -1));
        if (i > 0) {
            this.mDimensionRatio = f;
            this.mDimensionRatioSide = i2;
        }
    }

    public void setDimensionRatio(float f, int i) {
        this.mDimensionRatio = f;
        this.mDimensionRatioSide = i;
    }

    public float getDimensionRatio() {
        return this.mDimensionRatio;
    }

    public int getDimensionRatioSide() {
        return this.mDimensionRatioSide;
    }

    public void setHorizontalBiasPercent(float f) {
        this.mHorizontalBiasPercent = f;
    }

    public void setVerticalBiasPercent(float f) {
        this.mVerticalBiasPercent = f;
    }

    public void setMinWidth(int i) {
        if (i < 0) {
            this.mMinWidth = 0;
        } else {
            this.mMinWidth = i;
        }
    }

    public void setMinHeight(int i) {
        if (i < 0) {
            this.mMinHeight = 0;
        } else {
            this.mMinHeight = i;
        }
    }

    public void setWrapWidth(int i) {
        this.mWrapWidth = i;
    }

    public void setWrapHeight(int i) {
        this.mWrapHeight = i;
    }

    public void setDimension(int i, int i2) {
        this.mWidth = i;
        if (this.mWidth < this.mMinWidth) {
            this.mWidth = this.mMinWidth;
        }
        this.mHeight = i2;
        if (this.mHeight < this.mMinHeight) {
            this.mHeight = this.mMinHeight;
        }
    }

    public void setFrame(int i, int i2, int i3, int i4) {
        int i5 = i3 - i;
        int i6 = i4 - i2;
        this.mX = i;
        this.mY = i2;
        if (this.mVisibility == 8) {
            this.mWidth = 0;
            this.mHeight = 0;
            return;
        }
        if (this.mHorizontalDimensionBehaviour == DimensionBehaviour.FIXED && i5 < this.mWidth) {
            i5 = this.mWidth;
        }
        if (this.mVerticalDimensionBehaviour == DimensionBehaviour.FIXED && i6 < this.mHeight) {
            i6 = this.mHeight;
        }
        this.mWidth = i5;
        this.mHeight = i6;
        if (this.mHeight < this.mMinHeight) {
            this.mHeight = this.mMinHeight;
        }
        if (this.mWidth < this.mMinWidth) {
            this.mWidth = this.mMinWidth;
        }
    }

    public void setHorizontalDimension(int i, int i2) {
        this.mX = i;
        this.mWidth = i2 - i;
        if (this.mWidth < this.mMinWidth) {
            this.mWidth = this.mMinWidth;
        }
    }

    public void setVerticalDimension(int i, int i2) {
        this.mY = i;
        this.mHeight = i2 - i;
        if (this.mHeight < this.mMinHeight) {
            this.mHeight = this.mMinHeight;
        }
    }

    public void setBaselineDistance(int i) {
        this.mBaselineDistance = i;
    }

    public void setCompanionWidget(Object obj) {
        this.mCompanionWidget = obj;
    }

    public void setContainerItemSkip(int i) {
        if (i >= 0) {
            this.mContainerItemSkip = i;
        } else {
            this.mContainerItemSkip = 0;
        }
    }

    public int getContainerItemSkip() {
        return this.mContainerItemSkip;
    }

    public void setHorizontalWeight(float f) {
        this.mHorizontalWeight = f;
    }

    public void setVerticalWeight(float f) {
        this.mVerticalWeight = f;
    }

    public void setHorizontalChainStyle(int i) {
        this.mHorizontalChainStyle = i;
    }

    public int getHorizontalChainStyle() {
        return this.mHorizontalChainStyle;
    }

    public void setVerticalChainStyle(int i) {
        this.mVerticalChainStyle = i;
    }

    public int getVerticalChainStyle() {
        return this.mVerticalChainStyle;
    }

    public void immediateConnect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2, int i, int i2) {
        getAnchor(type).connect(constraintWidget.getAnchor(type2), i, i2, ConstraintAnchor.Strength.STRONG, 0, true);
    }

    public void connect(ConstraintAnchor constraintAnchor, ConstraintAnchor constraintAnchor2, int i, int i2) {
        connect(constraintAnchor, constraintAnchor2, i, ConstraintAnchor.Strength.STRONG, i2);
    }

    public void connect(ConstraintAnchor constraintAnchor, ConstraintAnchor constraintAnchor2, int i) {
        connect(constraintAnchor, constraintAnchor2, i, ConstraintAnchor.Strength.STRONG, 0);
    }

    public void connect(ConstraintAnchor constraintAnchor, ConstraintAnchor constraintAnchor2, int i, ConstraintAnchor.Strength strength, int i2) {
        if (constraintAnchor.getOwner() == this) {
            connect(constraintAnchor.getType(), constraintAnchor2.getOwner(), constraintAnchor2.getType(), i, strength, i2);
        }
    }

    public void connect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2, int i) {
        connect(type, constraintWidget, type2, i, ConstraintAnchor.Strength.STRONG);
    }

    public void connect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2) {
        connect(type, constraintWidget, type2, 0, ConstraintAnchor.Strength.STRONG);
    }

    public void connect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2, int i, ConstraintAnchor.Strength strength) {
        connect(type, constraintWidget, type2, i, strength, 0);
    }

    public void connect(ConstraintAnchor.Type type, ConstraintWidget constraintWidget, ConstraintAnchor.Type type2, int i, ConstraintAnchor.Strength strength, int i2) {
        boolean z;
        int i3 = 0;
        if (type == ConstraintAnchor.Type.CENTER) {
            if (type2 == ConstraintAnchor.Type.CENTER) {
                ConstraintAnchor anchor = getAnchor(ConstraintAnchor.Type.LEFT);
                ConstraintAnchor anchor2 = getAnchor(ConstraintAnchor.Type.RIGHT);
                ConstraintAnchor anchor3 = getAnchor(ConstraintAnchor.Type.TOP);
                ConstraintAnchor anchor4 = getAnchor(ConstraintAnchor.Type.BOTTOM);
                boolean z2 = true;
                if ((anchor == null || !anchor.isConnected()) && (anchor2 == null || !anchor2.isConnected())) {
                    connect(ConstraintAnchor.Type.LEFT, constraintWidget, ConstraintAnchor.Type.LEFT, 0, strength, i2);
                    connect(ConstraintAnchor.Type.RIGHT, constraintWidget, ConstraintAnchor.Type.RIGHT, 0, strength, i2);
                    z = true;
                } else {
                    z = false;
                }
                if ((anchor3 == null || !anchor3.isConnected()) && (anchor4 == null || !anchor4.isConnected())) {
                    connect(ConstraintAnchor.Type.TOP, constraintWidget, ConstraintAnchor.Type.TOP, 0, strength, i2);
                    connect(ConstraintAnchor.Type.BOTTOM, constraintWidget, ConstraintAnchor.Type.BOTTOM, 0, strength, i2);
                } else {
                    z2 = false;
                }
                if (z && z2) {
                    getAnchor(ConstraintAnchor.Type.CENTER).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.CENTER), 0, i2);
                    return;
                } else if (z) {
                    getAnchor(ConstraintAnchor.Type.CENTER_X).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.CENTER_X), 0, i2);
                    return;
                } else {
                    if (z2) {
                        getAnchor(ConstraintAnchor.Type.CENTER_Y).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.CENTER_Y), 0, i2);
                        return;
                    }
                    return;
                }
            }
            if (type2 == ConstraintAnchor.Type.LEFT || type2 == ConstraintAnchor.Type.RIGHT) {
                connect(ConstraintAnchor.Type.LEFT, constraintWidget, type2, 0, strength, i2);
                connect(ConstraintAnchor.Type.RIGHT, constraintWidget, type2, 0, strength, i2);
                getAnchor(ConstraintAnchor.Type.CENTER).connect(constraintWidget.getAnchor(type2), 0, i2);
                return;
            } else {
                if (type2 == ConstraintAnchor.Type.TOP || type2 == ConstraintAnchor.Type.BOTTOM) {
                    connect(ConstraintAnchor.Type.TOP, constraintWidget, type2, 0, strength, i2);
                    connect(ConstraintAnchor.Type.BOTTOM, constraintWidget, type2, 0, strength, i2);
                    getAnchor(ConstraintAnchor.Type.CENTER).connect(constraintWidget.getAnchor(type2), 0, i2);
                    return;
                }
                return;
            }
        }
        if (type == ConstraintAnchor.Type.CENTER_X && (type2 == ConstraintAnchor.Type.LEFT || type2 == ConstraintAnchor.Type.RIGHT)) {
            ConstraintAnchor anchor5 = getAnchor(ConstraintAnchor.Type.LEFT);
            ConstraintAnchor anchor6 = constraintWidget.getAnchor(type2);
            ConstraintAnchor anchor7 = getAnchor(ConstraintAnchor.Type.RIGHT);
            anchor5.connect(anchor6, 0, i2);
            anchor7.connect(anchor6, 0, i2);
            getAnchor(ConstraintAnchor.Type.CENTER_X).connect(anchor6, 0, i2);
            return;
        }
        if (type == ConstraintAnchor.Type.CENTER_Y && (type2 == ConstraintAnchor.Type.TOP || type2 == ConstraintAnchor.Type.BOTTOM)) {
            ConstraintAnchor anchor8 = constraintWidget.getAnchor(type2);
            getAnchor(ConstraintAnchor.Type.TOP).connect(anchor8, 0, i2);
            getAnchor(ConstraintAnchor.Type.BOTTOM).connect(anchor8, 0, i2);
            getAnchor(ConstraintAnchor.Type.CENTER_Y).connect(anchor8, 0, i2);
            return;
        }
        if (type == ConstraintAnchor.Type.CENTER_X && type2 == ConstraintAnchor.Type.CENTER_X) {
            getAnchor(ConstraintAnchor.Type.LEFT).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.LEFT), 0, i2);
            getAnchor(ConstraintAnchor.Type.RIGHT).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.RIGHT), 0, i2);
            getAnchor(ConstraintAnchor.Type.CENTER_X).connect(constraintWidget.getAnchor(type2), 0, i2);
            return;
        }
        if (type == ConstraintAnchor.Type.CENTER_Y && type2 == ConstraintAnchor.Type.CENTER_Y) {
            getAnchor(ConstraintAnchor.Type.TOP).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.TOP), 0, i2);
            getAnchor(ConstraintAnchor.Type.BOTTOM).connect(constraintWidget.getAnchor(ConstraintAnchor.Type.BOTTOM), 0, i2);
            getAnchor(ConstraintAnchor.Type.CENTER_Y).connect(constraintWidget.getAnchor(type2), 0, i2);
            return;
        }
        ConstraintAnchor anchor9 = getAnchor(type);
        ConstraintAnchor anchor10 = constraintWidget.getAnchor(type2);
        if (anchor9.isValidConnection(anchor10)) {
            if (type == ConstraintAnchor.Type.BASELINE) {
                ConstraintAnchor anchor11 = getAnchor(ConstraintAnchor.Type.TOP);
                ConstraintAnchor anchor12 = getAnchor(ConstraintAnchor.Type.BOTTOM);
                if (anchor11 != null) {
                    anchor11.reset();
                }
                if (anchor12 != null) {
                    anchor12.reset();
                }
            } else {
                if (type == ConstraintAnchor.Type.TOP || type == ConstraintAnchor.Type.BOTTOM) {
                    ConstraintAnchor anchor13 = getAnchor(ConstraintAnchor.Type.BASELINE);
                    if (anchor13 != null) {
                        anchor13.reset();
                    }
                    ConstraintAnchor anchor14 = getAnchor(ConstraintAnchor.Type.CENTER);
                    if (anchor14.getTarget() != anchor10) {
                        anchor14.reset();
                    }
                    ConstraintAnchor opposite = getAnchor(type).getOpposite();
                    ConstraintAnchor anchor15 = getAnchor(ConstraintAnchor.Type.CENTER_Y);
                    if (anchor15.isConnected()) {
                        opposite.reset();
                        anchor15.reset();
                    }
                } else if (type == ConstraintAnchor.Type.LEFT || type == ConstraintAnchor.Type.RIGHT) {
                    ConstraintAnchor anchor16 = getAnchor(ConstraintAnchor.Type.CENTER);
                    if (anchor16.getTarget() != anchor10) {
                        anchor16.reset();
                    }
                    ConstraintAnchor opposite2 = getAnchor(type).getOpposite();
                    ConstraintAnchor anchor17 = getAnchor(ConstraintAnchor.Type.CENTER_X);
                    if (anchor17.isConnected()) {
                        opposite2.reset();
                        anchor17.reset();
                    }
                }
                i3 = i;
            }
            anchor9.connect(anchor10, i3, strength, i2);
            anchor10.getOwner().connectedTo(anchor9.getOwner());
        }
    }

    public void resetAllConstraints() {
        resetAnchors();
        setVerticalBiasPercent(DEFAULT_BIAS);
        setHorizontalBiasPercent(DEFAULT_BIAS);
        if (this instanceof ConstraintWidgetContainer) {
            return;
        }
        if (getHorizontalDimensionBehaviour() == DimensionBehaviour.MATCH_CONSTRAINT) {
            if (getWidth() == getWrapWidth()) {
                setHorizontalDimensionBehaviour(DimensionBehaviour.WRAP_CONTENT);
            } else if (getWidth() > getMinWidth()) {
                setHorizontalDimensionBehaviour(DimensionBehaviour.FIXED);
            }
        }
        if (getVerticalDimensionBehaviour() == DimensionBehaviour.MATCH_CONSTRAINT) {
            if (getHeight() == getWrapHeight()) {
                setVerticalDimensionBehaviour(DimensionBehaviour.WRAP_CONTENT);
            } else if (getHeight() > getMinHeight()) {
                setVerticalDimensionBehaviour(DimensionBehaviour.FIXED);
            }
        }
    }

    public void resetAnchor(ConstraintAnchor constraintAnchor) {
        if (getParent() != null && (getParent() instanceof ConstraintWidgetContainer) && ((ConstraintWidgetContainer) getParent()).handlesInternalConstraints()) {
            return;
        }
        ConstraintAnchor anchor = getAnchor(ConstraintAnchor.Type.LEFT);
        ConstraintAnchor anchor2 = getAnchor(ConstraintAnchor.Type.RIGHT);
        ConstraintAnchor anchor3 = getAnchor(ConstraintAnchor.Type.TOP);
        ConstraintAnchor anchor4 = getAnchor(ConstraintAnchor.Type.BOTTOM);
        ConstraintAnchor anchor5 = getAnchor(ConstraintAnchor.Type.CENTER);
        ConstraintAnchor anchor6 = getAnchor(ConstraintAnchor.Type.CENTER_X);
        ConstraintAnchor anchor7 = getAnchor(ConstraintAnchor.Type.CENTER_Y);
        if (constraintAnchor == anchor5) {
            if (anchor.isConnected() && anchor2.isConnected() && anchor.getTarget() == anchor2.getTarget()) {
                anchor.reset();
                anchor2.reset();
            }
            if (anchor3.isConnected() && anchor4.isConnected() && anchor3.getTarget() == anchor4.getTarget()) {
                anchor3.reset();
                anchor4.reset();
            }
            this.mHorizontalBiasPercent = 0.5f;
            this.mVerticalBiasPercent = 0.5f;
        } else if (constraintAnchor == anchor6) {
            if (anchor.isConnected() && anchor2.isConnected() && anchor.getTarget().getOwner() == anchor2.getTarget().getOwner()) {
                anchor.reset();
                anchor2.reset();
            }
            this.mHorizontalBiasPercent = 0.5f;
        } else if (constraintAnchor == anchor7) {
            if (anchor3.isConnected() && anchor4.isConnected() && anchor3.getTarget().getOwner() == anchor4.getTarget().getOwner()) {
                anchor3.reset();
                anchor4.reset();
            }
            this.mVerticalBiasPercent = 0.5f;
        } else if (constraintAnchor == anchor || constraintAnchor == anchor2) {
            if (anchor.isConnected() && anchor.getTarget() == anchor2.getTarget()) {
                anchor5.reset();
            }
        } else if ((constraintAnchor == anchor3 || constraintAnchor == anchor4) && anchor3.isConnected() && anchor3.getTarget() == anchor4.getTarget()) {
            anchor5.reset();
        }
        constraintAnchor.reset();
    }

    public void resetAnchors() {
        ConstraintWidget parent = getParent();
        if (parent != null && (parent instanceof ConstraintWidgetContainer) && ((ConstraintWidgetContainer) getParent()).handlesInternalConstraints()) {
            return;
        }
        int size = this.mAnchors.size();
        for (int i = 0; i < size; i++) {
            this.mAnchors.get(i).reset();
        }
    }

    public void resetAnchors(int i) {
        ConstraintWidget parent = getParent();
        if (parent != null && (parent instanceof ConstraintWidgetContainer) && ((ConstraintWidgetContainer) getParent()).handlesInternalConstraints()) {
            return;
        }
        int size = this.mAnchors.size();
        for (int i2 = 0; i2 < size; i2++) {
            ConstraintAnchor constraintAnchor = this.mAnchors.get(i2);
            if (i == constraintAnchor.getConnectionCreator()) {
                if (constraintAnchor.isVerticalAnchor()) {
                    setVerticalBiasPercent(DEFAULT_BIAS);
                } else {
                    setHorizontalBiasPercent(DEFAULT_BIAS);
                }
                constraintAnchor.reset();
            }
        }
    }

    public void disconnectWidget(ConstraintWidget constraintWidget) {
        ArrayList<ConstraintAnchor> anchors = getAnchors();
        int size = anchors.size();
        for (int i = 0; i < size; i++) {
            ConstraintAnchor constraintAnchor = anchors.get(i);
            if (constraintAnchor.isConnected() && constraintAnchor.getTarget().getOwner() == constraintWidget) {
                constraintAnchor.reset();
            }
        }
    }

    public void disconnectUnlockedWidget(ConstraintWidget constraintWidget) {
        ArrayList<ConstraintAnchor> anchors = getAnchors();
        int size = anchors.size();
        for (int i = 0; i < size; i++) {
            ConstraintAnchor constraintAnchor = anchors.get(i);
            if (constraintAnchor.isConnected() && constraintAnchor.getTarget().getOwner() == constraintWidget && constraintAnchor.getConnectionCreator() == 2) {
                constraintAnchor.reset();
            }
        }
    }

    public ConstraintAnchor getAnchor(ConstraintAnchor.Type type) {
        switch (type) {
            case LEFT:
                return this.mLeft;
            case TOP:
                return this.mTop;
            case RIGHT:
                return this.mRight;
            case BOTTOM:
                return this.mBottom;
            case BASELINE:
                return this.mBaseline;
            case CENTER_X:
                return this.mCenterX;
            case CENTER_Y:
                return this.mCenterY;
            case CENTER:
                return this.mCenter;
            default:
                return null;
        }
    }

    public DimensionBehaviour getHorizontalDimensionBehaviour() {
        return this.mHorizontalDimensionBehaviour;
    }

    public DimensionBehaviour getVerticalDimensionBehaviour() {
        return this.mVerticalDimensionBehaviour;
    }

    public void setHorizontalDimensionBehaviour(DimensionBehaviour dimensionBehaviour) {
        this.mHorizontalDimensionBehaviour = dimensionBehaviour;
        if (this.mHorizontalDimensionBehaviour == DimensionBehaviour.WRAP_CONTENT) {
            setWidth(this.mWrapWidth);
        }
    }

    public void setVerticalDimensionBehaviour(DimensionBehaviour dimensionBehaviour) {
        this.mVerticalDimensionBehaviour = dimensionBehaviour;
        if (this.mVerticalDimensionBehaviour == DimensionBehaviour.WRAP_CONTENT) {
            setHeight(this.mWrapHeight);
        }
    }

    public boolean isInHorizontalChain() {
        if (this.mLeft.mTarget == null || this.mLeft.mTarget.mTarget != this.mLeft) {
            return this.mRight.mTarget != null && this.mRight.mTarget.mTarget == this.mRight;
        }
        return true;
    }

    public ConstraintWidget getHorizontalChainControlWidget() {
        if (!isInHorizontalChain()) {
            return null;
        }
        ConstraintWidget constraintWidget = this;
        ConstraintWidget constraintWidget2 = null;
        while (constraintWidget2 == null && constraintWidget != null) {
            ConstraintAnchor anchor = constraintWidget.getAnchor(ConstraintAnchor.Type.LEFT);
            ConstraintAnchor target = anchor == null ? null : anchor.getTarget();
            ConstraintWidget owner = target == null ? null : target.getOwner();
            if (owner == getParent()) {
                return constraintWidget;
            }
            ConstraintAnchor target2 = owner == null ? null : owner.getAnchor(ConstraintAnchor.Type.RIGHT).getTarget();
            if (target2 == null || target2.getOwner() == constraintWidget) {
                constraintWidget = owner;
            } else {
                constraintWidget2 = constraintWidget;
            }
        }
        return constraintWidget2;
    }

    public boolean isInVerticalChain() {
        if (this.mTop.mTarget == null || this.mTop.mTarget.mTarget != this.mTop) {
            return this.mBottom.mTarget != null && this.mBottom.mTarget.mTarget == this.mBottom;
        }
        return true;
    }

    public ConstraintWidget getVerticalChainControlWidget() {
        if (!isInVerticalChain()) {
            return null;
        }
        ConstraintWidget constraintWidget = this;
        ConstraintWidget constraintWidget2 = null;
        while (constraintWidget2 == null && constraintWidget != null) {
            ConstraintAnchor anchor = constraintWidget.getAnchor(ConstraintAnchor.Type.TOP);
            ConstraintAnchor target = anchor == null ? null : anchor.getTarget();
            ConstraintWidget owner = target == null ? null : target.getOwner();
            if (owner == getParent()) {
                return constraintWidget;
            }
            ConstraintAnchor target2 = owner == null ? null : owner.getAnchor(ConstraintAnchor.Type.BOTTOM).getTarget();
            if (target2 == null || target2.getOwner() == constraintWidget) {
                constraintWidget = owner;
            } else {
                constraintWidget2 = constraintWidget;
            }
        }
        return constraintWidget2;
    }

    public void addToSolver(LinearSystem linearSystem) {
        addToSolver(linearSystem, Integer.MAX_VALUE);
    }

    /* JADX WARN: Code restructure failed: missing block: B:165:0x0416, code lost:
    
        if (r14 == (-1)) goto L230;
     */
    /* JADX WARN: Code restructure failed: missing block: B:233:0x0547, code lost:
    
        if (r9.mBottom.mGroup == r45) goto L275;
     */
    /* JADX WARN: Removed duplicated region for block: B:135:0x02d6 A[ADDED_TO_REGION] */
    /* JADX WARN: Removed duplicated region for block: B:140:0x02e5  */
    /* JADX WARN: Removed duplicated region for block: B:145:0x02f2  */
    /* JADX WARN: Removed duplicated region for block: B:154:0x03ff A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:156:0x0400  */
    /* JADX WARN: Removed duplicated region for block: B:169:0x0426  */
    /* JADX WARN: Removed duplicated region for block: B:187:0x05e1  */
    /* JADX WARN: Removed duplicated region for block: B:214:? A[RETURN, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:228:0x052a  */
    /* JADX WARN: Removed duplicated region for block: B:260:0x03e8  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public void addToSolver(LinearSystem linearSystem, int i) {
        boolean z;
        boolean z2;
        int i2;
        int i3;
        boolean z3;
        int i4;
        float f;
        boolean z4;
        boolean z5;
        int i5;
        SolverVariable solverVariable;
        SolverVariable solverVariable2;
        SolverVariable solverVariable3;
        SolverVariable solverVariable4;
        int i6;
        SolverVariable solverVariable5;
        boolean z6;
        int i7;
        int i8;
        boolean z7;
        int i9;
        SolverVariable solverVariable6;
        SolverVariable solverVariable7;
        ConstraintWidget constraintWidget;
        SolverVariable solverVariable8;
        SolverVariable solverVariable9;
        ConstraintWidget constraintWidget2;
        SolverVariable solverVariable10;
        SolverVariable solverVariable11;
        int i10;
        SolverVariable solverVariable12;
        SolverVariable solverVariable13;
        SolverVariable solverVariable14;
        LinearSystem linearSystem2;
        ConstraintAnchor constraintAnchor;
        int i11;
        SolverVariable solverVariable15;
        LinearSystem linearSystem3;
        boolean z8;
        boolean z9;
        ConstraintWidget constraintWidget3 = this;
        SolverVariable createObjectVariable = (i == Integer.MAX_VALUE || constraintWidget3.mLeft.mGroup == i) ? linearSystem.createObjectVariable(constraintWidget3.mLeft) : null;
        SolverVariable createObjectVariable2 = (i == Integer.MAX_VALUE || constraintWidget3.mRight.mGroup == i) ? linearSystem.createObjectVariable(constraintWidget3.mRight) : null;
        SolverVariable createObjectVariable3 = (i == Integer.MAX_VALUE || constraintWidget3.mTop.mGroup == i) ? linearSystem.createObjectVariable(constraintWidget3.mTop) : null;
        SolverVariable createObjectVariable4 = (i == Integer.MAX_VALUE || constraintWidget3.mBottom.mGroup == i) ? linearSystem.createObjectVariable(constraintWidget3.mBottom) : null;
        SolverVariable createObjectVariable5 = (i == Integer.MAX_VALUE || constraintWidget3.mBaseline.mGroup == i) ? linearSystem.createObjectVariable(constraintWidget3.mBaseline) : null;
        if (constraintWidget3.mParent != null) {
            if ((constraintWidget3.mLeft.mTarget == null || constraintWidget3.mLeft.mTarget.mTarget != constraintWidget3.mLeft) && (constraintWidget3.mRight.mTarget == null || constraintWidget3.mRight.mTarget.mTarget != constraintWidget3.mRight)) {
                z8 = false;
            } else {
                ((ConstraintWidgetContainer) constraintWidget3.mParent).addChain(constraintWidget3, 0);
                z8 = true;
            }
            if ((constraintWidget3.mTop.mTarget == null || constraintWidget3.mTop.mTarget.mTarget != constraintWidget3.mTop) && (constraintWidget3.mBottom.mTarget == null || constraintWidget3.mBottom.mTarget.mTarget != constraintWidget3.mBottom)) {
                z9 = false;
            } else {
                ((ConstraintWidgetContainer) constraintWidget3.mParent).addChain(constraintWidget3, 1);
                z9 = true;
            }
            if (constraintWidget3.mParent.getHorizontalDimensionBehaviour() == DimensionBehaviour.WRAP_CONTENT && !z8) {
                if (constraintWidget3.mLeft.mTarget == null || constraintWidget3.mLeft.mTarget.mOwner != constraintWidget3.mParent) {
                    SolverVariable createObjectVariable6 = linearSystem.createObjectVariable(constraintWidget3.mParent.mLeft);
                    ArrayRow createRow = linearSystem.createRow();
                    createRow.createRowGreaterThan(createObjectVariable, createObjectVariable6, linearSystem.createSlackVariable(), 0);
                    linearSystem.addConstraint(createRow);
                } else if (constraintWidget3.mLeft.mTarget != null && constraintWidget3.mLeft.mTarget.mOwner == constraintWidget3.mParent) {
                    constraintWidget3.mLeft.setConnectionType(ConstraintAnchor.ConnectionType.STRICT);
                }
                if (constraintWidget3.mRight.mTarget == null || constraintWidget3.mRight.mTarget.mOwner != constraintWidget3.mParent) {
                    SolverVariable createObjectVariable7 = linearSystem.createObjectVariable(constraintWidget3.mParent.mRight);
                    ArrayRow createRow2 = linearSystem.createRow();
                    createRow2.createRowGreaterThan(createObjectVariable7, createObjectVariable2, linearSystem.createSlackVariable(), 0);
                    linearSystem.addConstraint(createRow2);
                } else if (constraintWidget3.mRight.mTarget != null && constraintWidget3.mRight.mTarget.mOwner == constraintWidget3.mParent) {
                    constraintWidget3.mRight.setConnectionType(ConstraintAnchor.ConnectionType.STRICT);
                }
            }
            if (constraintWidget3.mParent.getVerticalDimensionBehaviour() == DimensionBehaviour.WRAP_CONTENT && !z9) {
                if (constraintWidget3.mTop.mTarget == null || constraintWidget3.mTop.mTarget.mOwner != constraintWidget3.mParent) {
                    SolverVariable createObjectVariable8 = linearSystem.createObjectVariable(constraintWidget3.mParent.mTop);
                    ArrayRow createRow3 = linearSystem.createRow();
                    createRow3.createRowGreaterThan(createObjectVariable3, createObjectVariable8, linearSystem.createSlackVariable(), 0);
                    linearSystem.addConstraint(createRow3);
                } else if (constraintWidget3.mTop.mTarget != null && constraintWidget3.mTop.mTarget.mOwner == constraintWidget3.mParent) {
                    constraintWidget3.mTop.setConnectionType(ConstraintAnchor.ConnectionType.STRICT);
                }
                if (constraintWidget3.mBottom.mTarget == null || constraintWidget3.mBottom.mTarget.mOwner != constraintWidget3.mParent) {
                    SolverVariable createObjectVariable9 = linearSystem.createObjectVariable(constraintWidget3.mParent.mBottom);
                    ArrayRow createRow4 = linearSystem.createRow();
                    createRow4.createRowGreaterThan(createObjectVariable9, createObjectVariable4, linearSystem.createSlackVariable(), 0);
                    linearSystem.addConstraint(createRow4);
                } else if (constraintWidget3.mBottom.mTarget != null && constraintWidget3.mBottom.mTarget.mOwner == constraintWidget3.mParent) {
                    constraintWidget3.mBottom.setConnectionType(ConstraintAnchor.ConnectionType.STRICT);
                }
            }
            z = z8;
            z2 = z9;
        } else {
            z = false;
            z2 = false;
        }
        int i12 = constraintWidget3.mWidth;
        if (i12 < constraintWidget3.mMinWidth) {
            i12 = constraintWidget3.mMinWidth;
        }
        int i13 = constraintWidget3.mHeight;
        if (i13 < constraintWidget3.mMinHeight) {
            i13 = constraintWidget3.mMinHeight;
        }
        boolean z10 = constraintWidget3.mHorizontalDimensionBehaviour != DimensionBehaviour.MATCH_CONSTRAINT;
        boolean z11 = constraintWidget3.mVerticalDimensionBehaviour != DimensionBehaviour.MATCH_CONSTRAINT;
        if (!z10 && constraintWidget3.mLeft != null && constraintWidget3.mRight != null && (constraintWidget3.mLeft.mTarget == null || constraintWidget3.mRight.mTarget == null)) {
            z10 = true;
        }
        if (!z11 && constraintWidget3.mTop != null && constraintWidget3.mBottom != null && ((constraintWidget3.mTop.mTarget == null || constraintWidget3.mBottom.mTarget == null) && (constraintWidget3.mBaselineDistance == 0 || (constraintWidget3.mBaseline != null && (constraintWidget3.mTop.mTarget == null || constraintWidget3.mBaseline.mTarget == null))))) {
            z11 = true;
        }
        int i14 = constraintWidget3.mDimensionRatioSide;
        float f2 = constraintWidget3.mDimensionRatio;
        SolverVariable solverVariable16 = createObjectVariable4;
        if (constraintWidget3.mDimensionRatio > 0.0f && constraintWidget3.mVisibility != 8) {
            if (constraintWidget3.mHorizontalDimensionBehaviour != DimensionBehaviour.MATCH_CONSTRAINT || constraintWidget3.mVerticalDimensionBehaviour != DimensionBehaviour.MATCH_CONSTRAINT) {
                if (constraintWidget3.mHorizontalDimensionBehaviour == DimensionBehaviour.MATCH_CONSTRAINT) {
                    i2 = (int) (constraintWidget3.mHeight * f2);
                    i3 = i13;
                    z3 = z11;
                    f = f2;
                    z5 = true;
                    i4 = 0;
                    z4 = false;
                } else if (constraintWidget3.mVerticalDimensionBehaviour == DimensionBehaviour.MATCH_CONSTRAINT) {
                    if (constraintWidget3.mDimensionRatioSide == -1) {
                        f2 = 1.0f / f2;
                    }
                    i2 = i12;
                    i3 = (int) (constraintWidget3.mWidth * f2);
                    z5 = z10;
                    f = f2;
                    i4 = 1;
                    z4 = false;
                    z3 = true;
                }
                boolean z12 = !z4 && (i4 == 0 || i4 == -1);
                boolean z13 = constraintWidget3.mHorizontalDimensionBehaviour != DimensionBehaviour.WRAP_CONTENT && (constraintWidget3 instanceof ConstraintWidgetContainer);
                if (constraintWidget3.mHorizontalResolution != 2) {
                    if (i != Integer.MAX_VALUE && (constraintWidget3.mLeft.mGroup != i || constraintWidget3.mRight.mGroup != i)) {
                        i5 = i3;
                        solverVariable = createObjectVariable5;
                        solverVariable2 = createObjectVariable3;
                        solverVariable3 = createObjectVariable2;
                        solverVariable4 = createObjectVariable;
                        i6 = i4;
                        solverVariable5 = solverVariable16;
                        z6 = false;
                    } else if (z12 && constraintWidget3.mLeft.mTarget != null && constraintWidget3.mRight.mTarget != null) {
                        SolverVariable createObjectVariable10 = linearSystem.createObjectVariable(constraintWidget3.mLeft);
                        SolverVariable createObjectVariable11 = linearSystem.createObjectVariable(constraintWidget3.mRight);
                        SolverVariable createObjectVariable12 = linearSystem.createObjectVariable(constraintWidget3.mLeft.getTarget());
                        SolverVariable createObjectVariable13 = linearSystem.createObjectVariable(constraintWidget3.mRight.getTarget());
                        linearSystem.addGreaterThan(createObjectVariable10, createObjectVariable12, constraintWidget3.mLeft.getMargin(), 3);
                        linearSystem.addLowerThan(createObjectVariable11, createObjectVariable13, constraintWidget3.mRight.getMargin() * (-1), 3);
                        if (z) {
                            i5 = i3;
                            solverVariable = createObjectVariable5;
                            solverVariable5 = solverVariable16;
                            z6 = false;
                        } else {
                            i5 = i3;
                            z6 = false;
                            solverVariable = createObjectVariable5;
                            solverVariable5 = solverVariable16;
                            linearSystem.addCentering(createObjectVariable10, createObjectVariable12, constraintWidget3.mLeft.getMargin(), constraintWidget3.mHorizontalBiasPercent, createObjectVariable13, createObjectVariable11, constraintWidget3.mRight.getMargin(), 4);
                        }
                        solverVariable2 = createObjectVariable3;
                        solverVariable3 = createObjectVariable2;
                        solverVariable4 = createObjectVariable;
                        i6 = i4;
                    } else {
                        i5 = i3;
                        solverVariable = createObjectVariable5;
                        solverVariable5 = solverVariable16;
                        z6 = false;
                        solverVariable2 = createObjectVariable3;
                        solverVariable3 = createObjectVariable2;
                        solverVariable4 = createObjectVariable;
                        i6 = i4;
                        applyConstraints(linearSystem, z13, z5, constraintWidget3.mLeft, constraintWidget3.mRight, constraintWidget3.mX, constraintWidget3.mX + i2, i2, constraintWidget3.mMinWidth, constraintWidget3.mHorizontalBiasPercent, z12, z, constraintWidget3.mMatchConstraintDefaultWidth, constraintWidget3.mMatchConstraintMinWidth, constraintWidget3.mMatchConstraintMaxWidth);
                    }
                    if (constraintWidget3.mVerticalResolution != 2) {
                        return;
                    }
                    boolean z14 = (constraintWidget3.mVerticalDimensionBehaviour == DimensionBehaviour.WRAP_CONTENT && (constraintWidget3 instanceof ConstraintWidgetContainer)) ? true : z6;
                    if (z4) {
                        i7 = i6;
                        if (i7 != 1) {
                            i8 = -1;
                        } else {
                            i8 = -1;
                        }
                        z7 = true;
                        if (constraintWidget3.mBaselineDistance <= 0) {
                            ConstraintAnchor constraintAnchor2 = constraintWidget3.mBottom;
                            if (i == Integer.MAX_VALUE || (constraintWidget3.mBottom.mGroup == i && constraintWidget3.mBaseline.mGroup == i)) {
                                solverVariable14 = solverVariable2;
                                linearSystem2 = linearSystem;
                                linearSystem2.addEquality(solverVariable, solverVariable14, getBaselineDistance(), 5);
                            } else {
                                solverVariable14 = solverVariable2;
                                linearSystem2 = linearSystem;
                            }
                            if (constraintWidget3.mBaseline.mTarget != null) {
                                i11 = constraintWidget3.mBaselineDistance;
                                constraintAnchor = constraintWidget3.mBaseline;
                            } else {
                                constraintAnchor = constraintAnchor2;
                                i11 = i5;
                            }
                            if (i != Integer.MAX_VALUE && (constraintWidget3.mTop.mGroup != i || constraintAnchor.mGroup != i)) {
                                i9 = i7;
                                solverVariable6 = solverVariable5;
                                solverVariable7 = solverVariable14;
                            } else if (z7 && constraintWidget3.mTop.mTarget != null && constraintWidget3.mBottom.mTarget != null) {
                                SolverVariable createObjectVariable14 = linearSystem2.createObjectVariable(constraintWidget3.mTop);
                                SolverVariable createObjectVariable15 = linearSystem2.createObjectVariable(constraintWidget3.mBottom);
                                SolverVariable createObjectVariable16 = linearSystem2.createObjectVariable(constraintWidget3.mTop.getTarget());
                                SolverVariable createObjectVariable17 = linearSystem2.createObjectVariable(constraintWidget3.mBottom.getTarget());
                                linearSystem2.addGreaterThan(createObjectVariable14, createObjectVariable16, constraintWidget3.mTop.getMargin(), 3);
                                linearSystem2.addLowerThan(createObjectVariable15, createObjectVariable17, constraintWidget3.mBottom.getMargin() * i8, 3);
                                if (z2) {
                                    solverVariable15 = solverVariable14;
                                    linearSystem3 = linearSystem2;
                                } else {
                                    solverVariable15 = solverVariable14;
                                    linearSystem3 = linearSystem2;
                                    linearSystem.addCentering(createObjectVariable14, createObjectVariable16, constraintWidget3.mTop.getMargin(), constraintWidget3.mVerticalBiasPercent, createObjectVariable17, createObjectVariable15, constraintWidget3.mBottom.getMargin(), 4);
                                }
                                i9 = i7;
                                solverVariable6 = solverVariable5;
                                solverVariable7 = solverVariable15;
                            } else {
                                i9 = i7;
                                applyConstraints(linearSystem, z14, z3, constraintWidget3.mTop, constraintAnchor, constraintWidget3.mY, constraintWidget3.mY + i11, i11, constraintWidget3.mMinHeight, constraintWidget3.mVerticalBiasPercent, z7, z2, constraintWidget3.mMatchConstraintDefaultHeight, constraintWidget3.mMatchConstraintMinHeight, constraintWidget3.mMatchConstraintMaxHeight);
                                solverVariable6 = solverVariable5;
                                solverVariable7 = solverVariable14;
                                linearSystem.addEquality(solverVariable6, solverVariable7, i5, 5);
                            }
                        } else {
                            i9 = i7;
                            int i15 = i5;
                            solverVariable6 = solverVariable5;
                            solverVariable7 = solverVariable2;
                            if (i != Integer.MAX_VALUE) {
                                constraintWidget = this;
                                if (constraintWidget.mTop.mGroup == i) {
                                }
                            } else {
                                constraintWidget = this;
                            }
                            if (z7 && constraintWidget.mTop.mTarget != null && constraintWidget.mBottom.mTarget != null) {
                                SolverVariable createObjectVariable18 = linearSystem.createObjectVariable(constraintWidget.mTop);
                                SolverVariable createObjectVariable19 = linearSystem.createObjectVariable(constraintWidget.mBottom);
                                SolverVariable createObjectVariable20 = linearSystem.createObjectVariable(constraintWidget.mTop.getTarget());
                                SolverVariable createObjectVariable21 = linearSystem.createObjectVariable(constraintWidget.mBottom.getTarget());
                                linearSystem.addGreaterThan(createObjectVariable18, createObjectVariable20, constraintWidget.mTop.getMargin(), 3);
                                linearSystem.addLowerThan(createObjectVariable19, createObjectVariable21, constraintWidget.mBottom.getMargin() * i8, 3);
                                if (!z2) {
                                    linearSystem.addCentering(createObjectVariable18, createObjectVariable20, constraintWidget.mTop.getMargin(), constraintWidget.mVerticalBiasPercent, createObjectVariable21, createObjectVariable19, constraintWidget.mBottom.getMargin(), 4);
                                }
                            } else {
                                solverVariable8 = solverVariable6;
                                solverVariable9 = solverVariable7;
                                applyConstraints(linearSystem, z14, z3, constraintWidget.mTop, constraintWidget.mBottom, constraintWidget.mY, constraintWidget.mY + i15, i15, constraintWidget.mMinHeight, constraintWidget.mVerticalBiasPercent, z7, z2, constraintWidget.mMatchConstraintDefaultHeight, constraintWidget.mMatchConstraintMinHeight, constraintWidget.mMatchConstraintMaxHeight);
                                if (z4) {
                                    ArrayRow createRow5 = linearSystem.createRow();
                                    if (i != Integer.MAX_VALUE) {
                                        constraintWidget2 = this;
                                        if (constraintWidget2.mLeft.mGroup != i || constraintWidget2.mRight.mGroup != i) {
                                            return;
                                        }
                                    } else {
                                        constraintWidget2 = this;
                                    }
                                    int i16 = i9;
                                    if (i16 == 0) {
                                        linearSystem.addConstraint(createRow5.createRowDimensionRatio(solverVariable3, solverVariable4, solverVariable8, solverVariable9, f));
                                        return;
                                    }
                                    if (i16 == 1) {
                                        linearSystem.addConstraint(createRow5.createRowDimensionRatio(solverVariable8, solverVariable9, solverVariable3, solverVariable4, f));
                                        return;
                                    }
                                    if (constraintWidget2.mMatchConstraintMinWidth > 0) {
                                        solverVariable10 = solverVariable3;
                                        solverVariable11 = solverVariable4;
                                        i10 = 3;
                                        linearSystem.addGreaterThan(solverVariable10, solverVariable11, constraintWidget2.mMatchConstraintMinWidth, 3);
                                    } else {
                                        solverVariable10 = solverVariable3;
                                        solverVariable11 = solverVariable4;
                                        i10 = 3;
                                    }
                                    if (constraintWidget2.mMatchConstraintMinHeight > 0) {
                                        solverVariable12 = solverVariable8;
                                        solverVariable13 = solverVariable9;
                                        linearSystem.addGreaterThan(solverVariable12, solverVariable13, constraintWidget2.mMatchConstraintMinHeight, i10);
                                    } else {
                                        solverVariable12 = solverVariable8;
                                        solverVariable13 = solverVariable9;
                                    }
                                    createRow5.createRowDimensionRatio(solverVariable10, solverVariable11, solverVariable12, solverVariable13, f);
                                    SolverVariable createErrorVariable = linearSystem.createErrorVariable();
                                    SolverVariable createErrorVariable2 = linearSystem.createErrorVariable();
                                    createErrorVariable.strength = 4;
                                    createErrorVariable2.strength = 4;
                                    createRow5.addError(createErrorVariable, createErrorVariable2);
                                    linearSystem.addConstraint(createRow5);
                                    return;
                                }
                                return;
                            }
                        }
                        solverVariable8 = solverVariable6;
                        solverVariable9 = solverVariable7;
                        if (z4) {
                        }
                    } else {
                        i7 = i6;
                        i8 = -1;
                    }
                    z7 = z6;
                    if (constraintWidget3.mBaselineDistance <= 0) {
                    }
                    solverVariable8 = solverVariable6;
                    solverVariable9 = solverVariable7;
                    if (z4) {
                    }
                } else {
                    i5 = i3;
                    solverVariable = createObjectVariable5;
                    solverVariable2 = createObjectVariable3;
                    solverVariable3 = createObjectVariable2;
                    solverVariable4 = createObjectVariable;
                    i6 = i4;
                    solverVariable5 = solverVariable16;
                    z6 = false;
                }
                constraintWidget3 = this;
                if (constraintWidget3.mVerticalResolution != 2) {
                }
            } else {
                if (z10 && !z11) {
                    i2 = i12;
                    i3 = i13;
                    z3 = z11;
                    f = f2;
                    i4 = 0;
                } else if (z10 || !z11) {
                    i2 = i12;
                    i3 = i13;
                    z3 = z11;
                    i4 = i14;
                    f = f2;
                } else {
                    if (constraintWidget3.mDimensionRatioSide == -1) {
                        i2 = i12;
                        i3 = i13;
                        z3 = z11;
                        f = 1.0f / f2;
                    } else {
                        i2 = i12;
                        i3 = i13;
                        z3 = z11;
                        f = f2;
                    }
                    i4 = 1;
                }
                z4 = true;
                z5 = z10;
                if (z4) {
                }
                if (constraintWidget3.mHorizontalDimensionBehaviour != DimensionBehaviour.WRAP_CONTENT) {
                }
                if (constraintWidget3.mHorizontalResolution != 2) {
                }
                constraintWidget3 = this;
                if (constraintWidget3.mVerticalResolution != 2) {
                }
            }
        }
        i2 = i12;
        i3 = i13;
        z3 = z11;
        i4 = i14;
        f = f2;
        z4 = false;
        z5 = z10;
        if (z4) {
        }
        if (constraintWidget3.mHorizontalDimensionBehaviour != DimensionBehaviour.WRAP_CONTENT) {
        }
        if (constraintWidget3.mHorizontalResolution != 2) {
        }
        constraintWidget3 = this;
        if (constraintWidget3.mVerticalResolution != 2) {
        }
    }

    private void applyConstraints(LinearSystem linearSystem, boolean z, boolean z2, ConstraintAnchor constraintAnchor, ConstraintAnchor constraintAnchor2, int i, int i2, int i3, int i4, float f, boolean z3, boolean z4, int i5, int i6, int i7) {
        boolean z5;
        int i8;
        int i9 = i6;
        SolverVariable createObjectVariable = linearSystem.createObjectVariable(constraintAnchor);
        SolverVariable createObjectVariable2 = linearSystem.createObjectVariable(constraintAnchor2);
        SolverVariable createObjectVariable3 = linearSystem.createObjectVariable(constraintAnchor.getTarget());
        SolverVariable createObjectVariable4 = linearSystem.createObjectVariable(constraintAnchor2.getTarget());
        int margin = constraintAnchor.getMargin();
        int margin2 = constraintAnchor2.getMargin();
        if (this.mVisibility == 8) {
            z5 = true;
            i8 = 0;
        } else {
            z5 = z2;
            i8 = i3;
        }
        if (createObjectVariable3 == null && createObjectVariable4 == null) {
            linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable, i));
            if (z3) {
                return;
            }
            if (z) {
                linearSystem.addConstraint(LinearSystem.createRowEquals(linearSystem, createObjectVariable2, createObjectVariable, i4, true));
                return;
            } else if (z5) {
                linearSystem.addConstraint(LinearSystem.createRowEquals(linearSystem, createObjectVariable2, createObjectVariable, i8, false));
                return;
            } else {
                linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, i2));
                return;
            }
        }
        if (createObjectVariable3 != null && createObjectVariable4 == null) {
            linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable, createObjectVariable3, margin));
            if (z) {
                linearSystem.addConstraint(LinearSystem.createRowEquals(linearSystem, createObjectVariable2, createObjectVariable, i4, true));
                return;
            } else {
                if (z3) {
                    return;
                }
                if (z5) {
                    linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, createObjectVariable, i8));
                    return;
                } else {
                    linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, i2));
                    return;
                }
            }
        }
        if (createObjectVariable3 == null && createObjectVariable4 != null) {
            linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, createObjectVariable4, margin2 * (-1)));
            if (z) {
                linearSystem.addConstraint(LinearSystem.createRowEquals(linearSystem, createObjectVariable2, createObjectVariable, i4, true));
                return;
            } else {
                if (z3) {
                    return;
                }
                if (z5) {
                    linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, createObjectVariable, i8));
                    return;
                } else {
                    linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable, i));
                    return;
                }
            }
        }
        if (z5) {
            if (z) {
                linearSystem.addConstraint(LinearSystem.createRowEquals(linearSystem, createObjectVariable2, createObjectVariable, i4, true));
            } else {
                linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, createObjectVariable, i8));
            }
            if (constraintAnchor.getStrength() == constraintAnchor2.getStrength()) {
                if (createObjectVariable3 == createObjectVariable4) {
                    linearSystem.addConstraint(LinearSystem.createRowCentering(linearSystem, createObjectVariable, createObjectVariable3, 0, 0.5f, createObjectVariable4, createObjectVariable2, 0, true));
                    return;
                } else {
                    if (z4) {
                        return;
                    }
                    linearSystem.addConstraint(LinearSystem.createRowGreaterThan(linearSystem, createObjectVariable, createObjectVariable3, margin, constraintAnchor.getConnectionType() != ConstraintAnchor.ConnectionType.STRICT));
                    linearSystem.addConstraint(LinearSystem.createRowLowerThan(linearSystem, createObjectVariable2, createObjectVariable4, margin2 * (-1), constraintAnchor2.getConnectionType() != ConstraintAnchor.ConnectionType.STRICT));
                    linearSystem.addConstraint(LinearSystem.createRowCentering(linearSystem, createObjectVariable, createObjectVariable3, margin, f, createObjectVariable4, createObjectVariable2, margin2, false));
                    return;
                }
            }
            if (constraintAnchor.getStrength() == ConstraintAnchor.Strength.STRONG) {
                linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable, createObjectVariable3, margin));
                SolverVariable createSlackVariable = linearSystem.createSlackVariable();
                ArrayRow createRow = linearSystem.createRow();
                createRow.createRowLowerThan(createObjectVariable2, createObjectVariable4, createSlackVariable, margin2 * (-1));
                linearSystem.addConstraint(createRow);
                return;
            }
            SolverVariable createSlackVariable2 = linearSystem.createSlackVariable();
            ArrayRow createRow2 = linearSystem.createRow();
            createRow2.createRowGreaterThan(createObjectVariable, createObjectVariable3, createSlackVariable2, margin);
            linearSystem.addConstraint(createRow2);
            linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, createObjectVariable4, margin2 * (-1)));
            return;
        }
        if (z3) {
            linearSystem.addGreaterThan(createObjectVariable, createObjectVariable3, margin, 3);
            linearSystem.addLowerThan(createObjectVariable2, createObjectVariable4, margin2 * (-1), 3);
            linearSystem.addConstraint(LinearSystem.createRowCentering(linearSystem, createObjectVariable, createObjectVariable3, margin, f, createObjectVariable4, createObjectVariable2, margin2, true));
            return;
        }
        if (z4) {
            return;
        }
        if (i5 != 1) {
            if (i9 == 0 && i7 == 0) {
                linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable, createObjectVariable3, margin));
                linearSystem.addConstraint(linearSystem.createRow().createRowEquals(createObjectVariable2, createObjectVariable4, margin2 * (-1)));
                return;
            }
            if (i7 > 0) {
                linearSystem.addLowerThan(createObjectVariable2, createObjectVariable, i7, 3);
            }
            linearSystem.addGreaterThan(createObjectVariable, createObjectVariable3, margin, 2);
            linearSystem.addLowerThan(createObjectVariable2, createObjectVariable4, -margin2, 2);
            linearSystem.addCentering(createObjectVariable, createObjectVariable3, margin, f, createObjectVariable4, createObjectVariable2, margin2, 4);
            return;
        }
        if (i9 <= i8) {
            i9 = i8;
        }
        int i10 = i7;
        if (i10 > 0) {
            if (i10 >= i9) {
                linearSystem.addLowerThan(createObjectVariable2, createObjectVariable, i10, 3);
            }
            linearSystem.addEquality(createObjectVariable2, createObjectVariable, i10, 3);
            linearSystem.addGreaterThan(createObjectVariable, createObjectVariable3, margin, 2);
            linearSystem.addLowerThan(createObjectVariable2, createObjectVariable4, -margin2, 2);
            linearSystem.addCentering(createObjectVariable, createObjectVariable3, margin, f, createObjectVariable4, createObjectVariable2, margin2, 4);
        }
        i10 = i9;
        linearSystem.addEquality(createObjectVariable2, createObjectVariable, i10, 3);
        linearSystem.addGreaterThan(createObjectVariable, createObjectVariable3, margin, 2);
        linearSystem.addLowerThan(createObjectVariable2, createObjectVariable4, -margin2, 2);
        linearSystem.addCentering(createObjectVariable, createObjectVariable3, margin, f, createObjectVariable4, createObjectVariable2, margin2, 4);
    }

    public void updateFromSolver(LinearSystem linearSystem, int i) {
        if (i == Integer.MAX_VALUE) {
            setFrame(linearSystem.getObjectVariableValue(this.mLeft), linearSystem.getObjectVariableValue(this.mTop), linearSystem.getObjectVariableValue(this.mRight), linearSystem.getObjectVariableValue(this.mBottom));
            return;
        }
        if (i == -2) {
            setFrame(this.mSolverLeft, this.mSolverTop, this.mSolverRight, this.mSolverBottom);
            return;
        }
        if (this.mLeft.mGroup == i) {
            this.mSolverLeft = linearSystem.getObjectVariableValue(this.mLeft);
        }
        if (this.mTop.mGroup == i) {
            this.mSolverTop = linearSystem.getObjectVariableValue(this.mTop);
        }
        if (this.mRight.mGroup == i) {
            this.mSolverRight = linearSystem.getObjectVariableValue(this.mRight);
        }
        if (this.mBottom.mGroup == i) {
            this.mSolverBottom = linearSystem.getObjectVariableValue(this.mBottom);
        }
    }

    public void updateFromSolver(LinearSystem linearSystem) {
        updateFromSolver(linearSystem, Integer.MAX_VALUE);
    }
}
