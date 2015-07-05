//
//  ViewController.m
//  alerm_app
//
//  Created by 河辺雅史 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
NSString *currentTime;
bool isChecked;
NSInteger myHour;
NSInteger myMinutes;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isChecked = NO;
    myHour = 11;
    myMinutes = 6;
    
    // 現在日付を取得
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    // 時・分・秒を取得
    flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:flags fromDate:now];
    NSInteger hour = comps.hour;
    NSInteger minute = comps.minute;
    currentTime = [NSString stringWithFormat:@"%ld時%ld分", hour, minute];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"alarm" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &sound);

    if(!isChecked && hour <= myHour && minute <= myMinutes){
        [self performSelector:@selector(alert) withObject:nil afterDelay:5];
    }
    
    //NSLog([self getCurrentTime]);
    //NSLog([self getMyTime]);
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        isChecked = YES;
        AudioServicesDisposeSystemSoundID(sound);
        NSLog(@"OK");
    }
}

- (void)alert {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"アラーム"
                          message:nil
                          delegate:self
                          cancelButtonTitle:nil otherButtonTitles:nil];
    alert.delegate = self;
    [alert addButtonWithTitle:@"OK"];
    
    // 現在日付を取得
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    // 時・分・秒を取得
    flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:flags fromDate:now];
    NSInteger hour = comps.hour;
    NSInteger minute = comps.minute;
    currentTime = [NSString stringWithFormat:@"%ld時%ld分", hour, minute];
    NSLog(currentTime);
    
    NSString *myTime = [NSString stringWithFormat:@"%ld時%ld分", (long)myHour, (long)myMinutes];
    
    if([currentTime isEqualToString:myTime] && isChecked == NO) {
        NSLog(@"same time");
        AudioServicesPlaySystemSound(sound);
        [alert show];
    }else{
        [self performSelector:@selector(viewDidLoad) withObject:nil afterDelay:5];
    }
}

//- (NSString *)getCurrentTime {
//    // 現在日付を取得
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger flags;
//    NSDateComponents *comps;
//    
//    // 時・分・秒を取得
//    flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    comps = [calendar components:flags fromDate:now];
//    NSInteger hour = comps.hour;
//    NSInteger minute = comps.minute;
//    currentTime = [NSString stringWithFormat:@"%ld時%ld分", hour, minute];
//    
//    return currentTime;
//}
//
//- (NSString *)getMyTime {
//    myHour = 10;
//    myMinutes = 36;
//    //NSString *myTime = [NSString stringWithFormat:@"%d時%d分", myHour, myMinutes];
//    NSString *myTime = [NSString stringWithFormat:@"%d時%d分", myHour, myMinutes];
//    
//    return myTime;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
