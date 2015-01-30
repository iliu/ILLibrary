//
//  UIImage+Helpers.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/24/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Colors)

// http://stackoverflow.com/questions/14523348/how-to-change-the-background-color-of-a-uibutton-while-its-highlighted
+ (UIImage *)imageWithColor:(UIColor *)color;


@end


// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support resizing/cropping
@interface UIImage (Resize)
- (UIImage *)croppedImage:(CGRect)bounds;
//- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
//          transparentBorder:(NSUInteger)borderSize
//               cornerRadius:(NSUInteger)cornerRadius
//       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
@end