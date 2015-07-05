//
//  AppDelegate.h
//  alerm_app
//
//  Created by 河辺雅史 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#include <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    SystemSoundID sound;
}

@property (strong, nonatomic) UIWindow *window;

@end

