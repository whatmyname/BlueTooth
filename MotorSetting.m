//
//  MotorSetting.m
//  Bugoo
//
//  Created by bugoo on 13/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "MotorSetting.h"
#import "ChangeType.h"

@interface MotorSetting ()
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,strong)UIImageView *motorType;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *type;
@property (nonatomic,strong)NSString *typeString;
@end

@implementation MotorSetting

-(instancetype)init{
    if (self=[super init]) {
        _model = [[Model alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rootView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view))];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    [self.view addSubview:_rootView];
    self.title = HXString(@"摩托车设置");
//    [_model check];
    
    [self createUI];
    
    
    // Do any additional setup after loading the view.
}


-(void)createUI{
    
    _motorType = [[UIImageView alloc]init];
    
    
    [self setTypeImage];
   
    [_rootView addSubview:_motorType];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(260), WIDTH(self.view),Adapt_IPHONE6_scaleV(25))];
    _name.text = _model.name;
    _name.font = [UIFont systemFontOfSize:18];
    _name.textColor = [Utility colorWithHexString:@"333333"];
    _name.textAlignment = NSTextAlignmentCenter;
    [_rootView addSubview:_name];
    
    UIButton *edite = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(255, 242, 40, 40)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(255, 262, 20, 20)];
    image.image = [UIImage imageNamed:@"edite"];
    image.userInteractionEnabled = YES;
    [_rootView addSubview:image];
    [edite addTarget:self action:@selector(changName:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _type = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(311), WIDTH(self.view), Adapt_IPHONE6_scaleV(22))];
    _type.font = [UIFont systemFontOfSize:16];
    _type.textAlignment = NSTextAlignmentCenter;
    NSString *fu = [NSString stringWithFormat:@"%@: %@",HXString(@"类型"),_typeString];
    NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
    [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-_typeString.length, _typeString.length)];
    _type.attributedText = strFU;
    
    
    
//    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(255, 314, 16, 16)];
//    arrow.image = [UIImage imageNamed:@"rightArrow"];
    
//    [_rootView addSubview:arrow];
    
    
    [_rootView addSubview:_type];
    
    
    UIButton *changeType = [[UIButton alloc]initWithFrame:_type.bounds];
    [changeType addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    [_type addSubview:changeType];
    _type.userInteractionEnabled = YES;
    
    [_rootView addSubview:edite];
    
    UILabel *fid = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(366), WIDTH(self.view), Adapt_IPHONE6_scaleV(22))];
    fid.text = [NSString stringWithFormat:@"%@%@",HXString(@"前轮发射器ID:"),self.model.lfid];
    fid.textAlignment = NSTextAlignmentCenter;
    fid.textColor = [Utility colorWithHexString:@"666666"];
    fid.font = [UIFont systemFontOfSize:16];
    [_rootView addSubview:fid];
    
    UILabel *rid = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(393), WIDTH(self.view), Adapt_IPHONE6_scaleV(22))];
    rid.text = [NSString stringWithFormat:@"%@%@",HXString(@"后轮发射器ID:"),self.model.rfid];
    rid.textAlignment = NSTextAlignmentCenter;
    rid.textColor = [Utility colorWithHexString:@"666666"];
    rid.font = [UIFont systemFontOfSize:16];
    [_rootView addSubview:rid];
    

}


-(void)setTypeImage{
    switch (_model.type) {
        case 0:
        {
            _motorType.frame = CGRectMakeIPHONE6Adapt(0, 0, 210, 152);
            _motorType.image = [UIImage imageNamed:@"motor1"];
            _typeString = HXString(@"普通摩托");
        }
            
            break;
        case 1:
        {
            _motorType.frame = CGRectMakeIPHONE6Adapt(0, 0, 210, 126);
            _motorType.image = [UIImage imageNamed:@"motor"];
            _typeString = HXString(@"跑车");
        }
            break;
        case 2:
        {
            _motorType.frame = CGRectMakeIPHONE6Adapt(0, 0, 210, 109);
            _motorType.image = [UIImage imageNamed:@"motor2"];
            _typeString = HXString(@"重型摩托");
        }
            break;
        default:
            break;
    }
    
    [_motorType setCenter:CGPointMake(WIDTH(self.view)/2, Adapt_IPHONE6_scaleV(110-(HEIGHT(_motorType)-109))+HEIGHT(_motorType)/2)];
}


#pragma mark -按钮方法

-(void)changeType:(UIButton *)button{
    ChangeType *change = [[ChangeType alloc]init];
    change.CancelBackBlcok = ^(MotorType type){
        self.model.type = type;
        switch (type) {
            case 0:
            {
                NSString *fu = [NSString stringWithFormat:@"%@: %@",HXString(@"类型"),HXString(@"普通摩托")];
                NSString *ss = HXString(@"普通摩托");
                
                NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-ss.length, ss.length)];
                _type.attributedText = strFU;
            }
                break;
            case 1:
            {
                NSString *fu = [NSString stringWithFormat:@"%@: %@",HXString(@"类型"),HXString(@"跑车")];
                NSString *ss = HXString(@"跑车");
                NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-ss.length, ss.length)];
                _type.attributedText = strFU;
            }
                break;
            case 2:
            {
                NSString *fu = [NSString stringWithFormat:@"%@: %@",HXString(@"类型"),HXString(@"重型摩托")];
                NSString *ss = HXString(@"重型摩托");
                NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-ss.length, ss.length)];
                _type.attributedText = strFU;
            }
                break;
            default:
                break;
        }
        
        [self setTypeImage];
        [self.model setDefault];
    };
    [self.navigationController pushViewController:change animated:YES];
}


-(void)changName:(UIButton *)button{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"设置别名") message:HXString(@"别名由1-8位字符组成") preferredStyle:UIAlertControllerStyleAlert];
    
    //添加的输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        // 可以在这里对textfield进行定制，例如改变背景色
        //textField.backgroundColor = [UIColor orangeColor];
        
        
    }];
    UIAlertAction *Action = [UIAlertAction actionWithTitle:HXString(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    UIAlertAction *twoAc = [UIAlertAction actionWithTitle:HXString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField  *text = (UITextField *)alert.textFields.firstObject;
        if(text.text.length>8){
            [Utility topAlertView:HXString(@"请输入1-8位字符")];
        }else{
            _name.text = text.text;
            self.model.name = _name.text;
            [self.model setDefault];
        }
        
        
    }];
    
    
    [alert addAction:Action];
    [alert addAction:twoAc];
    [self presentViewController:alert animated:YES completion:nil];
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
