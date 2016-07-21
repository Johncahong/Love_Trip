//
//  STableViewCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/7.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "STableViewCell.h"
#import "XCButton.h"
@interface STableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet XCButton *xcBtn;
@property (weak, nonatomic) IBOutlet XCButton *lxdBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation STableViewCell


-(void)setModel:(SDetailModel *)model{
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
    
    _xcBtn.btnId = model.idStr;
    _xcBtn.btn_name_zhStr = model.name_zh_cn;
    
    _lxdBtn.btnId = model.idStr;
    _lxdBtn.btn_name_zhStr = model.name_zh_cn;
    
    if([model.name_zh_cn isEqualToString:_titleName]){
        _nameLabel.text = [NSString stringWithFormat:@"%@概览",model.name_zh_cn];
    }else{
        _nameLabel.text = model.name_zh_cn;
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
