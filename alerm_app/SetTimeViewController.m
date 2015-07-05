//
//  SetTimeViewController.m
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "SetTimeViewController.h"

@interface SetTimeViewController ()

@end

@implementation SetTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackButtonAction:(id)sender {
}

- (IBAction)SaveTimeButtonAction:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.dateFormat = @"HH:mm";
    
    NSString *url = @"http://175.184.46.172/server/timeSave.php";
    NSString *time = [df stringFromDate:self.myDatePicker.date];
    NSString *param = [NSString stringWithFormat:@"data1=%d&data2=%d&data3=%@", 7, 4, time];
    
    NSMutableURLRequest *request;
    request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL: [NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setTimeoutInterval:20];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    [self performSegueWithIdentifier:@"saveTime" sender:self];
}
- (IBAction)changeDate:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.dateFormat = @"HH:mm";
    
    NSLog(@"%@",[df stringFromDate:self.myDatePicker.date]);
}
@end
