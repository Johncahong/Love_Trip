//
//  LXDDetailViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LXDDetailViewController.h"
#import "LXDDetailModel.h"
#import "Trip_tagModel.h"
#import "AttractionModel.h"
#import "LXDImageModel.h"
#import "LXDDetailCell.h"
#import "MyBgImageView.h"
#import "MBProgressHUD.h"
#import "LXDCollectionCell.h"
#import "ShowImageVC.h"
@interface LXDDetailViewController ()<UITableViewDataSource,UITableViewDelegate,pushShowVCProtocol>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)MyBgImageView *bgImageView;
@property (nonatomic,strong)  MBProgressHUD *MBView;
@property (nonatomic,strong)  UIView *bgview;
@end

@implementation LXDDetailViewController

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
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden =NO;
}
-(void)getUI{

    _MBView = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    // 让hub在显示时仍能点击其他按钮
    _MBView.userInteractionEnabled = NO;
    [self.navigationController.view addSubview:_MBView];
    [_MBView show:YES];

    
    _bgImageView = [[MyBgImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth *0.55)];
    _tableView.tableHeaderView = _bgImageView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:1 actionBlock:^(ZYZMyButton *button) {
        [_MBView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 173;

    _bgview = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];
    
}

-(void)getRequest{


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:GL_LXD_Detail_URL,_idlxdStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LXDDetailModel *model = [[LXDDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        
        model.attraction_trip_tags = [[NSMutableArray alloc] init];
        for (NSDictionary *tagDict in responseObject[@"attraction_trip_tags"]) {
            Trip_tagModel *tagmodel = [[Trip_tagModel alloc] init];
            [tagmodel setValuesForKeysWithDictionary:tagDict];
            
            tagmodel.attraction_contents = [[NSMutableArray alloc] init];
            
            for (NSDictionary *nodeDict in tagDict[@"attraction_contents"]) {
                AttractionModel *attmodel = [[AttractionModel alloc] init];
                [attmodel setValuesForKeysWithDictionary:nodeDict];
                
                attmodel.notes = [[NSMutableArray alloc] init];
                for (NSDictionary *imagedict in nodeDict[@"notes"]) {
                    LXDImageModel *imagemodel = [[LXDImageModel alloc] init];
                    [imagemodel setValuesForKeysWithDictionary:imagedict];
                    
                    [attmodel.notes addObject:imagemodel];
                    
                }
                [tagmodel.attraction_contents addObject:attmodel];
            }
            
            [model.attraction_trip_tags addObject:tagmodel];
        }
        [self.dataArray addObjectsFromArray:model.attraction_trip_tags];
        [self setHeaderView:model];
        
        _bgview.hidden = YES;
        _MBView.hidden = YES;
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"内容下载失败error:%@",error);
        
    }];
}

-(void)setHeaderView:(LXDDetailModel *)model{
    _bgImageView.titleLabel.text = model.name_zh_cn;
    _bgImageView.dateLabel.text = model.name_en;
    _bgImageView.userIconImageView.image = [UIImage imageNamed:@"NodeIconAttraction48"];
    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"holiday"]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Trip_tagModel *model = self.dataArray[section];
    return model.attraction_contents.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXDDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXDDetailCell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.delegate =self;
    Trip_tagModel *tagmodel = self.dataArray[indexPath.section];
    AttractionModel *attmodel = tagmodel.attraction_contents[indexPath.row];
    cell.attmodel = attmodel;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushShowVC:(UIImage *)image width:(int)width heigth:(int)heigth{
    ShowImageVC *vc = [[ShowImageVC alloc] init];
    vc.imgV_W = width;
    vc.imgV_H = heigth;
    vc.image = image;
    [self.navigationController pushViewController:vc animated:YES];
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
