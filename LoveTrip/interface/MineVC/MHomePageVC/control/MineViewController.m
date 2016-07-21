//
//  MineViewController.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/4.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "MineViewController.h"
#import "MineModel.h"
#import "MineCell.h"
#import "MessageVC.h"
#import "LoveVC.h"
#import "SDImageCache.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MineViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

//在viewDidLoad加载后，viewWillAppear才会调用
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;


    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUI];
    [self getData];
}

-(void)getUI{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];

    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200*ScreenHeight*1.0/568)];
    imageV.image = [UIImage imageNamed:@"wodebeijing"];
    [self.view addSubview:imageV];


    _tableView.tableHeaderView =imageV;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)getData{
    
    NSArray *arr1 = @[@"我的收藏",@"关于我们",@"清理缓存"];
    NSArray *arr2 = @[@"IconSetting1",@"MessageButton",@"Delete_Pressed"];
    for (int i=0; i<3; i++) {
        MineModel *model = [[MineModel alloc] init];
        model.iconImage = arr2[i];
        model.textShow = arr1[i];
        [self.dataArray addObject:model];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];

    MineModel *model = _dataArray[indexPath.row];
    cell.imageV.image = [UIImage imageNamed:model.iconImage];
    if (indexPath.row!=2) {
        cell.mineLabel.text = model.textShow;
    }else{
        cell.mineLabel.text = [NSString stringWithFormat:@"%@  已缓存%luM",model.textShow,(unsigned long)[[SDImageCache sharedImageCache] getSize]/(1024*1024)];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        LoveVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoveVC"];
        self.navigationController.navigationBar.hidden = NO;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row ==1){
        
        MessageVC *vc = [[MessageVC alloc] init];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [self.tableView reloadData];
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
