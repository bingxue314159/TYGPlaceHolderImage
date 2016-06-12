//
//  UIImageView+TYGPlaceholder.h
//  TYGPlaceHolderImage
//
//  Created by 谈宇刚 on 16/6/1.
//  Copyright © 2016年 tanyugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TYGPlaceholder)

- (void)fillWithPlaceholderImage;
- (void)fillWithPlaceholderImageAndFillColor:(UIColor *)fillColor;
- (void)fillWithPlaceholderImageWithCellImage:(UIImage *)cellImage cellImageScale:(CGFloat)cellImageScale fillColor:(UIColor *)fillColor;

- (void)fillWithPlaceholderImageAndText:(NSString *)text;
- (void)fillWithPlaceholderImageAndText:(NSString *)text fillColor:(UIColor *)fillColor;

@end
