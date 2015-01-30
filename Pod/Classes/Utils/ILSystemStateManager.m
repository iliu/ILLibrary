//
//  PGMSystemStateManager.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/15/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "ILSystemStateManager.h"

@implementation ILSystemStateManager


// FIXME: Meant to detect and return the status bar height at all times
- (CGFloat) getStatusBarHeight {
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

+ (id)sharedManager {
    static ILSystemStateManager *sharedManager = nil;
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
