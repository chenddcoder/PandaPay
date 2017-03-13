//
//  FingerSignViewController.m
//  PandaPay
//
//  Created by chendd on 2017/3/3.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "FingerSignViewController.h"
#import "LoginNavigationController.h"
#import "LocalAuthentication/LAContext.h"
@interface FingerSignViewController ()
@property (nonatomic, copy) NSString * returnCode;
@end

@implementation FingerSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //右上角添加按钮
    [self checkFinger];
}
-(void)checkFinger{
    self.returnCode=nil;
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"我们需要验证您的指纹来确认你的身份";
    // 判断设备是否支持指纹识别
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        // 指纹识别只判断当前用户是否机主
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    NSLog(@"指纹认证成功");
                                    self.returnCode = @"1";
                                    
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                    NSLog(@"指纹认证失败，%@",error.description);
                                    // 错误码 error.code
                                    // -1: 连续三次指纹识别错误
                                    // -2: 在TouchID对话框中点击了取消按钮
                                    // -3: 在TouchID对话框中点击了输入密码按钮
                                    // -4: TouchID对话框被系统取消，例如按下Home或者电源键
                                    // -8: 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                                    
                                    self.returnCode = [@(error.code) stringValue];
                                    
                                    
                                }
                            }];
        
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        NSLog(@"TouchID设备不可用");
        // TouchID没有设置指纹
        // 关闭密码（系统如果没有设置密码TouchID无法启用）
        
    }
}
- (IBAction)skipClicked:(id)sender {
    //如果是登录页调用，则回调登录页block
    if( [self.navigationController isKindOfClass:[LoginNavigationController class]]){
        [self dismissViewControllerAnimated:NO completion:nil];
        LoginNavigationController * loginNC= (LoginNavigationController*)self.navigationController;
        if (loginNC.loginCallBack) {
            loginNC.loginCallBack(LoginState_Success);
        }
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
