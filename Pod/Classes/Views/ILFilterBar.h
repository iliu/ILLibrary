//
//  ILFilterBar.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/9/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "ILButtonsBar.h"


typedef NS_ENUM(NSInteger, ILFilterButtonState)
{
    ILFilterButtonStateOff = 0,
    ILFilterButtonStateOn = 1,

};

@class ILFilterBar;

@protocol ILFilterBarDataSource <ILButtonsBarDataSource>
@optional
- (void) filterBar:(id)sender setButton:(UIButton *)button forControlState:(UIControlState)controlState;
@end

@protocol ILFilterBarDelegate <ILButtonsBarDelegate>
@optional
- (void) filterBar:(id)sender filterStateChanged:(NSArray *)newState;
@end


@interface ILFilterBar : ILButtonsBar

@property (nonatomic, weak) id<ILFilterBarDelegate>delegate;
@property (nonatomic, weak) id<ILFilterBarDataSource>dataSource;
@property (nonatomic, assign) BOOL toggleMode;

- (id) initWithButtonSpacing:(CGFloat)spacing andTopBottomInset:(UIEdgeInsets)inset;

- (ILFilterButtonState) getStateForButtonIndex:(NSIndexPath *)indexPath;

- (void) resetFilters;
- (BOOL) buttonsAreAllOff;

@end
