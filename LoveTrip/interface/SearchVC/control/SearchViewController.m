//
//  SearchViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "SearchCollectionCell.h"
#import "SearchDetailVC.h"

@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

typedef enum {
    NSSegmentZore     = 0,
    NSSegmentOne      = 1,
    NSSegmentTwo      = 2,
    NSSegmentThree    = 3,
    NSSegmentFour     = 4,
}NSSegment;
@property (assign, nonatomic) NSSegment segment_index;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * dataChaiaArr;
@property (nonatomic, strong) NSArray * monthArr;
@property (nonatomic, strong) UIView  *grayView;
@property (nonatomic,   copy) NSString *name;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation SearchViewController

#pragma mark --- 懒加载
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (NSMutableArray *)dataChaiaArr{
    if (!_dataChaiaArr) {
        _dataChaiaArr = [[NSMutableArray alloc]init];
    }
    return _dataChaiaArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUI];
    [self networkState];
}

#pragma mark --- 分段选择器（国内、国外、季节）
- (IBAction)segmentAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.segment_index = NSSegmentZore;
    }else if (sender.selectedSegmentIndex == 1){
        self.segment_index = NSSegmentOne;
    }else{
        self.segment_index = NSSegmentTwo;
    }
    [self segmentRun];
}
- (void)segmentRun{
    [self networkState];
}
#pragma mark ---网络请求相关
//判断网络状态
-(void)networkState{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    //设置一个回调block,当网络状态发生变化的时候就会回调以下block
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //创建弹出视图
            UIAlertController *ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络有误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel  =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [ale addAction:cancel];
            [self presentViewController:ale animated:YES completion:nil];
        }else{
            //检测有网络，进行网络请求数据
            [self getRequest];
        }
    }];
}

-(void)getUI{
     self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.translucent = NO;
    self.monthArr = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.title = @"搜索";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)getRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:KSearchURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.dataArr.count!=0) {
            [self.dataArr removeAllObjects];
        }
        if (self.dataChaiaArr.count!=0) {
            [self.dataChaiaArr removeAllObjects];
        }
        for (NSDictionary *dic in responseObject) {
            
            //国内
            if ([dic[@"category"]isEqualToString:@"1"]||[dic[@"category"]isEqualToString:@"2"]||[dic[@"category"]isEqualToString:@"3"]) {
                NSArray *arr = dic[@"destinations"];
                for (NSDictionary *dict in arr) {
                    SearchModel *model = [SearchModel new];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataArr addObject:model];
                }
            //国外
            }else{
                NSArray *arr1 = dic[@"destinations"];
                for (NSDictionary *dict1 in arr1) {
                    SearchModel *model = [SearchModel new];
                    [model setValuesForKeysWithDictionary:dict1];
                    [self.dataChaiaArr addObject:model];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"内容下载失败error:%@",error);
    }];
    
}


#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.segment_index == NSSegmentZore) {
        return self.dataArr.count;
    }else if(self.segment_index == NSSegmentOne){
        return self.dataChaiaArr.count;
    }else{
        return self.monthArr.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionCell" forIndexPath:indexPath];
    //设置边框颜色
    cell.view.layer.borderColor = [UIColor grayColor].CGColor;
    cell.view.layer.borderWidth = 0.5;
    //设置圆弧
    cell.view.layer.masksToBounds = YES;
    cell.view.layer.cornerRadius = 7;

    if (self.segment_index == NSSegmentZore) {
        SearchModel *model = self.dataArr[indexPath.row];
        cell.textLabel.text = model.name_zh_cn;
    }else if (self.segment_index == NSSegmentOne){
        SearchModel *model = self.dataChaiaArr[indexPath.row];
        cell.textLabel.text = model.name_zh_cn;
    }else  if(self.segment_index == NSSegmentTwo){
        cell.textLabel.text = self.monthArr[indexPath.row];
    }
    
    return cell;
}
//返回cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(((ScreenWidth - 30)/3), 43);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchDetailVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailVC"];
    if (self.segment_index == NSSegmentZore) {
        SearchModel *model = self.dataArr[indexPath.row];
        self.name = model.name_zh_cn;
    }else if (self.segment_index == NSSegmentOne){
        SearchModel *model = self.dataChaiaArr[indexPath.row];
        self.name = model.name_zh_cn;
    }else  if(self.segment_index == NSSegmentTwo){
        self.name = self.monthArr[indexPath.row];
    }

    vc.searchName = self.name;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar becomeFirstResponder];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchDetailVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailVC"];
    vc.searchName = searchBar.text;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//当searchbar开始编辑时，创建一个蒙层View，便于收键盘
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.grayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0.3;
    [self.view addSubview:self.grayView];
    //添加一个手势在蒙层View上，收键盘
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.grayView addGestureRecognizer:tap];
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.grayView removeFromSuperview];//-------yes
}
#pragma mark -- 收键盘触发事件
- (void)hideKeyBoard{
    [self.searchBar resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
