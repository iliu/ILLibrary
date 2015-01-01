//
//  UITableViewCell+Helpers.h
//  ILLibrary
//
//  Created by Isaac Liu on 12/31/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Helpers)

+(UIEdgeInsets) numArrayToInset:(NSArray *)numArray;
+(NSArray *) UIEdgeInsetsToNumArray:(UIEdgeInsets)inset;

@property (nonatomic, assign) UIEdgeInsets placeHolderInset;
@property (nonatomic, strong) UIView *placeHolderView;
@property (nonatomic, strong) NSString *placeHolderImageName;

@end
