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
    NSLog(@"%@",array);
    for(int i = 0;i < [array count];i++){
        NSString *encode_name = [[array valueForKeyPath:@"name"] objectAtIndex:i];
        NSString *encode_time = [[array valueForKeyPath:@"time"] objectAtIndex:i];
        NSLog(@"%@", [encode_name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        [nameArray addObject:[encode_name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [timeArray addObject:[encode_time stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    for(int j=0;j<timeArray.count;j++){
        if(indexPath.row == j){
            NSString *str =
            [NSString stringWithFormat:@"%@\t%@",[nameArray objectAtIndex:j],[timeArray objectAtIndex:j]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@\t\t\t\t\t%@",[nameArray objectAtIndex:j],[timeArray objectAtIndex:j]];
            

        }
    }
    
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
