//
//  AddMemberViewController.h
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMemberViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *mtArray;
    NSMutableArray *flagArray;
}
- (IBAction)BackButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
