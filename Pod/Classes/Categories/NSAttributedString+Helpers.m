//
//  NSAttributedString+Helpers.m
//  ILLibrary
//
//  Created by Isaac Liu on 12/7/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "NSAttributedString+Helpers.h"

@implementation NSAttributedString (Helpers)

+(NSMutableAttributedString *) attributedStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat)size andAlignment:(NSTextAlignment)alignment andColor:(UIColor *)color {

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableDictionary *attributes = NSMutableDictionary.new;
    [attributes setObject:[UIFont fontWithName:fontName size:size] forKey:NSFontAttributeName];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = alignment;
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    [attributes setObject:color forKey:NSForegroundColorAttributeName];
    
    [attrString addAttributes:attributes range:NSMakeRange(0, attrString.length)];
    
    return attrString;

}

+ (NSMutableAttributedString *)leftAlignedAttributeStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat) size {
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableDictionary *attributes = NSMutableDictionary.new;
    [attributes setObject:[UIFont fontWithName:fontName size:size] forKey:NSFontAttributeName];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentLeft;
    
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    [attrString addAttributes:attributes range:NSMakeRange(0, attrString.length)];
    
    return attrString;
}

+ (NSMutableAttributedString *)centerAlignedAttributeStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat) size {

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableDictionary *attributes = NSMutableDictionary.new;
    [attributes setObject:[UIFont fontWithName:fontName size:size] forKey:NSFontAttributeName];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    [attrString addAttributes:attributes range:NSMakeRange(0, attrString.length)];
    
    return attrString;
}


+ (NSMutableAttributedString *)rightAlignedAttributeStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat) size {
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableDictionary *attributes = NSMutableDictionary.new;
    [attributes setObject:[UIFont fontWithName:fontName size:size] forKey:NSFontAttributeName];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentRight;
    
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    [attrString addAttributes:attributes range:NSMakeRange(0, attrString.length)];
    
    return attrString;
}

+ (NSMutableAttributedString *)attributedString:(NSString* )string withHorizontalIcon:(UIImage *)icon fontName:(NSString *)fontName fontSize:(CGFloat)size fontColor:(UIColor *)color iconLocation:(ILAttributedStringIconLocation)location textAlignment:(NSTextAlignment) alignment{

    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = icon;
    NSMutableAttributedString *imgAttrString = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init] ;
    [paragraphStyle setAlignment:alignment];
    [imgAttrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [imgAttrString length])];
    
    
    NSMutableAttributedString *myString = [NSAttributedString attributedStringWithString:string andFont:fontName andSize:size andAlignment:alignment andColor:color];
    
    if (location == ILAttributedStringIconLocationLeft || location == ILAttributedStringIconLocationRight) {
        if (location == ILAttributedStringIconLocationLeft) {
            [imgAttrString appendAttributedString:myString];
            
            return imgAttrString;
        } else {
            [myString appendAttributedString:imgAttrString];
            return myString;
        }
    } else {
        [NSException raise:@"Invalid location" format:@"Only IconLocationLeft and IconLocationRight is accepted"];
    }
    return nil;
}


+ (NSMutableAttributedString *)verticalAlignedAttributeStringWithLabel:(NSString *)label withFontName:(NSString *)fontName andFontSize:(CGFloat)size andIcon:(UIImage *)icon {
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = icon;
    NSMutableAttributedString *imgAttrString = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init] ;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [paragraphStyle setAlignment:NSTextAlignmentCenter];            // centers image horizontally
    [imgAttrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [imgAttrString length])];

    NSMutableAttributedString *attrString = [NSAttributedString centerAlignedAttributeStringWithString:[NSString stringWithFormat:@"\n%@", label] andFont:fontName andSize:size];
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init] ;
    paragraphStyle2.lineBreakMode = NSLineBreakByWordWrapping;
    [paragraphStyle2 setAlignment:NSTextAlignmentCenter];            // centers image horizontally
    [paragraphStyle2 setParagraphSpacingBefore:3.0];
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [attrString length])];
    
    [imgAttrString appendAttributedString:attrString];
    return imgAttrString;
    
}



@end
