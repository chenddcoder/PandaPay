//
//  BenefitView.h
//  PandaPay
//
//  Created by chendd on 2017/2/28.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BenefitView : UIView
+(instancetype)benefitView;
-(void)addMenuClickCallBack:(void(^)(int index))callback;
@end
