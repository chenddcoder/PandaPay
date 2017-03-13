//
//  ContainerViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/28.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "ContainerViewController.h"
#import "MainViewController.h"
#import "MenuViewController.h"
@interface ContainerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuCV;
@property (weak, nonatomic) IBOutlet UIView *mainCV;
@property (nonatomic, strong) MainViewController * mainVC;
@property (nonatomic, strong) MenuViewController * menuVC;
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, assign) BOOL isMenuOpen;
@property (nonatomic, assign) CGPoint swiptBeginPoint;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //让menuVC的位置位于左边界，由于container view获取frame不正确，不知道为什么，因此将去本View的高度
    //宽度固定240px
    self.menuVC.view.frame=CGRectMake(-240, 0, 240, self.view.frame.size.height);
    //设置menuView中的navgationController为mainView的
    __weak typeof(self) weakSelf=self;
    //处理主页面打开我的菜单
    self.mainVC.personInfoClicked=^(){
        [weakSelf openMenu];
    };
    //处理主页面手势，根据右滑手势逐渐改变view的x
    self.mainVC.edgePanGestureBlock=^(CGPoint currentPoint,BOOL isEnded){
        if(!isEnded){
            float offsetX=currentPoint.x;
            [weakSelf moveMenuByOffsetX:offsetX];
        }else{
            //判断菜单x是否大于一半，如果大于则打开菜单
            BOOL isShouldOpenMenu=self.menuVC.view.frame.origin.x>=-120;
            if (isShouldOpenMenu) {
                [weakSelf openMenu];
            }else{
                [weakSelf closeMenu];
            }
        }
    };
    //处理菜单页面点击菜单后的页面操作
    self.menuVC.menuClickedCallBack=^(NSInteger index){
        //需要先push，然后再关闭菜单，2个动画应该是同时进行
        if (index==5) {//设置页面
            [weakSelf.mainVC performSegueWithIdentifier:@"SettingSegue" sender:nil];
        }
        [weakSelf closeMenu];
    };

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"MainEmbedSegue"]) {
        UINavigationController * nav=segue.destinationViewController;
        self.mainVC=(MainViewController*)nav.topViewController;
    }else if([segue.identifier isEqualToString:@"MenuEmbedSegue"]){
        self.menuVC=segue.destinationViewController;
    }
}
-(void)moveMenuByOffsetX:(float)x{
    CGRect NCRect=self.mainVC.navigationController.view.frame;
    CGRect menuRect=self.menuVC.view.frame;
    if (NCRect.origin.x+x>=0&&NCRect.origin.x+x<=240) {
        self.mainVC.navigationController.view.frame=CGRectMake(NCRect.origin.x+x, NCRect.origin.y, NCRect.size.width, NCRect.size.height);
        self.menuVC.view.frame=CGRectMake(menuRect.origin.x+x, menuRect.origin.y, menuRect.size.width, menuRect.size.height);
    }
}

-(void)openMenu{
    if (!self.isMenuOpen) {
        //给mainNC添加蒙版
        self.maskView= [[UIView alloc] initWithFrame:self.view.frame];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.2f;
        UIGestureRecognizer * gest= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu)];
        UIPanGestureRecognizer * pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGueture:)];
        [self.maskView addGestureRecognizer:gest];
        [self.maskView addGestureRecognizer:pan];
        [self.mainVC.view addSubview:self.maskView];
    }
    //计算要移动的距离
    CGRect finalMenuRect= CGRectMake(0, 0, self.menuVC.view.frame.size.width, self.menuVC.view.frame.size.height);
    CGRect finalMainRect=CGRectMake(240, 0, self.mainVC.navigationController.view.frame.size.width, self.mainVC.navigationController.view.frame.size.height);
    //让menuVC从最左端向右移动
    [UIView animateWithDuration:0.2 animations:^{
        self.mainVC.navigationController.view.frame=finalMainRect;
        self.menuVC.view.frame=finalMenuRect;
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.menuCV];
        self.isMenuOpen=YES;
    }];
    
}
-(void)closeMenu{
    if (self.isMenuOpen) {
        //移除蒙版
        [self.maskView removeFromSuperview];
    }
    //计算最终位置
    CGRect finalMenuRect= CGRectMake(-240, 0, self.menuVC.view.frame.size.width, self.menuVC.view.frame.size.height);
    CGRect finalMainRect=CGRectMake(0, 0, self.mainVC.navigationController.view.frame.size.width, self.mainVC.navigationController.view.frame.size.height);
    //让menuVC从当前位置回到左边缘
    [UIView animateWithDuration:0.2 animations:^{
        self.mainVC.navigationController.view.frame=finalMainRect;
        self.menuVC.view.frame=finalMenuRect;
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.mainCV];
        self.isMenuOpen=NO;
    }];
    
}
-(void)panGueture:(UIGestureRecognizer*)gestureRecognizer{
    CGPoint currentPoint;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.swiptBeginPoint=[gestureRecognizer locationInView:self.maskView];
            break;
        case UIGestureRecognizerStateChanged:
            currentPoint =[gestureRecognizer locationInView:self.maskView];
            //计算x偏移
            float offsetX=currentPoint.x-self.swiptBeginPoint.x;
            [self moveMenuByOffsetX:offsetX];
            break;
        case UIGestureRecognizerStateEnded:
            currentPoint =[gestureRecognizer locationInView:self.maskView];
            BOOL isShouldOpenMenu=self.menuVC.view.frame.origin.x>=-120;
            if (isShouldOpenMenu) {
                [self openMenu];
            }else{
                [self closeMenu];
            }
            break;
        default:
            break;
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
