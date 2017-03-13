//
//  RepeatPassViewController.m
//  PandaPay
//
//  Created by chendd on 2017/3/9.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "RepeatPassViewController.h"
#import "UnderLineTextField.h"
@interface RepeatPassViewController ()
@property (weak, nonatomic) IBOutlet UnderLineTextField *RepeatTF;
@property (nonatomic, strong) UIImageView * passMask;
@property (nonatomic,strong) UIImage * secureYESImg;
@property (weak, nonatomic) IBOutlet UITextField *alertTF;
@property (nonatomic, strong) UIImage * secureNOImg;
@end

@implementation RepeatPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.RepeatTF.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pwd"]];
    self.RepeatTF.leftViewMode=UITextFieldViewModeAlways;
    self.RepeatTF.secureTextEntry=YES;
    self.secureYESImg=[UIImage imageNamed:@"icon_sp_1"];
    self.secureNOImg=[UIImage imageNamed:@"icon_sp"];
    self.passMask=[[UIImageView alloc]initWithImage:self.secureYESImg];
    self.passMask.userInteractionEnabled=YES;
    UIGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.passMask addGestureRecognizer:tapGesture];
    self.RepeatTF.rightView=self.passMask;
    self.RepeatTF.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView * alertIV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_alert"]];
    alertIV.contentMode=UIViewContentModeScaleAspectFit;
    self.alertTF.leftView=alertIV;
    CGRect oriRect=self.alertTF.leftView.frame;
    self.alertTF.leftView.frame=CGRectMake(0, 0, oriRect.size.width+10, oriRect.size.height);
    self.alertTF.leftViewMode=UITextFieldViewModeAlways;
}
-(void)tap:(id)sender{
    if(self.passMask.image==self.secureYESImg){
        self.passMask.image=self.secureNOImg;
        self.RepeatTF.secureTextEntry=NO;
    }else{
        self.passMask.image=self.secureYESImg;
        self.RepeatTF.secureTextEntry=YES;
    }
    
}
- (IBAction)nextClicked:(id)sender {
    [self performSegueWithIdentifier:@"SetPayPassSegue" sender:nil];
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
