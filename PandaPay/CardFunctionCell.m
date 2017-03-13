//
//  CardFunctionCell.m
//  PandaPay
//
//  Created by chendd on 2017/3/13.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "CardFunctionCell.h"

@implementation CardFunctionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"CardFunctionCell" owner:self options:nil].lastObject;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
