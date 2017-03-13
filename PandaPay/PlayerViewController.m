//
//  PlayerViewController.m
//  PandaPay
//
//  Created by chendd on 2017/2/25.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "GuideViewController.h"
#import "LoginNavigationController.h"
@interface PlayerViewController ()
@property (nonatomic, strong) AVPlayer * player;//播放器
@property (nonatomic, strong) AVPlayerLayer *playerLayer;//播放器层，播放结束时移除
@property (nonatomic, strong) UIButton * skipBtn;//跳过按钮
@property (nonatomic, assign) BOOL isFirstLoad;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //去掉导航栏
    self.navigationController.navigationBar.hidden=YES;
    [self.view.layer addSublayer:self.playerLayer];
    self.isFirstLoad=NO;
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if (self.isFirstLoad) {
        [self playGuideVedio];
    }else{
        [self performWithLoginStatus];
    }
}

-(AVPlayerLayer *)playerLayer{
    if(!_playerLayer){
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:@"启动视频" withExtension:@"mp4"]];
        _player = [AVPlayer playerWithPlayerItem:item];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.frame = self.view.bounds;
    }
    return _playerLayer;
}
-(void)playGuideVedio{
    if (_player) {
        [_player seekToTime:kCMTimeZero];
        [_player play];
    }
    //添加跳过按钮
    _skipBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100, 40, 100, 40)];
    [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [_skipBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipBtn];
    NSLog(@"播放视频");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
-(void)skip:(id)object{
    NSLog(@"点击跳过");
    [_player pause];
    [_skipBtn removeFromSuperview];
    [self dismiss];
    
}
-(void)dismiss{
    NSLog(@"播放结束");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self performWithLoginStatus];
}
-(void)performWithLoginStatus{
    //播放结束时需判断是否已经登录，如果已经登录则直接进入页面，根据实际流程操作
    BOOL isLogin=YES;
    if (isLogin) {
        [self performSegueWithIdentifier:@"MainSegue" sender:nil];
    }else{
        [self performSegueWithIdentifier:@"LoginPreSegue" sender:nil];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"LoginPreSegue"]) {
         //处理重播回调
        GuideViewController * guideVC=segue.destinationViewController;
        [self setCustomValueInLoginPre:guideVC];
    }
}
-(void)setCustomValueInLoginPre:(GuideViewController*)guideVC{
    guideVC.replayCallBack=^(){
        self.isFirstLoad=YES;
    };
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
