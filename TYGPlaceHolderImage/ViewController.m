//
//  ViewController.m
//  TYGPlaceHolderImage
//
//  Created by 谈宇刚 on 16/6/1.
//  Copyright © 2016年 tanyugang. All rights reserved.
//

#import "ViewController.h"
#import "TYGPlaceholderHelper.h"
#import "UIImageView+TYGPlaceholder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self drawMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawMainView{
    
    TYGPlaceholderHelper *place = [TYGPlaceholderHelper sharedInstance];
    place.fillColor = [UIColor lightGrayColor];
    place.cellImage = [UIImage imageNamed:@"TYGPlaceholderHelperImage"];

    self.image100.image = [place placeholderImageWithSize:self.image100.frame.size text:nil];
    self.image101.image = [place placeholderImageWithSize:self.image101.frame.size text:nil fillColor:[UIColor grayColor]];
    self.image102.image = [place placeholderImageWithSize:self.image102.frame.size text:nil fillColor:[UIColor grayColor]];
    
    self.image200.image = [place placeholderImageWithSize:self.image200.frame.size text:@"图片还在路上"];
    self.image201.image = [place placeholderImageWithSize:self.image201.frame.size text:@"图片还在路上" fillColor:[UIColor grayColor]];
    self.image202.image = [place placeholderImageWithSize:self.image202.frame.size text:@"图片还在路上" fillColor:[UIColor blackColor]];
    
    self.image300.image = [place placeholderImageWithSize:self.image300.frame.size];
    self.image301.image = [place placeholderImageWithSize:self.image301.frame.size fillColor:[UIColor blueColor]];
    self.image302.image = [place placeholderImageWithSize:self.image302.frame.size cellImage:[UIImage imageNamed:@"TYGPlaceholderHelperImage"] cellImageScale:0.7 fillColor:[UIColor blueColor]];
    
    self.image303.image = [place placeholderImageWithSize:self.image303.frame.size];
}

- (void)drawMainView2{

    [self.image100 fillWithPlaceholderImageAndText:nil];
    [self.image101 fillWithPlaceholderImageAndText:nil fillColor:[UIColor brownColor]];
    [self.image102 fillWithPlaceholderImageAndText:nil fillColor:[UIColor brownColor]];
    
    [self.image200 fillWithPlaceholderImageAndText:@"图片还在路上2"];
    [self.image201 fillWithPlaceholderImageAndText:@"图片还在路上2" fillColor:[UIColor brownColor]];
    [self.image202 fillWithPlaceholderImageAndText:@"图片还在路上2" fillColor:[UIColor brownColor]];

    
    TYGPlaceholderHelper *place = [TYGPlaceholderHelper sharedInstance];
    place.fillColor = [UIColor colorWithRed:0.95 green:0.96 blue:0.97 alpha:1.00];
    place.cellImage = [UIImage imageNamed:@"TYGPlaceholderHelperImage2"];
    
    
    [self.image300 fillWithPlaceholderImage];
    [self.image301 fillWithPlaceholderImageAndFillColor:[UIColor magentaColor]];
    [self.image302 fillWithPlaceholderImageWithCellImage:[UIImage imageNamed:@"TYGPlaceholderHelperImage2"] cellImageScale:0.9 fillColor:[UIColor colorWithRed:0.95 green:0.96 blue:0.97 alpha:1.00]];
    [self.image303 fillWithPlaceholderImage];

}

- (IBAction)buttonClick:(UIButton *)sender {
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([@"plan1" isEqualToString:title]) {
        
        [sender setTitle:@"plan2" forState:UIControlStateNormal];
        [self drawMainView2];
    }
    else{
        [sender setTitle:@"plan1" forState:UIControlStateNormal];
        [self drawMainView];
    }
    
}
@end
