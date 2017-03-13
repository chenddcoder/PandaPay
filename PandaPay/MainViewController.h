//
//  MainViewController.h
//  PandaPay
//
//  Created by chendd on 2017/2/23.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (nonatomic, copy) void(^personInfoClicked)();
@property (nonatomic, copy) void(^edgePanGestureBlock)(CGPoint currentPoint,BOOL isEnded);
@property (weak, nonatomic) IBOutlet UIView *BenefitMenuView;//由于是全局页面按钮，需要在子页面中控制是否显示
@end

