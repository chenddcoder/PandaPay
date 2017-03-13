//
//  LoginViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/24.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginNavigationController.h"
#import "UnderLineTextField.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UnderLineTextField *PhoneTF;

@property (weak, nonatomic) IBOutlet UITextField *AlertTF;
@property (weak, nonatomic) IBOutlet UnderLineTextField *PassTF;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置文本框左面的图标
    self.PhoneTF.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pn"]];
    self.PhoneTF.leftViewMode=UITextFieldViewModeAlways;
    self.PassTF.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pwd"]];
    self.PassTF.leftViewMode=UITextFieldViewModeAlways;
    //由于图标文字之间挨的近，调整frame宽度
    UIImageView * alertIV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_alert"]];
    alertIV.contentMode=UIViewContentModeScaleAspectFit;
    self.AlertTF.leftView=alertIV;
    CGRect oriRect=self.AlertTF.leftView.frame;
    self.AlertTF.leftView.frame=CGRectMake(0, 0, oriRect.size.width+10, oriRect.size.height);
    self.AlertTF.leftViewMode=UITextFieldViewModeAlways;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (IBAction)cancleClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    //告知调用者登录取消
    LoginNavigationController * loginNC= (LoginNavigationController*)self.navigationController;
    if (loginNC.loginCallBack) {
        loginNC.loginCallBack(LoginState_None);
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
