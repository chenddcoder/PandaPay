//
//  JTCardViewController.m
//  PandaPay
//
//  Created by chendd on 2017/3/4.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "JTCardViewController.h"
#import "MainViewController.h"
#import "CardFunctionCell.h"
#define TRANSFORM_TIME 0.4
@interface JTCardViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *cardPlace;
@property (nonatomic, strong) NSArray * cardImageArray;
@property (weak, nonatomic) IBOutlet UIView *cardDetailView;
@property (nonatomic, strong) UIImageView * transImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addCardBtn;
@property (weak, nonatomic) IBOutlet UIImageView *shortIcon;
@property (weak, nonatomic) IBOutlet UIButton *toolKitBtn;
@property (nonatomic, strong) NSArray * cardFunctions;
@end

@implementation JTCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cardImageArray=@[@"YKT",@"YKT2",@"WHT"];
    //给cardPlace添加点击收回
    self.cardPlace.userInteractionEnabled=YES;
    self.cardPlace.layer.cornerRadius=4;
    self.cardPlace.clipsToBounds=YES;
    UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardPlaceTap:)];
    [self.cardPlace addGestureRecognizer:tapGesture];
    //进来时让卡详情隐藏
    [UIView animateWithDuration:0 animations:^{
        //移动至屏幕外
        self.cardDetailView.transform=CGAffineTransformMakeTranslation(0, self.cardDetailView.frame.size.height);
    }];
    self.cardFunctions=@[@"用户指南",@"网点查询",@"查询记录",@"充值",@"优惠活动",@"退卡、退资"];
}
//由于contentMode没有我们想要的效果，因此自定义图片裁剪
//由于是卡片，希望卡片横向填满，上部顶头，因此 根据self.cardPlace.frame的宽高比切除图片下半截
- (UIImage *)cutImage:(UIImage*)originImage withFrame:(CGRect)frame
{
    CGSize newImageSize;
    CGImageRef imageRef = nil;
    CGSize imageViewSize = frame.size;//由于需要使用CGImage，因此使用CGImage的size，这是图片的真实宽高
    CGSize originImageSize = CGSizeMake(CGImageGetWidth(originImage.CGImage), CGImageGetHeight(originImage.CGImage));;
    //不用考虑宽高比是否>1，全部是以横向为准
    newImageSize.width = originImageSize.width;//宽度不变
    newImageSize.height = imageViewSize.height * (originImageSize.width / imageViewSize.width);
    CGRect finalRect= CGRectMake(0, 0, newImageSize.width, newImageSize.height);
    imageRef = CGImageCreateWithImageInRect([originImage CGImage],finalRect);
    UIImage *retImg=[UIImage imageWithCGImage:imageRef];
    return retImg;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cardImageArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifer=@"JTCardIdentifer";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    for (UIView * sub in cell.contentView.subviews) {
        [sub removeFromSuperview];
    }
    UIImageView * cardIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 150.00/240*tableView.frame.size.width)];
    cardIV.image=[self cutImage:[UIImage imageNamed:self.cardImageArray[indexPath.row]] withFrame:cardIV.frame];
    cardIV.layer.cornerRadius=4;
    cardIV.clipsToBounds=YES;
    cell.clipsToBounds=YES;
    
    [cell.contentView addSubview:cardIV];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //动态定制高度
    CGFloat height=44;
    if(indexPath.row==self.cardImageArray.count-1){
        height=150.00/240*tableView.frame.size.width;
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self showCardDetail:indexPath];
}
-(void)cardPlaceTap:(UITapGestureRecognizer*)gesture{
    [self showCardList];
}
-(void)showCardDetail:(NSIndexPath*)indexPath{
    //用动画方式将Image贴到CardPlace上
    //取出ImageView,设计时只有一个Image因此取时用第一个subview
    UITableViewCell * cell=[self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
    UIImageView * imageView=cell.contentView.subviews[0];
    self.transImageView.image=imageView.image;
    self.transImageView.frame=CGRectMake(rectInSuperview.origin.x, rectInSuperview.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    self.transImageView.alpha=1;
    [self.view insertSubview:self.transImageView aboveSubview:self.tableView];
    //需要复制一份到cardPlace中
    MainViewController * mainVC=(MainViewController *)self.parentViewController.parentViewController;
    [UIView animateWithDuration:TRANSFORM_TIME animations:^{
        self.transImageView.frame=self.cardPlace.frame;
        self.tableView.transform=CGAffineTransformMakeTranslation(0,self.view.frame.size.height);//将tableview移除屏幕
        //让卡详情页面弹出来
        self.cardDetailView.transform=CGAffineTransformMakeTranslation(0, 100);
        self.addCardBtn.hidden=YES;
        //隐藏惠菜单
        mainVC.BenefitMenuView.hidden=YES;
    } completion:^(BOOL finished) {
        self.cardPlace.image=self.transImageView.image;
        self.transImageView.alpha=0;
        self.cardPlace.alpha=1;
        [self.transImageView removeFromSuperview];
    }];
    

}
-(void)showCardList{
    //点击后让tableView回到原来的位置
    self.cardPlace.alpha=1;
    MainViewController * mainVC=(MainViewController *)self.parentViewController.parentViewController;
    [UIView animateWithDuration:TRANSFORM_TIME animations:^{
        self.tableView.transform=CGAffineTransformMakeTranslation(0, 0);
        self.cardDetailView.transform=CGAffineTransformMakeTranslation(0, self.cardDetailView.frame.size.height);
        self.cardPlace.alpha=0;
        self.addCardBtn.hidden=NO;
        mainVC.BenefitMenuView.hidden=NO;
    }completion:^(BOOL finished) {
        self.cardPlace.image=nil;
    }];
}
-(UIImageView *)transImageView{
    if (!_transImageView) {
        _transImageView=[[UIImageView alloc] init];
        _transImageView.layer.cornerRadius=4;
        _transImageView.clipsToBounds=YES;
    }
    return _transImageView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cardFunctions.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CardFunctionCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CardFunctionCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    cell.functionLabel.text=self.cardFunctions[indexPath.row];
    return cell;
    
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
