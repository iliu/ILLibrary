//
//  UIButton+Helpers.m
//  ILLibrary
//
//  Created by Isaac Liu on 12/10/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "UIButton+Helpers.h"
#import <Masonry/Masonry.h>

@implementation UIButton (Helpers)

+ (UIButton *) buttonWithImage:(UIImage *)image AttributedString:(NSAttributedString *) attributedString {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [button addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.mas_left).with.offset(10);
        make.top.equalTo(button.mas_top).with.offset(10);
        make.bottom.equalTo(button.mas_bottom).with.offset(-10);
        make.width.equalTo(imageView.mas_height);
    }];
    
    UILabel *buttonLabel = UILabel.new;
    buttonLabel.attributedText = attributedString;
    [button addSubview:buttonLabel];
    [buttonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).with.offset(10);
        make.top.equalTo(imageView.mas_top);
        make.bottom.equalTo(imageView.mas_bottom);
        make.right.equalTo(button).with.offset(-10);
    }];
    
    return button;
}


@end