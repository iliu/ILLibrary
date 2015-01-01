//
//  ILButtonsBar.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/8/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ILButtonsBarDataSource <NSObject>
@required
- (UIButton *) buttonBar:(id)sender buttonForIndexPath: (NSIndexPath *) indexPath;
- (NSUInteger) numberOfButtonsForButtonBar:(id)sender;

@optional
- (UIView *) buttonBar:(id)sender separatorViewRightOfIndexPath:(NSIndexPath *)indexPath;
- (CGFloat) buttonBar:(id)sender separatorWidthRightOfIndexPath:(NSIndexPath *)indexPath;
@end

@protocol ILButtonsBarDelegate <NSObject>
@optional
- (void) buttonBar:(id)sender buttonTappedWithIndex:(NSUInteger)index;
@end

@interface ILButtonsBar : UIView <ILButtonsBarDelegate>
@property (nonatomic, weak) id<ILButtonsBarDelegate> delegate;
@property (nonatomic, weak) id<ILButtonsBarDataSource> dataSource;

- (id) initWithButtonSpacing:(CGFloat)spacing andTopBottomInset:(UIEdgeInsets)inset;
- (UIButton *)buttonAtIndexPath:(NSIndexPath *)indexPath;

// For child class to overwrite
- (void)buttonHitWithIndex:(NSInteger)index;
- (void)refresh;
@end
