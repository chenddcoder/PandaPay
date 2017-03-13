//
//  MainViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/23.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "MainViewController.h"
#import "BenefitViewController.h"
#import "BenefitMenu.h"
#import "DDNavigationBarMenu.h"
#import "JTCardContainerViewController.h"
#define TRANSFORM_TIME 0.2
@interface MainViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) DDNavigationBarMenu *popMenu;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic, strong) BenefitMenu * benefitMenu;

@property (strong, nonatomic)  UIViewController *ticketVC;
@property (strong, nonatomic)  UIViewController *YLCardVC;
@property (strong, nonatomic)  JTCardContainerViewController *JTCardVC;
@property (nonatomic, strong) UIViewController * currentVC;
@property (nonatomic, strong) NSMutableArray * VCArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //自定义navigationBar
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.alpha=0;
    //自定义SegmentController
    self.segmentControl.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName: [UIColor
                                                                              orangeColor]};
    [self.segmentControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.segmentControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    //设置进入第一个页面
    self.segmentControl.selectedSegmentIndex=1;
    [self segChanged:self.segmentControl];
    //给惠按钮添加响应
    UIGestureRecognizer * recg=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BenefitMenuClicked:)];
    [self.BenefitMenuView addGestureRecognizer:recg];
    //添加边缘右滑打开我的菜单
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
    //添加左右滑
    UISwipeGestureRecognizer * leftSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer * rightSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
}
- (void)edgePanGesture:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint currentPoint;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateChanged:
            currentPoint =[gestureRecognizer locationInView:self.view];
            if (self.edgePanGestureBlock) {
                self.edgePanGestureBlock(currentPoint,NO);
            }
            
            break;
        case UIGestureRecognizerStateEnded:
            currentPoint =[gestureRecognizer locationInView:self.view];
            if (self.edgePanGestureBlock) {
                self.edgePanGestureBlock(currentPoint,YES);
            }
            break;
        default:
            break;
    }
}
-(void)swipeGesture:(UISwipeGestureRecognizer*)gestureRecognizer{
    NSUInteger currentIndex=0;
    switch (gestureRecognizer.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"向左滑");
            //如果当前页面是最左面的则不滑
            currentIndex=[self.VCArray indexOfObject:self.currentVC];
            if (currentIndex!=NSNotFound&&currentIndex<self.VCArray.count-1) {
                UIViewController * nextVC=[self.VCArray objectAtIndex:currentIndex+1];
                [self transitionFromViewController:self.currentVC toViewController:nextVC duration:TRANSFORM_TIME options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                    [self moveToVC:nextVC];
                    self.segmentControl.selectedSegmentIndex=currentIndex+1;
                }];
            }
            break;
        case UISwipeGestureRecognizerDirectionRight:
            
            NSLog(@"向右滑");
            //如果当前页面是最右面的则不滑
            currentIndex=[self.VCArray indexOfObject:self.currentVC];
            if (currentIndex!=NSNotFound&&currentIndex>0) {
                UIViewController * nextVC=[self.VCArray objectAtIndex:currentIndex-1];
                [self transitionFromViewController:self.currentVC toViewController:nextVC duration:TRANSFORM_TIME options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                    [self moveToVC:nextVC];
                    self.segmentControl.selectedSegmentIndex=currentIndex-1;
                }];
            }
            break;
        default:
            break;
    }
}
- (IBAction)BenefitMenuClicked:(id)sender {
    self.benefitMenu=[[BenefitMenu alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-120, self.view.frame.size.height/2-120, 240, 240)];
    __weak typeof(self) weakSelf=self;
    self.benefitMenu.didSelectMenuIndex=^(int index){
        NSLog(@"click=%d",index);
        switch (index) {
            case 0:
                [weakSelf performSegueWithIdentifier:@"BenefitSegue" sender:nil];
                break;
                
            default:
                break;
        }
    };
    [self.benefitMenu show];
}

- (IBAction)segChanged:(id)sender {
    UISegmentedControl * segControl=sender;
    NSString * title=[segControl titleForSegmentAtIndex:segControl.selectedSegmentIndex];
    if ([title isEqualToString:@"卡票券"]) {
        [self transitionFromViewController:self.currentVC toViewController:self.ticketVC duration:TRANSFORM_TIME options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            [self moveToVC:self.ticketVC];
            NSLog(@"进入卡票券页面");
        }];
    }else if([title isEqualToString:@"银联卡"]){
        [self transitionFromViewController:self.currentVC toViewController:self.YLCardVC duration:TRANSFORM_TIME options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            [self moveToVC:self.YLCardVC];
            NSLog(@"进入银联卡页面");
        }];
    }else if([title isEqualToString:@"交通卡"]){
        [self transitionFromViewController:self.currentVC toViewController:self.JTCardVC duration:TRANSFORM_TIME options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            [self moveToVC:self.JTCardVC];
            NSLog(@"进入交通卡页面");
        }];
    }
}
-(void)moveToVC:(UIViewController*)VC{
    self.currentVC=VC;
    if ([self.currentVC respondsToSelector:@selector(refreshView)]) {
        [self.currentVC performSelector:@selector(refreshView)];
        NSLog(@"刷新。。。");
    }
}
-(NSMutableArray *)VCArray{
    if (!_VCArray) {
        _VCArray=[[NSMutableArray alloc] init];
    }
    return _VCArray;
}
- (IBAction)personInfoClicked:(id)sender {
    //可以判断是否需要打开登录窗口，还是显示菜单
    if (self.personInfoClicked) {
        self.personInfoClicked();
    }
}
- (IBAction)ToolKitClicked:(id)sender {
    NSMutableArray *menuItems = [NSMutableArray array];
    //    menuImages = @[@"icon_menu_venue", @"icon_menu_map", @"icon_menu_region", @"icon_menu_search", @"icon_menu_scan"];
    NSArray * menuTitles = @[@"识别卡片", @"切换到手环", @"活动", @"消息", @"设置"];
    for (int i = 0; i < menuTitles.count; i++) {
        DDNavigationBarMenuItem *item = [DDNavigationBarMenuItem navigationBarMenuItemWithImage:nil title:menuTitles[i]];
        [menuItems addObject:item];
    }
    
    self.popMenu = [[DDNavigationBarMenu alloc] initWithOrigin:CGPointMake(self.view.frame.size.width - 125, 64) width:110 ];
    self.popMenu.items = menuItems;
    self.popMenu.didSelectMenuItem=^(DDNavigationBarMenu *menu, DDNavigationBarMenuItem *item){
        NSLog(@"点击了%@",item.title);
    };
    [self.popMenu show];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ticketVCSegue"]){
        self.ticketVC=segue.destinationViewController;
        [self.VCArray addObject:self.ticketVC];
        self.currentVC=self.ticketVC;
    }else if([segue.identifier isEqualToString:@"YLCardVCSegue"]){
        self.YLCardVC=segue.destinationViewController;
        [self.VCArray addObject:self.YLCardVC];
        self.currentVC=self.YLCardVC;
    }else if([segue.identifier isEqualToString:@"JTCardVCSegue"]){
        self.JTCardVC=segue.destinationViewController;
        [self.VCArray addObject:self.JTCardVC];
        self.currentVC=self.JTCardVC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
