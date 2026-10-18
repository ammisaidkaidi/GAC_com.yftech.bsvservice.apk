package android.support.constraint.solver.widgets;

import android.support.constraint.solver.ArrayRow;
import android.support.constraint.solver.LinearSystem;
import android.support.constraint.solver.SolverVariable;
import android.support.constraint.solver.widgets.ConstraintAnchor;
import android.support.constraint.solver.widgets.ConstraintWidget;
import java.util.ArrayList;
import java.util.Arrays;

/* loaded from: /home/user/work/dex/classes.dex */
public class ConstraintWidgetContainer extends WidgetContainer {
    static boolean ALLOW_ROOT_GROUP = true;
    private static final int CHAIN_FIRST = 0;
    private static final int CHAIN_FIRST_VISIBLE = 2;
    private static final int CHAIN_LAST = 1;
    private static final int CHAIN_LAST_VISIBLE = 3;
    private static final boolean DEBUG = false;
    private static final boolean DEBUG_LAYOUT = false;
    private static final boolean DEBUG_OPTIMIZE = false;
    private static final int FLAG_CHAIN_DANGLING = 1;
    private static final int FLAG_CHAIN_OPTIMIZE = 0;
    private static final int FLAG_RECOMPUTE_BOUNDS = 2;
    private static final int MAX_ITERATIONS = 8;
    public static final int OPTIMIZATION_ALL = 2;
    public static final int OPTIMIZATION_BASIC = 4;
    public static final int OPTIMIZATION_CHAIN = 8;
    public static final int OPTIMIZATION_NONE = 1;
    private static final boolean USE_SNAPSHOT = true;
    private static final boolean USE_THREAD = false;
    private boolean[] flags;
    protected LinearSystem mBackgroundSystem;
    private ConstraintWidget[] mChainEnds;
    private boolean mHeightMeasuredTooSmall;
    private ConstraintWidget[] mHorizontalChainsArray;
    private int mHorizontalChainsSize;
    private ConstraintWidget[] mMatchConstraintsChainedWidgets;
    private int mOptimizationLevel;
    int mPaddingBottom;
    int mPaddingLeft;
    int mPaddingRight;
    int mPaddingTop;
    private Snapshot mSnapshot;
    protected LinearSystem mSystem;
    private ConstraintWidget[] mVerticalChainsArray;
    private int mVerticalChainsSize;
    private boolean mWidthMeasuredTooSmall;
    int mWrapHeight;
    int mWrapWidth;

    @Override // android.support.constraint.solver.widgets.ConstraintWidget
    public String getType() {
        return "ConstraintLayout";
    }

    public boolean handlesInternalConstraints() {
        return false;
    }

    public ConstraintWidgetContainer() {
        this.mSystem = new LinearSystem();
        this.mBackgroundSystem = null;
        this.mHorizontalChainsSize = 0;
        this.mVerticalChainsSize = 0;
        this.mMatchConstraintsChainedWidgets = new ConstraintWidget[4];
        this.mVerticalChainsArray = new ConstraintWidget[4];
        this.mHorizontalChainsArray = new ConstraintWidget[4];
        this.mOptimizationLevel = 2;
        this.flags = new boolean[3];
        this.mChainEnds = new ConstraintWidget[4];
        this.mWidthMeasuredTooSmall = false;
        this.mHeightMeasuredTooSmall = false;
    }

    public ConstraintWidgetContainer(int i, int i2, int i3, int i4) {
        super(i, i2, i3, i4);
        this.mSystem = new LinearSystem();
        this.mBackgroundSystem = null;
        this.mHorizontalChainsSize = 0;
        this.mVerticalChainsSize = 0;
        this.mMatchConstraintsChainedWidgets = new ConstraintWidget[4];
        this.mVerticalChainsArray = new ConstraintWidget[4];
        this.mHorizontalChainsArray = new ConstraintWidget[4];
        this.mOptimizationLevel = 2;
        this.flags = new boolean[3];
        this.mChainEnds = new ConstraintWidget[4];
        this.mWidthMeasuredTooSmall = false;
        this.mHeightMeasuredTooSmall = false;
    }

    public ConstraintWidgetContainer(int i, int i2) {
        super(i, i2);
        this.mSystem = new LinearSystem();
        this.mBackgroundSystem = null;
        this.mHorizontalChainsSize = 0;
        this.mVerticalChainsSize = 0;
        this.mMatchConstraintsChainedWidgets = new ConstraintWidget[4];
        this.mVerticalChainsArray = new ConstraintWidget[4];
        this.mHorizontalChainsArray = new ConstraintWidget[4];
        this.mOptimizationLevel = 2;
        this.flags = new boolean[3];
        this.mChainEnds = new ConstraintWidget[4];
        this.mWidthMeasuredTooSmall = false;
        this.mHeightMeasuredTooSmall = false;
    }

    public void setOptimizationLevel(int i) {
        this.mOptimizationLevel = i;
    }

    @Override // android.support.constraint.solver.widgets.WidgetContainer, android.support.constraint.solver.widgets.ConstraintWidget
    public void reset() {
        this.mSystem.reset();
        this.mPaddingLeft = 0;
        this.mPaddingRight = 0;
        this.mPaddingTop = 0;
        this.mPaddingBottom = 0;
        super.reset();
    }

    public boolean isWidthMeasuredTooSmall() {
        return this.mWidthMeasuredTooSmall;
    }

    public boolean isHeightMeasuredTooSmall() {
        return this.mHeightMeasuredTooSmall;
    }

    public static ConstraintWidgetContainer createContainer(ConstraintWidgetContainer constraintWidgetContainer, String str, ArrayList<ConstraintWidget> arrayList, int i) {
        Rectangle bounds = getBounds(arrayList);
        if (bounds.width == 0 || bounds.height == 0) {
            return null;
        }
        if (i > 0) {
            int min = Math.min(bounds.x, bounds.y);
            if (i > min) {
                i = min;
            }
            bounds.grow(i, i);
        }
        constraintWidgetContainer.setOrigin(bounds.x, bounds.y);
        constraintWidgetContainer.setDimension(bounds.width, bounds.height);
        constraintWidgetContainer.setDebugName(str);
        ConstraintWidget parent = arrayList.get(0).getParent();
        int size = arrayList.size();
        for (int i2 = 0; i2 < size; i2++) {
            ConstraintWidget constraintWidget = arrayList.get(i2);
            if (constraintWidget.getParent() == parent) {
                constraintWidgetContainer.add(constraintWidget);
                constraintWidget.setX(constraintWidget.getX() - bounds.x);
                constraintWidget.setY(constraintWidget.getY() - bounds.y);
            }
        }
        return constraintWidgetContainer;
    }

    public boolean addChildrenToSolver(LinearSystem linearSystem, int i) {
        boolean z;
        addToSolver(linearSystem, i);
        int size = this.mChildren.size();
        if (this.mOptimizationLevel == 2 || this.mOptimizationLevel == 4) {
            if (optimize(linearSystem)) {
                return false;
            }
            z = false;
        } else {
            z = true;
        }
        for (int i2 = 0; i2 < size; i2++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i2);
            if (constraintWidget instanceof ConstraintWidgetContainer) {
                ConstraintWidget.DimensionBehaviour dimensionBehaviour = constraintWidget.mHorizontalDimensionBehaviour;
                ConstraintWidget.DimensionBehaviour dimensionBehaviour2 = constraintWidget.mVerticalDimensionBehaviour;
                if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                    constraintWidget.setHorizontalDimensionBehaviour(ConstraintWidget.DimensionBehaviour.FIXED);
                }
                if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                    constraintWidget.setVerticalDimensionBehaviour(ConstraintWidget.DimensionBehaviour.FIXED);
                }
                constraintWidget.addToSolver(linearSystem, i);
                if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                    constraintWidget.setHorizontalDimensionBehaviour(dimensionBehaviour);
                }
                if (dimensionBehaviour2 == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                    constraintWidget.setVerticalDimensionBehaviour(dimensionBehaviour2);
                }
            } else {
                if (z) {
                    Optimizer.checkMatchParent(this, linearSystem, constraintWidget);
                }
                constraintWidget.addToSolver(linearSystem, i);
            }
        }
        if (this.mHorizontalChainsSize > 0) {
            applyHorizontalChain(linearSystem);
        }
        if (this.mVerticalChainsSize > 0) {
            applyVerticalChain(linearSystem);
        }
        return true;
    }

    private boolean optimize(LinearSystem linearSystem) {
        int size = this.mChildren.size();
        for (int i = 0; i < size; i++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i);
            constraintWidget.mHorizontalResolution = -1;
            constraintWidget.mVerticalResolution = -1;
            if (constraintWidget.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT || constraintWidget.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                constraintWidget.mHorizontalResolution = 1;
                constraintWidget.mVerticalResolution = 1;
            }
        }
        boolean z = false;
        int i2 = 0;
        int i3 = 0;
        while (!z) {
            int i4 = 0;
            int i5 = 0;
            for (int i6 = 0; i6 < size; i6++) {
                ConstraintWidget constraintWidget2 = this.mChildren.get(i6);
                if (constraintWidget2.mHorizontalResolution == -1) {
                    if (this.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                        constraintWidget2.mHorizontalResolution = 1;
                    } else {
                        Optimizer.checkHorizontalSimpleDependency(this, linearSystem, constraintWidget2);
                    }
                }
                if (constraintWidget2.mVerticalResolution == -1) {
                    if (this.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                        constraintWidget2.mVerticalResolution = 1;
                    } else {
                        Optimizer.checkVerticalSimpleDependency(this, linearSystem, constraintWidget2);
                    }
                }
                if (constraintWidget2.mVerticalResolution == -1) {
                    i4++;
                }
                if (constraintWidget2.mHorizontalResolution == -1) {
                    i5++;
                }
            }
            if ((i4 == 0 && i5 == 0) || (i2 == i4 && i3 == i5)) {
                z = true;
            }
            i2 = i4;
            i3 = i5;
        }
        int i7 = 0;
        int i8 = 0;
        for (int i9 = 0; i9 < size; i9++) {
            ConstraintWidget constraintWidget3 = this.mChildren.get(i9);
            if (constraintWidget3.mHorizontalResolution == 1 || constraintWidget3.mHorizontalResolution == -1) {
                i7++;
            }
            if (constraintWidget3.mVerticalResolution == 1 || constraintWidget3.mVerticalResolution == -1) {
                i8++;
            }
        }
        return i7 == 0 && i8 == 0;
    }

    /* JADX WARN: Removed duplicated region for block: B:146:0x04bc  */
    /* JADX WARN: Removed duplicated region for block: B:149:0x04be A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    private void applyHorizontalChain(LinearSystem linearSystem) {
        int i;
        LinearSystem linearSystem2;
        int i2;
        ConstraintWidget constraintWidget;
        boolean z;
        ConstraintWidget constraintWidget2;
        int i3;
        ConstraintWidget constraintWidget3;
        ConstraintWidget constraintWidget4;
        ConstraintWidget constraintWidget5;
        LinearSystem linearSystem3;
        int i4;
        int i5;
        int i6;
        ConstraintWidgetContainer constraintWidgetContainer = this;
        LinearSystem linearSystem4 = linearSystem;
        int i7 = 0;
        int i8 = 0;
        while (i8 < constraintWidgetContainer.mHorizontalChainsSize) {
            ConstraintWidget constraintWidget6 = constraintWidgetContainer.mHorizontalChainsArray[i8];
            int countMatchConstraintsChainedWidgets = countMatchConstraintsChainedWidgets(linearSystem, constraintWidgetContainer.mChainEnds, constraintWidgetContainer.mHorizontalChainsArray[i8], 0, constraintWidgetContainer.flags);
            ConstraintWidget constraintWidget7 = constraintWidgetContainer.mChainEnds[2];
            if (constraintWidget7 != null) {
                if (constraintWidgetContainer.flags[1]) {
                    int drawX = constraintWidget6.getDrawX();
                    while (constraintWidget7 != null) {
                        linearSystem4.addEquality(constraintWidget7.mLeft.mSolverVariable, drawX);
                        ConstraintWidget constraintWidget8 = constraintWidget7.mHorizontalNextWidget;
                        drawX += constraintWidget7.mLeft.getMargin() + constraintWidget7.getWidth() + constraintWidget7.mRight.getMargin();
                        constraintWidget7 = constraintWidget8;
                    }
                } else {
                    int i9 = constraintWidget6.mHorizontalChainStyle == 0 ? 1 : i7;
                    int i10 = constraintWidget6.mHorizontalChainStyle == 2 ? 1 : i7;
                    int i11 = constraintWidgetContainer.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT ? 1 : i7;
                    if ((constraintWidgetContainer.mOptimizationLevel != 2 && constraintWidgetContainer.mOptimizationLevel != 8) || !constraintWidgetContainer.flags[i7] || !constraintWidget6.mHorizontalChainFixedPosition || i10 != 0 || i11 != 0 || constraintWidget6.mHorizontalChainStyle != 0) {
                        char c = 3;
                        if (countMatchConstraintsChainedWidgets != 0 && i10 == 0) {
                            float f = 0.0f;
                            ConstraintWidget constraintWidget9 = null;
                            while (constraintWidget7 != null) {
                                if (constraintWidget7.mHorizontalDimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                    int margin = constraintWidget7.mLeft.getMargin();
                                    if (constraintWidget9 != null) {
                                        margin += constraintWidget9.mRight.getMargin();
                                    }
                                    linearSystem4.addGreaterThan(constraintWidget7.mLeft.mSolverVariable, constraintWidget7.mLeft.mTarget.mSolverVariable, margin, constraintWidget7.mLeft.mTarget.mOwner.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT ? 2 : 3);
                                    int margin2 = constraintWidget7.mRight.getMargin();
                                    if (constraintWidget7.mRight.mTarget.mOwner.mLeft.mTarget != null && constraintWidget7.mRight.mTarget.mOwner.mLeft.mTarget.mOwner == constraintWidget7) {
                                        margin2 += constraintWidget7.mRight.mTarget.mOwner.mLeft.getMargin();
                                    }
                                    linearSystem4.addLowerThan(constraintWidget7.mRight.mSolverVariable, constraintWidget7.mRight.mTarget.mSolverVariable, -margin2, constraintWidget7.mRight.mTarget.mOwner.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT ? 2 : 3);
                                } else {
                                    f += constraintWidget7.mHorizontalWeight;
                                    if (constraintWidget7.mRight.mTarget != null) {
                                        i6 = constraintWidget7.mRight.getMargin();
                                        if (constraintWidget7 != constraintWidgetContainer.mChainEnds[3]) {
                                            i6 += constraintWidget7.mRight.mTarget.mOwner.mLeft.getMargin();
                                        }
                                    } else {
                                        i6 = i7;
                                    }
                                    linearSystem4.addGreaterThan(constraintWidget7.mRight.mSolverVariable, constraintWidget7.mLeft.mSolverVariable, i7, 1);
                                    linearSystem4.addLowerThan(constraintWidget7.mRight.mSolverVariable, constraintWidget7.mRight.mTarget.mSolverVariable, -i6, 1);
                                }
                                constraintWidget9 = constraintWidget7;
                                constraintWidget7 = constraintWidget7.mHorizontalNextWidget;
                            }
                            if (countMatchConstraintsChainedWidgets != 1) {
                                int i12 = i7;
                                while (true) {
                                    int i13 = countMatchConstraintsChainedWidgets - 1;
                                    if (i12 >= i13) {
                                        break;
                                    }
                                    ConstraintWidget constraintWidget10 = constraintWidgetContainer.mMatchConstraintsChainedWidgets[i12];
                                    i12++;
                                    ConstraintWidget constraintWidget11 = constraintWidgetContainer.mMatchConstraintsChainedWidgets[i12];
                                    SolverVariable solverVariable = constraintWidget10.mLeft.mSolverVariable;
                                    SolverVariable solverVariable2 = constraintWidget10.mRight.mSolverVariable;
                                    SolverVariable solverVariable3 = constraintWidget11.mLeft.mSolverVariable;
                                    SolverVariable solverVariable4 = constraintWidget11.mRight.mSolverVariable;
                                    if (constraintWidget11 == constraintWidgetContainer.mChainEnds[c]) {
                                        solverVariable4 = constraintWidgetContainer.mChainEnds[1].mRight.mSolverVariable;
                                    }
                                    int margin3 = constraintWidget10.mLeft.getMargin();
                                    if (constraintWidget10.mLeft.mTarget != null && constraintWidget10.mLeft.mTarget.mOwner.mRight.mTarget != null && constraintWidget10.mLeft.mTarget.mOwner.mRight.mTarget.mOwner == constraintWidget10) {
                                        margin3 += constraintWidget10.mLeft.mTarget.mOwner.mRight.getMargin();
                                    }
                                    int i14 = countMatchConstraintsChainedWidgets;
                                    linearSystem4.addGreaterThan(solverVariable, constraintWidget10.mLeft.mTarget.mSolverVariable, margin3, 2);
                                    int margin4 = constraintWidget10.mRight.getMargin();
                                    if (constraintWidget10.mRight.mTarget != null && constraintWidget10.mHorizontalNextWidget != null) {
                                        margin4 += constraintWidget10.mHorizontalNextWidget.mLeft.mTarget != null ? constraintWidget10.mHorizontalNextWidget.mLeft.getMargin() : 0;
                                    }
                                    linearSystem4.addLowerThan(solverVariable2, constraintWidget10.mRight.mTarget.mSolverVariable, -margin4, 2);
                                    if (i12 == i13) {
                                        int margin5 = constraintWidget11.mLeft.getMargin();
                                        if (constraintWidget11.mLeft.mTarget != null && constraintWidget11.mLeft.mTarget.mOwner.mRight.mTarget != null && constraintWidget11.mLeft.mTarget.mOwner.mRight.mTarget.mOwner == constraintWidget11) {
                                            margin5 += constraintWidget11.mLeft.mTarget.mOwner.mRight.getMargin();
                                        }
                                        linearSystem4.addGreaterThan(solverVariable3, constraintWidget11.mLeft.mTarget.mSolverVariable, margin5, 2);
                                        ConstraintAnchor constraintAnchor = constraintWidget11.mRight;
                                        if (constraintWidget11 == constraintWidgetContainer.mChainEnds[3]) {
                                            constraintAnchor = constraintWidgetContainer.mChainEnds[1].mRight;
                                        }
                                        int margin6 = constraintAnchor.getMargin();
                                        if (constraintAnchor.mTarget != null && constraintAnchor.mTarget.mOwner.mLeft.mTarget != null && constraintAnchor.mTarget.mOwner.mLeft.mTarget.mOwner == constraintWidget11) {
                                            margin6 += constraintAnchor.mTarget.mOwner.mLeft.getMargin();
                                        }
                                        i5 = 2;
                                        linearSystem4.addLowerThan(solverVariable4, constraintAnchor.mTarget.mSolverVariable, -margin6, 2);
                                    } else {
                                        i5 = 2;
                                    }
                                    if (constraintWidget6.mMatchConstraintMaxWidth > 0) {
                                        linearSystem4.addLowerThan(solverVariable2, solverVariable, constraintWidget6.mMatchConstraintMaxWidth, i5);
                                    }
                                    ArrayRow createRow = linearSystem.createRow();
                                    createRow.createRowEqualDimension(constraintWidget10.mHorizontalWeight, f, constraintWidget11.mHorizontalWeight, solverVariable, constraintWidget10.mLeft.getMargin(), solverVariable2, constraintWidget10.mRight.getMargin(), solverVariable3, constraintWidget11.mLeft.getMargin(), solverVariable4, constraintWidget11.mRight.getMargin());
                                    linearSystem4.addConstraint(createRow);
                                    countMatchConstraintsChainedWidgets = i14;
                                    c = 3;
                                    i7 = 0;
                                }
                            } else {
                                ConstraintWidget constraintWidget12 = constraintWidgetContainer.mMatchConstraintsChainedWidgets[i7];
                                int margin7 = constraintWidget12.mLeft.getMargin();
                                if (constraintWidget12.mLeft.mTarget != null) {
                                    margin7 += constraintWidget12.mLeft.mTarget.getMargin();
                                }
                                int margin8 = constraintWidget12.mRight.getMargin();
                                if (constraintWidget12.mRight.mTarget != null) {
                                    margin8 += constraintWidget12.mRight.mTarget.getMargin();
                                }
                                SolverVariable solverVariable5 = constraintWidget6.mRight.mTarget.mSolverVariable;
                                if (constraintWidget12 == constraintWidgetContainer.mChainEnds[3]) {
                                    solverVariable5 = constraintWidgetContainer.mChainEnds[1].mRight.mTarget.mSolverVariable;
                                }
                                if (constraintWidget12.mMatchConstraintDefaultWidth == 1) {
                                    linearSystem4.addGreaterThan(constraintWidget6.mLeft.mSolverVariable, constraintWidget6.mLeft.mTarget.mSolverVariable, margin7, 1);
                                    linearSystem4.addLowerThan(constraintWidget6.mRight.mSolverVariable, solverVariable5, -margin8, 1);
                                    linearSystem4.addEquality(constraintWidget6.mRight.mSolverVariable, constraintWidget6.mLeft.mSolverVariable, constraintWidget6.getWidth(), 2);
                                } else {
                                    linearSystem4.addEquality(constraintWidget12.mLeft.mSolverVariable, constraintWidget12.mLeft.mTarget.mSolverVariable, margin7, 1);
                                    linearSystem4.addEquality(constraintWidget12.mRight.mSolverVariable, solverVariable5, -margin8, 1);
                                }
                            }
                        } else {
                            ConstraintWidget constraintWidget13 = constraintWidget7;
                            ConstraintWidget constraintWidget14 = null;
                            ConstraintWidget constraintWidget15 = null;
                            boolean z2 = false;
                            while (constraintWidget13 != null) {
                                ConstraintWidget constraintWidget16 = constraintWidget13.mHorizontalNextWidget;
                                if (constraintWidget16 == null) {
                                    constraintWidget = constraintWidgetContainer.mChainEnds[1];
                                    z = true;
                                } else {
                                    constraintWidget = constraintWidget14;
                                    z = z2;
                                }
                                if (i10 != 0) {
                                    ConstraintAnchor constraintAnchor2 = constraintWidget13.mLeft;
                                    int margin9 = constraintAnchor2.getMargin();
                                    if (constraintWidget15 != null) {
                                        margin9 += constraintWidget15.mRight.getMargin();
                                    }
                                    linearSystem4.addGreaterThan(constraintAnchor2.mSolverVariable, constraintAnchor2.mTarget.mSolverVariable, margin9, constraintWidget7 != constraintWidget13 ? 3 : 1);
                                    if (constraintWidget13.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                        ConstraintAnchor constraintAnchor3 = constraintWidget13.mRight;
                                        if (constraintWidget13.mMatchConstraintDefaultWidth == 1) {
                                            linearSystem4.addEquality(constraintAnchor3.mSolverVariable, constraintAnchor2.mSolverVariable, Math.max(constraintWidget13.mMatchConstraintMinWidth, constraintWidget13.getWidth()), 3);
                                        } else {
                                            linearSystem4.addGreaterThan(constraintAnchor2.mSolverVariable, constraintAnchor2.mTarget.mSolverVariable, constraintAnchor2.mMargin, 3);
                                            linearSystem4.addLowerThan(constraintAnchor3.mSolverVariable, constraintAnchor2.mSolverVariable, constraintWidget13.mMatchConstraintMinWidth, 3);
                                        }
                                    }
                                } else if (i9 == 0 && z && constraintWidget15 != null) {
                                    if (constraintWidget13.mRight.mTarget == null) {
                                        linearSystem4.addEquality(constraintWidget13.mRight.mSolverVariable, constraintWidget13.getDrawRight());
                                    } else {
                                        linearSystem4.addEquality(constraintWidget13.mRight.mSolverVariable, constraintWidget.mRight.mTarget.mSolverVariable, -constraintWidget13.mRight.getMargin(), 5);
                                    }
                                } else if (i9 == 0 && !z && constraintWidget15 == null) {
                                    if (constraintWidget13.mLeft.mTarget == null) {
                                        linearSystem4.addEquality(constraintWidget13.mLeft.mSolverVariable, constraintWidget13.getDrawX());
                                    } else {
                                        linearSystem4.addEquality(constraintWidget13.mLeft.mSolverVariable, constraintWidget6.mLeft.mTarget.mSolverVariable, constraintWidget13.mLeft.getMargin(), 5);
                                    }
                                } else {
                                    ConstraintAnchor constraintAnchor4 = constraintWidget13.mLeft;
                                    ConstraintAnchor constraintAnchor5 = constraintWidget13.mRight;
                                    int margin10 = constraintAnchor4.getMargin();
                                    int margin11 = constraintAnchor5.getMargin();
                                    constraintWidget2 = constraintWidget13;
                                    i3 = i9;
                                    linearSystem4.addGreaterThan(constraintAnchor4.mSolverVariable, constraintAnchor4.mTarget.mSolverVariable, margin10, 1);
                                    int i15 = i8;
                                    linearSystem4.addLowerThan(constraintAnchor5.mSolverVariable, constraintAnchor5.mTarget.mSolverVariable, -margin11, 1);
                                    SolverVariable solverVariable6 = constraintAnchor4.mTarget != null ? constraintAnchor4.mTarget.mSolverVariable : null;
                                    if (constraintWidget15 == null) {
                                        solverVariable6 = constraintWidget6.mLeft.mTarget != null ? constraintWidget6.mLeft.mTarget.mSolverVariable : null;
                                    }
                                    if (constraintWidget16 == null) {
                                        constraintWidget16 = constraintWidget.mRight.mTarget != null ? constraintWidget.mRight.mTarget.mOwner : null;
                                    }
                                    ConstraintWidget constraintWidget17 = constraintWidget16;
                                    if (constraintWidget17 != null) {
                                        SolverVariable solverVariable7 = constraintWidget17.mLeft.mSolverVariable;
                                        if (z) {
                                            solverVariable7 = constraintWidget.mRight.mTarget != null ? constraintWidget.mRight.mTarget.mSolverVariable : null;
                                        }
                                        if (solverVariable6 != null && solverVariable7 != null) {
                                            SolverVariable solverVariable8 = solverVariable6;
                                            constraintWidget4 = constraintWidget6;
                                            SolverVariable solverVariable9 = solverVariable7;
                                            i4 = i15;
                                            constraintWidget5 = constraintWidget;
                                            constraintWidget3 = constraintWidget17;
                                            linearSystem3 = linearSystem4;
                                            linearSystem.addCentering(constraintAnchor4.mSolverVariable, solverVariable8, margin10, 0.5f, solverVariable9, constraintAnchor5.mSolverVariable, margin11, 4);
                                            if (z) {
                                                constraintWidget3 = null;
                                            }
                                            constraintWidget6 = constraintWidget4;
                                            z2 = z;
                                            linearSystem4 = linearSystem3;
                                            i8 = i4;
                                            constraintWidget14 = constraintWidget5;
                                            constraintWidget15 = constraintWidget2;
                                            i9 = i3;
                                            constraintWidget13 = constraintWidget3;
                                            constraintWidgetContainer = this;
                                        }
                                    }
                                    constraintWidget3 = constraintWidget17;
                                    constraintWidget4 = constraintWidget6;
                                    constraintWidget5 = constraintWidget;
                                    linearSystem3 = linearSystem4;
                                    i4 = i15;
                                    if (z) {
                                    }
                                    constraintWidget6 = constraintWidget4;
                                    z2 = z;
                                    linearSystem4 = linearSystem3;
                                    i8 = i4;
                                    constraintWidget14 = constraintWidget5;
                                    constraintWidget15 = constraintWidget2;
                                    i9 = i3;
                                    constraintWidget13 = constraintWidget3;
                                    constraintWidgetContainer = this;
                                }
                                constraintWidget2 = constraintWidget13;
                                i3 = i9;
                                constraintWidget3 = constraintWidget16;
                                constraintWidget4 = constraintWidget6;
                                i4 = i8;
                                constraintWidget5 = constraintWidget;
                                linearSystem3 = linearSystem4;
                                if (z) {
                                }
                                constraintWidget6 = constraintWidget4;
                                z2 = z;
                                linearSystem4 = linearSystem3;
                                i8 = i4;
                                constraintWidget14 = constraintWidget5;
                                constraintWidget15 = constraintWidget2;
                                i9 = i3;
                                constraintWidget13 = constraintWidget3;
                                constraintWidgetContainer = this;
                            }
                            ConstraintWidget constraintWidget18 = constraintWidget6;
                            i = i8;
                            linearSystem2 = linearSystem4;
                            i2 = 0;
                            if (i10 != 0) {
                                ConstraintAnchor constraintAnchor6 = constraintWidget7.mLeft;
                                ConstraintAnchor constraintAnchor7 = constraintWidget14.mRight;
                                int margin12 = constraintAnchor6.getMargin();
                                int margin13 = constraintAnchor7.getMargin();
                                SolverVariable solverVariable10 = constraintWidget18.mLeft.mTarget != null ? constraintWidget18.mLeft.mTarget.mSolverVariable : null;
                                SolverVariable solverVariable11 = constraintWidget14.mRight.mTarget != null ? constraintWidget14.mRight.mTarget.mSolverVariable : null;
                                if (solverVariable10 != null && solverVariable11 != null) {
                                    linearSystem2.addLowerThan(constraintAnchor7.mSolverVariable, solverVariable11, -margin13, 1);
                                    linearSystem.addCentering(constraintAnchor6.mSolverVariable, solverVariable10, margin12, constraintWidget18.mHorizontalBiasPercent, solverVariable11, constraintAnchor7.mSolverVariable, margin13, 4);
                                }
                            }
                            i8 = i + 1;
                            linearSystem4 = linearSystem2;
                            i7 = i2;
                            constraintWidgetContainer = this;
                        }
                    } else {
                        Optimizer.applyDirectResolutionHorizontalChain(constraintWidgetContainer, linearSystem4, countMatchConstraintsChainedWidgets, constraintWidget6);
                    }
                }
            }
            i = i8;
            i2 = i7;
            linearSystem2 = linearSystem4;
            i8 = i + 1;
            linearSystem4 = linearSystem2;
            i7 = i2;
            constraintWidgetContainer = this;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:152:0x04df  */
    /* JADX WARN: Removed duplicated region for block: B:155:0x04e1 A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    private void applyVerticalChain(LinearSystem linearSystem) {
        int i;
        LinearSystem linearSystem2;
        int i2;
        ConstraintWidget constraintWidget;
        boolean z;
        ConstraintWidget constraintWidget2;
        int i3;
        ConstraintWidget constraintWidget3;
        ConstraintWidget constraintWidget4;
        ConstraintWidget constraintWidget5;
        LinearSystem linearSystem3;
        int i4;
        SolverVariable solverVariable;
        SolverVariable solverVariable2;
        int i5;
        int i6;
        ConstraintWidgetContainer constraintWidgetContainer = this;
        LinearSystem linearSystem4 = linearSystem;
        int i7 = 0;
        int i8 = 0;
        while (i8 < constraintWidgetContainer.mVerticalChainsSize) {
            ConstraintWidget constraintWidget6 = constraintWidgetContainer.mVerticalChainsArray[i8];
            int countMatchConstraintsChainedWidgets = countMatchConstraintsChainedWidgets(linearSystem, constraintWidgetContainer.mChainEnds, constraintWidgetContainer.mVerticalChainsArray[i8], 1, constraintWidgetContainer.flags);
            ConstraintWidget constraintWidget7 = constraintWidgetContainer.mChainEnds[2];
            if (constraintWidget7 != null) {
                if (constraintWidgetContainer.flags[1]) {
                    int drawY = constraintWidget6.getDrawY();
                    while (constraintWidget7 != null) {
                        linearSystem4.addEquality(constraintWidget7.mTop.mSolverVariable, drawY);
                        ConstraintWidget constraintWidget8 = constraintWidget7.mVerticalNextWidget;
                        drawY += constraintWidget7.mTop.getMargin() + constraintWidget7.getHeight() + constraintWidget7.mBottom.getMargin();
                        constraintWidget7 = constraintWidget8;
                    }
                } else {
                    int i9 = constraintWidget6.mVerticalChainStyle == 0 ? 1 : i7;
                    int i10 = constraintWidget6.mVerticalChainStyle == 2 ? 1 : i7;
                    int i11 = constraintWidgetContainer.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT ? 1 : i7;
                    if ((constraintWidgetContainer.mOptimizationLevel != 2 && constraintWidgetContainer.mOptimizationLevel != 8) || !constraintWidgetContainer.flags[i7] || !constraintWidget6.mVerticalChainFixedPosition || i10 != 0 || i11 != 0 || constraintWidget6.mVerticalChainStyle != 0) {
                        char c = 3;
                        if (countMatchConstraintsChainedWidgets != 0 && i10 == 0) {
                            float f = 0.0f;
                            ConstraintWidget constraintWidget9 = null;
                            while (constraintWidget7 != null) {
                                if (constraintWidget7.mVerticalDimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                    int margin = constraintWidget7.mTop.getMargin();
                                    if (constraintWidget9 != null) {
                                        margin += constraintWidget9.mBottom.getMargin();
                                    }
                                    linearSystem4.addGreaterThan(constraintWidget7.mTop.mSolverVariable, constraintWidget7.mTop.mTarget.mSolverVariable, margin, constraintWidget7.mTop.mTarget.mOwner.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT ? 2 : 3);
                                    int margin2 = constraintWidget7.mBottom.getMargin();
                                    if (constraintWidget7.mBottom.mTarget.mOwner.mTop.mTarget != null && constraintWidget7.mBottom.mTarget.mOwner.mTop.mTarget.mOwner == constraintWidget7) {
                                        margin2 += constraintWidget7.mBottom.mTarget.mOwner.mTop.getMargin();
                                    }
                                    linearSystem4.addLowerThan(constraintWidget7.mBottom.mSolverVariable, constraintWidget7.mBottom.mTarget.mSolverVariable, -margin2, constraintWidget7.mBottom.mTarget.mOwner.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT ? 2 : 3);
                                } else {
                                    f += constraintWidget7.mVerticalWeight;
                                    if (constraintWidget7.mBottom.mTarget != null) {
                                        i6 = constraintWidget7.mBottom.getMargin();
                                        if (constraintWidget7 != constraintWidgetContainer.mChainEnds[3]) {
                                            i6 += constraintWidget7.mBottom.mTarget.mOwner.mTop.getMargin();
                                        }
                                    } else {
                                        i6 = i7;
                                    }
                                    linearSystem4.addGreaterThan(constraintWidget7.mBottom.mSolverVariable, constraintWidget7.mTop.mSolverVariable, i7, 1);
                                    linearSystem4.addLowerThan(constraintWidget7.mBottom.mSolverVariable, constraintWidget7.mBottom.mTarget.mSolverVariable, -i6, 1);
                                }
                                constraintWidget9 = constraintWidget7;
                                constraintWidget7 = constraintWidget7.mVerticalNextWidget;
                            }
                            if (countMatchConstraintsChainedWidgets != 1) {
                                int i12 = i7;
                                while (true) {
                                    int i13 = countMatchConstraintsChainedWidgets - 1;
                                    if (i12 >= i13) {
                                        break;
                                    }
                                    ConstraintWidget constraintWidget10 = constraintWidgetContainer.mMatchConstraintsChainedWidgets[i12];
                                    i12++;
                                    ConstraintWidget constraintWidget11 = constraintWidgetContainer.mMatchConstraintsChainedWidgets[i12];
                                    SolverVariable solverVariable3 = constraintWidget10.mTop.mSolverVariable;
                                    SolverVariable solverVariable4 = constraintWidget10.mBottom.mSolverVariable;
                                    SolverVariable solverVariable5 = constraintWidget11.mTop.mSolverVariable;
                                    SolverVariable solverVariable6 = constraintWidget11.mBottom.mSolverVariable;
                                    if (constraintWidget11 == constraintWidgetContainer.mChainEnds[c]) {
                                        solverVariable6 = constraintWidgetContainer.mChainEnds[1].mBottom.mSolverVariable;
                                    }
                                    int margin3 = constraintWidget10.mTop.getMargin();
                                    if (constraintWidget10.mTop.mTarget != null && constraintWidget10.mTop.mTarget.mOwner.mBottom.mTarget != null && constraintWidget10.mTop.mTarget.mOwner.mBottom.mTarget.mOwner == constraintWidget10) {
                                        margin3 += constraintWidget10.mTop.mTarget.mOwner.mBottom.getMargin();
                                    }
                                    int i14 = countMatchConstraintsChainedWidgets;
                                    linearSystem4.addGreaterThan(solverVariable3, constraintWidget10.mTop.mTarget.mSolverVariable, margin3, 2);
                                    int margin4 = constraintWidget10.mBottom.getMargin();
                                    if (constraintWidget10.mBottom.mTarget != null && constraintWidget10.mVerticalNextWidget != null) {
                                        margin4 += constraintWidget10.mVerticalNextWidget.mTop.mTarget != null ? constraintWidget10.mVerticalNextWidget.mTop.getMargin() : 0;
                                    }
                                    linearSystem4.addLowerThan(solverVariable4, constraintWidget10.mBottom.mTarget.mSolverVariable, -margin4, 2);
                                    if (i12 == i13) {
                                        int margin5 = constraintWidget11.mTop.getMargin();
                                        if (constraintWidget11.mTop.mTarget != null && constraintWidget11.mTop.mTarget.mOwner.mBottom.mTarget != null && constraintWidget11.mTop.mTarget.mOwner.mBottom.mTarget.mOwner == constraintWidget11) {
                                            margin5 += constraintWidget11.mTop.mTarget.mOwner.mBottom.getMargin();
                                        }
                                        linearSystem4.addGreaterThan(solverVariable5, constraintWidget11.mTop.mTarget.mSolverVariable, margin5, 2);
                                        ConstraintAnchor constraintAnchor = constraintWidget11.mBottom;
                                        if (constraintWidget11 == constraintWidgetContainer.mChainEnds[3]) {
                                            constraintAnchor = constraintWidgetContainer.mChainEnds[1].mBottom;
                                        }
                                        int margin6 = constraintAnchor.getMargin();
                                        if (constraintAnchor.mTarget != null && constraintAnchor.mTarget.mOwner.mTop.mTarget != null && constraintAnchor.mTarget.mOwner.mTop.mTarget.mOwner == constraintWidget11) {
                                            margin6 += constraintAnchor.mTarget.mOwner.mTop.getMargin();
                                        }
                                        i5 = 2;
                                        linearSystem4.addLowerThan(solverVariable6, constraintAnchor.mTarget.mSolverVariable, -margin6, 2);
                                    } else {
                                        i5 = 2;
                                    }
                                    if (constraintWidget6.mMatchConstraintMaxHeight > 0) {
                                        linearSystem4.addLowerThan(solverVariable4, solverVariable3, constraintWidget6.mMatchConstraintMaxHeight, i5);
                                    }
                                    ArrayRow createRow = linearSystem.createRow();
                                    createRow.createRowEqualDimension(constraintWidget10.mVerticalWeight, f, constraintWidget11.mVerticalWeight, solverVariable3, constraintWidget10.mTop.getMargin(), solverVariable4, constraintWidget10.mBottom.getMargin(), solverVariable5, constraintWidget11.mTop.getMargin(), solverVariable6, constraintWidget11.mBottom.getMargin());
                                    linearSystem4.addConstraint(createRow);
                                    countMatchConstraintsChainedWidgets = i14;
                                    c = 3;
                                    i7 = 0;
                                }
                            } else {
                                ConstraintWidget constraintWidget12 = constraintWidgetContainer.mMatchConstraintsChainedWidgets[i7];
                                int margin7 = constraintWidget12.mTop.getMargin();
                                if (constraintWidget12.mTop.mTarget != null) {
                                    margin7 += constraintWidget12.mTop.mTarget.getMargin();
                                }
                                int margin8 = constraintWidget12.mBottom.getMargin();
                                if (constraintWidget12.mBottom.mTarget != null) {
                                    margin8 += constraintWidget12.mBottom.mTarget.getMargin();
                                }
                                SolverVariable solverVariable7 = constraintWidget6.mBottom.mTarget.mSolverVariable;
                                if (constraintWidget12 == constraintWidgetContainer.mChainEnds[3]) {
                                    solverVariable7 = constraintWidgetContainer.mChainEnds[1].mBottom.mTarget.mSolverVariable;
                                }
                                if (constraintWidget12.mMatchConstraintDefaultHeight == 1) {
                                    linearSystem4.addGreaterThan(constraintWidget6.mTop.mSolverVariable, constraintWidget6.mTop.mTarget.mSolverVariable, margin7, 1);
                                    linearSystem4.addLowerThan(constraintWidget6.mBottom.mSolverVariable, solverVariable7, -margin8, 1);
                                    linearSystem4.addEquality(constraintWidget6.mBottom.mSolverVariable, constraintWidget6.mTop.mSolverVariable, constraintWidget6.getHeight(), 2);
                                } else {
                                    linearSystem4.addEquality(constraintWidget12.mTop.mSolverVariable, constraintWidget12.mTop.mTarget.mSolverVariable, margin7, 1);
                                    linearSystem4.addEquality(constraintWidget12.mBottom.mSolverVariable, solverVariable7, -margin8, 1);
                                }
                            }
                        } else {
                            ConstraintWidget constraintWidget13 = constraintWidget7;
                            ConstraintWidget constraintWidget14 = null;
                            ConstraintWidget constraintWidget15 = null;
                            boolean z2 = false;
                            while (constraintWidget13 != null) {
                                ConstraintWidget constraintWidget16 = constraintWidget13.mVerticalNextWidget;
                                if (constraintWidget16 == null) {
                                    constraintWidget = constraintWidgetContainer.mChainEnds[1];
                                    z = true;
                                } else {
                                    constraintWidget = constraintWidget14;
                                    z = z2;
                                }
                                if (i10 != 0) {
                                    ConstraintAnchor constraintAnchor2 = constraintWidget13.mTop;
                                    int margin9 = constraintAnchor2.getMargin();
                                    if (constraintWidget15 != null) {
                                        margin9 += constraintWidget15.mBottom.getMargin();
                                    }
                                    int i15 = constraintWidget7 != constraintWidget13 ? 3 : 1;
                                    if (constraintAnchor2.mTarget != null) {
                                        solverVariable = constraintAnchor2.mSolverVariable;
                                        solverVariable2 = constraintAnchor2.mTarget.mSolverVariable;
                                    } else if (constraintWidget13.mBaseline.mTarget != null) {
                                        solverVariable = constraintWidget13.mBaseline.mSolverVariable;
                                        solverVariable2 = constraintWidget13.mBaseline.mTarget.mSolverVariable;
                                        margin9 -= constraintAnchor2.getMargin();
                                    } else {
                                        solverVariable = null;
                                        solverVariable2 = null;
                                    }
                                    if (solverVariable != null && solverVariable2 != null) {
                                        linearSystem4.addGreaterThan(solverVariable, solverVariable2, margin9, i15);
                                    }
                                    if (constraintWidget13.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                                        ConstraintAnchor constraintAnchor3 = constraintWidget13.mBottom;
                                        if (constraintWidget13.mMatchConstraintDefaultHeight == 1) {
                                            linearSystem4.addEquality(constraintAnchor3.mSolverVariable, constraintAnchor2.mSolverVariable, Math.max(constraintWidget13.mMatchConstraintMinHeight, constraintWidget13.getHeight()), 3);
                                        } else {
                                            linearSystem4.addGreaterThan(constraintAnchor2.mSolverVariable, constraintAnchor2.mTarget.mSolverVariable, constraintAnchor2.mMargin, 3);
                                            linearSystem4.addLowerThan(constraintAnchor3.mSolverVariable, constraintAnchor2.mSolverVariable, constraintWidget13.mMatchConstraintMinHeight, 3);
                                        }
                                    }
                                } else if (i9 == 0 && z && constraintWidget15 != null) {
                                    if (constraintWidget13.mBottom.mTarget == null) {
                                        linearSystem4.addEquality(constraintWidget13.mBottom.mSolverVariable, constraintWidget13.getDrawBottom());
                                    } else {
                                        linearSystem4.addEquality(constraintWidget13.mBottom.mSolverVariable, constraintWidget.mBottom.mTarget.mSolverVariable, -constraintWidget13.mBottom.getMargin(), 5);
                                    }
                                } else if (i9 == 0 && !z && constraintWidget15 == null) {
                                    if (constraintWidget13.mTop.mTarget == null) {
                                        linearSystem4.addEquality(constraintWidget13.mTop.mSolverVariable, constraintWidget13.getDrawY());
                                    } else {
                                        linearSystem4.addEquality(constraintWidget13.mTop.mSolverVariable, constraintWidget6.mTop.mTarget.mSolverVariable, constraintWidget13.mTop.getMargin(), 5);
                                    }
                                } else {
                                    ConstraintAnchor constraintAnchor4 = constraintWidget13.mTop;
                                    ConstraintAnchor constraintAnchor5 = constraintWidget13.mBottom;
                                    int margin10 = constraintAnchor4.getMargin();
                                    int margin11 = constraintAnchor5.getMargin();
                                    constraintWidget2 = constraintWidget13;
                                    i3 = i9;
                                    linearSystem4.addGreaterThan(constraintAnchor4.mSolverVariable, constraintAnchor4.mTarget.mSolverVariable, margin10, 1);
                                    int i16 = i8;
                                    linearSystem4.addLowerThan(constraintAnchor5.mSolverVariable, constraintAnchor5.mTarget.mSolverVariable, -margin11, 1);
                                    SolverVariable solverVariable8 = constraintAnchor4.mTarget != null ? constraintAnchor4.mTarget.mSolverVariable : null;
                                    if (constraintWidget15 == null) {
                                        solverVariable8 = constraintWidget6.mTop.mTarget != null ? constraintWidget6.mTop.mTarget.mSolverVariable : null;
                                    }
                                    if (constraintWidget16 == null) {
                                        constraintWidget16 = constraintWidget.mBottom.mTarget != null ? constraintWidget.mBottom.mTarget.mOwner : null;
                                    }
                                    ConstraintWidget constraintWidget17 = constraintWidget16;
                                    if (constraintWidget17 != null) {
                                        SolverVariable solverVariable9 = constraintWidget17.mTop.mSolverVariable;
                                        if (z) {
                                            solverVariable9 = constraintWidget.mBottom.mTarget != null ? constraintWidget.mBottom.mTarget.mSolverVariable : null;
                                        }
                                        if (solverVariable8 != null && solverVariable9 != null) {
                                            SolverVariable solverVariable10 = solverVariable8;
                                            constraintWidget4 = constraintWidget6;
                                            SolverVariable solverVariable11 = solverVariable9;
                                            i4 = i16;
                                            constraintWidget5 = constraintWidget;
                                            constraintWidget3 = constraintWidget17;
                                            linearSystem3 = linearSystem4;
                                            linearSystem.addCentering(constraintAnchor4.mSolverVariable, solverVariable10, margin10, 0.5f, solverVariable11, constraintAnchor5.mSolverVariable, margin11, 4);
                                            if (z) {
                                                constraintWidget3 = null;
                                            }
                                            constraintWidget6 = constraintWidget4;
                                            z2 = z;
                                            linearSystem4 = linearSystem3;
                                            i8 = i4;
                                            constraintWidget14 = constraintWidget5;
                                            constraintWidget15 = constraintWidget2;
                                            i9 = i3;
                                            constraintWidget13 = constraintWidget3;
                                            constraintWidgetContainer = this;
                                        }
                                    }
                                    constraintWidget3 = constraintWidget17;
                                    constraintWidget4 = constraintWidget6;
                                    constraintWidget5 = constraintWidget;
                                    linearSystem3 = linearSystem4;
                                    i4 = i16;
                                    if (z) {
                                    }
                                    constraintWidget6 = constraintWidget4;
                                    z2 = z;
                                    linearSystem4 = linearSystem3;
                                    i8 = i4;
                                    constraintWidget14 = constraintWidget5;
                                    constraintWidget15 = constraintWidget2;
                                    i9 = i3;
                                    constraintWidget13 = constraintWidget3;
                                    constraintWidgetContainer = this;
                                }
                                constraintWidget2 = constraintWidget13;
                                i3 = i9;
                                constraintWidget3 = constraintWidget16;
                                constraintWidget4 = constraintWidget6;
                                i4 = i8;
                                constraintWidget5 = constraintWidget;
                                linearSystem3 = linearSystem4;
                                if (z) {
                                }
                                constraintWidget6 = constraintWidget4;
                                z2 = z;
                                linearSystem4 = linearSystem3;
                                i8 = i4;
                                constraintWidget14 = constraintWidget5;
                                constraintWidget15 = constraintWidget2;
                                i9 = i3;
                                constraintWidget13 = constraintWidget3;
                                constraintWidgetContainer = this;
                            }
                            ConstraintWidget constraintWidget18 = constraintWidget6;
                            i = i8;
                            linearSystem2 = linearSystem4;
                            i2 = 0;
                            if (i10 != 0) {
                                ConstraintAnchor constraintAnchor6 = constraintWidget7.mTop;
                                ConstraintAnchor constraintAnchor7 = constraintWidget14.mBottom;
                                int margin12 = constraintAnchor6.getMargin();
                                int margin13 = constraintAnchor7.getMargin();
                                SolverVariable solverVariable12 = constraintWidget18.mTop.mTarget != null ? constraintWidget18.mTop.mTarget.mSolverVariable : null;
                                SolverVariable solverVariable13 = constraintWidget14.mBottom.mTarget != null ? constraintWidget14.mBottom.mTarget.mSolverVariable : null;
                                if (solverVariable12 != null && solverVariable13 != null) {
                                    linearSystem2.addLowerThan(constraintAnchor7.mSolverVariable, solverVariable13, -margin13, 1);
                                    linearSystem.addCentering(constraintAnchor6.mSolverVariable, solverVariable12, margin12, constraintWidget18.mVerticalBiasPercent, solverVariable13, constraintAnchor7.mSolverVariable, margin13, 4);
                                }
                            }
                            i8 = i + 1;
                            linearSystem4 = linearSystem2;
                            i7 = i2;
                            constraintWidgetContainer = this;
                        }
                    } else {
                        Optimizer.applyDirectResolutionVerticalChain(constraintWidgetContainer, linearSystem4, countMatchConstraintsChainedWidgets, constraintWidget6);
                    }
                }
            }
            i = i8;
            i2 = i7;
            linearSystem2 = linearSystem4;
            i8 = i + 1;
            linearSystem4 = linearSystem2;
            i7 = i2;
            constraintWidgetContainer = this;
        }
    }

    public void updateChildrenFromSolver(LinearSystem linearSystem, int i, boolean[] zArr) {
        zArr[2] = false;
        updateFromSolver(linearSystem, i);
        int size = this.mChildren.size();
        for (int i2 = 0; i2 < size; i2++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i2);
            constraintWidget.updateFromSolver(linearSystem, i);
            if (constraintWidget.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.getWidth() < constraintWidget.getWrapWidth()) {
                zArr[2] = true;
            }
            if (constraintWidget.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.getHeight() < constraintWidget.getWrapHeight()) {
                zArr[2] = true;
            }
        }
    }

    public void setPadding(int i, int i2, int i3, int i4) {
        this.mPaddingLeft = i;
        this.mPaddingTop = i2;
        this.mPaddingRight = i3;
        this.mPaddingBottom = i4;
    }

    /* JADX WARN: Removed duplicated region for block: B:54:0x0105  */
    /* JADX WARN: Removed duplicated region for block: B:75:0x01c3  */
    /* JADX WARN: Removed duplicated region for block: B:78:0x01dc  */
    /* JADX WARN: Removed duplicated region for block: B:80:0x01e7  */
    /* JADX WARN: Removed duplicated region for block: B:98:0x010d  */
    @Override // android.support.constraint.solver.widgets.WidgetContainer
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public void layout() {
        boolean z;
        boolean z2;
        boolean z3;
        int max;
        int max2;
        int i = this.mX;
        int i2 = this.mY;
        int i3 = 0;
        int max3 = Math.max(0, getWidth());
        int max4 = Math.max(0, getHeight());
        this.mWidthMeasuredTooSmall = false;
        this.mHeightMeasuredTooSmall = false;
        if (this.mParent != null) {
            if (this.mSnapshot == null) {
                this.mSnapshot = new Snapshot(this);
            }
            this.mSnapshot.updateFrom(this);
            setX(this.mPaddingLeft);
            setY(this.mPaddingTop);
            resetAnchors();
            resetSolverVariables(this.mSystem.getCache());
        } else {
            this.mX = 0;
            this.mY = 0;
        }
        ConstraintWidget.DimensionBehaviour dimensionBehaviour = this.mVerticalDimensionBehaviour;
        ConstraintWidget.DimensionBehaviour dimensionBehaviour2 = this.mHorizontalDimensionBehaviour;
        char c = 2;
        if (this.mOptimizationLevel == 2 && (this.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT || this.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT)) {
            findWrapSize(this.mChildren, this.flags);
            z = this.flags[0];
            if (max3 > 0 && max4 > 0 && (this.mWrapWidth > max3 || this.mWrapHeight > max4)) {
                z = false;
            }
            if (z) {
                if (this.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                    this.mHorizontalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.FIXED;
                    if (max3 > 0 && max3 < this.mWrapWidth) {
                        this.mWidthMeasuredTooSmall = true;
                        setWidth(max3);
                    } else {
                        setWidth(Math.max(this.mMinWidth, this.mWrapWidth));
                    }
                }
                if (this.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT) {
                    this.mVerticalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.FIXED;
                    if (max4 > 0 && max4 < this.mWrapHeight) {
                        this.mHeightMeasuredTooSmall = true;
                        setHeight(max4);
                    } else {
                        setHeight(Math.max(this.mMinHeight, this.mWrapHeight));
                    }
                }
            }
        } else {
            z = false;
        }
        resetChains();
        int size = this.mChildren.size();
        for (int i4 = 0; i4 < size; i4++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i4);
            if (constraintWidget instanceof WidgetContainer) {
                ((WidgetContainer) constraintWidget).layout();
            }
        }
        boolean z4 = z;
        int i5 = 0;
        boolean z5 = true;
        while (z5) {
            int i6 = i5 + 1;
            try {
                this.mSystem.reset();
                z2 = addChildrenToSolver(this.mSystem, Integer.MAX_VALUE);
                if (z2) {
                    try {
                        this.mSystem.minimize();
                    } catch (Exception e) {
                        e = e;
                        e.printStackTrace();
                        if (!z2) {
                        }
                        if (i6 < 8) {
                        }
                        z3 = false;
                        max = Math.max(this.mMinWidth, getWidth());
                        if (max > getWidth()) {
                        }
                        max2 = Math.max(this.mMinHeight, getHeight());
                        if (max2 > getHeight()) {
                        }
                        if (!z4) {
                        }
                        z5 = z3;
                        i5 = i6;
                        i3 = 0;
                        c = 2;
                    }
                }
            } catch (Exception e2) {
                e = e2;
                z2 = z5;
            }
            if (!z2) {
                updateChildrenFromSolver(this.mSystem, Integer.MAX_VALUE, this.flags);
            } else {
                updateFromSolver(this.mSystem, Integer.MAX_VALUE);
                int i7 = i3;
                while (true) {
                    if (i7 >= size) {
                        break;
                    }
                    ConstraintWidget constraintWidget2 = this.mChildren.get(i7);
                    if (constraintWidget2.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget2.getWidth() < constraintWidget2.getWrapWidth()) {
                        this.flags[c] = true;
                        break;
                    } else {
                        if (constraintWidget2.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget2.getHeight() < constraintWidget2.getWrapHeight()) {
                            this.flags[c] = true;
                            break;
                        }
                        i7++;
                    }
                }
            }
            if (i6 < 8 || !this.flags[c]) {
                z3 = false;
            } else {
                int i8 = 0;
                int i9 = 0;
                for (int i10 = 0; i10 < size; i10++) {
                    ConstraintWidget constraintWidget3 = this.mChildren.get(i10);
                    i8 = Math.max(i8, constraintWidget3.mX + constraintWidget3.getWidth());
                    i9 = Math.max(i9, constraintWidget3.mY + constraintWidget3.getHeight());
                }
                int max5 = Math.max(this.mMinWidth, i8);
                int max6 = Math.max(this.mMinHeight, i9);
                if (dimensionBehaviour2 != ConstraintWidget.DimensionBehaviour.WRAP_CONTENT || getWidth() >= max5) {
                    z3 = false;
                } else {
                    setWidth(max5);
                    this.mHorizontalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.WRAP_CONTENT;
                    z3 = true;
                    z4 = true;
                }
                if (dimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT && getHeight() < max6) {
                    setHeight(max6);
                    this.mVerticalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.WRAP_CONTENT;
                    z3 = true;
                    z4 = true;
                }
            }
            max = Math.max(this.mMinWidth, getWidth());
            if (max > getWidth()) {
                setWidth(max);
                this.mHorizontalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.FIXED;
                z3 = true;
                z4 = true;
            }
            max2 = Math.max(this.mMinHeight, getHeight());
            if (max2 > getHeight()) {
                setHeight(max2);
                this.mVerticalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.FIXED;
                z3 = true;
                z4 = true;
            }
            if (!z4) {
                if (this.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT && max3 > 0 && getWidth() > max3) {
                    this.mWidthMeasuredTooSmall = true;
                    this.mHorizontalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.FIXED;
                    setWidth(max3);
                    z3 = true;
                    z4 = true;
                }
                if (this.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.WRAP_CONTENT && max4 > 0 && getHeight() > max4) {
                    this.mHeightMeasuredTooSmall = true;
                    this.mVerticalDimensionBehaviour = ConstraintWidget.DimensionBehaviour.FIXED;
                    setHeight(max4);
                    z5 = true;
                    z4 = true;
                    i5 = i6;
                    i3 = 0;
                    c = 2;
                }
            }
            z5 = z3;
            i5 = i6;
            i3 = 0;
            c = 2;
        }
        if (this.mParent != null) {
            int max7 = Math.max(this.mMinWidth, getWidth());
            int max8 = Math.max(this.mMinHeight, getHeight());
            this.mSnapshot.applyTo(this);
            setWidth(max7 + this.mPaddingLeft + this.mPaddingRight);
            setHeight(max8 + this.mPaddingTop + this.mPaddingBottom);
        } else {
            this.mX = i;
            this.mY = i2;
        }
        if (z4) {
            this.mHorizontalDimensionBehaviour = dimensionBehaviour2;
            this.mVerticalDimensionBehaviour = dimensionBehaviour;
        }
        resetSolverVariables(this.mSystem.getCache());
        if (this == getRootConstraintContainer()) {
            updateDrawPosition();
        }
    }

    static int setGroup(ConstraintAnchor constraintAnchor, int i) {
        int i2 = constraintAnchor.mGroup;
        if (constraintAnchor.mOwner.getParent() == null) {
            return i;
        }
        if (i2 <= i) {
            return i2;
        }
        constraintAnchor.mGroup = i;
        ConstraintAnchor opposite = constraintAnchor.getOpposite();
        ConstraintAnchor constraintAnchor2 = constraintAnchor.mTarget;
        if (opposite != null) {
            i = setGroup(opposite, i);
        }
        if (constraintAnchor2 != null) {
            i = setGroup(constraintAnchor2, i);
        }
        if (opposite != null) {
            i = setGroup(opposite, i);
        }
        constraintAnchor.mGroup = i;
        return i;
    }

    public int layoutFindGroupsSimple() {
        int size = this.mChildren.size();
        for (int i = 0; i < size; i++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i);
            constraintWidget.mLeft.mGroup = 0;
            constraintWidget.mRight.mGroup = 0;
            constraintWidget.mTop.mGroup = 1;
            constraintWidget.mBottom.mGroup = 1;
            constraintWidget.mBaseline.mGroup = 1;
        }
        return 2;
    }

    /* JADX WARN: Removed duplicated region for block: B:28:0x01bb  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public void findHorizontalWrapRecursive(ConstraintWidget constraintWidget, boolean[] zArr) {
        int i;
        ConstraintWidget constraintWidget2;
        int i2 = 0;
        if (constraintWidget.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.mDimensionRatio > 0.0f) {
            zArr[0] = false;
            return;
        }
        int optimizerWrapWidth = constraintWidget.getOptimizerWrapWidth();
        if (constraintWidget.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.mVerticalDimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.mDimensionRatio > 0.0f) {
            zArr[0] = false;
            return;
        }
        boolean z = true;
        constraintWidget.mHorizontalWrapVisited = true;
        if (constraintWidget instanceof Guideline) {
            Guideline guideline = (Guideline) constraintWidget;
            if (guideline.getOrientation() != 1) {
                i2 = optimizerWrapWidth;
            } else if (guideline.getRelativeBegin() != -1) {
                optimizerWrapWidth = 0;
                i2 = guideline.getRelativeBegin();
            } else {
                optimizerWrapWidth = guideline.getRelativeEnd() != -1 ? guideline.getRelativeEnd() : 0;
            }
        } else if (!constraintWidget.mRight.isConnected() && !constraintWidget.mLeft.isConnected()) {
            i2 = optimizerWrapWidth + constraintWidget.getX();
        } else {
            if (constraintWidget.mRight.mTarget != null && constraintWidget.mLeft.mTarget != null && (constraintWidget.mRight.mTarget == constraintWidget.mLeft.mTarget || (constraintWidget.mRight.mTarget.mOwner == constraintWidget.mLeft.mTarget.mOwner && constraintWidget.mRight.mTarget.mOwner != constraintWidget.mParent))) {
                zArr[0] = false;
                return;
            }
            ConstraintWidget constraintWidget3 = null;
            if (constraintWidget.mRight.mTarget != null) {
                constraintWidget2 = constraintWidget.mRight.mTarget.mOwner;
                i = constraintWidget.mRight.getMargin() + optimizerWrapWidth;
                if (!constraintWidget2.isRoot() && !constraintWidget2.mHorizontalWrapVisited) {
                    findHorizontalWrapRecursive(constraintWidget2, zArr);
                }
            } else {
                i = optimizerWrapWidth;
                constraintWidget2 = null;
            }
            if (constraintWidget.mLeft.mTarget != null) {
                constraintWidget3 = constraintWidget.mLeft.mTarget.mOwner;
                optimizerWrapWidth += constraintWidget.mLeft.getMargin();
                if (!constraintWidget3.isRoot() && !constraintWidget3.mHorizontalWrapVisited) {
                    findHorizontalWrapRecursive(constraintWidget3, zArr);
                }
            }
            if (constraintWidget.mRight.mTarget != null && !constraintWidget2.isRoot()) {
                if (constraintWidget.mRight.mTarget.mType == ConstraintAnchor.Type.RIGHT) {
                    i += constraintWidget2.mDistToRight - constraintWidget2.getOptimizerWrapWidth();
                } else if (constraintWidget.mRight.mTarget.getType() == ConstraintAnchor.Type.LEFT) {
                    i += constraintWidget2.mDistToRight;
                }
                constraintWidget.mRightHasCentered = constraintWidget2.mRightHasCentered || !(constraintWidget2.mLeft.mTarget == null || constraintWidget2.mRight.mTarget == null || constraintWidget2.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT);
                if (constraintWidget.mRightHasCentered && (constraintWidget2.mLeft.mTarget == null || constraintWidget2.mLeft.mTarget.mOwner != constraintWidget)) {
                    i += i - constraintWidget2.mDistToRight;
                }
            }
            if (constraintWidget.mLeft.mTarget != null && !constraintWidget3.isRoot()) {
                if (constraintWidget.mLeft.mTarget.getType() == ConstraintAnchor.Type.LEFT) {
                    optimizerWrapWidth += constraintWidget3.mDistToLeft - constraintWidget3.getOptimizerWrapWidth();
                } else if (constraintWidget.mLeft.mTarget.getType() == ConstraintAnchor.Type.RIGHT) {
                    optimizerWrapWidth += constraintWidget3.mDistToLeft;
                }
                if (!constraintWidget3.mLeftHasCentered && (constraintWidget3.mLeft.mTarget == null || constraintWidget3.mRight.mTarget == null || constraintWidget3.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT)) {
                    z = false;
                }
                constraintWidget.mLeftHasCentered = z;
                if (constraintWidget.mLeftHasCentered && (constraintWidget3.mRight.mTarget == null || constraintWidget3.mRight.mTarget.mOwner != constraintWidget)) {
                    i2 = optimizerWrapWidth + (optimizerWrapWidth - constraintWidget3.mDistToLeft);
                    if (constraintWidget.getVisibility() == 8) {
                        i2 -= constraintWidget.mWidth;
                        i -= constraintWidget.mWidth;
                    }
                    constraintWidget.mDistToLeft = i2;
                    constraintWidget.mDistToRight = i;
                }
            }
            i2 = optimizerWrapWidth;
            if (constraintWidget.getVisibility() == 8) {
            }
            constraintWidget.mDistToLeft = i2;
            constraintWidget.mDistToRight = i;
        }
        i = optimizerWrapWidth;
        if (constraintWidget.getVisibility() == 8) {
        }
        constraintWidget.mDistToLeft = i2;
        constraintWidget.mDistToRight = i;
    }

    /* JADX WARN: Removed duplicated region for block: B:20:0x020b  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public void findVerticalWrapRecursive(ConstraintWidget constraintWidget, boolean[] zArr) {
        int i;
        ConstraintWidget constraintWidget2;
        int i2 = 0;
        if (constraintWidget.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.mHorizontalDimensionBehaviour != ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT && constraintWidget.mDimensionRatio > 0.0f) {
            zArr[0] = false;
            return;
        }
        int optimizerWrapHeight = constraintWidget.getOptimizerWrapHeight();
        boolean z = true;
        constraintWidget.mVerticalWrapVisited = true;
        if (constraintWidget instanceof Guideline) {
            Guideline guideline = (Guideline) constraintWidget;
            if (guideline.getOrientation() != 0) {
                i2 = optimizerWrapHeight;
            } else if (guideline.getRelativeBegin() != -1) {
                optimizerWrapHeight = 0;
                i2 = guideline.getRelativeBegin();
            } else {
                optimizerWrapHeight = guideline.getRelativeEnd() != -1 ? guideline.getRelativeEnd() : 0;
            }
        } else if (constraintWidget.mBaseline.mTarget == null && constraintWidget.mTop.mTarget == null && constraintWidget.mBottom.mTarget == null) {
            i2 = optimizerWrapHeight + constraintWidget.getY();
        } else {
            if (constraintWidget.mBottom.mTarget != null && constraintWidget.mTop.mTarget != null && (constraintWidget.mBottom.mTarget == constraintWidget.mTop.mTarget || (constraintWidget.mBottom.mTarget.mOwner == constraintWidget.mTop.mTarget.mOwner && constraintWidget.mBottom.mTarget.mOwner != constraintWidget.mParent))) {
                zArr[0] = false;
                return;
            }
            if (constraintWidget.mBaseline.isConnected()) {
                ConstraintWidget owner = constraintWidget.mBaseline.mTarget.getOwner();
                if (!owner.mVerticalWrapVisited) {
                    findVerticalWrapRecursive(owner, zArr);
                }
                int max = Math.max((owner.mDistToTop - owner.mHeight) + optimizerWrapHeight, optimizerWrapHeight);
                int max2 = Math.max((owner.mDistToBottom - owner.mHeight) + optimizerWrapHeight, optimizerWrapHeight);
                if (constraintWidget.getVisibility() == 8) {
                    max -= constraintWidget.mHeight;
                    max2 -= constraintWidget.mHeight;
                }
                constraintWidget.mDistToTop = max;
                constraintWidget.mDistToBottom = max2;
                return;
            }
            ConstraintWidget constraintWidget3 = null;
            if (constraintWidget.mTop.isConnected()) {
                constraintWidget2 = constraintWidget.mTop.mTarget.getOwner();
                i = constraintWidget.mTop.getMargin() + optimizerWrapHeight;
                if (!constraintWidget2.isRoot() && !constraintWidget2.mVerticalWrapVisited) {
                    findVerticalWrapRecursive(constraintWidget2, zArr);
                }
            } else {
                i = optimizerWrapHeight;
                constraintWidget2 = null;
            }
            if (constraintWidget.mBottom.isConnected()) {
                constraintWidget3 = constraintWidget.mBottom.mTarget.getOwner();
                optimizerWrapHeight += constraintWidget.mBottom.getMargin();
                if (!constraintWidget3.isRoot() && !constraintWidget3.mVerticalWrapVisited) {
                    findVerticalWrapRecursive(constraintWidget3, zArr);
                }
            }
            if (constraintWidget.mTop.mTarget != null && !constraintWidget2.isRoot()) {
                if (constraintWidget.mTop.mTarget.getType() == ConstraintAnchor.Type.TOP) {
                    i += constraintWidget2.mDistToTop - constraintWidget2.getOptimizerWrapHeight();
                } else if (constraintWidget.mTop.mTarget.getType() == ConstraintAnchor.Type.BOTTOM) {
                    i += constraintWidget2.mDistToTop;
                }
                constraintWidget.mTopHasCentered = constraintWidget2.mTopHasCentered || !(constraintWidget2.mTop.mTarget == null || constraintWidget2.mTop.mTarget.mOwner == constraintWidget || constraintWidget2.mBottom.mTarget == null || constraintWidget2.mBottom.mTarget.mOwner == constraintWidget || constraintWidget2.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT);
                if (constraintWidget.mTopHasCentered && (constraintWidget2.mBottom.mTarget == null || constraintWidget2.mBottom.mTarget.mOwner != constraintWidget)) {
                    i += i - constraintWidget2.mDistToTop;
                }
            }
            if (constraintWidget.mBottom.mTarget != null && !constraintWidget3.isRoot()) {
                if (constraintWidget.mBottom.mTarget.getType() == ConstraintAnchor.Type.BOTTOM) {
                    optimizerWrapHeight += constraintWidget3.mDistToBottom - constraintWidget3.getOptimizerWrapHeight();
                } else if (constraintWidget.mBottom.mTarget.getType() == ConstraintAnchor.Type.TOP) {
                    optimizerWrapHeight += constraintWidget3.mDistToBottom;
                }
                if (!constraintWidget3.mBottomHasCentered && (constraintWidget3.mTop.mTarget == null || constraintWidget3.mTop.mTarget.mOwner == constraintWidget || constraintWidget3.mBottom.mTarget == null || constraintWidget3.mBottom.mTarget.mOwner == constraintWidget || constraintWidget3.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT)) {
                    z = false;
                }
                constraintWidget.mBottomHasCentered = z;
                if (constraintWidget.mBottomHasCentered && (constraintWidget3.mTop.mTarget == null || constraintWidget3.mTop.mTarget.mOwner != constraintWidget)) {
                    optimizerWrapHeight += optimizerWrapHeight - constraintWidget3.mDistToBottom;
                }
            }
            if (constraintWidget.getVisibility() == 8) {
                i -= constraintWidget.mHeight;
                optimizerWrapHeight -= constraintWidget.mHeight;
            }
            constraintWidget.mDistToTop = i;
            constraintWidget.mDistToBottom = optimizerWrapHeight;
        }
        i = i2;
        if (constraintWidget.getVisibility() == 8) {
        }
        constraintWidget.mDistToTop = i;
        constraintWidget.mDistToBottom = optimizerWrapHeight;
    }

    public void findWrapSize(ArrayList<ConstraintWidget> arrayList, boolean[] zArr) {
        int size = arrayList.size();
        char c = 0;
        zArr[0] = true;
        int i = 0;
        int i2 = 0;
        int i3 = 0;
        int i4 = 0;
        int i5 = 0;
        int i6 = 0;
        int i7 = 0;
        while (i < size) {
            ConstraintWidget constraintWidget = arrayList.get(i);
            if (!constraintWidget.isRoot()) {
                if (!constraintWidget.mHorizontalWrapVisited) {
                    findHorizontalWrapRecursive(constraintWidget, zArr);
                }
                if (!constraintWidget.mVerticalWrapVisited) {
                    findVerticalWrapRecursive(constraintWidget, zArr);
                }
                if (!zArr[c]) {
                    return;
                }
                int width = (constraintWidget.mDistToLeft + constraintWidget.mDistToRight) - constraintWidget.getWidth();
                int height = (constraintWidget.mDistToTop + constraintWidget.mDistToBottom) - constraintWidget.getHeight();
                int width2 = constraintWidget.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_PARENT ? constraintWidget.getWidth() + constraintWidget.mLeft.mMargin + constraintWidget.mRight.mMargin : width;
                int height2 = constraintWidget.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_PARENT ? constraintWidget.getHeight() + constraintWidget.mTop.mMargin + constraintWidget.mBottom.mMargin : height;
                if (constraintWidget.getVisibility() == 8) {
                    width2 = 0;
                    height2 = 0;
                }
                i2 = Math.max(i2, constraintWidget.mDistToLeft);
                i3 = Math.max(i3, constraintWidget.mDistToRight);
                i6 = Math.max(i6, constraintWidget.mDistToBottom);
                i5 = Math.max(i5, constraintWidget.mDistToTop);
                int max = Math.max(i4, width2);
                i7 = Math.max(i7, height2);
                i4 = max;
            }
            i++;
            c = 0;
        }
        this.mWrapWidth = Math.max(this.mMinWidth, Math.max(Math.max(i2, i3), i4));
        this.mWrapHeight = Math.max(this.mMinHeight, Math.max(Math.max(i5, i6), i7));
        for (int i8 = 0; i8 < size; i8++) {
            ConstraintWidget constraintWidget2 = arrayList.get(i8);
            constraintWidget2.mHorizontalWrapVisited = false;
            constraintWidget2.mVerticalWrapVisited = false;
            constraintWidget2.mLeftHasCentered = false;
            constraintWidget2.mRightHasCentered = false;
            constraintWidget2.mTopHasCentered = false;
            constraintWidget2.mBottomHasCentered = false;
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Code restructure failed: missing block: B:53:0x00ba, code lost:
    
        r9 = r10.mTarget;
     */
    /* JADX WARN: Code restructure failed: missing block: B:54:0x00bc, code lost:
    
        if (r9 != null) goto L54;
     */
    /* JADX WARN: Code restructure failed: missing block: B:56:0x00c5, code lost:
    
        if (r9.mOwner.getParent() == null) goto L63;
     */
    /* JADX WARN: Code restructure failed: missing block: B:58:0x00cb, code lost:
    
        if (r9.mGroup == r10.mGroup) goto L63;
     */
    /* JADX WARN: Code restructure failed: missing block: B:60:0x00d1, code lost:
    
        if (r10.mGroup <= r9.mGroup) goto L61;
     */
    /* JADX WARN: Code restructure failed: missing block: B:61:0x00d3, code lost:
    
        r8 = r9.mGroup;
     */
    /* JADX WARN: Code restructure failed: missing block: B:62:0x00d8, code lost:
    
        r10.mGroup = r8;
        r9.mGroup = r8;
        r8 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:63:0x00d6, code lost:
    
        r8 = r10.mGroup;
     */
    /* JADX WARN: Code restructure failed: missing block: B:64:0x00dd, code lost:
    
        r9 = r9.getOpposite();
     */
    /* JADX WARN: Code restructure failed: missing block: B:65:0x00e1, code lost:
    
        if (r9 == null) goto L117;
     */
    /* JADX WARN: Code restructure failed: missing block: B:67:0x00e7, code lost:
    
        if (r9.mGroup == r10.mGroup) goto L118;
     */
    /* JADX WARN: Code restructure failed: missing block: B:69:0x00ed, code lost:
    
        if (r10.mGroup <= r9.mGroup) goto L70;
     */
    /* JADX WARN: Code restructure failed: missing block: B:70:0x00ef, code lost:
    
        r8 = r9.mGroup;
     */
    /* JADX WARN: Code restructure failed: missing block: B:71:0x00f4, code lost:
    
        r10.mGroup = r8;
        r9.mGroup = r8;
        r8 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:73:0x00f9, code lost:
    
        r5 = r5 + 1;
     */
    /* JADX WARN: Code restructure failed: missing block: B:74:0x00f2, code lost:
    
        r8 = r10.mGroup;
     */
    /* JADX WARN: Removed duplicated region for block: B:46:0x009d  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public int layoutFindGroups() {
        ConstraintAnchor.Type[] typeArr = {ConstraintAnchor.Type.LEFT, ConstraintAnchor.Type.RIGHT, ConstraintAnchor.Type.TOP, ConstraintAnchor.Type.BASELINE, ConstraintAnchor.Type.BOTTOM};
        int size = this.mChildren.size();
        int i = 1;
        for (int i2 = 0; i2 < size; i2++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i2);
            ConstraintAnchor constraintAnchor = constraintWidget.mLeft;
            if (constraintAnchor.mTarget != null) {
                if (setGroup(constraintAnchor, i) == i) {
                    i++;
                }
            } else {
                constraintAnchor.mGroup = Integer.MAX_VALUE;
            }
            ConstraintAnchor constraintAnchor2 = constraintWidget.mTop;
            if (constraintAnchor2.mTarget != null) {
                if (setGroup(constraintAnchor2, i) == i) {
                    i++;
                }
            } else {
                constraintAnchor2.mGroup = Integer.MAX_VALUE;
            }
            ConstraintAnchor constraintAnchor3 = constraintWidget.mRight;
            if (constraintAnchor3.mTarget != null) {
                if (setGroup(constraintAnchor3, i) == i) {
                    i++;
                }
            } else {
                constraintAnchor3.mGroup = Integer.MAX_VALUE;
            }
            ConstraintAnchor constraintAnchor4 = constraintWidget.mBottom;
            if (constraintAnchor4.mTarget != null) {
                if (setGroup(constraintAnchor4, i) == i) {
                    i++;
                }
            } else {
                constraintAnchor4.mGroup = Integer.MAX_VALUE;
            }
            ConstraintAnchor constraintAnchor5 = constraintWidget.mBaseline;
            if (constraintAnchor5.mTarget != null) {
                if (setGroup(constraintAnchor5, i) == i) {
                    i++;
                }
            } else {
                constraintAnchor5.mGroup = Integer.MAX_VALUE;
            }
        }
        boolean z = true;
        while (z) {
            int i3 = 0;
            boolean z2 = false;
            while (i3 < size) {
                ConstraintWidget constraintWidget2 = this.mChildren.get(i3);
                boolean z3 = z2;
                int i4 = 0;
                while (i4 < typeArr.length) {
                    ConstraintAnchor constraintAnchor6 = null;
                    switch (typeArr[i4]) {
                        case LEFT:
                            constraintAnchor6 = constraintWidget2.mLeft;
                            break;
                        case TOP:
                            constraintAnchor6 = constraintWidget2.mTop;
                            break;
                        case RIGHT:
                            constraintAnchor6 = constraintWidget2.mRight;
                            break;
                        case BOTTOM:
                            constraintAnchor6 = constraintWidget2.mBottom;
                            break;
                        case BASELINE:
                            constraintAnchor6 = constraintWidget2.mBaseline;
                            break;
                    }
                    while (i4 < typeArr.length) {
                    }
                }
                i3++;
                z2 = z3;
            }
            z = z2;
        }
        int[] iArr = new int[(this.mChildren.size() * typeArr.length) + 1];
        Arrays.fill(iArr, -1);
        int i5 = 0;
        for (int i6 = 0; i6 < size; i6++) {
            ConstraintWidget constraintWidget3 = this.mChildren.get(i6);
            ConstraintAnchor constraintAnchor7 = constraintWidget3.mLeft;
            if (constraintAnchor7.mGroup != Integer.MAX_VALUE) {
                int i7 = constraintAnchor7.mGroup;
                if (iArr[i7] == -1) {
                    iArr[i7] = i5;
                    i5++;
                }
                constraintAnchor7.mGroup = iArr[i7];
            }
            ConstraintAnchor constraintAnchor8 = constraintWidget3.mTop;
            if (constraintAnchor8.mGroup != Integer.MAX_VALUE) {
                int i8 = constraintAnchor8.mGroup;
                if (iArr[i8] == -1) {
                    iArr[i8] = i5;
                    i5++;
                }
                constraintAnchor8.mGroup = iArr[i8];
            }
            ConstraintAnchor constraintAnchor9 = constraintWidget3.mRight;
            if (constraintAnchor9.mGroup != Integer.MAX_VALUE) {
                int i9 = constraintAnchor9.mGroup;
                if (iArr[i9] == -1) {
                    iArr[i9] = i5;
                    i5++;
                }
                constraintAnchor9.mGroup = iArr[i9];
            }
            ConstraintAnchor constraintAnchor10 = constraintWidget3.mBottom;
            if (constraintAnchor10.mGroup != Integer.MAX_VALUE) {
                int i10 = constraintAnchor10.mGroup;
                if (iArr[i10] == -1) {
                    iArr[i10] = i5;
                    i5++;
                }
                constraintAnchor10.mGroup = iArr[i10];
            }
            ConstraintAnchor constraintAnchor11 = constraintWidget3.mBaseline;
            if (constraintAnchor11.mGroup != Integer.MAX_VALUE) {
                int i11 = constraintAnchor11.mGroup;
                if (iArr[i11] == -1) {
                    iArr[i11] = i5;
                    i5++;
                }
                constraintAnchor11.mGroup = iArr[i11];
            }
        }
        return i5;
    }

    public void layoutWithGroup(int i) {
        int i2 = this.mX;
        int i3 = this.mY;
        if (this.mParent != null) {
            if (this.mSnapshot == null) {
                this.mSnapshot = new Snapshot(this);
            }
            this.mSnapshot.updateFrom(this);
            this.mX = 0;
            this.mY = 0;
            resetAnchors();
            resetSolverVariables(this.mSystem.getCache());
        } else {
            this.mX = 0;
            this.mY = 0;
        }
        int size = this.mChildren.size();
        for (int i4 = 0; i4 < size; i4++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i4);
            if (constraintWidget instanceof WidgetContainer) {
                ((WidgetContainer) constraintWidget).layout();
            }
        }
        this.mLeft.mGroup = 0;
        this.mRight.mGroup = 0;
        this.mTop.mGroup = 1;
        this.mBottom.mGroup = 1;
        this.mSystem.reset();
        for (int i5 = 0; i5 < i; i5++) {
            try {
                addToSolver(this.mSystem, i5);
                this.mSystem.minimize();
                updateFromSolver(this.mSystem, i5);
            } catch (Exception e) {
                e.printStackTrace();
            }
            updateFromSolver(this.mSystem, -2);
        }
        if (this.mParent != null) {
            int width = getWidth();
            int height = getHeight();
            this.mSnapshot.applyTo(this);
            setWidth(width);
            setHeight(height);
        } else {
            this.mX = i2;
            this.mY = i3;
        }
        if (this == getRootConstraintContainer()) {
            updateDrawPosition();
        }
    }

    public ArrayList<Guideline> getVerticalGuidelines() {
        ArrayList<Guideline> arrayList = new ArrayList<>();
        int size = this.mChildren.size();
        for (int i = 0; i < size; i++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i);
            if (constraintWidget instanceof Guideline) {
                Guideline guideline = (Guideline) constraintWidget;
                if (guideline.getOrientation() == 1) {
                    arrayList.add(guideline);
                }
            }
        }
        return arrayList;
    }

    public ArrayList<Guideline> getHorizontalGuidelines() {
        ArrayList<Guideline> arrayList = new ArrayList<>();
        int size = this.mChildren.size();
        for (int i = 0; i < size; i++) {
            ConstraintWidget constraintWidget = this.mChildren.get(i);
            if (constraintWidget instanceof Guideline) {
                Guideline guideline = (Guideline) constraintWidget;
                if (guideline.getOrientation() == 0) {
                    arrayList.add(guideline);
                }
            }
        }
        return arrayList;
    }

    public LinearSystem getSystem() {
        return this.mSystem;
    }

    private void resetChains() {
        this.mHorizontalChainsSize = 0;
        this.mVerticalChainsSize = 0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void addChain(ConstraintWidget constraintWidget, int i) {
        if (i == 0) {
            while (constraintWidget.mLeft.mTarget != null && constraintWidget.mLeft.mTarget.mOwner.mRight.mTarget != null && constraintWidget.mLeft.mTarget.mOwner.mRight.mTarget == constraintWidget.mLeft && constraintWidget.mLeft.mTarget.mOwner != constraintWidget) {
                constraintWidget = constraintWidget.mLeft.mTarget.mOwner;
            }
            addHorizontalChain(constraintWidget);
            return;
        }
        if (i == 1) {
            while (constraintWidget.mTop.mTarget != null && constraintWidget.mTop.mTarget.mOwner.mBottom.mTarget != null && constraintWidget.mTop.mTarget.mOwner.mBottom.mTarget == constraintWidget.mTop && constraintWidget.mTop.mTarget.mOwner != constraintWidget) {
                constraintWidget = constraintWidget.mTop.mTarget.mOwner;
            }
            addVerticalChain(constraintWidget);
        }
    }

    private void addHorizontalChain(ConstraintWidget constraintWidget) {
        for (int i = 0; i < this.mHorizontalChainsSize; i++) {
            if (this.mHorizontalChainsArray[i] == constraintWidget) {
                return;
            }
        }
        if (this.mHorizontalChainsSize + 1 >= this.mHorizontalChainsArray.length) {
            this.mHorizontalChainsArray = (ConstraintWidget[]) Arrays.copyOf(this.mHorizontalChainsArray, this.mHorizontalChainsArray.length * 2);
        }
        this.mHorizontalChainsArray[this.mHorizontalChainsSize] = constraintWidget;
        this.mHorizontalChainsSize++;
    }

    private void addVerticalChain(ConstraintWidget constraintWidget) {
        for (int i = 0; i < this.mVerticalChainsSize; i++) {
            if (this.mVerticalChainsArray[i] == constraintWidget) {
                return;
            }
        }
        if (this.mVerticalChainsSize + 1 >= this.mVerticalChainsArray.length) {
            this.mVerticalChainsArray = (ConstraintWidget[]) Arrays.copyOf(this.mVerticalChainsArray, this.mVerticalChainsArray.length * 2);
        }
        this.mVerticalChainsArray[this.mVerticalChainsSize] = constraintWidget;
        this.mVerticalChainsSize++;
    }

    private int countMatchConstraintsChainedWidgets(LinearSystem linearSystem, ConstraintWidget[] constraintWidgetArr, ConstraintWidget constraintWidget, int i, boolean[] zArr) {
        int i2;
        char c;
        char c2;
        zArr[0] = true;
        zArr[1] = false;
        ConstraintWidget constraintWidget2 = null;
        constraintWidgetArr[0] = null;
        constraintWidgetArr[2] = null;
        constraintWidgetArr[1] = null;
        constraintWidgetArr[3] = null;
        float f = 0.0f;
        int i3 = 5;
        int i4 = 8;
        if (i == 0) {
            boolean z = constraintWidget.mLeft.mTarget == null || constraintWidget.mLeft.mTarget.mOwner == this;
            constraintWidget.mHorizontalNextWidget = null;
            i2 = 0;
            ConstraintWidget constraintWidget3 = null;
            ConstraintWidget constraintWidget4 = constraintWidget.getVisibility() != 8 ? constraintWidget : null;
            ConstraintWidget constraintWidget5 = constraintWidget4;
            ConstraintWidget constraintWidget6 = constraintWidget;
            while (constraintWidget6.mRight.mTarget != null) {
                constraintWidget6.mHorizontalNextWidget = constraintWidget2;
                if (constraintWidget6.getVisibility() != 8) {
                    if (constraintWidget5 == null) {
                        constraintWidget5 = constraintWidget6;
                    }
                    if (constraintWidget4 != null && constraintWidget4 != constraintWidget6) {
                        constraintWidget4.mHorizontalNextWidget = constraintWidget6;
                    }
                    constraintWidget4 = constraintWidget6;
                } else {
                    linearSystem.addEquality(constraintWidget6.mLeft.mSolverVariable, constraintWidget6.mLeft.mTarget.mSolverVariable, 0, 5);
                    linearSystem.addEquality(constraintWidget6.mRight.mSolverVariable, constraintWidget6.mLeft.mSolverVariable, 0, 5);
                }
                if (constraintWidget6.getVisibility() != 8 && constraintWidget6.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                    if (constraintWidget6.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                        zArr[0] = false;
                    }
                    if (constraintWidget6.mDimensionRatio <= f) {
                        zArr[0] = false;
                        int i5 = i2 + 1;
                        if (i5 >= this.mMatchConstraintsChainedWidgets.length) {
                            this.mMatchConstraintsChainedWidgets = (ConstraintWidget[]) Arrays.copyOf(this.mMatchConstraintsChainedWidgets, this.mMatchConstraintsChainedWidgets.length * 2);
                        }
                        this.mMatchConstraintsChainedWidgets[i2] = constraintWidget6;
                        i2 = i5;
                    }
                }
                if (constraintWidget6.mRight.mTarget.mOwner.mLeft.mTarget == null || constraintWidget6.mRight.mTarget.mOwner.mLeft.mTarget.mOwner != constraintWidget6 || constraintWidget6.mRight.mTarget.mOwner == constraintWidget6) {
                    break;
                }
                constraintWidget3 = constraintWidget6.mRight.mTarget.mOwner;
                constraintWidget6 = constraintWidget3;
                constraintWidget2 = null;
                f = 0.0f;
            }
            if (constraintWidget6.mRight.mTarget != null && constraintWidget6.mRight.mTarget.mOwner != this) {
                z = false;
            }
            if (constraintWidget.mLeft.mTarget == null || constraintWidget3.mRight.mTarget == null) {
                c2 = 1;
                zArr[1] = true;
            } else {
                c2 = 1;
            }
            constraintWidget.mHorizontalChainFixedPosition = z;
            constraintWidget3.mHorizontalNextWidget = null;
            constraintWidgetArr[0] = constraintWidget;
            constraintWidgetArr[2] = constraintWidget5;
            constraintWidgetArr[c2] = constraintWidget3;
            constraintWidgetArr[3] = constraintWidget4;
        } else {
            boolean z2 = constraintWidget.mTop.mTarget == null || constraintWidget.mTop.mTarget.mOwner == this;
            ConstraintWidget constraintWidget7 = null;
            constraintWidget.mVerticalNextWidget = null;
            int i6 = 0;
            ConstraintWidget constraintWidget8 = null;
            ConstraintWidget constraintWidget9 = constraintWidget.getVisibility() != 8 ? constraintWidget : null;
            ConstraintWidget constraintWidget10 = constraintWidget9;
            ConstraintWidget constraintWidget11 = constraintWidget;
            while (constraintWidget11.mBottom.mTarget != null) {
                constraintWidget11.mVerticalNextWidget = constraintWidget7;
                if (constraintWidget11.getVisibility() != i4) {
                    if (constraintWidget9 == null) {
                        constraintWidget9 = constraintWidget11;
                    }
                    if (constraintWidget10 != null && constraintWidget10 != constraintWidget11) {
                        constraintWidget10.mVerticalNextWidget = constraintWidget11;
                    }
                    constraintWidget10 = constraintWidget11;
                } else {
                    linearSystem.addEquality(constraintWidget11.mTop.mSolverVariable, constraintWidget11.mTop.mTarget.mSolverVariable, 0, i3);
                    linearSystem.addEquality(constraintWidget11.mBottom.mSolverVariable, constraintWidget11.mTop.mSolverVariable, 0, i3);
                }
                if (constraintWidget11.getVisibility() != i4 && constraintWidget11.mVerticalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                    if (constraintWidget11.mHorizontalDimensionBehaviour == ConstraintWidget.DimensionBehaviour.MATCH_CONSTRAINT) {
                        zArr[0] = false;
                    }
                    if (constraintWidget11.mDimensionRatio <= 0.0f) {
                        zArr[0] = false;
                        int i7 = i6 + 1;
                        if (i7 >= this.mMatchConstraintsChainedWidgets.length) {
                            this.mMatchConstraintsChainedWidgets = (ConstraintWidget[]) Arrays.copyOf(this.mMatchConstraintsChainedWidgets, this.mMatchConstraintsChainedWidgets.length * 2);
                        }
                        this.mMatchConstraintsChainedWidgets[i6] = constraintWidget11;
                        i6 = i7;
                    }
                }
                if (constraintWidget11.mBottom.mTarget.mOwner.mTop.mTarget == null || constraintWidget11.mBottom.mTarget.mOwner.mTop.mTarget.mOwner != constraintWidget11 || constraintWidget11.mBottom.mTarget.mOwner == constraintWidget11) {
                    break;
                }
                constraintWidget8 = constraintWidget11.mBottom.mTarget.mOwner;
                constraintWidget11 = constraintWidget8;
                constraintWidget7 = null;
                i3 = 5;
                i4 = 8;
            }
            i2 = i6;
            if (constraintWidget11.mBottom.mTarget != null && constraintWidget11.mBottom.mTarget.mOwner != this) {
                z2 = false;
            }
            if (constraintWidget.mTop.mTarget == null || constraintWidget8.mBottom.mTarget == null) {
                c = 1;
                zArr[1] = true;
            } else {
                c = 1;
            }
            constraintWidget.mVerticalChainFixedPosition = z2;
            constraintWidget8.mVerticalNextWidget = null;
            constraintWidgetArr[0] = constraintWidget;
            constraintWidgetArr[2] = constraintWidget9;
            constraintWidgetArr[c] = constraintWidget8;
            constraintWidgetArr[3] = constraintWidget10;
        }
        return i2;
    }
}
