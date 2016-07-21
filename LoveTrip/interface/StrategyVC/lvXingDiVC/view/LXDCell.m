//
//  LXDCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LXDCell.h"

@interface LXDCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end
@implementation LXDCell

-(void)setModel:(LXDModel *)model{
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
    _titleLabel.text = model.name;
    _subTitleLabel.text = model.descriptionStr;
    _countLabel.text = [NSString stringWithFormat:@"%@ 篇游记",model.attraction_trips_count];
    _idStr = model.idStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
