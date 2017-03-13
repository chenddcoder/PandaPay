//
//  MenuViewController.m
//  PandaPay
//
//  Created by chendd on 2017/3/1.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) NSArray * imageArray;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArray=@[@"钱包",@"设备",@"消息",@"帮助",@"反馈",@"设置"];
    self.imageArray=@[@"Pocket",@"Device",@"Message",@"Help",@"Reply",@"Setting"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * menuIdentifier=@"menuIdentifier";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:menuIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] init];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        
    }
    cell.imageView.image=[UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text=self.titleArray[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //实现菜单功能
    if (self.menuClickedCallBack) {
        self.menuClickedCallBack(indexPath.row);
    }
}
- (IBAction)signIn:(id)sender {
    NSLog(@"签到");
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
