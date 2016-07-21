//
//  SDetailViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SDetailViewController.h"
#import "SDetailModel.h"
#import "STableViewCell.h"
#import "XingChengViewController.h"
#import "CollectionCell.h"
#import "XCButton.h"
#import "LvXingDiViewController.h"
#import "UMSocial.h"
#import "MBProgressHUD.h"
@interface SDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIView *grayView;
@property(nonatomic,strong)UIView *shareView;
@property (nonatomic,strong)  MBProgressHUD *MBView;
@property (nonatomic,strong)  UIView *bgview;
@end

@implementation SDetailViewController


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
    _MBView.labelText = @"加载中...";
    _MBView.userInteractionEnabled = NO;
    [self.navigationController.view addSubview:_MBView];
    [_MBView show:YES];

    
    self.navigationItem.title = [NSString stringWithFormat:@"%@攻略",_name_zhStr];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:1 actionBlock:^(ZYZMyButton *button) {
        [_MBView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    //添加一个手势在蒙层View上,创建时隐藏
    self.grayView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.grayView.hidden = YES;
    self.grayView.alpha = 0.3;
    self.grayView.backgroundColor = [UIColor blackColor];
//    [self.tableView addSubview:self.grayView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
    [self.grayView addGestureRecognizer:tap];
    
    //创建分享的图标，创建时隐藏
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-60, ScreenWidth, 60)];
    self.shareView.hidden = YES;
    self.shareView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.shareView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [btn setBackgroundImage:[UIImage imageNamed:@"ShareIconQQ.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.shareView addSubview:btn];
    
    
    //分享按钮
    __weak typeof(self)weakSelf = self;
    ZYZMyButton *buttonr = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"NavBar_Share_Normal"] bgImage:nil tag:1 actionBlock:^(ZYZMyButton *button) {
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFromBottom;
        animation.duration = 0.2;
        [self.shareView.layer addAnimation:animation forKey:nil];
        
        [UIView animateWithDuration:1 animations:^{
            self.grayView.hidden = NO;
            self.shareView.hidden = NO;

        }];
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"571a08aee0f55a66df0008e9"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession, nil]
                                           delegate:weakSelf];
        
    }];
    buttonr.tag = 101;
    
    [buttonr setImage:[UIImage imageNamed:@"NavBar_Share_Normal.png"] forState:UIControlStateSelected];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:buttonr];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _tableView.rowHeight = 255 *1.0 /568 *ScreenHeight;
}

-(void)getRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:GongLueDetail_URL, _idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        for (NSDictionary *dict in responseObject) {
            
            SDetailModel *model = [[SDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    STableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STableViewCell"];
    cell.titleName = _name_zhStr;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[XingChengViewController class]]){
        XingChengViewController *dvc = segue.destinationViewController;
        XCButton *btn = (XCButton *)sender;
        dvc.idStr = [btn btnId];
        dvc.name_zhStr = [btn btn_name_zhStr];
    
    }else if ([segue.destinationViewController isKindOfClass:[LvXingDiViewController class]]){
        LvXingDiViewController *lvc = segue.destinationViewController;
        XCButton *btn = (XCButton *)sender;
        lvc.idStr = [btn btnId];
        lvc.name_zhStr = [btn btn_name_zhStr];
    }
}
-(void)hideView:(UITapGestureRecognizer *)tap{
//    [self.shareView removeFromSuperview];
//    [self.grayView removeFromSuperview];
    

    [UIView animateWithDuration:1 animations:^{
        self.shareView.hidden = YES;
        self.grayView.hidden = YES;
    }];
}

-(void)shareClick:(UIButton *)btn{
    
}
@end
