//
//  XSCountDownButton.h
//  XSCountDown
//
//  Created by jcliuzl on 15/8/26.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import <UIKit/UIKit.h>

//UIButton type要 设置成UIButtonTypeCustom 否则会闪动

@class XSCountDownButton;

typedef NSString* (^DidCountChangedBlock)(XSCountDownButton *countDownButton,int second);
typedef NSString* (^DidCountFinishedBlock)(XSCountDownButton *countDownButton,int second);

typedef void (^TouchUpInsideBlock)(XSCountDownButton *countDownButton,NSInteger tag);

@interface XSCountDownButton : UIButton

@property (nonatomic, strong) NSTimer *timer;

- (void)addToucheHandler:(TouchUpInsideBlock)touchHandler;

- (void)didChanged:(DidCountChangedBlock)didChangedBlock;
- (void)didFinished:(DidCountFinishedBlock)didFinishedBlock;

- (void)startCountWithDispatchSecond:(int)second;
- (void)startCountWithSecond:(int)second;
- (void)stopCount;

@end
