//
//  SearchDetailCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SearchDetailCell.h"

@implementation SearchDetailCell

- (void)awakeFromNib {
    // Initialization code
    _bgImageView.clipsToBounds = YES;
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SearchDetailModel *)model{
    
    
    _model = model;
    self.nameLabel.text = model.name;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ /%@ /%@",model.start_date,model.days,model.photos_count];
    NSDictionary *dic = model.user;
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@"holiday.png"]];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"holiday.png"]];

    CALayer *layer = [self.bgImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:8.0];
    CALayer *layer1 = [self.iconImageView layer];
    [layer1 setMasksToBounds:YES];
    [layer1 setCornerRadius:20.0];
}
@end
