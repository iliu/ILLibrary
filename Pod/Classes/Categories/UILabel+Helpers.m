//
//  UILabel+Helpers.m
//  ILLibrary
//
//  Created by Isaac Liu on 12/31/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "UILabel+Helpers.h"

@implementation UILabel (Helpers)

-(CGSize) contentSize {
    NSMutableParagraphStyle* paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary* attributes = @{NSFontAttributeName: self.font, NSParagraphStyleAttributeName: paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
    return contentSize;
}


@end
