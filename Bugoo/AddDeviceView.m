//
//  AddDeviceView.m
//  Bugoo
//
//  Created by bugoo on 6/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "AddDeviceView.h"
#import "CollectionViewCell.h"
#import "AddDeviceView_2.h"
@interface AddDeviceView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray  *titleArray;

@end

@implementation AddDeviceView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = HXString(@"摩托车类型");
    _dataSource = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
//    _titleArray = [NSMutableArray arrayWithArray:@[HXString(@"普通摩托车"),HXString(@"跑车"),HXString(@"重型车")]];
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"DeviceTpye"];
    [self.view addSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMakeIPHONE6Adapt(15, 0, 15, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    switch (indexPath.row) {
        case 0:
            size = CGSizeMakeIPHONE6Adapt(WIDTH(self.view), 187);
            break;
        case 1:
            size = CGSizeMakeIPHONE6Adapt(WIDTH(self.view), 143);
            break;
        case 2:
            size = CGSizeMakeIPHONE6Adapt(WIDTH(self.view), 161);
            break;
        default:
            size = CGSizeMakeIPHONE6Adapt(0, 0);
            break;
    }
    
    return size;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"DeviceTpye" forIndexPath:indexPath];
   
    [cell createUIWithMotorType:indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AddDeviceView_2 *add = [[AddDeviceView_2 alloc]init];
    add.model = [[Model alloc]init];
    switch (indexPath.row) {
        case 0:
        {
            add.model.type = lightMotor;
        }
            break;
        case 1:
        {
            add.model.type = athletic;
        }
            break;
        case 2:
        {
            add.model.type = heavymotor;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:add animated:YES];
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
