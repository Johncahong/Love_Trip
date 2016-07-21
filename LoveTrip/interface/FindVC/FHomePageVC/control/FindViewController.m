//
//  FindViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/4.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "FindViewController.h"
#import "FindModel.h"
#import "FindCell.h"

#import "DatabaseManager.h"
#import "FDetailViewController.h"
#import "AppDelegate.h"
@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@end

@implementation FindViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(NSManagedObjectContext *)managedObjectContext{
    if(!_managedObjectContext){
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        _managedObjectContext = app.managedObjectContext;
    }
    return _managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [NSThread sleepForTimeInterval:0.8];
    [self getUI];

    //与网络相关
    [self loadDataFromDatabase];
    [self netWorkStatus];

    [self addRefresh];
}


-(void)getUI{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.translucent = NO;
    _page = 1;
    self.navigationItem.title = @"发现";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];

    _tableView.rowHeight = 188 *1.0 / 536 * ScreenHeight;
}

#pragma mark - 网络数据请求
-(void)getRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:FAXian_URL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //第一次进来与下拉刷新时需要有－－清空表格2数据和移除数组数据操作
        if(!_tableView.footer.isRefreshing){

            for (FindModel *model in self.dataArray) {
                [self.managedObjectContext deleteObject:model];
                NSError *error = nil;
                if(![self.managedObjectContext save:&error]){
                    NSLog(@"deleteError:%@",[error description]);
                }
            }
            [self.dataArray removeAllObjects];
            if(_tableView.footer.isRefreshing){
                [_tableView.footer endRefreshing];
            }
        }
        
        for (NSDictionary *dict in responseObject) {
            
            FindModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"FindModel" inManagedObjectContext:self.managedObjectContext];

            model.imageUrl = dict[@"uer"][@"image"];
            //用coredata做数据存储后一直崩溃后来才知道原来是model里面没有重写-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues方法
            [model setValuesForKeysWithDictionary:dict];
            
            NSError *error =nil;
            [self.managedObjectContext save:&error];
            if(error){
                NSLog(@"coredataInsert_Error%@",[error description]);
            }
            [self.dataArray addObject:model];
        }

        if(_page == 1){
            [self.tableView.header endRefreshing];
        }else{
            [self.tableView.footer endRefreshing];
            
        }
        
        [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"内容下载失败error:%@",error);
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindCell"];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - 本地加载
-(void)loadDataFromDatabase{
    
    //UITableView读取本地数据
    [self.dataArray addObjectsFromArray:[self searchDatabase]];
    
    NSLog(@"---path%@",NSHomeDirectory());
    if (self.dataArray.count!=0) {
        NSLog(@"读取本地数据成功");
        [self.tableView reloadData];
        
    }
}

//查找
-(NSArray *)searchDatabase{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FindModel" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSError *error =nil;
    NSArray *arr = [self.managedObjectContext executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"coredataSearch_Error%@",[error description]);
    }
    return arr;
}


#pragma mark - 联网判断
-(void)netWorkStatus{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"网络错误");
        }else{
            if(_dataArray.count ==0){
                [self getRequest];
            }
        }
    }];
    
}

#pragma mark - 上下拉刷新
-(void)addRefresh{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(self.tableView.footer.isRefreshing){
            [self.tableView.footer endRefreshing];
        }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.destinationViewController isKindOfClass:[FDetailViewController class]]) {

        FDetailViewController *fvc = segue.destinationViewController;
        //加这句在跳转到fvc时就能隐藏tabBar，pop回来时就能重新显示tabBar
        fvc.hidesBottomBarWhenPushed = YES;
        fvc.idStr = [sender idStr];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
