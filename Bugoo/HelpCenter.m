//
//  HelpCenter.m
//  Bugoo
//
//  Created by bugoo on 18/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "HelpCenter.h"
#import "CallUs.h"
#import "AboutUs.h"
#import "Retroaction.h"
@interface HelpCenter ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HelpCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = HXString(@"帮助中心");
    _dataSource = [NSMutableArray arrayWithArray:@[@[HXString(@"关于我们"),HXString(@"联系我们")],@[HXString(@"意见反馈")]]];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _dataSource[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray *arr = _dataSource[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 15;
    }
    return 7.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 7.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                AboutUs *us = [[AboutUs alloc]init];
                [self.navigationController pushViewController:us animated:YES];
            }
            else{
                CallUs *call = [[CallUs alloc]init];
                [self.navigationController pushViewController:call animated:YES];
            }
        }
            break;
        case 1:
        {
            Retroaction *retro = [[Retroaction alloc]init];
            [self.navigationController pushViewController:retro animated:YES];
        }
            break;
        default:
            break;
    }
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
