//
//  NSLayoutConstraint+AutolayoutHelpers.m
//  ILLibrary
//
//  Created by Isaac Liu on 12/6/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "NSLayoutConstraint+AutolayoutHelpers.h"

@implementation NSLayoutConstraint (AutolayoutHelpers)


#pragma mark - Positional Constraints
+(NSArray *) constraintsForCenteredViews:(UIView *)view1 andView2:(UIView *)view2 {
    return @[
    [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0],
    [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}
+(NSArray *) constraintsForHorizontallyCenteredItems:(NSArray *)items inView:(UIView *)view {
    NSMutableArray *constraints = NSMutableArray.new;
    for (int i = 0; i < items.count; i++) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i] attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    }
    return constraints;
}
+(NSArray *) constraintsForVerticallyCenteredItems:(NSArray *)items inView:(UIView *)view {
    NSMutableArray *constraints = NSMutableArray.new;
    for (int i = 0; i < items.count; i++) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i] attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    }
    return constraints;
}



#pragma mark - Full Size Constraints
+(NSArray *) constraintsForSameSizeViews:(UIView *)view1 andView2:(UIView *)view2 {
    return [self constraintsForSameSizeViews:view1 containingView2:view2 withInset:UIEdgeInsetsZero];
}
+(NSArray *) constraintsForSameSizeViews:(UIView *)view1 containingView2:(UIView *)view2 withInset:(UIEdgeInsets) insets {
    return @[
             [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-insets.top],
             [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeRight multiplier:1.0 constant:insets.right],
             [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-insets.left],
             [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:insets.bottom],
             ];
}

#pragma mark - Vertical Constraints
+(NSArray *) constraintsForHeightOfItems:(NSArray *)items inView:(UIView *)view withInset:(UIEdgeInsets) inset {
    NSMutableArray *constraints = NSMutableArray.new;

    for (int i = 0; i < items.count; i++) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:inset.top]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-inset.bottom]];
    }
    
    return constraints;
    
}
+(NSArray *) constraintsForHeight:(CGFloat)height forView:(UIView *)view{
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(height)]" options:0 metrics:@{@"height":@(height)} views:@{@"view":view}];
}
+(NSArray *) constraintsForSameHeightItems:(NSArray *)items {

    NSMutableArray *constraints = NSMutableArray.new;

    for (int i = 0; i < items.count; i++ ){
        if (i > 0) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i-1] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:items[i] attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
        }
    }
    return constraints;
}

#pragma mark - Horizontal Constraints
+(NSArray *) constraintsForHorizontalBar:(UIView *)barView onMainView:(UIView *)mainView withHeight:(CGFloat)height {
    NSMutableArray *constraints = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:[barView(height)]" options:0 metrics:@{@"height":@(height)} views:@{@"barView":barView}] mutableCopy];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    
    return constraints;
}
+(NSArray *) constraintsForSameWidthItems:(NSArray *)items {
    
    NSMutableArray *constraints = NSMutableArray.new;
    
    for (int i = 0; i < items.count; i++ ){
        if (i > 0) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i-1] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:items[i] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
        }
    }
    
    return constraints;
}
+(NSArray *) constraintsForFullWidthItems:(NSArray *)items inView:(UIView *)view {
    NSMutableArray *constraints = [[NSLayoutConstraint constraintsForHorizontallyCenteredItems:items inView:view] mutableCopy];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsForSameWidthItems:items]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:items[0] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    return constraints;
}

#pragma mark - Different View Layout Constraints
+(NSArray *) constraintsForHorizontalItems:(NSArray *)items inView:(UIView *)view {
    return [NSLayoutConstraint constraintsForHorizontalItems:items inView:view withSpacing:0.0];
}
+(NSArray *) constraintsForHorizontalItems:(NSArray *)items inView:(UIView *)view withSpacing:(CGFloat)space{
    return [NSLayoutConstraint constraintsForHorizontalItems:items inView:view withSpacing:space andInset:UIEdgeInsetsZero];
}
+(NSArray *) constraintsForHorizontalItems:(NSArray *)items inView:(UIView *)view withSpacing:(CGFloat)space andInset:(UIEdgeInsets) inset{
    
    NSMutableArray *constraints = NSMutableArray.new;
    UIView* prevItem;
    for (int i = 0; i < items.count; i++) {
        [items[i] setTranslatesAutoresizingMaskIntoConstraints:NO];
        if ([items[i] superview] != view) {
            [view addSubview:items[i]];
        }
        
        if (!prevItem) {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i] attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:space]];
        }
        else {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:items[i] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:prevItem attribute:NSLayoutAttributeRight multiplier:1.0 constant:space]];
        }
        
        prevItem = items[i];
    }
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsForHeightOfItems:items inView:view withInset:inset]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:prevItem attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-space]];
    
    return constraints;
}

#pragma mark - Others
+(NSArray *) constraintsForNavigationBar:(UIView *) navBarView onMainView:(UIView *)mainView withHeight:(CGFloat)height {
    NSMutableArray *constraints = NSMutableArray.new;
    [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[navBarView(height)]" options:0 metrics:@{ @"height":@(height)} views:@{@"navBarView":navBarView}]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsForFullWidthItems:@[navBarView] inView:mainView]];
    return constraints;
}

@end
