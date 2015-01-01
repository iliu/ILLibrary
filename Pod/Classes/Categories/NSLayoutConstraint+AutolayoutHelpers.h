//
//  NSLayoutConstraint+AutolayoutHelpers.h
//  ILLibrary
//
//  Created by Isaac Liu on 12/6/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (AutolayoutHelpers)

// ====== Positional Constraints ======
+(NSArray *) constraintsForCenteredViews:(UIView *)view1 andView2:(UIView *)view2;
+(NSArray *) constraintsForHorizontallyCenteredItems:(NSArray *)items inView:(UIView *)view;
+(NSArray *) constraintsForVerticallyCenteredItems:(NSArray *)items inView:(UIView *)view;


// ====== Full Size Constraints ======
+(NSArray *) constraintsForSameSizeViews:(UIView *)view1 andView2:(UIView *)view2;
+(NSArray *) constraintsForSameSizeViews:(UIView *)view1 containingView2:(UIView *)view2 withInset:(UIEdgeInsets) insets;


// ====== Horizontal Constraints ======
+(NSArray *) constraintsForHorizontalBar:(UIView *)barView onMainView:(UIView *)mainView withHeight:(CGFloat)height;
+(NSArray *) constraintsForSameWidthItems:(NSArray *)items;
+(NSArray *) constraintsForFullWidthItems:(NSArray *)items inView:(UIView *)view;

// ====== Vertical Constraints ======
+(NSArray *) constraintsForSameHeightItems:(NSArray *)items;
+(NSArray *) constraintsForHeightOfItems:(NSArray *)items inView:(UIView *)view withInset:(UIEdgeInsets) inset;

// ==== Collection items Constraints =====
+(NSArray *) constraintsForHorizontalItems:(NSArray *)items inView:(UIView *)view;
+(NSArray *) constraintsForHorizontalItems:(NSArray *)items inView:(UIView *)view withSpacing:(CGFloat) space;
+(NSArray *) constraintsForHorizontalItems:(NSArray *)items inView:(UIView *)view withSpacing:(CGFloat)space andInset:(UIEdgeInsets) inset;

// ==== Other =====
+(NSArray *) constraintsForNavigationBar:(UIView *) navBarView onMainView:(UIView *)mainView withHeight:(CGFloat)height;




@end
