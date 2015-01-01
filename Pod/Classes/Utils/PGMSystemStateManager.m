//
//  PGMSystemStateManager.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/15/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "PGMSystemStateManager.h"

@implementation PGMSystemStateManager

- (CGFloat) getStatusBarHeight {
//    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
//    return MIN(statusBarSize.width, statusBarSize.height);
    return 20;
}

+ (id)sharedManager {
    static PGMSystemStateManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] initPrivate];
    });
    return sharedManager;
}

- (id)initPrivate {
    if (self = [super init]) {
    }
    return self;
}

- (id)init {
    return [[self class] sharedManager];
}

@end
