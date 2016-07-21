//
//  LoveVC.m
//  LoveTrip
//
//  Created by Hello Cai on 16/5/5.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LoveVC.h"
#import "LoveCell.h"
#import "CGHDBManager.h"
#import "FDetailModel.h"
#import "FDetailViewController.h"
@interface LoveVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LoveVC

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
}

-(void)getData{
    
    self.navigationItem.title  = @"我的收藏";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:100 actionBlock:^(ZYZMyButton *button) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.dataArray = [[CGHDBManager shareDBManager] selectWithModel:[[FDetailModel alloc] init]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoveCell"];
    FDetailModel *model = _dataArray[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url]];
    cell.nameLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FDetailViewController"];
    FDetailModel *model = _dataArray[indexPath.row];
    vc.idStr = model.idStr;
    
    [vc setRefreshLoveVCBlock:^{
        self.dataArray = [[CGHDBManager shareDBManager] selectWithModel:[[FDetailModel alloc] init]];
        [_tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
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
