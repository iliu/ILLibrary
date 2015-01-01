//
//  ILButtonsBarPrivate.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/9/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "ILButtonsBar.h"

@interface ILButtonsBar ()
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSArray *buttonViewConstraints;
@property (nonatomic, assign) CGFloat buttonSpacing;
@property (nonatomic, assign) UIEdgeInsets barInset;
@end
