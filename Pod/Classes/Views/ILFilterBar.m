//
//  ILFilterBar.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/9/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "ILFilterBar.h"
#import "ILButtonsBarPrivate.h"

@interface ILFilterBar ()

@property (nonatomic, strong) NSMutableArray *buttonStates;

@end


@implementation ILFilterBar

@dynamic delegate;
@dynamic dataSource;


- (id) initWithButtonSpacing:(CGFloat)spacing andTopBottomInset:(UIEdgeInsets)inset {
    if (self = [super initWithButtonSpacing:spacing andTopBottomInset:inset]) {
        self.buttonStates = NSMutableArray.new;
    }
    return self;

}
- (id) init {
    return [self initWithButtonSpacing:0 andTopBottomInset:UIEdgeInsetsZero];
}

/** refresh is called when the user wants to rebuild the button bar, so we allocate the buttonStates array and reset */
- (void) refresh {
    [super refresh];
    self.buttonStates = [[NSMutableArray alloc]initWithCapacity:self.buttons.count];
    // Insert items into the array, we can't use refreshFilters here because there's nothing in the buttonStates right now
    for (int i = 0; i < self.buttons.count; i++) {
        self.buttonStates[i] = @(NO);
    }
    [self refreshButtonFilterState];
}


- (void) resetFilters {
    for (int i = 0; i < self.buttonStates.count; i++) {
        self.buttonStates[i] = @(NO);
    }
    [self refreshButtonFilterState];
}


- (void) refreshButtonFilterState {
    UIControlState controlState;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(filterBar:setButton:forControlState:)]) {
        BOOL buttonsOff = [self buttonsAreAllOff];
        for (int i = 0; i < self.buttons.count; i++) {
            if (buttonsOff) {
                controlState = UIControlStateNormal;
            } else {
                controlState = [self.buttonStates[i] boolValue] ? UIControlStateSelected : UIControlStateDisabled;
            }
            [self.dataSource filterBar:self setButton:self.buttons[i] forControlState:controlState];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterBar:filterStateChanged:)]) {
        [self.delegate filterBar:self filterStateChanged:self.buttonStates];
    }
}

- (BOOL) buttonsAreAllOff {
    for (int i = 0; i < self.buttonStates.count; i++) {
        if ([self.buttonStates[i] boolValue]) {
            return false;
        }
    }
    return true;
}

- (void)buttonHitWithIndex:(NSInteger)index {
    if ([self.buttonStates[index] boolValue] == ILFilterButtonStateOff) {
        self.buttonStates[index] = @(ILFilterButtonStateOn);
    } else {
        self.buttonStates[index] = @(ILFilterButtonStateOff);
    }
    [self refreshButtonFilterState];
}



- (ILFilterButtonState) getStateForButtonIndex:(NSIndexPath *)indexPath {
    return [self.buttonStates[indexPath.row] boolValue];
}


@end
