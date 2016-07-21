//
//  LXDCollectionCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LXDCollectionCell.h"
#import "AppDelegate.h"
#import "UILabel+LXAdd.h"
@interface LXDCollectionCell ()

@end
@implementation LXDCollectionCell

-(void)setModel:(LXDImageModel *)model{
    _model = model;

    _desLabel.text = model.descriptionStr;
    if(_desLabel.text!=nil){
        //行间距
        _desLabel.lineSpace = 2;
        //字间距
        _desLabel.characterSpace = 1;
        [_desLabel getLableSizeWithMaxWidth:_desLabel.frame.size.width];
    }
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.photo_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
}

@end
