//
//  MyHeaderView.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "MyHeaderView.h"

@implementation MyHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNewView];
    }
    return self;
}
- (void)createNewView{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, ScreenWidth-100, 30)];
    self.titleLabel.center = self.center;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor redColor];
    [self addSubview:self.titleLabel];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(10, 25, 35, 25);
    [self addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(ScreenWidth-60, 25, 35, 25);
    [self addSubview:self.rightBtn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
