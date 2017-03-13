//
//  VerifyCodeViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/24.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "UnderLineTextField.h"
@interface VerifyCodeViewController ()
@property (weak, nonatomic) IBOutlet UnderLineTextField *VerifyTF;
@property (nonatomic, strong) NSTimer * getVerifyCodeTimer;

@end

@implementation VerifyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.VerifyTF.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pin"]];
    self.VerifyTF.leftViewMode=UITextFieldViewModeAlways;
    UIButton * getVerifyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [getVerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerifyBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [getVerifyBtn setTitleColor:[UIColor colorWithRed:0 green:0.6 blue:1 alpha:1] forState:UIControlStateNormal];
    [getVerifyBtn setTitleColor:[UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [getVerifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    getVerifyBtn.frame=CGRectMake(0, 0, 120, 30);
    [getVerifyBtn addTarget:self action:@selector(getVerifyCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.VerifyTF.rightView=getVerifyBtn;
    self.VerifyTF.rightViewMode=UITextFieldViewModeAlways;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //此处处理一些资源释放
    if (self.getVerifyCodeTimer) {
        [self.getVerifyCodeTimer invalidate];
        self.getVerifyCodeTimer=nil;
    }
}
- (IBAction)nextClicked:(id)sender {
    [self performSegueWithIdentifier:@"SetPassSegue" sender:nil];
}
-(void)getVerifyCodeClicked:(id)sender{
    UIButton * btn=(UIButton*)self.VerifyTF.rightView;
    //启动定时器，倒计时
    __block int count=60;
    self.getVerifyCodeTimer= [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        count--;
        NSLog(@"timer=%d",count);
        [btn setTitle:[NSString stringWithFormat:@"%ds后再次获取",count] forState:UIControlStateDisabled];
        if (btn.enabled) {
            btn.enabled=NO;
        }
        if (count==0) {
            //停止定时器
            [timer invalidate];
            timer=nil;
            //修改button可以点击
            btn.enabled=YES;
        }
        
    }];
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
