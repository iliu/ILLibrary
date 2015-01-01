//
//  UITableViewCell+Helpers.m
//  ILLibrary
//
//  Created by Isaac Liu on 12/31/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "UITableViewCell+Helpers.h"
#import "NSLayoutConstraint+AutolayoutHelpers.h"
#import <objc/runtime.h>

static char placeHolderAssociationKey;
static char placeHolderInsetAssociationKey;

@implementation UITableViewCell (Helpers)

+(UIEdgeInsets) numArrayToInset:(NSArray *)numArray {
    return UIEdgeInsetsMake([numArray[0] floatValue], [numArray[1] floatValue], [numArray[2] floatValue], [numArray[3] floatValue]);
}

+(NSArray *) UIEdgeInsetsToNumArray:(UIEdgeInsets)inset {
    return @[@(inset.top), @(inset.left), @(inset.bottom), @(inset.right)];
    
}

- (UIEdgeInsets) placeHolderInset {
    NSArray *results = (NSArray *)objc_getAssociatedObject(self, &placeHolderInsetAssociationKey);
    if (!results) {
        return UIEdgeInsetsZero;
    } else {
        return [UITableViewCell numArrayToInset:results];
    }
}

- (void) setPlaceHolderInset:(UIEdgeInsets)placeHolderInset {
    objc_setAssociatedObject(self, &placeHolderInsetAssociationKey, [UITableViewCell UIEdgeInsetsToNumArray:placeHolderInset], OBJC_ASSOCIATION_RETAIN);
    
}

- (UIView *) placeHolderView {
    return objc_getAssociatedObject(self, &placeHolderAssociationKey);
}

- (void) setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, &placeHolderAssociationKey, placeHolderView, OBJC_ASSOCIATION_RETAIN);
}


- (NSString *) placeHolderImageName {
    [NSException raise:@"Invalid Call" format:@"%s should not be called!", __func__];
    return nil;
}

- (void) setPlaceHolderImageName:(NSString *)placeHolderImageName {
    // TODO: Get image from image cache
    UIImage* image = [UIImage imageNamed:placeHolderImageName];
    
    if (image) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        if (imageView) {
            [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            imageView.contentMode = UIViewContentModeScaleToFill;
            [self.contentView addSubview:imageView];

            UIEdgeInsets insets = self.placeHolderInset;
            [self addConstraints:[NSLayoutConstraint constraintsForSameSizeViews:self.contentView containingView2:imageView withInset:insets]];
            self.placeHolderView = imageView;
        }
        
    } else {
        [self.placeHolderView removeFromSuperview];
    }
}



@end
