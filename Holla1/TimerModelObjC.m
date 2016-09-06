//
//  TimerModelObjC.m
//  Holla1
//
//  Created by Kruthika Holla on 9/14/15.
//  Copyright (c) 2015 Kruthika Holla. All rights reserved.
//

#import "TimerModelObjC.h"

@implementation TimerModelObjC

-(id) init{
    self.timerIsActive = FALSE;
    self.lapArray = [NSMutableArray array];
    return self;
}

//MARK: method to calculate time
-(void) timerSetter{
    NSMutableDictionary *timerData = [NSMutableDictionary new];
    NSMutableDictionary *lapTimerData = [NSMutableDictionary dictionary];
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    self.timePassed = currentTime - self.timerStartTime;
    self.lapTimePassed = currentTime - self.lapStartTime;
    NSLog(@"current time: %f", currentTime);
    NSLog(@"timePassed: %f",self.timePassed);
    int minutesPassed = (self.timePassed/60);
    NSLog(@"minutes Passed: %d", minutesPassed);
    [timerData setValue:[NSNumber numberWithInt:minutesPassed] forKey:@"timerMinutes"];
    NSTimeInterval secondsTimePassed = self.timePassed - (NSTimeInterval)(minutesPassed*60);
    int secondsPassed = secondsTimePassed;
    [timerData setValue:[NSNumber numberWithInt:secondsPassed] forKey:@"timerSeconds"];
    NSTimeInterval milliTimePassed = secondsTimePassed - (NSTimeInterval)(secondsPassed);
    int milliSecondsPassed = milliTimePassed*100;
    [timerData setValue:[NSNumber numberWithInt:milliSecondsPassed] forKey:@"timerMilliSeconds"];
    [self.delegate timerDataUpdate:timerData];
    
    
    
    int lapMinutesPassed = (self.lapTimePassed/60);
    [lapTimerData setValue:[NSNumber numberWithInt:lapMinutesPassed] forKey:@"lapTimerMinutes"];
    NSTimeInterval lapSecondsTimePassed = self.lapTimePassed - (NSTimeInterval)(lapMinutesPassed*60);
    int lapSecondsPassed = lapSecondsTimePassed;
    [lapTimerData setValue:[NSNumber numberWithInt:lapSecondsPassed] forKey:@"lapTimerSeconds"];
    NSTimeInterval lapMilliTimePassed = lapSecondsTimePassed - (NSTimeInterval)(lapSecondsPassed);
    int lapMilliSecondsPassed = lapMilliTimePassed*100;
    [lapTimerData setValue:[NSNumber numberWithInt:lapMilliSecondsPassed] forKey:@"lapTimerMilliSeconds"];
    [self.delegate lapTimerDataUpdate:lapTimerData];
    
}

-(void) fireTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerSetter) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.timerStartTime = [NSDate timeIntervalSinceReferenceDate];
    self.lapStartTime = self.timerStartTime;
}

-(void) stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void) resetTimer{
    [self.timer invalidate];
    self.timer = nil;
    [self.lapArray removeAllObjects];
}


-(void) resumeTimer{
    [self fireTimer];
    self.timerStartTime = ([NSDate timeIntervalSinceReferenceDate] - self.timePassed);
    self.lapStartTime = ([NSDate timeIntervalSinceReferenceDate] - self.lapTimePassed);
    
}

-(void) lapButtonPressed : (NSString*) currentLapTime{
    [self.lapArray insertObject:currentLapTime atIndex:0];
    self.lapStartTime += self.lapTimePassed;
   
}


@end


