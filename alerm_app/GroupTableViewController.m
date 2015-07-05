//
//  GroupTableViewController.m
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "GroupTableViewController.h"
#import "GroupDetailViewController.h"

@interface GroupTableViewController ()

@end

@implementation GroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    mtArray = [NSMutableArray array];
    idArray = [NSMutableArray array];
    
    NSString *url = @"http://175.184.46.172/server/groupsTable.php";
    NSString *param = [NSString stringWithFormat:@"data1=%d", 1];
    
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
    
    for(int i = 0;i < [array count];i++){
        NSString *encode_msg = [[array valueForKeyPath:@"name"] objectAtIndex:i];
        NSString *encode_id = [[array valueForKeyPath:@"id"] objectAtIndex:i];
        NSLog(@"%@", [encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        [mtArray addObject:[encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [idArray addObject:[encode_id stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [self.myTableView setBackgroundColor:[UIColor clearColor]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mtArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    for(int j=0;j<mtArray.count;j++){
        if(indexPath.row == j){
            cell.textLabel.text = [mtArray objectAtIndex:j];
        }
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    for(int a = 0; a < idArray.count; a++){
        if(indexPath.row == a){
            
            groupid = [[idArray objectAtIndex:a] intValue];
            [self performSegueWithIdentifier:@"showDetail" sender:self];
        }
    }
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showDetail"]){
        GroupDetailViewController *view = (GroupDetailViewController*)[segue destinationViewController];
        view.userid = 1;
        view.groupid = groupid;
        
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
