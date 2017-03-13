//
//  GuideViewController.h
//  PandaPay
//
//  Created by chendd on 2017/2/24.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReplayCallBack) ();
@interface GuideViewController : UIViewController
@property (nonatomic, copy) ReplayCallBack replayCallBack;
@end
