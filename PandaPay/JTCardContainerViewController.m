//
//  JTCardContainerViewController.m
//  PandaPay
//
//  Created by chendd on 2017/3/4.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "JTCardContainerViewController.h"
#import "JTCardViewController.h"
#import "JTNoCardViewController.h"
@interface JTCardContainerViewController ()
@property (nonatomic, strong) JTNoCardViewController * noCardVC;
@property (nonatomic, strong) JTCardViewController * JTCardVC;
@property (nonatomic, strong) UIViewController * currentVC;
@end

@implementation JTCardContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)refreshView{
    //请求服务器得到当前显示的页面是哪一个
    BOOL isHasCard=YES;
    if (isHasCard) {
        NSLog(@"进入有卡页面");
        [self showSubVC:self.JTCardVC];
    }else{
        NSLog(@"进入无卡页面");
        [self showSubVC:self.noCardVC];
    }
}
-(void)showSubVC:(UIViewController*)subVC{
    if (subVC==self.currentVC) {
        return;
    }
    [self transitionFromViewController:self.currentVC toViewController:subVC duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        self.currentVC=subVC;
    }];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NoCardEmbedSegue"]) {
        self.noCardVC=segue.destinationViewController;
        self.currentVC=self.noCardVC;
    }else if([segue.identifier isEqualToString:@"HasCardEmbedSegue"]){
        self.JTCardVC=segue.destinationViewController;
        self.currentVC=self.JTCardVC;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
