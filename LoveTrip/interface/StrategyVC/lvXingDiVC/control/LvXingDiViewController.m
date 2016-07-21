//
//  LvXingDiViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LvXingDiViewController.h"
#import "MBProgressHUD.h"
#import "LXDModel.h"
#import "LXDCell.h"
#import "LXDDetailViewController.h"
@interface LvXingDiViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int page;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)  MBProgressHUD *MBView;
@property (nonatomic,strong)  UIView *bgview;
@end

@implementation LvXingDiViewController

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
    [self getRequest];
    [self addRefresh];

}

-(void)getUI{
    _MBView = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    // 让hub在显示时仍能点击其他按钮
    _MBView.userInteractionEnabled = NO;
    [self.navigationController.view addSubview:_MBView];
    [_MBView show:YES];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@旅行地",_name_zhStr];
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
    _tableView.rowHeight = 75 *1.0 /568 *ScreenHeight;
    
    _bgview = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];
}

-(void)getRequest{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:GL_LvXingDi3_URL, _idStr,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (!_tableView.footer.isRefreshing) {
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in responseObject) {
            
            LXDModel *model = [[LXDModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
        
        if(_page == 1){
            [self.tableView.header endRefreshing];
        }else{
            [self.tableView.footer endRefreshing];
            
        }
        
        _bgview.hidden = YES;
        _MBView.hidden =YES;
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"内容下载失败error:%@",error);
    }];
    
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXDCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXDCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[LXDDetailViewController class]]) {
        LXDDetailViewController *lvc = segue.destinationViewController;
        LXDCell *cell = (LXDCell *)sender;
        lvc.idlxdStr = [cell idStr];
    }
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
