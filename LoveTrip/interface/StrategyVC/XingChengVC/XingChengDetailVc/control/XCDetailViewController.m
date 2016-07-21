//
//  XCDetailViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "XCDetailViewController.h"
#import "XCDetailModel.h"
#import "XCPlanDayModel.h"
#import "XCNodeModel.h"
#import "XCDetailCell.h"
#import "LXDImageView.h"
#import "LXDDetailViewController.h"
#import "MBProgressHUD.h"
@interface XCDetailViewController ()<UITableViewDataSource,UITableViewDelegate,pushVCProtocol>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)LXDImageView *bgImageView;
@property (nonatomic,strong)  MBProgressHUD *MBView;
@property (nonatomic,strong)  UIView *bgview;
@end

@implementation XCDetailViewController

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
}

-(void)getUI{
    
    _MBView = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    // 让hub在显示时仍能点击其他按钮
    _MBView.userInteractionEnabled = NO;
    [self.navigationController.view addSubview:_MBView];
    [_MBView show:YES];

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:1 actionBlock:^(ZYZMyButton *button) {
        [_MBView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _bgImageView = [[LXDImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth *0.55)];
    _tableView.tableHeaderView = _bgImageView;
    _tableView.estimatedRowHeight = 252;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _bgview = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];
}

-(void)getRequest{
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[NSString stringWithFormat:GL_XC_Detail_URL, _idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        XCDetailModel *model = [[XCDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        
        model.plan_days = [[NSMutableArray alloc] init];
        for (NSDictionary *planDict in responseObject[@"plan_days"]) {
            XCPlanDayModel *planmodel = [[XCPlanDayModel alloc] init];
            [planmodel setValuesForKeysWithDictionary:planDict];
            
            planmodel.plan_nodes = [[NSMutableArray alloc] init];
            //用于保存name_zh_cn，记住组头
            NSString *nameZhCn;
            
            //创建一个nodeAddmodel模型，等解析完数据后，给数组planmodel.plan_nodes添加nodeAddmodel作为第一个数组元素，里面存储了memo值()
            XCNodeModel *nodeAddmodel = [[XCNodeModel alloc] init];
            nodeAddmodel.memo = planmodel.memo;
            
            for (NSDictionary *nodeDict in planDict[@"plan_nodes"]) {
                XCNodeModel *nodemodel = [[XCNodeModel alloc] init];
                [nodemodel setValuesForKeysWithDictionary:nodeDict];
                
                nameZhCn = nodeDict[@"destination"][@"name_zh_cn"];
                
                [planmodel.plan_nodes addObject:nodemodel];
            }
            
            [planmodel.plan_nodes insertObject:nodeAddmodel atIndex:0];
            planmodel.name_zh_cn = nameZhCn;
            
            [model.plan_days addObject:planmodel];

        }
        [self.dataArray addObjectsFromArray:model.plan_days];
        [self setHeaderView:model];
        
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

-(void)setHeaderView:(XCDetailModel *)model{
    _bgImageView.titleLabel.text = model.name;

    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"holidayr"]];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    XCPlanDayModel *model = self.dataArray[section];
    return model.name_zh_cn;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XCPlanDayModel *model = self.dataArray[section];

    return model.plan_nodes.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XCDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XCDetailCell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    XCPlanDayModel *model = self.dataArray[indexPath.section];
    XCNodeModel *nodemodel = model.plan_nodes[indexPath.row];
    cell.model = nodemodel;
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)pushVC:(NSString *)idStr{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LXDDetailViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LXDDetailViewController"];
    lvc.idlxdStr = idStr;
    [self.navigationController pushViewController:lvc animated:YES];

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
