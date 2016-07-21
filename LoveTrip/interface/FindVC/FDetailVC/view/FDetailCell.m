//
//  FDetailCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "FDetailCell.h"
#import "FImageModel.h"
#import "UILabel+LXAdd.h"
#import "MyTapGestureRecognizer.h"
@interface FDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *urlImageV;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeIcon_H;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgV_H;

@property(nonatomic,assign)CGFloat retainIcon_H;
@end

@implementation FDetailCell

- (void)awakeFromNib {
    // Initialization code
    _retainIcon_H =_placeIcon_H.constant;
}


-(void)setNodeSubmodel:(FNodesSubModel *)nodeSubmodel{
    

    _commentLabel.text = nodeSubmodel.comment;
    if(_commentLabel.text!=nil){
        //行间距
        _commentLabel.lineSpace = 1;
        //字间距
        _commentLabel.characterSpace = 1;
        [_commentLabel getLableSizeWithMaxWidth:_descLabel.frame.size.width];
    }
    _placeLabel.text = nodeSubmodel.entry_name;
    _placeLabel.userInteractionEnabled = YES;

    if(_placeLabel.text==nil){
        _placeIcon_H.constant = 0;
    }else{
        _placeIcon_H.constant = _retainIcon_H;
    }
    
    _descLabel.text = nodeSubmodel.descriptionStr;
    if(_descLabel.text!=nil){
        //行间距
        _descLabel.lineSpace = 1;
        //字间距
        _descLabel.characterSpace = 1;
        [_descLabel getLableSizeWithMaxWidth:_descLabel.frame.size.width];
    }

    FImageModel *imagemodel = nodeSubmodel.photo[0];
    
    [_urlImageV sd_setImageWithURL:[NSURL URLWithString:imagemodel.url] placeholderImage:[UIImage imageNamed:@"holiday"]];
    _urlImageV.userInteractionEnabled = YES;
    
    if(nodeSubmodel.photo ==nil || [imagemodel.image_height isKindOfClass:[NSNull class]] || [imagemodel.image_width isKindOfClass:[NSNull class]] || imagemodel.image_width == 0){
        _imgV_H.constant = 0;
        
    }else{
    
        _imgV_H.constant =  (([UIScreen mainScreen].bounds.size.width - 20) * [imagemodel.image_height floatValue] *1.0 / [imagemodel.image_width floatValue]);
        
        MyTapGestureRecognizer *tap = [[MyTapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tap.width = imagemodel.image_width;
        tap.height = imagemodel.image_height;
        [_urlImageV addGestureRecognizer:tap]; 
    }
}

-(void)tapAction:(MyTapGestureRecognizer *)tap{
    UIImageView *imageV = (UIImageView *)tap.view;
    if(self.pushShowBlock){
        self.pushShowBlock(imageV.image,[tap.width intValue], [tap.height intValue]);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
