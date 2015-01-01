//
//  ILImageCache.m
//  draft-iosclient
//
//  Created by Isaac Liu on 11/27/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "ILImageCache.h"
#import <FontAwesomeKit/FAKFontAwesome.h>

static NSMutableDictionary* _ILImageCache;
@implementation ILImageCache

+(NSMutableDictionary *)imageCache {
    if (!_ILImageCache) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _ILImageCache = NSMutableDictionary.new;
        });
    }
    return _ILImageCache;
}

+(UIImage *) getImageForKey: (NSString *)uniqueKey withGenerator: (ILImageCacheImageGenerator) generator {
    NSMutableDictionary* cache = [self imageCache];
    
    UIImage *image = [cache objectForKey:uniqueKey];
    if (image) { return image; }
    
    // missed the cache, call generator
//    NSLog(@"Missed the cache, generating for key: %@", uniqueKey);
    image = generator();
    if (image != nil && ![uniqueKey isEqualToString:@""]) {
        [cache setObject:image forKey:uniqueKey];
    }
    return image;
}


+(void) getImageForPath: (NSURL *)path withCompletionBlock: (void(^)(UIImage *image, NSError *error)) completion {
    [self getImageForPath:path andContext:nil withCompletionBlock:^(UIImage *image, NSError *error, NSDictionary *context) {
        completion(image, error);
    }];
}

+(void) getImageForPath: (NSURL *)path andContext:(NSDictionary *)context withCompletionBlock: (void(^)(UIImage *image, NSError *error, NSDictionary* context)) completion {
    NSMutableDictionary* cache = [self imageCache];
    
    UIImage *image = [cache objectForKey:[path absoluteString]];
    if (image) { completion(image, nil, context); }
    
    // missed the cache, download the image
    NSString *scheme = [path scheme];
    
    if ([scheme isEqualToString:@"file"]) {
        NSString *imageName = [path host];
        NSLog(@"imagename - %@", imageName);
        UIImage *image = [UIImage imageNamed:imageName];
        if (image != nil) {
            [cache setObject:image forKey:[path absoluteString]];
            completion(image, nil, context);
        } else {
            NSString *errorString = [NSString stringWithFormat:@"Cannot find file: %@", [path absoluteString]];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: errorString };
            completion(nil, [NSError errorWithDomain:PocketGMErrorDomain code:4 userInfo:userInfo], context);
        }
    } else if ([scheme isEqualToString:@"http"]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:path];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIImage *image = [UIImage imageWithData:responseObject];
            if (image) {
                [cache setObject:image forKey:[path absoluteString]];
                completion(image, nil, context);
            } else {
                NSString *errorString = [NSString stringWithFormat:@"UIImage imageWIthData Failed: %@", [path absoluteString]];
                NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: errorString };
                completion(nil, [NSError errorWithDomain:PocketGMErrorDomain code:4 userInfo:userInfo], context);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *errorString = [NSString stringWithFormat:@"Download Failed: %@", [path absoluteString]];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: errorString };
            completion(nil, [NSError errorWithDomain:PocketGMErrorDomain code:4 userInfo:userInfo], context);
        }];
        [requestOperation start];
        
    }
    else {
        NSString *errorString = [NSString stringWithFormat:@"Unrecognized protocol: %@", scheme];
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: errorString };
        completion(nil, [NSError errorWithDomain:PocketGMErrorDomain code:4 userInfo:userInfo], context);
    }
}



+(UIImage *) getFAIcon:(NSString *)name withSize:(CGFloat)size andColor:(UIColor *)color {
    NSMutableDictionary* cache = [self imageCache];
    NSString *uniqueKey = [NSString stringWithFormat:@"%@-%d-%@", name, (int)size, [UIColor hexValuesFromUIColor:color]];
    
    UIImage *image = [cache objectForKey:uniqueKey];
    if (image) { return image; }
    
    // missed the cache, call generator
//    NSLog(@"Missed the cache, generating icon for key: %@", uniqueKey);

    NSString *fontAwesomeSelector = [NSString stringWithFormat:@"%@IconWithSize:", name];
    SEL theSelector = NSSelectorFromString(fontAwesomeSelector);
    NSMethodSignature *aSignature = [FAKFontAwesome methodSignatureForSelector:theSelector];
    
    if (!aSignature) {
        [NSException raise:@"Invalid icon" format:@"Cannot find Font Awesome Icon \" %@\"", name];
    }

    // Use an invocation to dynamically call FAKAwesome class methods
    NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:aSignature];
    [anInvocation setSelector:theSelector];
    [anInvocation setTarget:[FAKFontAwesome class]];
    [anInvocation setArgument:&size atIndex:2];
    [anInvocation invoke];

    // http://stackoverflow.com/questions/22018272/nsinvocation-returns-value-but-makes-app-crash-with-exc-bad-access
    FAKFontAwesome * __unsafe_unretained _tmpIcon;
    [anInvocation getReturnValue:&_tmpIcon];
    FAKFontAwesome *_icon = _tmpIcon;
    
    if (_icon) {
        [_icon addAttribute:NSForegroundColorAttributeName value:color];
        image = [_icon imageWithSize:CGSizeMake(size, size)];
    } else {
        [NSException raise:@"Invalid icon" format:@"inovacation failed \" %@\"", name];
    }
    
    if (image != nil && ![uniqueKey isEqualToString:@""]) {
        [cache setObject:image forKey:uniqueKey];
    }
    return image;
}


@end
