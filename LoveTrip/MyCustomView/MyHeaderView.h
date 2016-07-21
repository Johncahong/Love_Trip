//
//  MyHeaderView.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeaderView : UIView


@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIButton *leftBtn;
@property (strong,nonatomic)UIButton *rightBtn;

@end
//定义一个协议
@protocol MyViewDelegate <NSObject>
@required //必须实现的方法


@optional //可选实现的方法
- (void)buttonActionOf:(UIButton*)btn;
- (void)buttonAction:(UIButton*)btn;
@end
