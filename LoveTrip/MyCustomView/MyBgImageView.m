//
//  MyBgImageView.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "MyBgImageView.h"

@implementation MyBgImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNewImageView];
    }
    return self;
}
- (void)createNewImageView{
    self.userIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-20-10-10, 30, 30)];
    self.userIconImageView.clipsToBounds = YES;
    self.userIconImageView.layer.cornerRadius = 15;
    [self addSubview:self.userIconImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, self.bounds.size.height-20-10, self.bounds.size.width-self.userIconImageView.bounds.size.width-25-20, 15)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.titleLabel];
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, self.bounds.size.height-15-10-20+2, self.titleLabel.bounds.size.width-10, 15)];
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    self.dateLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.dateLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
