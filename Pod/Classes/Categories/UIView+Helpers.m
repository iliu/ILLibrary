//
//  UIView+Helpers.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/8/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "UIView+Helpers.h"
#import <objc/runtime.h>
#import "NSLayoutConstraint+AutolayoutHelpers.h"

static char placeHolderImageKey;

@implementation UIView (Helpers)


- (void) addBorder {
    [self addBorderWithColor:[UIColor darkGrayColor] andWidth:0.5];
}

- (void) addBorderWithColor:(UIColor *)color andWidth:(CGFloat) width{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void) addRoundedCornerWithRadius:(CGFloat) radius {
    self.layer.cornerRadius = radius;
//    self.layer.masksToBounds = YES;
}

- (UIImage *) placeHolderImage {
    [NSException raise:@"Invalid call" format:@"%s should never be called", __FUNCTION__];
    return nil;
}

- (void) setPlaceHolderImage:(UIImage *)placeHolderImage {
    
    UIImageView *imageView =(UIImageView *)objc_getAssociatedObject(self, &placeHolderImageKey);
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithImage:placeHolderImage];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:imageView];
        [self sendSubviewToBack:imageView];
        [self addConstraints:[NSLayoutConstraint constraintsForSameSizeViews:imageView andView2:self]];
        objc_setAssociatedObject(self, &placeHolderImageKey, imageView, OBJC_ASSOCIATION_RETAIN);
    }
    else {
        imageView.image = placeHolderImage;
    }
}

@end


@implementation UIView (mxcl)
- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
        return (UIViewController *)responder;
}
@end
