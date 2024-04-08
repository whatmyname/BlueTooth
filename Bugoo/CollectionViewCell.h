//
//  CollectionViewCell.h
//  Bugoo
//
//  Created by bugoo on 10/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *lable;
- (void)createUIWithMotorType:(MotorType)type;
@end
