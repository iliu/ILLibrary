//
//  UIView+Helpers.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/8/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helpers)

@property (nonatomic, strong) UIImage* placeHolderImage;

- (void) addBorder;
- (void) addBorderWithColor:(UIColor *)color andWidth:(CGFloat) width;

- (void) addRoundedCornerWithRadius:(CGFloat) radius;

@end


// http://stackoverflow.com/questions/1372977/given-a-view-how-do-i-get-its-viewcontroller
@interface UIView (mxcl)
- (UIViewController *)parentViewController;
@end

