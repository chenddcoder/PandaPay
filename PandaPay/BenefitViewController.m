//
//  BenefitViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/24.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "BenefitViewController.h"
@interface BenefitViewController ()<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDC;

@end

@implementation BenefitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden=NO;
    //自定义右面定位菜单
    UIBarButtonItem * addrBtn=[[UIBarButtonItem alloc] initWithTitle:@"北京 ∨" style:UIBarButtonItemStyleDone target:self action:@selector(selectAddr:)];
    self.navigationItem.rightBarButtonItem=addrBtn;
    //设置searchDC空行显示
    self.searchDC.searchResultsTableView.tableFooterView=[[UIView alloc] init];
}
-(void)selectAddr:(id)object{
    
}
#pragma mark tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
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
