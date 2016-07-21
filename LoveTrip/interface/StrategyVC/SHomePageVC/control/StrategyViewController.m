//
//  StrategyViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/4.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "StrategyViewController.h"
#import "CategoryModel.h"
#import "DestinationsModel.h"
#import "CollectionCell.h"
#import "AppDelegate.h"
#import "SDetailViewController.h"
@interface StrategyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *typeArray;
@end

@implementation StrategyViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getUI];
    [self networkState];
}

-(void)getUI{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.navigationItem.title = @"旅行攻略";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    _typeArray = @[@"亚洲",@"欧洲",@"美洲大洋洲非洲与南极洲",@"台港澳",@"大陆"];

}

#pragma mark - 网络数据请求
-(void)getRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:GongLue_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //第一次进来与下拉刷新时需要有－－清空表格2数据和移除数组数据操作
        
        for (NSDictionary *dict in responseObject) {
            
            CategoryModel *model = [[CategoryModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            model.destinations = [[NSMutableArray alloc] init];
            for (NSDictionary *desDict in dict[@"destinations"]) {
                
                DestinationsModel *desmodel = [[DestinationsModel alloc] init];
                [desmodel setValuesForKeysWithDictionary:desDict];
                [model.destinations addObject:desmodel];
            }
            
            [self.dataArray addObject:model];
        }
        
        [_collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"内容下载失败error:%@",error);
    }];
    
}

-(void)networkState{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger startMonitoring];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络有误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [ac addAction:cancel];
            [self presentViewController:ac animated:YES completion:nil];
            NSLog(@"网络有误");
        }else{
            [self getRequest];
        }
    }];
}

#pragma mark - collectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    CategoryModel *model = self.dataArray[section];
    return model.destinations.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    CategoryModel *model = self.dataArray[indexPath.section];
    cell.model = model.destinations[indexPath.row];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5 *1.0/320 *ScreenWidth, 10 *1.0/320 *ScreenWidth, 5 *1.0/320 *ScreenWidth, 10 *1.0/320 *ScreenWidth);
}

//设置cell 最小的列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(145 *1.0/320 *ScreenWidth, [AppDelegate getCalculatorValue_Height:194]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionCell * cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

        cell.textString = _typeArray[indexPath.section];
        
        return cell;
        
    }else{
        
        return nil;
    }
}

#pragma mark - cell传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[SDetailViewController class]]){
        SDetailViewController *dvc = segue.destinationViewController;
        dvc.hidesBottomBarWhenPushed = YES;
        CollectionCell *cell = (CollectionCell *)sender;
        dvc.idStr = [cell idStr];
        dvc.name_zhStr = [cell name_zh_cn];
    }
}


@end
