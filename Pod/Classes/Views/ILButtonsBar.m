//
//  ILButtonsBar.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/8/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "ILButtonsBar.h"
#import "ILButtonsBarPrivate.h"
#import "NSLayoutConstraint+AutolayoutHelpers.h"

@implementation ILButtonsBar

- (id) initWithButtonSpacing:(CGFloat)spacing andTopBottomInset:(UIEdgeInsets)inset {
    if (self = [super init]) {
        self.buttonSpacing = spacing;
        self.barInset = inset;
        self.delegate = self;
    }
    return self;
}

- (id) init {
    return [self initWithButtonSpacing:0 andTopBottomInset:UIEdgeInsetsZero];
}

- (void) setDataSource:(id<ILButtonsBarDataSource>)dataSource {
    _dataSource = dataSource;
    [self refresh];
}

- (void) refresh {
    [self rebuildButtons];
}

- (UIButton *) buttonAtIndexPath:(NSIndexPath *)indexPath {
    if (self.buttons && indexPath.row < self.buttons.count){
        return self.buttons[indexPath.row];
    }
    return nil;
}

- (void) rebuildButtons {
    
    NSLog(@"%s", __func__);
    
    // clear previous buttons
    if (self.buttons) {
        for (NSUInteger i = 0; i < self.buttons.count; i++ ) {
            [self.buttons[i] removeFromSuperview];
        }
        [self removeConstraints:self.buttonViewConstraints];
    }

    NSMutableArray *views = NSMutableArray.new;
    NSMutableArray *buttons = NSMutableArray.new;
    NSMutableArray *constraints = NSMutableArray.new;
    NSUInteger count = self.dataSource ? [self.dataSource numberOfButtonsForButtonBar:self] : 0;
    for (int i = 0; i < count; i++ ){
        NSIndexPath *thisIndexPath = [NSIndexPath indexPathForRow:i inSection:1];
        UIButton *button = [self.dataSource buttonBar:self buttonForIndexPath:thisIndexPath];
        
        if (!button) { continue; }
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button addTarget:self action:@selector(buttonHit:) forControlEvents:UIControlEventTouchUpInside];

        [buttons addObject:button];
        [views addObject:button];
        
        // add in separator if given one
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(buttonBar:separatorViewRightOfIndexPath:)]) {
            if (i != count-1) {
                UIView *separatorView = [self.dataSource buttonBar:self separatorViewRightOfIndexPath:thisIndexPath];
                [separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
                CGFloat separatorWidth;
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(buttonBar:separatorWidthRightOfIndexPath:)]) {
                    separatorWidth = [self.dataSource buttonBar:self separatorWidthRightOfIndexPath:thisIndexPath];
                }
                else {
                    separatorWidth = 1.0;
                }
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[separator(width)]" options:0 metrics:@{@"width":@(separatorWidth)} views:@{@"separator":separatorView}]];
                [views addObject:separatorView];
                [self addSubview:separatorView];
            }
        }
        
        [self addSubview:button];
    }
    
    if (buttons.count > 0) {
        CGFloat buttonSpacing = self.buttonSpacing;
        UIEdgeInsets inset = self.barInset;
        [constraints addObjectsFromArray: [NSLayoutConstraint constraintsForHorizontalItems:views inView:self withSpacing:buttonSpacing andInset:inset]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsForSameWidthItems:buttons]];
    }
    
    if (constraints) {
        [self addConstraints:constraints];
        self.buttons = buttons;
        self.buttonViewConstraints = constraints;
    }
}


- (void)buttonHit:(id)sender {
    NSUInteger index = [self.buttons indexOfObject:sender];
    if (index == NSNotFound) {
        [NSException raise:@"Invalid Button" format:@"Cannot find button in buttons list \" %@\"", sender];
    } else {
        [self buttonHitWithIndex:index];
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonBar:buttonTappedWithIndex:)]) {
            [self.delegate buttonBar:self buttonTappedWithIndex:index];
        }
    }
}

- (void) buttonHitWithIndex:(NSInteger)index {
    // override
}

#pragma mark ILButtonsBar Delegate default implementation

-  (UIButton *) buttonBar:(id)sender buttonForIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (NSUInteger) numberOfButtonsForButtonBar:(id)sender {
    // FIXME: for testing
    return 0;
}



@end
