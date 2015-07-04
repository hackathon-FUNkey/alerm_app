//
//  SetTimeViewController.h
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTimeViewController : UIViewController
- (IBAction)BackButtonAction:(id)sender;
- (IBAction)SaveTimeButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;
- (IBAction)changeDate:(id)sender;



@end
