//
//  TimerModelObjC.h
//  Holla1
//
//  Created by Kruthika Holla on 9/14/15.
//  Copyright (c) 2015 Kruthika Holla. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DataSourceTimer <NSObject>

//-(void) updateLabel: (NSArray*) timerString;
-(void) timerDataUpdate : (NSDictionary*) timerData;
-(void) lapTimerDataUpdate: (NSDictionary*) lapTimerData;


@end

@interface TimerModelObjC : NSObject

@property (nonatomic) BOOL timerIsActive;
@property (weak, nonatomic) id<DataSourceTimer> delegate;
@property (nonatomic) NSTimeInterval timerStartTime;
@property (nonatomic) NSTimeInterval lapStartTime;

@property (nonatomic) NSTimeInterval timePassed;
@property (nonatomic) NSTimeInterval lapTimePassed;
@property (nonatomic) NSMutableArray* lapArray;
@property (nonatomic, retain) NSTimer *timer;
-(void) fireTimer;
-(void) stopTimer;
-(void) timerSetter;
-(void) resumeTimer;
-(void) resetTimer;
-(void) lapButtonPressed : (NSString*) currentLapTime;


@end
