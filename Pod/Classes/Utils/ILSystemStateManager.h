//
//  PGMSystemStateManager.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/15/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILSystemStateManager : NSObject

- (CGFloat) getStatusBarHeight;

// Singleton
+ (ILSystemStateManager *) sharedManager;

@end
