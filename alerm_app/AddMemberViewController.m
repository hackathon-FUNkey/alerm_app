//
//  AddMemberViewController.m
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "AddMemberViewController.h"
#import "MakeGroupViewController.h"

@interface AddMemberViewController ()

@end

@implementation AddMemberViewController
@synthesize groupName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    mtArray = [NSMutableArray array];
    flagArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://175.184.46.172/server/usersList.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    
    for(int i = 0;i < [array count];i++){
        NSString *encode_msg = [[array valueForKeyPath:@"name"] objectAtIndex:i];
          NSLog(@"%@", [encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        [mtArray addObject:[encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [flagArray addObject:[NSNumber numberWithInteger:0]];
    }
    NSLog(@"%@",groupName);
    
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
    
    for(int j=0;j<mtArray.count;j++){
    if(indexPath.row == j){
        cell.textLabel.text = [mtArray objectAtIndex:j];
        NSLog(@"%@",[flagArray objectAtIndex:j]);
     }
    }

    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //選択されたセルを取得
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
    cell.accessoryType = UITableViewCellAccessoryNone;
        for(int j=0;j<mtArray.count;j++){
        if(indexPath.row==j){
            [flagArray replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:0]];
        }
     }
    }else{
   cell.accessoryType = UITableViewCellAccessoryCheckmark;
        for(int j=0;j<mtArray.count;j++){
            if(indexPath.row==j){
            [flagArray replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:1]];
            }
        }
     }
    }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"addMember"]){
        MakeGroupViewController *view = (MakeGroupViewController*)[segue destinationViewController];
        view.flagArray = flagArray;
        view.groupName = groupName;
    }
    if ([[segue identifier] isEqualToString:@"moveAddmember"]){
        MakeGroupViewController*view = (MakeGroupViewController*)[segue destinationViewController];
        view.groupName = groupName;
        
    }
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
