//
//  TYGPlaceholderHelper.h
//  TYGPlaceHolderImage
//
//  Created by 谈宇刚 on 16/6/1.
//  Copyright © 2016年 tanyugang. All rights reserved.
//
//  生成自定义图片（为UIImageView生成placerholderImage）
//  此份源码来自：https://github.com/albertschulz/DRImagePlaceholderHelper
//  在此基础上改造一下,增加自定义图片功能
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TYGPlaceholderHelper : NSObject

@property (nonatomic, strong) UIImage *cellImage;/**< 默认的填充图片 */
@property (nonatomic, assign) CGFloat cellImageScale;/**< 默认的填充图片的缩放比例 */
@property (nonatomic, strong) UIColor *fillColor;/**< 默认的填充颜色，lightGrayColor */

+ (id)sharedInstance;

/**
 *  纯色，自定义文字
 *  @param size ImageSize
 *  @param text 文字内容(若为nil,则默认为图片尺寸.如:100x200)
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size text:(NSString *)text;

/**
 *  自定义文字，自定义背景色
 *  @param size      ImageSize
 *  @param text      文字内容(若为nil,则默认为图片尺寸.如:100x200)
 *  @param fillColor 背景色
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size text:(NSString *)text fillColor:(UIColor *)fillColor;

/**
 *  图片(默认)
 *  @param size ImageSize
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size;

/**
 *  自定义图片，自定义背景色
 *  @param size             ImageSize
 *  @param fillColor        背景色
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor;


/**
 *  自定义图片
 *  @param size             ImageSize
 *  @param cellImage        中间图片
 *  @param cellImageScale   中间图片的缩放比例
 *  @param fillColor        背景色
 *  @return UIImage
 */
- (UIImage *)placeholderImageWithSize:(CGSize)size cellImage:(UIImage *)cellImage cellImageScale:(CGFloat)cellImageScale fillColor:(UIColor *)fillColor;



@end
