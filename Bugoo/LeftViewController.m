//
//  LeftViewController.m
//  Bugoo
//
//  Created by bugoo on 4/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableCell.h"
#import "AddDeviceView.h"
#import "MainViewController.h"
#import "W1Tool.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *editeButton;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataSource = Peripherals_Arr?[NSMutableArray arrayWithArray:Peripherals_Arr]:[NSMutableArray array];
    
//    
//    if (_dataSource.count==0) {
//        for (int i=0; i<1; i++) {
//            Model *model = [[Model alloc]init];
//            model.type = i%3;
//            model.name = [NSString stringWithFormat:@"%d",i];
//            
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//            
//            
//            [_dataSource addObject:data];
//        }
//    }
//    
    
    
//    self.title = @"选车车辆";
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];

    
    
    self.view.backgroundColor = [Utility colorWithHexString:@"2e2f33"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,Adapt_IPHONE6_scaleV(208.6), HEIGHT(self.view)-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.editing = YES;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [Utility colorWithHexString:@"2e2f33"];
    
    if (_dataSource.count>0) {
        [self createUIEditeButton];
    }
    
    [self createFootView];
    [self.view addSubview:_tableView];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}


-(void)createUIEditeButton{
    if (editeButton) {
        
    }else{
        editeButton = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 24, 50, 40)];
        [editeButton setTitle:HXString(@"编辑") forState:UIControlStateNormal];
        editeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        if(kIsIphone5){
            editeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        }
        
        [editeButton setTitleColor:[Utility colorWithHexString:@"888888"] forState:UIControlStateNormal];
        [editeButton addTarget:self action:@selector(edited:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:editeButton];
    }
    
}

-(void)edited:(UIButton *)button{
    button.selected = !button.selected;
    _tableView.editing = button.selected;
    if (button.selected) {
        [button setTitle:HXString(@"完成") forState:UIControlStateNormal];
    }else{
        [button setTitle:HXString(@"编辑") forState:UIControlStateNormal];
    }

}

-(void)createFootView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 208.6, 157)];
    if (_dataSource.count==0) {
        view.center = CGPointMake(view.center.x, view.center.y+64);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [view addGestureRecognizer:tap];
    
    UIImageView *circle = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 126, 126)];
    circle.image = [UIImage imageNamed:@"circle"];
    circle.center = CGPointMake(circle.center.x+Adapt_IPHONE6_scaleV(41.5), circle.center.y);
    UIImageView *add = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add-left"]];
    add.center = circle.center;
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT(circle)+6,Adapt_IPHONE6_scaleL(208.6),Adapt_IPHONE6_scaleV(25))];
    addLabel.textColor = [Utility colorWithHexString:@"ededed"];
    addLabel.text =HXString(@"添加");
    addLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:circle];
    [view addSubview:add];
    [view addSubview:addLabel];
    _tableView.tableFooterView = view;
    
}

-(void)click:(UITapGestureRecognizer *)tap{
    AddDeviceView *add = [[AddDeviceView alloc]init];
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:add animated:YES];
    
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[LeftTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSData *data = _dataSource[indexPath.section];
    Model *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    CGPoint point = cell.motorType.center;
    switch (model.type) {
        case 0:
        {
            cell.motorType.frame = CGRectMakeIPHONE6Adapt(point.x-40, point.y-25, 80, 59);
            cell.motorType.image = [UIImage imageNamed:@"lightmoto-left"];
        }
            break;
        case 1:
        {
            cell.motorType.frame = CGRectMakeIPHONE6Adapt(point.x-40, point.y-24, 80, 49);
            cell.motorType.image = [UIImage imageNamed:@"athletic-left"];
        }
            break;
        case 2:
        {
             cell.motorType.frame = CGRectMakeIPHONE6Adapt(point.x-40, point.y-24, 80, 49);
            cell.motorType.image = [UIImage imageNamed:@"heavymotor-left"];
        }
            break;
        default:
            break;
    }
    cell.motorName.text = model.name;
    if(indexPath.section==0){
        cell.motorName.textColor = [Utility colorWithHexString:@"0079cc"];
        cell.circle.image = [UIImage imageNamed:@"circle"];
    }else{
        cell.motorName.textColor = [Utility colorWithHexString:@"ededed"];
    }
    cell.motorType.center = cell.circle.center;
    
//    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
//    longPressGR.minimumPressDuration = 3;
//    [cell addGestureRecognizer:longPressGR];
    return cell;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adapt_IPHONE6_scaleV(157);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section!=0) {
        [_dataSource exchangeObjectAtIndex:indexPath.section withObjectAtIndex:0];
        [self.tableView reloadData];
    }
    NSData *model = _dataSource[0];
    DEFAULTS_INFO(model, @"Device");
    DEFAULTS_INFO(self.dataSource, @"Per");
    DEFAULTS_SYNCHRONIZE;
    
    W1Tool * w1 = [W1Tool loadGuide];
    [w1 setModel];
    
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    MainViewController *mainView = (MainViewController *)nav.topViewController;
    [mainView setDefaultValue];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        
        [self.dataSource removeObjectAtIndex:indexPath.section];
        if (self.dataSource.count==0) {
            DEFAULTS_INFO(nil, @"Device");
            DEFAULTS_SYNCHRONIZE;
            [editeButton removeFromSuperview];
            editeButton = nil;
        }else{
            DEFAULTS_INFO(self.dataSource[0], @"Device");
            DEFAULTS_SYNCHRONIZE;
        }
        
        DEFAULTS_INFO(self.dataSource, @"Per");
        DEFAULTS_SYNCHRONIZE;
       
        
        
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        MainViewController *mainView = (MainViewController *)nav.topViewController;
        [mainView setDefaultValue];
        [self.tableView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Left will appear");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _dataSource = Peripherals_Arr?[NSMutableArray arrayWithArray:Peripherals_Arr]:[[NSMutableArray alloc]init];
    if (_dataSource.count>0) {
        [self createUIEditeButton];
    }else{
        if (editeButton) {
            [editeButton removeFromSuperview];
            editeButton = nil;
        }
    }
    if (self.tableView) {
        [_tableView reloadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tableView.editing = NO;
    editeButton.selected = NO;
    [editeButton setTitle:HXString(@"编辑") forState:UIControlStateNormal];
    NSLog(@"Left will disappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"Left did disappear");
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
