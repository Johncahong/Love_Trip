//
//  FDetailViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/5.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50

#import "FDetailViewController.h"
#import "FDetailModel.h"
#import "FTripdayModel.h"
#import "FNodesSubModel.h"
#import "FNodeTripModel.h"
#import "FImageModel.h"
#import "FDetailCell.h"
#import "MyHeaderView.h"
#import "MyBgImageView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "CGHDBManager.h"
#import "LoveVC.h"
#import "ShowImageVC.h"
@interface FDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)MyHeaderView *myView;
@property(nonatomic,strong)MyBgImageView *bgImageView;

@property(nonatomic,assign)int commentIndex;
@property(nonatomic,assign)int i;
@property(nonatomic,assign)CGFloat oldSrollValue;
@property (nonatomic,strong)  MBProgressHUD *MBView;
@property (nonatomic,strong)  UIView *bgview;
@property(nonatomic,strong)FDetailModel *model;

@end

@implementation FDetailViewController


-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    BOOL isSucceed = [[CGHDBManager shareDBManager] selectWithModel:[[FDetailModel alloc] init] whereWithDict:@{@"idStr":_idStr}];
    UIButton *btn = (UIButton *)[self.navigationController.navigationBar.subviews[0] viewWithTag:201];
    btn.selected = isSucceed;
    //找到navigationBar上面的收藏按钮并设置按钮存储在数据库中的状态
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if([view viewWithTag:201]){

            UIButton *btn = (UIButton *)view;
            btn.selected = isSucceed;
        }
    }
    NSLog(@"bool%d",isSucceed);

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self getUI];
    [self getRequest];
}

-(void)getUI{
    self.navigationController.navigationBar.translucent = NO;
    _MBView = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    _MBView.labelText = @"加载中...";
    _MBView.userInteractionEnabled = NO;
    [self.navigationController.view addSubview:_MBView];
    [_MBView show:YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];

    
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:200 actionBlock:^(ZYZMyButton *button) {
        [_MBView removeFromSuperview];
        //pop出视图控制器时移除掉navigationBar上面的收藏按钮
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            if([view viewWithTag:201]){
                [view removeFromSuperview];
            }
        }
        
        if(self.refreshLoveVCBlock){
            self.refreshLoveVCBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    ZYZMyButton *rightBtn = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(ScreenWidth-50-20, 0, 50, 40) title:nil image:[UIImage imageNamed:@"FavoriteBarButton"] bgImage:nil tag:201 actionBlock:^(ZYZMyButton *button) {
        
        UIButton *btn = (UIButton *)[button viewWithTag:201];
        btn.selected = !btn.selected;
        
        if(btn.selected){
            [[CGHDBManager shareDBManager] insertDbWithModel:_model];
            
        }else{

            [[CGHDBManager shareDBManager] deleteDbWithModel:_model];
        }
    }];
    [rightBtn setImage:[UIImage imageNamed:@"FavoritedBarButton"] forState:UIControlStateSelected];
    [self.navigationController.navigationBar addSubview:rightBtn];
    rightBtn.hidden = YES;
    
    _bgImageView = [[MyBgImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth *0.65)];
    _tableView.tableHeaderView = _bgImageView;
    
    _i = 0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 285;
    
    _bgview = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];

}


#pragma mark - 网络数据请求
-(void)getRequest{
    
    _commentIndex = 0;

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:FAXianDetail_URL,_idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

            _model = [[FDetailModel alloc] init];
            [_model setValuesForKeysWithDictionary:responseObject];
            
            _model.trip_days = [[NSMutableArray alloc] init];
            for(NSDictionary *TripDict in responseObject[@"trip_days"]){
                FTripdayModel *tripmodel = [[FTripdayModel alloc] init];
                [tripmodel setValuesForKeysWithDictionary:TripDict];

                tripmodel.nodeArray = [[NSMutableArray alloc] init];
                tripmodel.nodesTirp = [[NSMutableArray alloc] init];
                for (NSDictionary *nodeDic in TripDict[@"nodes"]) {
                    FNodeTripModel *nodemodel = [[FNodeTripModel alloc] init];
                    [nodemodel setValuesForKeysWithDictionary:nodeDic];

                    _commentIndex =0;
                    nodemodel.notesSub = [[NSMutableArray alloc] init];
                    for (NSDictionary *nodeSubDic in nodeDic[@"notes"]) {
                        FNodesSubModel *nodeSubmodel = [[FNodesSubModel alloc] init];
                        [nodeSubmodel setValuesForKeysWithDictionary:nodeSubDic];
                        
                        
                        //扁平化处理
                        if(_commentIndex ==0){
                            nodeSubmodel.comment = nodemodel.comment;
                            _commentIndex =1;
                        }
                        nodeSubmodel.entry_name = nodemodel.entry_name;
                        
                        nodeSubmodel.photo = [[NSMutableArray alloc] init];
                        FImageModel *imagemodel = [[FImageModel alloc] init];
                        [imagemodel setValuesForKeysWithDictionary:nodeSubDic[@"photo"]];
                        
                        [nodeSubmodel.photo addObject:imagemodel];

                        [nodemodel.notesSub addObject:nodeSubmodel];
                        
                        //新设置的数组添加nodeSubmodel
                        [tripmodel.nodeArray addObject:nodeSubmodel];
                    }
                    [tripmodel.nodesTirp addObject:nodemodel];
                }
                
                [_model.trip_days addObject:tripmodel];

            }
            [self.dataArray addObjectsFromArray:_model.trip_days];
        
        [self setHeaderView:_model];
        
        _bgview.hidden = YES;

        [_MBView removeFromSuperview];
        
        [_tableView reloadData];
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            if([view viewWithTag:201]){
                view.hidden = NO;
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide: YES afterDelay: 2];
        
        [_MBView removeFromSuperview];
        NSLog(@"内容下载失败error:%@",error);
    }];
    
}

-(void)setHeaderView:(FDetailModel *)model{
    _bgImageView.titleLabel.text = model.name;
    _bgImageView.dateLabel.text = model.start_date;
    [_bgImageView.userIconImageView sd_setImageWithURL:[NSURL URLWithString:[model.user objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"holiday"]];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    FTripdayModel *model = self.dataArray[section];
    return model.trip_date;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FTripdayModel *model = self.dataArray[section];
    NSInteger sum = 0;
    
    while(model.nodesTirp.count > _i){
        FNodeTripModel *nodemodel = model.nodesTirp[_i++];
        sum = nodemodel.notesSub.count + sum;

    }
    _i = 0;
    return sum;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDetailCell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    FTripdayModel *model = self.dataArray[indexPath.section];

    FNodesSubModel *nodemodel = model.nodeArray[indexPath.row];
    cell.nodeSubmodel = nodemodel;
    
    [cell setPushShowBlock:^(UIImage *image, int width, int height) {
        ShowImageVC *vc = [[ShowImageVC alloc] init];
        vc.image = image;
        vc.imgV_W = width;
        vc.imgV_H = height;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
