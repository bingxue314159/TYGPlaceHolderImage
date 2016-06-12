//
//  UIImageView+TYGPlaceholder.m
//  TYGPlaceHolderImage
//
//  Created by 谈宇刚 on 16/6/1.
//  Copyright © 2016年 tanyugang. All rights reserved.
//

#import "UIImageView+TYGPlaceholder.h"
#import "TYGPlaceholderHelper.h"

@implementation UIImageView (TYGPlaceholder)

- (void)fillWithPlaceholderImage{
    
    self.image = [[TYGPlaceholderHelper sharedInstance] placeholderImageWithSize:self.frame.size];
}

- (void)fillWithPlaceholderImageAndFillColor:(UIColor *)fillColor{
    
    self.image = [[TYGPlaceholderHelper sharedInstance] placeholderImageWithSize:self.frame.size fillColor:fillColor];
}

- (void)fillWithPlaceholderImageWithCellImage:(UIImage *)cellImage cellImageScale:(CGFloat)cellImageScale fillColor:(UIColor *)fillColor{
    self.image = [[TYGPlaceholderHelper sharedInstance] placeholderImageWithSize:self.frame.size cellImage:cellImage cellImageScale:cellImageScale fillColor:fillColor];
}

- (void)fillWithPlaceholderImageAndText:(NSString *)text{
    
    self.image = [[TYGPlaceholderHelper sharedInstance] placeholderImageWithSize:self.frame.size text:text];
}

- (void)fillWithPlaceholderImageAndText:(NSString *)text fillColor:(UIColor *)fillColor{
    
    self.image = [[TYGPlaceholderHelper sharedInstance] placeholderImageWithSize:self.frame.size text:text fillColor:fillColor];
}

@end
