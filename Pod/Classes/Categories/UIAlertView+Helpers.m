//
//  UIAlertView+Helpers.m
//  Pods
//
//  Created by Isaac Liu on 3/17/15.
//
//

#import "UIAlertView+Helpers.h"

@implementation UIAlertView (Helpers)

+ (void) showAlertWithTitle:(NSString *)title {
    UIAlertView *alert = UIAlertView.new;
    alert.title = title;
    [alert addButtonWithTitle:@"Ok"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}


@end
