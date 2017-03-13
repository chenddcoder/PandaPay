//
//  CustomButton.m
//  PandaPay
//
//  Created by chendd on 2017/3/8.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(void)awakeFromNib{
    [super awakeFromNib];
    //    self.layer.cornerRadius=4;
    //    self.clipsToBounds=YES;
    self.titleLabel.textColor=[UIColor whiteColor];
    [self setBackgroundImage:[UIImage imageNamed:@"button_default"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"button_highlight"] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"button_disable"] forState:UIControlStateDisabled];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
