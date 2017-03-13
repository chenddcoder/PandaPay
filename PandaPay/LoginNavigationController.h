//
//  LoginNavigationController.h
//  PandaPay
//
//  Created by chendd on 2017/2/24.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    LoginState_None=0,//初始状态，不做任何处理，等价取消登录
    LoginState_Success,//登录成功，包括注册成功自动登录，登录失败状态不需要传递，因为登录失败停在此页面
    LoginState_Visit,//游客模式
    LoginState_Benefit,//找优惠
}LoginState;
typedef void(^LoginCallBack) (LoginState);
@interface LoginNavigationController : UINavigationController
//登录采用模态处理，使用block返回处理结果
@property (nonatomic, copy) LoginCallBack loginCallBack;
@end
