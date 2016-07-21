//
//  SearchDetailVC.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SearchDetailVC.h"
#import "SearchDetailModel.h"
#import "SearchDetailCell.h"
#import "AppDelegate.h"
#import "FDetailViewController.h"
#import "MBProgressHUD.h"
@interface SearchDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)  MBProgressHUD *MBView;
@property (nonatomic,strong)  UIView *bgview;
@end

@implementation SearchDetailVC

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.self getUI];
    
    [self getUI];
    [self networkState];
    [self addRefresh];
}

-(void)getUI{

    _MBView = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    _MBView.labelText = @"加载中...";
    _MBView.userInteractionEnabled = NO;
    [self.navigationController.view addSubview:_MBView];
    [_MBView show:YES];

    self.navigationItem.title = [NSString stringWithFormat:@"%@游记",_searchName];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:1 actionBlock:^(ZYZMyButton *button) {
        [_MBView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _page = 1;
    _tableView.rowHeight = 202 *1.0 /568 *ScreenHeight;
    
    _bgview = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];

}

-(void)getRequest{
    
    NSString *str = [self.searchName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:@"%@page=%d&q=%@",KSearchDetailURL,self.page,str];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        if(!_tableView.footer.isRefreshing){
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dic in responseObject) {
           
            SearchDetailModel *model = [SearchDetailModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        
        if(_page == 1){
            [self.tableView.header endRefreshing];
        }else{
            [self.tableView.footer endRefreshing];
            
        }
        _bgview.hidden = YES;
        
        [_MBView removeFromSuperview];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide: YES afterDelay: 2];
        
        [_MBView removeFromSuperview];
        NSLog(@"内容下载失败error:%@",error);
    }];
    
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchDetailCell"];
    SearchDetailModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchDetailModel *model = self.dataArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"FDetailViewController"];
    vc.idStr = [NSString stringWithFormat:@"%d",[model.codeId intValue]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 上下拉刷新
-(void)addRefresh{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.tableView.header beginRefreshing];
        _page = 1;
        [self getRequest];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.footer beginRefreshing];
        _page++;
        [self getRequest];
        
    }];
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
            [_MBView hide:YES];
            //创建弹出视图
            UIAlertController *ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络有误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel  =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [ale addAction:cancel];
            [self presentViewController:ale animated:YES completion:nil];

        }else{
            //检测有网络，进行网络请求数据
            [self getRequest];
        }
    }];
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
