//
//  LXDDetailCell.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LXDDetailCell.h"
#import "LXDCollectionCell.h"
#import "AppDelegate.h"
#import "MyTapGestureRecognizer.h"
@interface LXDDetailCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collecitnonView_H;

@end

@implementation LXDDetailCell

-(void)setAttmodel:(AttractionModel *)attmodel{
    _attmodel = attmodel;
    
    _titleLabel.text = attmodel.descriptionStr;

    _nameLabel.text = [NSString stringWithFormat:@"@%@",attmodel.trip[@"user"][@"name"]];

    

    if(attmodel.notes.count==0){
        _collecitnonView_H.constant = 0;
    }else{
        //这句话是关键，解决困扰我很久的问题［因为我的collectionView的高度为107，所以这里就设置成107］
        _collecitnonView_H.constant = [AppDelegate getCalculatorValue_Height:107];
    }

    if (![attmodel.trip[@"start_date"] isKindOfClass:[NSNull class]]) {
        _timeLabel.text = attmodel.trip[@"start_date"];
    }


    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.attmodel.notes.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXDCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXDCollectionCell" forIndexPath:indexPath];
    LXDImageModel *model = self.attmodel.notes[indexPath.row];
    cell.model = model;
    
    MyTapGestureRecognizer *tap = [[MyTapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.height = model.height;
    tap.width = model.width;
    cell.imageV.userInteractionEnabled = YES;
    [cell.imageV addGestureRecognizer:tap];
    
    return cell;
}

-(void)tapAction:(MyTapGestureRecognizer *)tap{
    UIImageView *imageV = (UIImageView *)tap.view;
    [self.delegate pushShowVC:imageV.image width:[tap.width intValue] heigth:[tap.height intValue]];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LXDImageModel *model = self.attmodel.notes[indexPath.row];
    CGFloat contentHeight;
    if(model.photo_url !=nil){
        //这里提醒一下，storyboard中collectionView高度需要约束，而这里设置的cgsize却是cell的cgsize，cell的高度不可高于collectionview的view的高度。collectionView的高度可以拉约束来改变
        contentHeight = [AppDelegate getCalculatorValue_Height:105.0];
        CGFloat contentWidth = contentHeight * [model.width intValue] *1.0 / [model.height intValue];
        return CGSizeMake(contentWidth,contentHeight);

    }
    return CGSizeMake(1, contentHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
