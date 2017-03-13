//
//  BenefitMenu.h
//  PandaPay
//
//  Created by chendd on 2017/2/28.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BenefitMenu : NSObject
@property (nonatomic, copy) void(^didSelectMenuIndex)(int index);
-(instancetype)initWithFrame:(CGRect)frame;
- (void)show;
- (void)dismiss;
@end
