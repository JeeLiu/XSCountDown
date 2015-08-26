//
//  XSCountDownButton.m
//  XSCountDown
//
//  Created by jcliuzl on 15/8/26.
//  Copyright (c) 2015年 jcliuzl. All rights reserved.
//

#import "XSCountDownButton.h"

@interface XSCountDownButton () {
    DidCountChangedBlock    _didChangedBlock;
    DidCountFinishedBlock   _didFinishedBlock;
    TouchUpInsideBlock      _touchedBlock;
}

@property (assign) int second;
@property (assign) int totalSecond;

@end


@implementation XSCountDownButton

#pragma mark - add handler

- (void)addToucheHandler:(TouchUpInsideBlock)touchHandler {
    _touchedBlock = [touchHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(XSCountDownButton*)sender{
    if (_touchedBlock) {
        _touchedBlock(sender,sender.tag);
    }
}

#pragma mark - block

- (void)didChanged:(DidCountChangedBlock)didChangedBlock{
    _didChangedBlock = [didChangedBlock copy];
}

- (void)didFinished:(DidCountFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}

#pragma mark - countdown

- (void)startCountWithSecond:(int)second{
    self.totalSecond = second;
    self.second = second;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStartCountDown:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

-(void)timerStartCountDown:(NSTimer *)theTimer {
    if (_second == 1) {
        [self stopCount];
    } else {
        _second--;
        if (_didChangedBlock) {
            [self setTitle:_didChangedBlock(self,_second) forState:UIControlStateNormal];
        } else {
            NSString *title = [NSString stringWithFormat:@"%d秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
        }
    }
}

- (void)stopCount{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)]) {
            if ([_timer isValid]) {
                [_timer invalidate];
                _second = _totalSecond;
                if (_didFinishedBlock) {
                    [self setTitle:_didFinishedBlock(self,_totalSecond)forState:UIControlStateNormal];
                } else  {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                }
            }
        }
    }
}

@end
