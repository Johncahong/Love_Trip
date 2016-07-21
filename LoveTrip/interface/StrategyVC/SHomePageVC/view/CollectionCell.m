//
//  CollectionCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/7.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "CollectionCell.h"

@interface CollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameCnLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameEngLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageV;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end


@implementation CollectionCell

-(void)setModel:(DestinationsModel *)model{
    _nameCnLabel.text = model.name_zh_cn;
    _nameEngLabel.text = model.name_en;
    
    [_ImageV sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
    _numLabel.text = [NSString stringWithFormat:@"旅游地 %@",model.poi_count];
    
    _idStr = model.idStr;
    _name_zh_cn = model.name_zh_cn;
}

//返回组头内容
-(void)setTextString:(NSString *)textString{
    _textLabel.text = textString;
}

@end
