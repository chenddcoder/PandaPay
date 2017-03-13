//
//  MenuViewController.h
//  PandaPay
//
//  Created by chendd on 2017/3/1.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (nonatomic, copy) void(^menuClickedCallBack)(NSInteger index);
@end
