//
//  AddDeviceView_2.m
//  Bugoo
//
//  Created by bugoo on 10/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "AddDeviceView_2.h"
#import "QRCode_ViewController.h"
#import "W1Tool.h"
#import "AddDeciveView_3.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface AddDeviceView_2 ()<CBCentralManagerDelegate>
{
    UIAlertController *alertController;
    UIButton *next;
    BOOL isblue;
    CBCentralManager *manager;
}
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,assign)NSInteger learStyle;
@property (nonatomic,strong)UIView *lTireView;
@property (nonatomic,strong)UIView *rTireView;
@property (nonatomic,strong)UILabel *lId;
@property (nonatomic,strong)UILabel *rId;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation AddDeviceView_2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =HXString(@"学习发射器ID");
    [self createUI];
}


-(void)createUI{
    
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64)];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, WIDTH(self.view), Adapt_scaleV(56))];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = HXString(@"请选择发射器学习方式");
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [Utility colorWithHexString:@"333333"];
    [_rootView addSubview:label];
    float button_width = (WIDTH(self.view)-45)/3;
    for (int i=0;i<3 ; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(15+i*button_width+i*7.5, MAXY(label)+20, button_width, 50)];
        switch (i) {
            case 0:
                [button setTitle:HXString(@"二维码") forState:UIControlStateNormal];
                break;
            case 1:
                [button setTitle:HXString(@"手动输入") forState:UIControlStateNormal];
                break;
            case 2:
                [button setTitle:HXString(@"泄压") forState:UIControlStateNormal];
            default:
                break;
        }
        
        [_rootView addSubview:button];
        button.tag = i+101;
        [button setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];
        button.layer.borderColor = [Utility colorWithHexString:@"b9bebf"].CGColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        button.layer.borderWidth = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        if(kIsIphone5||kIsIphone4s){
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        button.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [button setTitleColor:[Utility colorWithHexString:@"0079cc"] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    _lTireView = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 188, 134, 134)];
    _lTireView.center = CGPointMake(WIDTH(_rootView)/2, _lTireView.center.y);
    [_rootView addSubview:_lTireView];
    _lTireView.alpha = 0;
    
    UIImageView *lbackImage = [[UIImageView alloc]initWithFrame:_lTireView.bounds];
    lbackImage.image = [UIImage imageNamed:@"tireback"];
    [_lTireView addSubview:lbackImage];
    
    UILabel *lTire = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(37, 31, 60, 21)];
    lTire.text = HXString(@"前轮");
    lTire.textColor = [Utility colorWithHexString:@"444444"];
    lTire.textAlignment = NSTextAlignmentCenter;
    [_lTireView addSubview:lTire];
//    NSString *contentStr = @"简介：hello world";
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//    //设置：在0-3个单位长度内的内容显示成红色
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//    lTire.attributedText = str;
    _lId = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(20, 73, 94, 21)];
    _lId.text = [NSString stringWithFormat:@"ID:%@",HXString(@"点击学习")];
    _lId.textAlignment = NSTextAlignmentCenter;
    _lId.textColor = [Utility colorWithHexString:@"222222"];
    if (kIsIphone5||kIsIphone4s) {
        _lId
        .font = [UIFont systemFontOfSize:14];
    }
    [_lTireView addSubview:_lId];
    
    UIButton *lbutton = [[UIButton alloc]initWithFrame:_lTireView.bounds];
    lbutton.tag = 201;
    [_lTireView addSubview:lbutton];
    [lbutton addTarget:self action:@selector(choseLearnStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    
  
    
    _rTireView = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 352, 134, 134)];
    _rTireView.center = CGPointMake(WIDTH(_rootView)/2, _rTireView.center.y);
    [_rootView addSubview:_rTireView];
    _rTireView.alpha = 0;
    UIImageView *rbackImage = [[UIImageView alloc]initWithFrame:_rTireView.bounds];
    rbackImage.image = [UIImage imageNamed:@"tireback"];
    [_rTireView addSubview:rbackImage];
    
    UILabel *rTire = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(37, 31, 60, 21)];
    rTire.text = HXString(@"后轮");
    rTire.textColor = [Utility colorWithHexString:@"444444"];
    rTire.textAlignment = NSTextAlignmentCenter;
    [_rTireView addSubview:rTire];
    //    NSString *contentStr = @"简介：hello world";
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    //    //设置：在0-3个单位长度内的内容显示成红色
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
    //    lTire.attributedText = str;
    _rId = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(20, 73, 94, 21)];
    _rId.text = [NSString stringWithFormat:@"ID:%@",HXString(@"点击学习")];
    _rId.textColor = [Utility colorWithHexString:@"222222"];
    if (kIsIphone5||kIsIphone4s) {
        _rId.font = [UIFont systemFontOfSize:14];
    }
    _rId.textAlignment = NSTextAlignmentCenter;
    [_rTireView addSubview:_rId];
    
    
    UIButton *rbutton = [[UIButton alloc]initWithFrame:_rTireView.bounds];
    rbutton.tag = 202;
    [_rTireView addSubview:rbutton];
    [rbutton addTarget:self action:@selector(choseLearnStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *alert = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(550), WIDTH(self.view ),Adapt_IPHONE6_scaleV(20)*2)];
    alert.textAlignment = NSTextAlignmentCenter;
    alert.textColor = [Utility colorWithHexString:@"e74949"];
    alert.font = [UIFont systemFontOfSize:14];
    alert.numberOfLines = 2;
    alert.text = HXString(@"请仔细核对发射器ID,如果有误，会监测不到数据");
    [_rootView addSubview:alert];
    
    
    
    
    next = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(98, 499, 180, 50)];
    next.userInteractionEnabled = NO;
    next.backgroundColor = [Utility colorWithHexString:@"d8d8d8"];
    next.layer.cornerRadius = 15;
    next.layer.borderWidth = 1;
    next.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
    [next setTitle:HXString(@"下一步") forState:UIControlStateNormal];
    [next setTitleColor:[Utility colorWithHexString:@"007acc"]  forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:next];
    
    [self.view addSubview:_rootView];
    
    
}

-(void)next:(UIButton *)button{
//    [self.model check];
    if (_rId.text.length==8&&_lId.text.length==8) {
        AddDeciveView_3 *add = [[AddDeciveView_3 alloc]init];
        add.model = [[Model alloc]init];

        add.model = self.model;
        [self.navigationController pushViewController:add animated:YES];
    }
    else{
        [Utility topAlertView:HXString(@"请完成学习")];
    }
}


-(void)choseLearnStyle:(UIButton *)button{
    if (!_learStyle) {
        [Utility topAlertView:HXString(@"请选择学习方式")];
    }else{
//        switch (button.tag) {
//            case 201:
//            {
//                [self learnID:button.tag];
//            }
//                break;
//            case 202:
//            {
//                [self learnID:button.tag];
//            }
//                break;
//            default:
//                break;
//        }
        [self learnID:button.tag-200];
        
        
      
    }
    
}


-(void)learnID:(NSInteger)tireId{
    __block NSString *currentId;
    __block BOOL flag = YES;
    switch (_learStyle) {
        case 1:
        {
            QRCode_ViewController *qr = [[QRCode_ViewController alloc]init];
            qr.callback = ^(NSString *string){
                currentId = string;
                if (tireId==1) {
                    NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                    NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                    [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                    _lId.attributedText = strFU;
                    self.model.lfid = currentId;
                }else{
                    NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                    NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                    [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                    _rId.attributedText = strFU;
                    self.model.rfid = currentId;
                    
                }
            };
            [self presentViewController:qr animated:YES completion:nil];
        }
            break;
        case 2:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"请输入发射器ID") message:HXString(@"ID由5位字符组成") preferredStyle:UIAlertControllerStyleAlert];
            
            //添加的输入框
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                // 可以在这里对textfield进行定制，例如改变背景色
                //textField.backgroundColor = [UIColor orangeColor];
                
                
            }];
            UIAlertAction *Action = [UIAlertAction actionWithTitle:HXString(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                
            }];
            UIAlertAction *twoAc = [UIAlertAction actionWithTitle:HXString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UITextField  *text = (UITextField *)alert.textFields.firstObject;
                currentId = text.text;
                
                for (int i=0; i<currentId.length; i++) {
                    char a = [currentId characterAtIndex:i];
                    if ((a>='a'&&a<='f')||(a>='A'&&a<='F')||(a >= '0'&& a<= '9')) {
                        
                    }
                    else{
                        flag = NO;
                    }
                }
                if (currentId.length!=5) {
                    flag = NO;
                }
                
                if (flag) {
                    
                    if (tireId==1) {
                        NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                        NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                        [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                        _lId.attributedText = strFU;
                        self.model.lfid = [currentId uppercaseString];
                    }else{
                        NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                        NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                        [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                        _rId.attributedText = strFU;
                        self.model.rfid = [currentId uppercaseString];
                        
                    }
                    
                    
                }else{
                    [Utility topAlertView:HXString(@"请输入正确发射器ID")];
                }
                
             
            }];
            
            [alert addAction:Action];
            [alert addAction:twoAc];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            break;
        case 3:
        {
            
            if (manager.state==CBManagerStatePoweredOn) {
                W1Tool *w1 = [W1Tool loadGuide];
                
                if (![w1 isLocation]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"请开启定位服务允许\"Bugoo\"获取胎压信息") message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *set = [UIAlertAction actionWithTitle:HXString(@"设置") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                    
                    UIAlertAction *OK = [UIAlertAction actionWithTitle:HXString(@"好") style:UIAlertActionStyleDefault handler:nil];
                    
                    [alert addAction:set];
                    
                    
                    [alert addAction:OK];
                    
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                w1.isLearn = YES;
                
                
                alertController = [UIAlertController alertControllerWithTitle:HXString(@"学习中") message:HXString(@"请在60秒类对轮胎进行泄压或取下发射器") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:HXString(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    w1.learnArr = nil;
                    w1.isLearn = NO;
                    [_timer invalidate];
                    _timer = nil;
                }];
                w1.learnCall = ^(NSString *string){
                    if (tireId==1) {
                        NSString *fu = [NSString stringWithFormat:@"ID:%@",string.uppercaseString];
                        NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                        [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                        _lId.attributedText = strFU;
                        self.model.lfid = string;
                    }else{
                        NSString *fu = [NSString stringWithFormat:@"ID:%@",string.uppercaseString];
                        NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                        [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                        _rId.attributedText = strFU;
                        self.model.rfid = string;
                        
                    }
                    [_timer invalidate];
                    _timer = nil;
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    [Utility topAlertView:HXString(@"学习成功，请安装上发射器")];
                };
                [w1 startRanging];
                
                
                _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(remove) userInfo:nil repeats:NO];
                
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else{
                [Utility topAlertView:HXString(@"请打开蓝牙")];
            }
            

          
        }
            break;
        default:
            break;
    }
    

    
    
    
    
    
}



- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSString *message = nil;
    switch (central.state) {
        case 1:
            isblue = NO;
            
        case 2:

            break;
        case 3:
            isblue = NO;
            break;
        case 4:
            isblue = NO;
            break;
        case 5:
            isblue = YES;
            break;
        default:
            break;
    }
    if(message!=nil&&message.length!=0)
    {
        NSLog(@"message == %@",message);
    }
}

-(void)remove{
    [alertController dismissViewControllerAnimated:YES completion:nil];
    [Utility topAlertView:HXString(@"抱歉，学习失败")];
}



-(void)changeStyle:(UIButton *)button{
    [self cleanStatueView];
//    for (int i=101; i<104; i++) {
//        if (button.tag!=i) {
//            UIButton *btn = [_rootView viewWithTag:i];
//            [btn setTitleColor:[Utility colorWithHexString:@"f1f1f1"] forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor clearColor];
//        }
//        
//    }
//
//    switch (button.tag) {
//        case 101:
//            [Utility topAlertView:@"选择对应轮胎，即开始扫描二维码学习"];
//            break;
//        case 102:
//            [Utility topAlertView:@"选择对应轮胎，即开始手动学习"];
//            break;
//        case 103:
//        {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"操作提示" message:@"1、选择对应轮胎进入学习模式后，将该轮胎发射器取下，APP便会获取发射器ID。\n2、学习成功后，对应的轮胎上显示出ID号后请安装好发射器。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }
//        default:
//            break;
//    }
    
    [button setSelected:YES];
    
    [button setTitleColor:[Utility colorWithHexString:@"13b6f1"] forState:UIControlStateNormal];
    button.backgroundColor = [Utility colorWithHexString:@"D8D8D8"];
    _learStyle = (int)button.tag - 100;
    [UIView animateWithDuration:1 animations:^{
        _lTireView.alpha = 1;
        _rTireView.alpha = 1;
    }];
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

    
    next.userInteractionEnabled = YES;
}



-(void)cleanStatueView{
    for (int i=101; i<=103; i++) {
        
        UIButton *btn = [_rootView viewWithTag:i];
        btn.selected = NO;
        btn.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [btn setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];

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
