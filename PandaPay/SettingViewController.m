//
//  SettingViewController.m
//  PandaPay
//
//  Created by chendd on 2017/3/3.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *SettingTV;
@property (nonatomic, strong) NSArray * menuArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuArray=@[@[@"密码设置",@[@"设置支付密码",@"修改账户密码"]],@[@"身份认证",@[@"实名认证"]]];
    self.SettingTV.tableFooterView=[[UIView alloc] init];
    self.SettingTV.sectionHeaderHeight=22;
    self.SettingTV.sectionFooterHeight=22;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.menuArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.menuArray[section][1] count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.menuArray[section][0];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier=@"SettingIdentifier";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text=self.menuArray[indexPath.section][1][indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==1&&indexPath.row==0) {
        //点击实名认证，跳转到实名认证页面
        [self performSegueWithIdentifier:@"AuthSegue" sender:nil];
    }else if(indexPath.section==0&&indexPath.row==0){
        [self performSegueWithIdentifier:@"SetPayPassSegue" sender:nil];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView=[[UIView alloc]init];
    headerView.backgroundColor=[UIColor whiteColor];
    NSString * title=[self tableView:tableView titleForHeaderInSection:section];
    UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.bounds.size.width-30, 22)];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:12];
    label.textColor=[UIColor grayColor];
    label.text=title;
    [headerView addSubview:label];
    //加一个像素的横线
    UIView * sep=[[UIView alloc] initWithFrame:CGRectMake(15, 21, tableView.bounds.size.width-30, 1)];
    sep.backgroundColor=[UIColor colorWithRed:200.00/255 green:199.00/255 blue:204.00/255 alpha:0.5];
    [headerView addSubview:sep];
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
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
