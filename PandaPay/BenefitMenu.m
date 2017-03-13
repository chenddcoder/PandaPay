//
//  BenefitMenu.m
//  PandaPay
//
//  Created by chendd on 2017/2/28.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "BenefitMenu.h"
#import "BenefitView.h"
@interface BenefitMenu()
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) BenefitView * benefitView;
@end

@implementation BenefitMenu
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super init];
    if (self) {
        //蒙版
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.2f;
        UIGestureRecognizer * gest= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.maskView addGestureRecognizer:gest];
        //惠菜单
        self.benefitView=[BenefitView benefitView];
        self.benefitView.frame=frame;
        self.benefitView.layer.cornerRadius=20;
    }
    return self;
}
-(void)setDidSelectMenuIndex:(void (^)(int))didSelectMenuIndex{
    __weak typeof(self) weakSelf=self;
    [self.benefitView addMenuClickCallBack:^(int index) {
        //点击后消失
        __strong typeof(self) strongSelf=weakSelf;
        [strongSelf dismiss];
        didSelectMenuIndex(index);
    }];
}

-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.benefitView];
    self.benefitView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    self.benefitView.alpha = 0.0f;
    self.maskView.alpha = 0.0f;
    [UIView animateWithDuration:0.15 animations:^{
        self.benefitView.alpha = 1.0;
        self.benefitView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.maskView.alpha = 0.2f;
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.15 animations:^{
        self.benefitView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.benefitView.alpha = 0.0f;
        self.maskView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.maskView removeFromSuperview];
            [self.benefitView removeFromSuperview];
        }
    }];
}
@end
