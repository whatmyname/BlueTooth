//
//  MainViewController.m
//  Bugoo
//
//  Created by bugoo on 4/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "MainViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "TireDetail.h"
#import "W1Tool.h"
#import "SettingViewController.h"
#import "AddDeviceView.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
@interface MainViewController ()<AVAudioPlayerDelegate,CBCentralManagerDelegate>
{
    NSString *lastVoice;
    int currentVoice;
//    UILabel *alertLabel;
}
@property (nonatomic,strong)Model *model;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;
@property (nonatomic,strong)UIImageView *lTire;
@property (nonatomic,strong)UIImageView *rTire;
@property (nonatomic,strong)UIImageView *motorType;
@property (nonatomic,strong)TireDetail *lTireDetail;
@property (nonatomic,strong)TireDetail *rTireDetail;
@property (nonatomic,strong)W1Tool *w1;
@property(strong,nonatomic)CBCentralManager* CM;
@property (strong,nonatomic)NSMutableArray *voiceArr;
@property (strong,nonatomic)UILabel *alertLabel;
@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
//    self.navigationItem.leftBarButtonItem = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftBtn)];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = NO;
    _voiceArr = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.tintColor = [Utility colorWithHexString:@"ffffff"];
    self.title = @"BUGOO";
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[Utility colorWithHexString:@"ffffff"]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBtn)];
 
    
    [self setDefaultValue];
    // Do any additional setup after loading the view.
}


-(void)setDefaultValue{

    if (currentD) {
        _model = [NSKeyedUnarchiver unarchiveObjectWithData:currentD];
        self.title = _model.name;
        [_model check];
        [self createUI];
        if (self.player) {
            [self.player stop];
            self.player = nil;
            [_timer invalidate];
            _timer = nil;
        }
    }else{
        [self createUIWithoutDevice];
    }
    
}

-(void)createUI{
//    self.CM = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    
   
    
    
    
    CBCentralManager *manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(0,Adapt_IPHONE6_scaleV(98), WIDTH(self.view)/2,Adapt_IPHONE6_scaleV(410))];
//    _leftView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_leftView];

    _rightView = [[UIView alloc]initWithFrame:CGRectMake(MAXX(_leftView), 0, WIDTH(_leftView), HEIGHT(self.view))];
//    _rightView.backgroundColor = [UIColor purpleColor];

    [self.view addSubview:_rightView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtn)];
    
    switch (_model.type) {
        case 0:
        {
            _motorType = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 197, 335)];
            _motorType.image = [UIImage imageNamed:@"lightMotor"];
        }
            
            break;
        case 1:
        {
            _motorType = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 169, 333)];
            _motorType.image = [UIImage imageNamed:@"athletic"];
        }
            break;
        case 2:
        {
            _motorType = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 144, 317)];
            _motorType.image = [UIImage imageNamed:@"heavymotor"];
        }
            break;
        default:
            break;
    }
    
    _motorType.center = CGPointMake(WIDTH(_leftView)/2, HEIGHT(_leftView)/2);
    
    _lTire = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"l"]];
    _lTire.center = CGPointMake(_leftView.center.x, Y(_motorType)-10);
    [_leftView addSubview:_lTire];
    
    _rTire = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"r"]];
    _rTire.center = CGPointMake(_leftView.center.x, MAXY(_motorType)+Adapt_IPHONE6_scaleV(7));
    [_leftView addSubview:_rTire];
    
    
    [_leftView addSubview:_motorType];
    
    __block UIImageView *lt = _lTire;
    __block UIImageView *rt = _rTire;
    
    _lTireDetail = [[TireDetail alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 84, 150, 203) andTitle:HXString(@"前轮-index") andModel:self.model];
    _lTireDetail.model = self.model;
    _lTireDetail.tId = self.model.lfid;
    _lTireDetail.changeTireUn = ^(){
        lt.image = [UIImage imageNamed:@"l-unusual"];
    };
    _lTireDetail.changeTire = ^(){
        lt.image = [UIImage imageNamed:@"l"];
    };
    
    __weak MainViewController *weakSelf = self;
    _lTireDetail.addVoice = ^(NSString *string){
        if (![weakSelf.voiceArr containsObject:string]) {
            [weakSelf.voiceArr addObject:string];
        }
        if (self.model.voiceType==voice1) {
            [weakSelf playWarningVoice];
        }else if(self.model.voiceType==voice2){
            [weakSelf playWarningSound];
        }
        if (weakSelf.model.isShake&&![weakSelf.alertLabel.text isEqualToString:@"点击屏幕解除静音"]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        
    };
    _lTireDetail.rmVoice = ^(NSString *string){
        [weakSelf.voiceArr removeObject:string];
        if (weakSelf.voiceArr.count==0) {
            [weakSelf.player stop];
            weakSelf.player = nil;
        }
    };
    
    __block UILabel *blockAlert = _alertLabel;
    
    _lTireDetail.alertShow = ^(){
        if (weakSelf.player) {
            blockAlert.text = HXString(@"点击屏幕静音");
            blockAlert.hidden = NO;
        }else{
            weakSelf.alertLabel.text = @"";
             weakSelf.alertLabel.hidden = YES;
        }
    };
    _rTireDetail = [[TireDetail alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 368-14, 150, 203) andTitle:HXString(@"后轮-index") andModel:self.model];
    _rTireDetail.model = self.model;
    _rTireDetail.tId = self.model.rfid;
    _rTireDetail.changeTireUn = ^(){
        rt.image = [UIImage imageNamed:@"r-unusual"];
    };
    _rTireDetail.changeTire = ^(){
        rt.image = [UIImage imageNamed:@"r"];
    };
    _rTireDetail.addVoice = ^(NSString *string){
        if (![weakSelf.voiceArr containsObject:string]) {
            [weakSelf.voiceArr addObject:string];
        }
        
        if (self.model.voiceType==voice1) {
            [weakSelf playWarningVoice];
        }else if(self.model.voiceType==voice2){
            [weakSelf playWarningSound];
        }
        if (weakSelf.model.isShake&&![weakSelf.alertLabel.text isEqualToString:HXString(@"点击屏幕解除静音")]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    };
    _rTireDetail.rmVoice = ^(NSString *string){
        [weakSelf.voiceArr removeObject:string];
        if (weakSelf.voiceArr.count==0) {
            [weakSelf.player stop];
            weakSelf.player = nil;
        }
    };
    
    _rTireDetail.alertShow = ^(){
        if (weakSelf.player) {
            blockAlert.text = HXString(@"点击屏幕静音");
            blockAlert.hidden = NO;
        }else{
            weakSelf.alertLabel.text = @"";
            weakSelf.alertLabel.hidden = YES;
           
        }
    };
    [_rightView addSubview:_lTireDetail];
    [_rightView addSubview:_rTireDetail];
    
    
    _w1 =  [W1Tool loadGuide];
    if (![_w1 isLocation]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"请开启定位服务允许\"Bugoo\"获取胎压信息") message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *set = [UIAlertAction actionWithTitle:HXString(@"设置") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=LOCATION_SERVICES"];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
            
            
        }];
        
        UIAlertAction *OK = [UIAlertAction actionWithTitle:HXString(@"好") style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:set];
        
        
        [alert addAction:OK];
    
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    _alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), Adapt_IPHONE6_scaleV(50))];
    _alertLabel.textColor = [Utility colorWithHexString:@"ffffff"];
    _alertLabel.backgroundColor = [Utility colorWithHexString:@"363738"];
    _alertLabel.hidden = YES;
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_alertLabel];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view))];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(changeAlertLabel:) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [U IColor cyanColor];
    NSLog(@"%@",button);
    
    [_w1 startRanging];
    [_w1 setModel];

}


-(void)changeAlertLabel:(UIButton *)sender{

    if ([_alertLabel.text isEqualToString:HXString(@"点击屏幕静音")]) {
        _alertLabel.text = HXString(@"点击屏幕解除静音");
        if (self.player) {
            [self.player stop];
//            self.player = nil;
        }
    }else if([_alertLabel.text isEqualToString:HXString(@"点击屏幕解除静音")]){
        _alertLabel.text = HXString(@"点击屏幕静音");
    }
#if defined(DEBUG)
    NSLog(@"点点点点点");
#endif
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSString *message = nil;
    switch (central.state) {
        case 1:
            message = @"该设备不支持蓝牙功能,请检查系统设置";
            break;
        case 2:
            message = @"该设备蓝牙未授权,请检查系统设置";
            break;
        case 3:
            message = @"该设备蓝牙未授权,请检查系统设置";
            break;
        case 4:
            message = @"该设备尚未打开蓝牙,请在设置中打开";
            break;
        case 5:
            message = @"蓝牙已经成功开启,请稍后再试";
            break;
        default:
            break;
    }
    if(message!=nil&&message.length!=0)
    {
        NSLog(@"message == %@",message);
    }
}


-(void)createUIWithoutDevice{
  
    
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    [_w1 stopRanging];
    
    self.title = @"";
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(106, 150, 191, 65)];
    image.center = CGPointMake(WIDTH(self.view)/2, image.center.y);
    image.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:image];
    
    image.userInteractionEnabled = YES;
    
    UIButton *imageButton = [[UIButton alloc]initWithFrame:image.bounds];
    [image addSubview:imageButton];
    
    [imageButton addTarget:self action:@selector(addDevice:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT(self.view)-Adapt_IPHONE6_scaleV(97)-Adapt_IPHONE6_scaleV(28), WIDTH(self.view),Adapt_IPHONE6_scaleV(28))];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [Utility colorWithHexString:@"efefef"];
    label.font = [UIFont systemFontOfSize:20];
    label.text = HXString(@"添加布古胎压监测器");
    [self.view addSubview:label];
    self.navigationItem.rightBarButtonItem = nil;
    label.userInteractionEnabled = YES;
    
    UIButton *button = [[UIButton alloc]initWithFrame:label.bounds];
    [label addSubview:button];
    
    [button addTarget:self action:@selector(addDevice:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)addDevice:(UIButton *)button{
    AddDeviceView *add = [[AddDeviceView alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (!self.model) {
//        AddDeviceView *add = [[AddDeviceView alloc]init];
//        [self.navigationController pushViewController:add animated:YES];
//    }
//    
//    
//}



-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    SettingViewController *set = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:set animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)playWarningSound
{
    if (![_alertLabel.text isEqualToString:HXString(@"点击屏幕解除静音")]) {
        _alertLabel.text = HXString(@"点击屏幕静音");
        _alertLabel.hidden = NO;
    }
    if (![_alertLabel.text isEqualToString:HXString(@"点击屏幕解除静音")]){
        if (!self.player || self.player == nil || !self.player.prepareToPlay) {
            NSError *error;
            if (!AlertSound || ![AlertSound isKindOfClass:[NSDictionary class]]) {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"Bugoo" ofType:@"wav"];
                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return ;
                self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
                self.player.delegate = self;
            }
            else
            {
                NSURL *songURL = [NSURL URLWithString:AlertSound[@"url"]];
                self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:songURL error:nil];
            }
            if (!self.player)
            {
                NSLog(@"Error: %@", [error localizedDescription]);
                return;
            }
            [self.player prepareToPlay];
            [self.player setNumberOfLoops:-1];
            if (self.model.isShake) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        }
        
        
        [self.player play];
        
    }
    
    
}

- (void)playWarningVoice{
    
    if (![_alertLabel.text isEqualToString:HXString(@"点击屏幕解除静音")]) {
        _alertLabel.text = HXString(@"点击屏幕静音");
        _alertLabel.hidden = NO;
    }
    
    if (![_alertLabel.text isEqualToString:HXString(@"点击屏幕解除静音")]){
        
    if (!self.player&&!self.player.isPlaying) {
        NSError *error;
        NSString *path = [[NSBundle mainBundle] pathForResource:self.voiceArr[0] ofType:@"mp3"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return ;
        [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
        [[AVAudioSession sharedInstance]setActive:YES error:nil];
        // Activates the audio session.
        
        NSError *activationError = nil;
        [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
        
        
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
        self.player.delegate = self;
        [self.player prepareToPlay];
        [self.player play];
        
       
        
        if (_timer) {
            [_timer setFireDate:[NSDate distantPast]];
        }else{
            _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changVoice) userInfo:nil repeats:YES];
        }
      }
    }
}


-(void)changVoice{
    if (![_alertLabel.text isEqualToString:HXString(@"点击屏幕解除静音")]){
        NSError *error;
        NSLog(@"%@",self.voiceArr);
    
        if (self.voiceArr.count>0&&!self.player.isPlaying) {
        if (currentVoice>=self.voiceArr.count) {
            currentVoice = 0;
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:self.voiceArr[currentVoice] ofType:@"mp3"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return ;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
        self.player.delegate = self;
        NSString *string = _voiceArr[currentVoice];
        if ([string containsString:@"7"]&&_voiceArr.count>1) {
            self.player.numberOfLoops = 1;
            [_voiceArr removeObjectAtIndex:currentVoice];
        }else{
            self.player.numberOfLoops = 0;
        }
        [self.player prepareToPlay];
        [self.player play];
        if (self.model.isShake) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
   
    currentVoice++;
    if (self.voiceArr.count==0) {
        [_timer invalidate];
        _timer = nil;
    }
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setDefaultValue];
    //设置打开抽屉模式
    [_timer invalidate];
    _timer = nil;
    self.player = nil;
    [self.voiceArr removeAllObjects];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
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
