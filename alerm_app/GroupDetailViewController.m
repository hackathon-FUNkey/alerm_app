//
//  GroupDetailViewController.m
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "GroupDetailViewController.h"

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController
@synthesize userid,groupid;
NSString *currentTime;
bool isChecked;
NSInteger myHour;
NSInteger myMinutes;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    NSLog(@"%d",userid);
    NSLog(@"%d",groupid);
    nameArray = [NSMutableArray array];
    timeArray = [NSMutableArray array];

    
    
    NSString *url = @"http://175.184.46.172/server/groupTime.php";
    NSString *param = [NSString stringWithFormat:@"data1=%d",7];
    
    NSLog(@"Call GroupDetailView DidLoad");
    
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
    NSData* groupData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
 
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:groupData options:NSJSONReadingAllowFragments error:nil];
    //NSLog(@"%@",array);
    for(int i = 0;i < [array count];i++){
        NSString *encode_name = [[array valueForKeyPath:@"name"] objectAtIndex:i];
        NSString *encode_time = [[array valueForKeyPath:@"time"] objectAtIndex:i];
        //NSLog(@"%@", [encode_name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        [nameArray addObject:[encode_name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [timeArray addObject:[encode_time stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [self.myTableView setBackgroundColor:[UIColor clearColor]];
    
    isChecked = NO;
    myHour = 13;
    myMinutes = 37;
    
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
    NSURL *url2 = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url2), &sound);
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return nameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    for(int j=0;j<nameArray.count;j++){
        if(indexPath.row == j){
            NSString *str =
            [NSString stringWithFormat:@"%@\t%@",[nameArray objectAtIndex:j],[timeArray objectAtIndex:j]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@\t\t\t\t\t%@",[nameArray objectAtIndex:j],[timeArray objectAtIndex:j]];
            

        }
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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
    //[self.navigationController popToViewController:GroupTableViewController animated:YES];
    [self performSegueWithIdentifier:@"toTable" sender:self];
}

@end
