//
//  ViewController.m
//  XSCountDown
//
//  Created by jcliuzl on 15/8/26.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "ViewController.h"
#import "XSCountDownButton.h"

@interface ViewController ()

@property (nonatomic, strong) XSCountDownButton *countButton1;
@property (nonatomic, weak) IBOutlet XSCountDownButton *countButton2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self addCountDownModel];
}

- (void)addCountDownModel {
    
    self.countButton1 = [XSCountDownButton buttonWithType:UIButtonTypeCustom];
    _countButton1.frame = CGRectMake(50, 100, 200, 32);
    [_countButton1 setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    _countButton1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_countButton1];
    
    [_countButton1 addToucheHandler:^(XSCountDownButton *countDownButton, NSInteger tag) {
        countDownButton.enabled = NO;
        [countDownButton startCountWithSecond:10];
        
        [countDownButton didChanged:^NSString *(XSCountDownButton *countDownButton, int second) {
            NSString *title = [NSString stringWithFormat:@"%2d秒后重新获取",second];
            return title;
        }];
        
        [countDownButton didFinished:^NSString *(XSCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"点击获取验证码";
        }];
    }];
}

- (IBAction)didStoryBoardTouched:(XSCountDownButton *)button {
    button.enabled = NO;
    
    [button startCountWithSecond:20];
    
    [button didChanged:^NSString *(XSCountDownButton *countDownButton, int second) {
        NSString *title = [NSString stringWithFormat:@"%2d秒后重新获取",second];
        return title;
    }];
    
    [button didFinished:^NSString *(XSCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"点击获取验证码";
    }];
}

- (IBAction)didStopCount:(id)sender {
    [self.countButton1 stopCount];
    [self.countButton2 stopCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
