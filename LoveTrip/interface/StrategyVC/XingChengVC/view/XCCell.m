//
//  XCCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "XCCell.h"


@interface XCCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imagV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@end

@implementation XCCell


-(void)setModel:(XCModel *)model{
    
    [_imagV sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
    _titleLabel.text = model.name;
    _subTitleLabel.text = [NSString stringWithFormat:@"%@天 /%@个旅行地",model.plan_days_count,model.plan_nodes_count];
    _desLabel.text = model.descriptionStr;
    _idStr = model.IDStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
