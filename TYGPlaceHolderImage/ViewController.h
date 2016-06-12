//
//  ViewController.h
//  TYGPlaceHolderImage
//
//  Created by 谈宇刚 on 16/6/1.
//  Copyright © 2016年 tanyugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *image100;
@property (weak, nonatomic) IBOutlet UIImageView *image101;
@property (weak, nonatomic) IBOutlet UIImageView *image102;

@property (weak, nonatomic) IBOutlet UIImageView *image200;
@property (weak, nonatomic) IBOutlet UIImageView *image201;
@property (weak, nonatomic) IBOutlet UIImageView *image202;

@property (weak, nonatomic) IBOutlet UIImageView *image300;
@property (weak, nonatomic) IBOutlet UIImageView *image301;
@property (weak, nonatomic) IBOutlet UIImageView *image302;
@property (weak, nonatomic) IBOutlet UIImageView *image303;

- (IBAction)buttonClick:(UIButton *)sender;
@end

