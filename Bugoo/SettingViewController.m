//
//  SettingViewController.m
//  Bugoo
//
//  Created by bugoo on 13/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "SettingViewController.h"
#import "MotorSetting.h"
#import "PressSetting.h"
#import "SynchroVoice.h"
#import "LearnTireID.h"
#import "VoiceSetting.h"
#import "HelpCenter.h"
#import "TireStatue.h"
#import "International.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    _dataSource = [[NSMutableArray alloc]initWithArray:@[@[HXString(@"摩托车设置")],@[HXString(@"轮胎监测设置"),HXString(@"发射器学习"),HXString(@"语音棒同步"),HXString(@"报警音设置")],@[HXString(@"选择语言")],@[HXString(@"胎压状态预览")],@[HXString(@"帮助中心")]]];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _dataSource[section];
    return arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adapt_IPHONE6_scaleV(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Adapt_IPHONE6_scaleV(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return Adapt_IPHONE6_scaleV(15);
    }
    
    return Adapt_IPHONE6_scaleV(10);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSData *data = currentD;
    Model *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    switch (indexPath.section) {
        case 0:
        {
            MotorSetting *motor = [[MotorSetting alloc]init];
            motor.model = model;
            [self.navigationController pushViewController:motor animated:YES];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    PressSetting *press = [[PressSetting alloc]init];
                    [self.navigationController pushViewController:press animated:YES];
                }
                    break;
                case 1:
                {
                    LearnTireID *learn = [[LearnTireID alloc]init];
                    [self.navigationController pushViewController:learn animated:YES];
                }
                    break;
                case 2:
                {
                    SynchroVoice *sync = [[SynchroVoice alloc]init];
                    sync.diss = YES;
                    [self.navigationController pushViewController:sync animated:YES];
                }
                    break;
                case 3:
                {
                    VoiceSetting *voice = [[VoiceSetting alloc]init];
                    [self.navigationController pushViewController:voice animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            International *internation = [[International alloc]init];
            [self.navigationController pushViewController:internation animated:YES];
        }
            break;
        case 3:
        {
            TireStatue *tirestatue = [[TireStatue alloc]init];
            [self.navigationController pushViewController:tirestatue animated:YES];
        }
            break;
        case 4:
        {
            HelpCenter *help = [[HelpCenter alloc]init];
            [self.navigationController pushViewController:help animated:YES];
        }
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationItem setTitle:HXString(@"设置")];
        _dataSource = [[NSMutableArray alloc]initWithArray:@[@[HXString(@"摩托车设置")],@[HXString(@"轮胎监测设置"),HXString(@"发射器学习"),HXString(@"语音棒同步"),HXString(@"报警音设置")],@[HXString(@"语言选择")],@[HXString(@"胎压状态预览")],@[HXString(@"帮助中心")]]];
    [self.tableView reloadData];
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
