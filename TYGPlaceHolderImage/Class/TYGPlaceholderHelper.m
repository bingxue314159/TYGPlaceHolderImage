//
//  TYGPlaceholderHelper.m
//  TYGPlaceHolderImage
//
//  Created by 谈宇刚 on 16/6/1.
//  Copyright © 2016年 tanyugang. All rights reserved.
//

#import "TYGPlaceholderHelper.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation TYGPlaceholderHelper{
    
    NSMutableDictionary *cache;
}


static TYGPlaceholderHelper *sharedObject = nil;

+ (TYGPlaceholderHelper *)sharedInstance{
    
    static dispatch_once_t _singletonPredicate;
    
    dispatch_once(&_singletonPredicate, ^{
        sharedObject = [[super allocWithZone:nil] init];
    });
    
    return sharedObject;
}

+ (id)allocWithZone:(NSZone *)zone{
    
    return [self sharedInstance];
}

- (id)init{
    
    self = [super init];
    if (self) {
        cache = [[NSMutableDictionary alloc] init];
        self.fillColor = [UIColor lightGrayColor];
        self.cellImageScale = 0.5;
    }
    return self;
}

/**
 *  纯色，自定义文字
 *  @param size ImageSize
 *  @param text 文字内容
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size text:(NSString *)text{
    
    UIImage *image = [self placeholderImageWithSize:size text:text fillColor:self.fillColor];
    return image;
}

/**
 *  自定义文字，自定义背景色
 *  @param size      ImageSize
 *  @param text      文字内容
 *  @param fillColor 背景色
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size text:(NSString *)text fillColor:(UIColor *)fillColor{
    
    if (nil == text) {
        text = [NSString stringWithFormat:@"%ld x %ld", (long)size.width, (long)size.height];
    }
    
    UIImage *cachedImage = [self imageCachedForSize:size isHasImage:NO fillColor:fillColor text:text];
    if (!cachedImage) {
        // set the font type and size
        UIFont *font = [UIFont systemFontOfSize:MIN(size.width, size.height) / 5];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContextWithOptions(size,NO,0);
        
        [fillColor setFill];
        UIRectFill(rect);   // Fill it with your color
        
        CGFloat fontColor[4] = {255,6,27,1};
        CGContextSetFillColor(UIGraphicsGetCurrentContext(), fontColor);
        CGContextSetTextDrawingMode(UIGraphicsGetCurrentContext(), kCGTextFill);
        
        CGFloat fontHeight = font.pointSize;
        CGFloat yOffset = (rect.size.height - fontHeight) / 2.0;
        CGRect textRect = CGRectMake(0, yOffset, rect.size.width, fontHeight);
        
        [text drawInRect: textRect withFont: font lineBreakMode:NSLineBreakByTruncatingMiddle
               alignment: NSTextAlignmentCenter];
        
        cachedImage = UIGraphicsGetImageFromCurrentImageContext();
        [self cacheImage:cachedImage isHasImage:NO fillColor:fillColor text:text];
        
        UIGraphicsEndImageContext();
    }
    
    return cachedImage;
}

/**
 *  图片(默认)
 *  @param size ImageSize
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size{
    
    if (nil == self.cellImage) {
        
        self.cellImage = [UIImage imageNamed:@"TYGPlaceholderHelperImage"];
    }
    
    UIImage *image = [self placeholderImageWithSize:size cellImage:self.cellImage cellImageScale:self.cellImageScale fillColor:self.fillColor];
    
    return image;
}

/**
 *  自定义图片，自定义背景色
 *  @param size             ImageSize
 *  @param fillColor        背景色
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor;{
    
    UIImage *image = [self placeholderImageWithSize:size cellImage:self.cellImage cellImageScale:self.cellImageScale fillColor:fillColor];

    return image;
}

/**
 *  自定义中间图片
 *  @param size             ImageSize
 *  @param cellImage        中间图片
 *  @param cellImageScale   中间图片的缩放比例
 *  @param fillColor        背景色
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size cellImage:(UIImage *)cellImage cellImageScale:(CGFloat)cellImageScale fillColor:(UIColor *)fillColor{
    
    NSData *imageData = UIImagePNGRepresentation(cellImage);
    NSString *imageMD5 = [self md5Hash:imageData];
    
    NSString *keyText = [NSString stringWithFormat:@"%.1f%@",cellImageScale,imageMD5];
    UIImage *cachedImage = [self imageCachedForSize:size isHasImage:YES fillColor:fillColor text:keyText];
    if (!cachedImage) {
        // set the font type and size
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContextWithOptions(size,NO,0);
        
        [fillColor setFill];
        UIRectFill(rect);   // Fill it with your color
        
        //水印图
        CGSize cellImageSize = CGSizeZero;
        if (size.width > size.height) {
            CGFloat cellImageH = size.height * cellImageScale;
            CGFloat cellImageW = cellImageH * cellImage.size.width/cellImage.size.height;
            
            cellImageSize = CGSizeMake(cellImageW, cellImageH);
        }
        else{
            CGFloat cellImageW = size.width * cellImageScale;
            CGFloat cellImageH = cellImageW * cellImage.size.height/cellImage.size.width;
            cellImageSize = CGSizeMake(cellImageW, cellImageH);
        }

        CGRect imageRect = CGRectMake((size.width - cellImageSize.width)*0.5, (size.height - cellImageSize.height)*0.5, cellImageSize.width, cellImageSize.height);
        [cellImage drawInRect:imageRect];
        
        
        //从画布中得到image
        cachedImage = UIGraphicsGetImageFromCurrentImageContext();
        [self cacheImage:cachedImage isHasImage:NO fillColor:fillColor text:keyText];
        
        UIGraphicsEndImageContext();
    }
    
    return cachedImage;

}

#pragma mark - 图片缓存
//获取图片缓存
- (UIImage *)imageCachedForSize:(CGSize)size isHasImage:(BOOL)isHasImage fillColor:(UIColor *)color text:(NSString *)text{
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    NSString *key = [NSString stringWithFormat:@"%0.1fx%0.1f|%i|%@|%@", size.width, size.height, isHasImage, colorAsString, text];
    UIImage *cachedImage = [cache objectForKey:key];
    return cachedImage;
}

//缓存图片
- (void)cacheImage:(UIImage *)image isHasImage:(BOOL)isHasImage fillColor:(UIColor *)color text:(NSString *)text{
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    NSString *key = [NSString stringWithFormat:@"%0.1fx%0.1f|%i|%@|%@", image.size.width, image.size.height, isHasImage, colorAsString, text];
    [cache setObject:image forKey:key];
}

/**
 * MD5
 */
- (NSString *)md5Hash:(NSData *)data {
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5([data bytes], (unsigned int)[data length], result);
    
    NSString *newStr = [NSString stringWithFormat:
                        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                        ];

    return newStr;
}


@end
