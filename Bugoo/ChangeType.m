//
//  ChangeType.m
//  Bugoo
//
//  Created by bugoo on 13/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "ChangeType.h"
#import "CollectionViewCell.h"

@interface ChangeType ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray  *titleArray;
@property (nonatomic,strong)Model *model;
@end

@implementation ChangeType

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = HXString(@"摩托车类型");
    _model = [NSKeyedUnarchiver unarchiveObjectWithData:currentD];
    
    _dataSource = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
    //    _titleArray = [NSMutableArray arrayWithArray:@[HXString(@"普通摩托车"),HXString(@"跑车"),HXString(@"重型车")]];
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"DeviceTpye"];
    [self.view addSubview:_collectionView];
    // Do any additional setup after loading the view.
    
    
    
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
    if (indexPath.row==_model.type) {
        cell.lable.textColor = [Utility colorWithHexString:@"007acc"];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _CancelBackBlcok(indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
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
