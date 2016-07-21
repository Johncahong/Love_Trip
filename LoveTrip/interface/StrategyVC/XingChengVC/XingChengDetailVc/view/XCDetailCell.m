//
//  XCDetailCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "XCDetailCell.h"
#import "LXDDetailViewController.h"
#import "UILabel+LXAdd.h"
@interface XCDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *memoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageVConstraint_H;
@property (weak, nonatomic) IBOutlet UIImageView *tubiaoImageV;
@end

@implementation XCDetailCell

-(void)setModel:(XCNodeModel *)model{
    
    _model = model;
//因为我的模型已经处理过，把为NSNusll的内容赋值为nil
    //此判断的意义在于对于每组第一个cell（也就是构造出来的cell,只有memo值）里面肯定是没有图片的，因此让图片高度约束置为0
    if (model.memo != nil) {
        _tubiaoImageV.image = [UIImage imageNamed:@"CategoryIcon12.png"];
        _placeLabel.text = @"今日备忘";
        _tipLabel.text = model.tips;
        
        _memoLabel.text = model.memo;
        if(_memoLabel.text!=nil){
            //行间距
            _memoLabel.lineSpace = 2;
            //字间距
            _memoLabel.characterSpace = 1;
            [_memoLabel getLableSizeWithMaxWidth:_tipLabel.frame.size.width];
        }
        _imageVConstraint_H.constant = 0;
        
    }else{
        //正常的cell肯定是没有memo值的
        _tubiaoImageV.image = [UIImage imageNamed:@"CTNBillTypeTraffic.png"];
        _placeLabel.text = [NSString stringWithFormat:@"第%d站: %@", [model.position intValue]+1 ,model.entry_name];
        //
        _memoLabel.text = model.memo;
        
        //这里用来调行间距和列间距
        _tipLabel.text = model.tips;
        if(_tipLabel.text!=nil){
            //行间距
            _tipLabel.lineSpace = 2;
            //字间距
            _tipLabel.characterSpace = 1;
            [_tipLabel getLableSizeWithMaxWidth:_tipLabel.frame.size.width];
        }

        if(model.image_url!=nil){
            [_imageV sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
            
            _imageVConstraint_H.constant = (([UIScreen mainScreen].bounds.size.width - 20) * 0.522);
            
            _imageV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [_imageV addGestureRecognizer:tap];
        }else{
            _imageVConstraint_H.constant = 0;
        }

    }
    
}

- (void)tapAction:(UITapGestureRecognizer*)tap{

    [_delegate pushVC:_model.entry_id];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
