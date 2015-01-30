//
//  PGMSystemStateManager.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/15/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Modeling App State as described in https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html
 *
 *  We use:
 *      - UIApplicationDidBecomeActiveNotification 
 *      - UIApplicationDidEnterBackgroundNotification
 */
typedef NS_ENUM(NSInteger, ILSystemStateAppState){
    /**
     *  Foreground and Active
     */
    ILSystemStateAppStateForeground,
    /**
     *  Background
     */
    ILSystemStateAppStateBackground,
};

// Notification sent out when app state changes
extern NSString * const ILAppStateDidChangeNotification;



/**
 *  A system state manager that allows you to query various parameters about the system:
 *      - status bar height (to detect double status bar height)
 *      - App state: see ILSystemStateAppState Enum for states
 */
@interface ILSystemStateMonitor : NSObject

/**
 *  To get the status bar height of the system right now
 *
 *  @return status bar height
 */
- (CGFloat) getStatusBarHeight;

// -------------------------
//   App State Functions
// -------------------------

/**
 *  used to query the application state
 */
@property (nonatomic, assign, readonly) ILSystemStateAppState appState;

/**
 *  Convenience method to get a string representing the app state names
 *
 *  @param state app state
 *
 *  @return descriptive string describing the app state
 */
+ (NSString *) appStateName:(ILSystemStateAppState)state;

// Singleton
+ (ILSystemStateMonitor *) sharedMonitor;

@end
