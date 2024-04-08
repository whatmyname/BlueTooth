//
//  HXTireValue.m
//  Bugoo
//
//  Created by bugoo on 11/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import "HXTireValue.h"

@interface HXTireValue()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)NSString *value;
@property (nonatomic,strong)NSMutableArray *KpaArray;
@property (nonatomic,strong)NSMutableArray *BarArray;
@property (nonatomic,strong)NSMutableArray *PsiArray;
@property (nonatomic,strong)NSMutableArray *RateArray;
@property (nonatomic,strong)NSMutableArray *TempArray;
@property (nonatomic,strong)NSMutableArray *TempArray2;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)UIPickerView *tirePicker;
@end

@implementation HXTireValue

-(instancetype)initWithFrame:(CGRect)frame andUnit:(NSString *)unit{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        if ([unit isEqualToString:@"PSI"]) {
            _dataSource = [NSArray arrayWithArray:self.PsiArray];
            _value = _PsiArray[0];
        }else if([unit isEqualToString:@"KPA"]){
            _dataSource = [NSArray arrayWithArray:self.KpaArray];
            _value = _KpaArray[0];
        }else if([unit isEqualToString:@"BAR"]){
            _dataSource = [NSArray arrayWithArray:self.BarArray];
            _value = _BarArray[0];
        }else if([unit isEqualToString:@"rate"]){
            _dataSource = [NSArray arrayWithArray:self.RateArray];
            _value = _RateArray[0];
        }else if([unit isEqualToString:@"temp"]){
            _dataSource = [NSArray arrayWithArray:self.TempArray];
            _value = _TempArray[0];
        }else{
            _dataSource = [NSArray arrayWithArray:self.TempArray2];
            _value = _TempArray2[0];
        }
    }
    return  self;
}


+ (HXTireValue *) loadGuide:(CGRect)frame andUnit:(NSString *)unit
{
    @synchronized(self)
    {
        HXTireValue *hx = nil;
        if (hx == nil)
        {
            hx = [[self alloc] initWithFrame:frame andUnit:unit];
        }
        return hx;
    }
}

- (void)show
{
    [[Utility mainWindow] addSubview:self];
}


-(NSMutableArray *)KpaArray{
    if (_KpaArray==nil) {
        _KpaArray = [[NSMutableArray alloc]init];
        for (int i=200; i<=500; i=i+10) {
            [_KpaArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _KpaArray;
}

-(NSMutableArray *)PsiArray{
    if (_PsiArray==nil) {
        _PsiArray = [[NSMutableArray alloc]init];
        for (int i=30; i<=70; i=i+1) {
            [_PsiArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _PsiArray;
}

-(NSMutableArray *)BarArray{
    if (_BarArray==nil) {
        _BarArray = [[NSMutableArray alloc]init];
        for (float i=2.0; i<=5.0;i=i+0.1) {
            [_BarArray addObject:[NSString stringWithFormat:@"%.1f",i]];
        }
    }
    return _BarArray;
}

-(NSMutableArray *)RateArray{
    if (_RateArray==nil) {
        _RateArray = [[NSMutableArray alloc]init];
        for (float i = 0.25; i>=0.05; i=i-0.05) {
            [_RateArray addObject:[NSString stringWithFormat:@"%.2f",i]];
        }
    }
    return _RateArray;
}

-(NSMutableArray *)TempArray{
    if (_TempArray==nil) {
        _TempArray = [[NSMutableArray alloc]init];
        for (float i = 80; i>=70; i--) {
            [_TempArray addObject:[NSString stringWithFormat:@"%.0f",i]];
        }
    }
    return _TempArray;
}

-(NSMutableArray *)TempArray2{
    if (_TempArray2==nil) {
        _TempArray2 = [[NSMutableArray alloc]init];
        for (float i = 176; i>=158; i--) {
            [_TempArray2 addObject:[NSString stringWithFormat:@"%.0f",i]];
        }
    }
    return _TempArray2;
}

- (void)createUI{
    _tirePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT(self)-200, WIDTH(self), 200)];
    [self addSubview:_tirePicker];
    _tirePicker.delegate = self;
    _tirePicker.dataSource = self;
    _tirePicker.backgroundColor = [Utility colorWithHexString:@"f1f1f1"];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, Y(_tirePicker)-30, WIDTH(self), 30)];
    view.backgroundColor = [Utility colorWithHexString:@"f1f1f1"];
    [self addSubview:view];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
    [cancel setTitle:HXString(@"取消") forState:UIControlStateNormal];
    [cancel setTitleColor:[Utility colorWithHexString:@"1c1c1e"] forState:UIControlStateNormal];
    [cancel setBackgroundColor:[UIColor clearColor]];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancel];
    
    
    UIButton *com = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH(self)-10-60, 10, 60, 20)];
    [com setTitle:HXString(@"确定") forState:UIControlStateNormal];
    [com setTitleColor:[Utility colorWithHexString:@"1c1c1e"] forState:UIControlStateNormal];
    [com addTarget:self action:@selector(com:) forControlEvents:UIControlEventTouchUpInside];
    [com setBackgroundColor:[UIColor clearColor]];
    [view addSubview:com];
    
}




#pragma 按钮事件

-(void)cancel:(UIButton *)button{
    [self removeFromSuperview];
    _cancelBlock();
}

-(void)com:(UIButton *)button{

    _comBlock(_value);
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataSource[row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _value = _dataSource[row];
}

@end
