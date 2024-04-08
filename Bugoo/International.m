//
//  International.m
//  Bugoo
//
//  Created by bugoo on 19/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "International.h"

@interface International ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *view;

}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIBarButtonItem *bar;
@property (nonatomic,assign)NSInteger language;
@end

@implementation International

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = HXString(@"语言选择");
    
//    _dataSource = [[NSMutableArray alloc]initWithArray:@[@"简体中文",@"日本語",@"English",@"繁體中文"]];
    _dataSource = [[NSMutableArray alloc]initWithArray:@[@"简体中文",@"English",@"繁體中文"]];
    NSString *ll = Language;
    _language = ll.integerValue;
    _bar = [[UIBarButtonItem alloc]initWithTitle:HXString(@"保存") style:(UIBarButtonItemStyleDone) target:self action:@selector(setAppLanguage)];
    self.navigationItem.rightBarButtonItem = _bar;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    [self setAppLanguage];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
//
//    switch (indexPath.row) {
//        case 0:
//            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
//            DEFAULTS_SYNCHRONIZE;
//            break;
//        case 1:
//            [[NSUserDefaults standardUserDefaults] setObject:@"ja" forKey:@"appLanguage"];
//            DEFAULTS_SYNCHRONIZE;
//            break;
//        case 2:
//            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
//            DEFAULTS_SYNCHRONIZE;
//        default:
//            break;
//    }

    _language = indexPath.row;
    [self.tableView reloadData];
    
//    [self setAppLanguage];
}

-(void)setAppLanguage{
    
    switch (_language) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
            DEFAULTS_SYNCHRONIZE;
            break;
//        case 1:
//            [[NSUserDefaults standardUserDefaults] setObject:@"ja" forKey:@"appLanguage"];
//            DEFAULTS_SYNCHRONIZE;
//            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
            DEFAULTS_SYNCHRONIZE;
            break;
        case 2:
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:@"appLanguage"];
            DEFAULTS_SYNCHRONIZE;
        default:
            break;
    }
    NSString *string = [NSString stringWithFormat:@"%ld",_language];
    DEFAULTS_INFO(string, @"language");
    DEFAULTS_SYNCHRONIZE;
    _bar.title = HXString(@"保存");
    
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    if (indexPath.row==_language) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
