//
//  GuideViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/24.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "GuideViewController.h"
#import "LoginNavigationController.h"
@interface GuideViewController ()
@end

@implementation GuideViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //去掉导航栏
    self.navigationController.navigationBar.hidden=YES;
    
}

- (IBAction)replayClicked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.replayCallBack) {
        self.replayCallBack();
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"LoginSegue"]){
        LoginNavigationController * loginNC=segue.destinationViewController;
        [self setCustomValueInSegue:loginNC];
    }
}
-(void)setCustomValueInSegue:(LoginNavigationController*)loginNC{
    loginNC.loginCallBack=^(LoginState state){
        switch (state) {
            case LoginState_None:
                NSLog(@"用户取消登录");
                break;
            case LoginState_Success:
                NSLog(@"用户登录成功，进入首页");
                [self performSegueWithIdentifier:@"MainSegue" sender:nil];
                break;
            default:
                break;
        }
    };
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
