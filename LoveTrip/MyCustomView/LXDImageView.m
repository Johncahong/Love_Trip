//
//  LXDImageView.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LXDImageView.h"

@implementation LXDImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNewImageView];
    }
    return self;
}
- (void)createNewImageView{

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-35, self.bounds.size.width-10, 20)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    self.date_countLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-35-28, self.titleLabel.bounds.size.width-10, 20)];
    self.date_countLabel.font = [UIFont systemFontOfSize:15];
    self.date_countLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.date_countLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
