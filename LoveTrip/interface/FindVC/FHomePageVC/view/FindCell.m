//
//  FindCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/5.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "FindCell.h"
@interface FindCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgimagV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;

@end
@implementation FindCell

- (void)awakeFromNib {
    // Initialization code
    
    _bgimagV.layer.cornerRadius = 3;
    _bgimagV.clipsToBounds = YES;
    _bgimagV.contentMode = UIViewContentModeScaleAspectFill;
    
    _iconImgV.layer.cornerRadius = 19;
    _iconImgV.clipsToBounds = YES;
}


-(void)setModel:(FindModel *)model{
    _model = model;
    
    _titleLabel.text = model.name;
    
    [_bgimagV sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"holiday"]];

    _iconImgV.contentMode = UIViewContentModeScaleAspectFill;
    [_iconImgV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"holiday"]];

    _timeLabel.text = [NSString stringWithFormat:@"%@ / %@天 / %@图",model.start_date,model.days,model.photos_count];
    self.idStr = model.idStr;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
