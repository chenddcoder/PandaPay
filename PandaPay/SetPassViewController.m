//
//  SetPassViewController.m
//  PandaPay
//
//  Created by chendd on 2017/3/9.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "SetPassViewController.h"
#import "UnderLineTextField.h"
@interface SetPassViewController ()
@property (weak, nonatomic) IBOutlet UnderLineTextField *PassTF;
@property (nonatomic, strong) UIImageView * passMask;
@property (nonatomic,strong) UIImage * secureYESImg;
@property (nonatomic, strong) UIImage * secureNOImg;
@end

@implementation SetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.PassTF.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pwd"]];
    self.PassTF.leftViewMode=UITextFieldViewModeAlways;
    self.PassTF.secureTextEntry=YES;
    self.secureYESImg=[UIImage imageNamed:@"icon_sp_1"];
    self.secureNOImg=[UIImage imageNamed:@"icon_sp"];
    self.passMask=[[UIImageView alloc]initWithImage:self.secureYESImg];
    self.passMask.userInteractionEnabled=YES;
    UIGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.passMask addGestureRecognizer:tapGesture];
    self.PassTF.rightView=self.passMask;
    self.PassTF.rightViewMode=UITextFieldViewModeAlways;

}
-(void)tap:(id)sender{
    if(self.passMask.image==self.secureYESImg){
        self.passMask.image=self.secureNOImg;
        self.PassTF.secureTextEntry=NO;
    }else{
        self.passMask.image=self.secureYESImg;
        self.PassTF.secureTextEntry=YES;
    }
    
}
- (IBAction)nextClicked:(id)sender {
    [self performSegueWithIdentifier:@"ResetPassSegue" sender:nil];
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
