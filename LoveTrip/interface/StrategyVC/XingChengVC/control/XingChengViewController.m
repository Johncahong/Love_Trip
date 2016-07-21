//
//  XingChengViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "XingChengViewController.h"
#import "XCModel.h"
#import "XCCell.h"
#import "XCDetailViewController.h"
#import "XCCell.h"
#import "MBProgressHUD.h"
@interface XingChengViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)  MBProgressHUD *MBView;
@property (nonatomic,strong)  UIView *bgview;
@end

@implementation XingChengViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self getUI];
    [self getRequest];

}

-(void)getUI{

    _MBView = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_MBView];
    [_MBView show:YES];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@行程",_name_zhStr];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:1 actionBlock:^(ZYZMyButton *button) {
        
        [_MBView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    

    _tableView.estimatedRowHeight = 180;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _bgview = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];
}

-(void)getRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:GL_XingCheng2_URL, _idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        for (NSDictionary *dict in responseObject) {
            
            XCModel *model = [[XCModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
        _bgview.hidden = YES;
        [_MBView hide:YES];
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

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XCCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[XCDetailViewController class]]){
        XCDetailViewController *xvc = segue.destinationViewController;
        XCCell *cell = (XCCell *)sender;

        xvc.idStr = [cell idStr];

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
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
