//
//  MakeGroupViewController.h
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeGroupViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
     NSMutableArray *flagArray;
     NSMutableArray *selectNameArray;
    NSString *mytext;
    int count;
}
- (IBAction)BackButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
- (IBAction)inputText:(id)sender;


@property (nonatomic) NSMutableArray *flagArray;
@property (nonatomic) NSString *mytext;

@end
