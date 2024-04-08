//
//  LeftTableCell.m
//  Bugoo
//
//  Created by bugoo on 5/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "LeftTableCell.h"

@implementation LeftTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [Utility colorWithHexString:@"2f2f33"];
    _circle = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 126, 126)];
    _circle.center = CGPointMake(_circle.center.x+Adapt_IPHONE6_scaleV(41.5), _circle.center.y);
    
    _circle.image = [UIImage imageNamed:@"c2"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _motorType = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 80, 80)];
    _motorType.center = _circle.center;
    _motorType.backgroundColor = [UIColor clearColor];
    [self addSubview:_circle];
    [self addSubview:_motorType];
    _motorName = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT(_circle)+6,Adapt_IPHONE6_scaleL(208.6), Adapt_IPHONE6_scaleV(25))];
    _motorName.textAlignment = NSTextAlignmentCenter;
    _motorName.textColor = [Utility colorWithHexString:@"ededed"];
    [self addSubview:_motorName];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
