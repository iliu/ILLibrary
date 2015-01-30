//
//  PGMSystemStateManager.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/15/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "ILSystemStateMonitor.h"
#import "ILLibrary.h"

NSString * const ILAppStateDidChangeNotification = @"com.isaacliu.illibrary.AppStateDidChange";

@interface ILSystemStateMonitor ()

@property (nonatomic, assign) ILSystemStateAppState appState;

@end

@implementation ILSystemStateMonitor

- (id)initPrivate {
    if (self = [super init]) {
        
        /* List of notifications possible -  https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplication_Class/#//apple_ref/c/data/UIApplicationDidBecomeActiveNotification
         
         http://stackoverflow.com/questions/3712979/applicationwillenterforeground-vs-applicationdidbecomeactive-applicationwillre
         
         UIApplicationBackgroundRefreshStatusDidChangeNotification
         UIApplicationDidBecomeActiveNotification
         UIApplicationDidChangeStatusBarFrameNotification
         UIApplicationDidChangeStatusBarOrientationNotification
         UIApplicationDidEnterBackgroundNotification
         UIApplicationDidFinishLaunchingNotification
         UIApplicationDidReceiveMemoryWarningNotification
         UIApplicationProtectedDataDidBecomeAvailable
         UIApplicationProtectedDataWillBecomeUnavailable
         UIApplicationSignificantTimeChangeNotification
         UIApplicationUserDidTakeScreenshotNotification
         UIApplicationWillChangeStatusBarOrientationNotification
         UIApplicationWillChangeStatusBarFrameNotification
         UIApplicationWillEnterForegroundNotification
         UIApplicationWillResignActiveNotification
         UIApplicationWillTerminateNotification
         UIContentSizeCategoryDidChangeNotification
         */
        
        // Register for UIApplication App State Notifications
        // Uncomment the following for debug purposes
        // NSArray *uiAppStateNotifications = @[UIApplicationDidBecomeActiveNotification, UIApplicationBackgroundRefreshStatusDidChangeNotification,  UIApplicationDidEnterBackgroundNotification, UIApplicationDidFinishLaunchingNotification, UIApplicationWillEnterForegroundNotification, UIApplicationWillResignActiveNotification, UIApplicationWillTerminateNotification];
        
        NSArray *uiAppStateNotifications = @[UIApplicationDidBecomeActiveNotification, UIApplicationDidEnterBackgroundNotification];

        for (NSString *notificationName in uiAppStateNotifications) {
            [[NSNotificationCenter defaultCenter] addObserverForName:notificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                [self handleAppStateNotification:note];
            }];
        }

    }
    return self;
}

#pragma mark - status bar
- (CGFloat) getStatusBarHeight {
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

#pragma mark - App State
- (void) handleAppStateNotification:(NSNotification *)note {
    
//    NSLog(@"%s, notification: %@", __func__, [note name]);

    ILSystemStateAppState newAppState;
    if ([[note name] isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        newAppState = ILSystemStateAppStateForeground;
    } else if ([[note name] isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        newAppState = ILSystemStateAppStateBackground;
    }
    // update and broadcast
    self.appState = newAppState;
    [[NSNotificationCenter defaultCenter] postNotificationName:ILAppStateDidChangeNotification object:self];
}



+ (NSString *) appStateName:(ILSystemStateAppState)state{
    switch (state) {
        case ILSystemStateAppStateForeground:
            return @"ILSystemStateAppStateForeground";
        case ILSystemStateAppStateBackground:
            return @"ILSystemStateAppStateBackground";
        default:
            return @"ILSystemStateAppStateUnknown";
    }
}



#pragma mark - Others
+ (id)sharedMonitor {
    static ILSystemStateMonitor *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] initPrivate];
    });
    return sharedManager;
}


- (id)init {
    return [[self class] sharedMonitor];
}

@end
