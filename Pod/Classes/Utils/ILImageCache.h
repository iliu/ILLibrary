//
//  ILImageCache.h
//  draft-iosclient
//
//  Created by Isaac Liu on 11/27/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UIImage* (^ILImageCacheImageGenerator)();

@interface ILImageCache : NSObject
+(UIImage *) getImageForKey: (NSString *)uniqueKey withGenerator: (ILImageCacheImageGenerator) generator;

+(UIImage *) getFAIcon:(NSString *)name withSize:(CGFloat)size andColor:(UIColor *)color;

+(void) getImageForPath: (NSURL *)path withCompletionBlock: (void(^)(UIImage *image, NSError *error)) completion;

+(void) getImageForPath: (NSURL *)path andContext:(NSDictionary *)context withCompletionBlock: (void(^)(UIImage *image, NSError *error, NSDictionary* context)) completion;


@end
