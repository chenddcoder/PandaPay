//
//  BenefitView.m
//  PandaPay
//
//  Created by chendd on 2017/2/28.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "BenefitView.h"
@interface BenefitView()
@property (weak, nonatomic) IBOutlet UIImageView *CardBenefitIV;

@property (weak, nonatomic) IBOutlet UIImageView *FindIV;
@property (weak, nonatomic) IBOutlet UIImageView *MoreIV;
@property (weak, nonatomic) IBOutlet UIImageView *MineIV;
@property (nonatomic, copy) void(^clickCallBack) (int);
@end
@implementation BenefitView

+(instancetype)benefitView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BenefitView" owner:self options:nil] firstObject];
}
//约定 上：0， 左：1，下：2，右：3
-(void)addMenuClickCallBack:(void(^)(int))callback{
    self.clickCallBack=callback;
    UIGestureRecognizer * regc0=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UIGestureRecognizer * regc1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UIGestureRecognizer * regc2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UIGestureRecognizer * regc3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    [self.CardBenefitIV addGestureRecognizer:regc0];
    [self.FindIV addGestureRecognizer:regc1];
    [self.MoreIV addGestureRecognizer:regc2];
    [self.MineIV addGestureRecognizer:regc3];
    
}
-(void)clicked:(id)sender{
    UITapGestureRecognizer * gest=sender;
    if (self.clickCallBack) {
        if(gest.view==self.CardBenefitIV){
            self.clickCallBack(0);
        }else if(gest.view==self.FindIV){
            self.clickCallBack(1);
        }else if(gest.view==self.MoreIV){
            self.clickCallBack(2);
        }else if(gest.view==self.MineIV){
            self.clickCallBack(3);
        }
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
