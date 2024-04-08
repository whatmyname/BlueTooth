//
//  LearnTireID.m
//  Bugoo
//
//  Created by bugoo on 17/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "LearnTireID.h"
#import "QRCode_ViewController.h"
#import "W1Tool.h"
#import "SynchroVoiceViewController_3.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface LearnTireID ()<CBCentralManagerDelegate>
{
    UIAlertController *alertController;
    BOOL isSetting;
    BOOL isChange;
     CBCentralManager *manager;
}
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,assign)NSInteger learStyle;
@property (nonatomic,strong)UIView *lTireView;
@property (nonatomic,strong)UIView *rTireView;
@property (nonatomic,strong)UILabel *lId;
@property (nonatomic,strong)UILabel *rId;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)Model *model;
@end

@implementation LearnTireID

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [NSKeyedUnarchiver unarchiveObjectWithData:currentD];
    // Do any additional setup after loading the view.
    self.title = HXString(@"发射器学习");
    [self createUI];
}

-(void)createUI{
    
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64)];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bar-back"] style:UIBarButtonItemStyleDone target:self action:@selector(goback:)];
    
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
        if (kIsIphone5||kIsIphone4s) {
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        button.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [button setTitleColor:[Utility colorWithHexString:@"0079cc"] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    _lTireView = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 188, 134, 134)];
    _lTireView.center = CGPointMake(WIDTH(_rootView)/2, _lTireView.center.y);
    [_rootView addSubview:_lTireView];
    
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
//    _lId.text = [NSString stringWithFormat:@"ID:%@",self.model.lfid];
    
    _lId.textAlignment = NSTextAlignmentCenter;
    _lId.textColor = [Utility colorWithHexString:@"444444"];
    
    NSString *fu = [NSString stringWithFormat:@"ID:%@",self.model.lfid];
    NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
    [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
    _lId.attributedText = strFU;

    
    [_lTireView addSubview:_lId];
    
    UIButton *lbutton = [[UIButton alloc]initWithFrame:_lTireView.bounds];
    lbutton.tag = 201;
    [_lTireView addSubview:lbutton];
    [lbutton addTarget:self action:@selector(choseLearnStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    _rTireView = [[UIView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 352, 134, 134)];
    _rTireView.center = CGPointMake(WIDTH(_rootView)/2, _rTireView.center.y);
    [_rootView addSubview:_rTireView];
    
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
//    _rId.text = [NSString stringWithFormat:@"ID:%@",self.model.rfid];
    _rId.textColor = [Utility colorWithHexString:@"444444"];
    _rId.textAlignment = NSTextAlignmentCenter;
    
    NSString *rfu = [NSString stringWithFormat:@"ID:%@",self.model.rfid];
    NSMutableAttributedString *rstrFU = [[NSMutableAttributedString alloc]initWithString:rfu];
    [rstrFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(rstrFU.length-5, 5)];
    _rId.attributedText = rstrFU;
    
    
    
    [_rTireView addSubview:_rId];
    
    
    UIButton *rbutton = [[UIButton alloc]initWithFrame:_rTireView.bounds];
    rbutton.tag = 202;
    [_rTireView addSubview:rbutton];
    [rbutton addTarget:self action:@selector(choseLearnStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *alert = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(563)-20, WIDTH(self.view ),Adapt_IPHONE6_scaleV(20)*2)];
    alert.textAlignment = NSTextAlignmentCenter;
    alert.textColor = [Utility colorWithHexString:@"e74949"];
    alert.font = [UIFont systemFontOfSize:14];
    alert.numberOfLines =2;
    alert.text = HXString(@"请仔细核对发射器ID,如果有误，会监测不到数据");
    [_rootView addSubview:alert];
    
    
    
    
//    UIButton *next = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(98, 499, 180, 50)];
//    next.backgroundColor = [Utility colorWithHexString:@"d8d8d8"];
//    next.layer.cornerRadius = 15;
//    next.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
//    [next setTitle:HXString(@"下一步") forState:UIControlStateNormal];
//    [next setTitleColor:[Utility colorWithHexString:@"007acc"]  forState:UIControlStateNormal];
//    [next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
//    [_rootView addSubview:next];
//    
    [self.view addSubview:_rootView];
    
    
}


-(void)goback:(UIBarButtonItem*)bar{
    if (self.model.isVoice&&!isSetting&&isChange) {
        isSetting = YES;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"温馨提示") message:HXString(@"是否同步语音棒") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:HXString(@"下次再说") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *synac = [UIAlertAction actionWithTitle:HXString(@"去同步") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SynchroVoiceViewController_3 *s1 = [[SynchroVoiceViewController_3 alloc]init];
            UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:s1];
            
            [self presentViewController:nc animated:YES completion:nil];
            
        }];
        
        [alert addAction:cancel];
        [alert addAction:synac];
        
        [self presentViewController:alert animated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
                if(flag){
                if (tireId==1) {
//                    _lId.text = [NSString stringWithFormat:@"ID:%@",currentId];
                    NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                    NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                    [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                    _lId.attributedText = strFU;
                    self.model.lfid = currentId;
                    }else{
//                    _rId.text = [NSString stringWithFormat:@"ID:%@",currentId];
                        NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                        NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                        [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                        _lId.attributedText = strFU;
                        self.model.rfid = currentId;
                    
                    }
                    [self.model setDefault];
                }else{
                    [Utility topAlertView:HXString(@"扫描到了二维码不正确")];
                }
                
            };
            isChange = YES;
            [self presentViewController:qr animated:YES completion:nil];
        }
            break;
        case 2:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"请输入正确发射器ID") message:HXString(@"ID由5位字符组成") preferredStyle:UIAlertControllerStyleAlert];
            
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
//                        _lId.text = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                        NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                        NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                        [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                        _lId.attributedText = strFU;
                        self.model.lfid = currentId.uppercaseString;
                    }else{
//                        _rId.text = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                        NSString *fu = [NSString stringWithFormat:@"ID:%@",currentId.uppercaseString];
                        NSMutableAttributedString *strFU = [[NSMutableAttributedString alloc]initWithString:fu];
                        [strFU addAttribute:NSForegroundColorAttributeName value:[Utility colorWithHexString:@"007acc"] range:NSMakeRange(strFU.length-5, 5)];
                        _rId.attributedText = strFU;
                        self.model.rfid = currentId.uppercaseString;
                    }
                    [self.model setDefault];
                    
                }else{
                    [Utility topAlertView:HXString(@"请输入正确发射器ID")];
                }
                
                
            }];
            isChange = YES;
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
                } else{
                    w1.isLearn = YES;
                    
                    
                    alertController = [UIAlertController alertControllerWithTitle:HXString(@"学习中") message:HXString(@"请在60秒内对轮胎进行泄压或取下发射器") preferredStyle:UIAlertControllerStyleAlert];
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
                        [self.model setDefault];
                        [_timer invalidate];
                        _timer = nil;
                        [alertController dismissViewControllerAnimated:YES completion:nil];
                        [Utility topAlertView:HXString(@"学习成功，请安装上发射器")];
                    };
                    [w1 startRanging];
                    
                    isChange = YES;
                    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(remove) userInfo:nil repeats:NO];
                    
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
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



-(void)remove{
    [alertController dismissViewControllerAnimated:YES completion:nil];
    [Utility topAlertView:HXString(@"学习失败")];
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
    if (button.tag==103) {
        
    }
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    _learStyle = (int)button.tag - 100;

}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSString *message = nil;
    switch (central.state) {
        case 1:
            
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        default:
            break;
    }
    if(message!=nil&&message.length!=0)
    {
        NSLog(@"message == %@",message);
    }
}



-(void)cleanStatueView{
    for (int i=101; i<=103; i++) {
        
        UIButton *btn = [_rootView viewWithTag:i];
        btn.selected = NO;
        btn.backgroundColor = [Utility colorWithHexString:@"faffff"];
        [btn setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];
        
    }
    
}

-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
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
