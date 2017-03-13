//
//  RegisterViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/24.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "RegisterViewController.h"
#import "UnderLineTextField.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UnderLineTextField *PhoneTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.PhoneTF.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pn"]];
    self.PhoneTF.leftViewMode=UITextFieldViewModeAlways;
}
- (IBAction)verifyCodeClicked:(id)sender {
    [self performSegueWithIdentifier:@"VerifyCodeSegue" sender:nil];
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
