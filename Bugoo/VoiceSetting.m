//
//  VoiceSetting.m
//  Bugoo
//
//  Created by bugoo on 18/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "VoiceSetting.h"

@interface VoiceSetting (){
    UISwitch *voiceButton;
    UIButton *voiceButton1;
    UIButton *voiceButton2;
    UISwitch *shakeButton;
    UIView *voice;
    UIView *shake;
}
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,strong)Model *model;

@end

@implementation VoiceSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = HXString(@"报警音设置");
    [self getDefaultModel];
    [self createUI];

}


-(void)createUI{
    _rootView =  [[UIView alloc]initWithFrame:self.view.bounds];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    [self.view addSubview:_rootView];
    

    voice = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 15, 375, 65+50+50)];
    UILabel *alert = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 20, 173, 25)];
    alert.text = HXString(@"声音提示");
    voice.layer.masksToBounds = YES;
    alert.textColor = [Utility colorWithHexString:@"222222"];
    
    voiceButton = [[UISwitch alloc]initWithFrame:CGRectMakeIPHONE6Adapt(304, 17, 57, 31)];
    [voice addSubview:voiceButton];
    [voiceButton addTarget:self action:@selector(onOff:) forControlEvents:UIControlEventValueChanged];
    if (self.model.voiceType!=Mute) {
        [voiceButton setOn:YES];
    }else{
        [voiceButton setOn:NO];
    }
    
    
    [voice addSubview:alert];
    
    UIView *line1 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(0, 64, 375, 1)];
    [voice addSubview:line1];
    
    voiceButton1 = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 65, 375, 50)];
    [voiceButton1 setTitle:HXString(@"人工语音报警") forState:UIControlStateNormal];
    [voiceButton1 setTitleColor:[Utility colorWithHexString:@"007acc"] forState:UIControlStateSelected];
    [voiceButton1 setTitleColor:[Utility colorWithHexString:@"777777"] forState:UIControlStateNormal];
    voiceButton1.tag = 1;
    [voiceButton1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [voice addSubview:voiceButton1];
    
    
    UIView *line2 = [UIView initWithLine:CGRectMakeIPHONE6Adapt(0, 64+50, 375, 1)];
    [voice addSubview:line2];
    
    voiceButton2 = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 65+50, 375, 50)];
    [voiceButton2 setTitle:HXString(@"默认报警") forState:UIControlStateNormal];
    [voiceButton2 setTitleColor:[Utility colorWithHexString:@"007acc"] forState:UIControlStateSelected];
    [voiceButton2 setTitleColor:[Utility colorWithHexString:@"777777"] forState:UIControlStateNormal];
    voiceButton2.tag = 2;
    [voiceButton2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [voice addSubview:voiceButton2];
    
    shake = [UIView initMyView:CGRectMakeIPHONE6Adapt(0, 200, 375, 65)];
    UILabel *shakeAlert = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 20, 173, 25)];
    shakeAlert.text = HXString(@"震动提示");
    shakeAlert.textColor = [Utility colorWithHexString:@"222222"];
    [shake addSubview:shakeAlert];
    
    
    shakeButton = [[UISwitch alloc]initWithFrame:CGRectMakeIPHONE6Adapt(304, 17, 57, 31)];
    [shake addSubview:shakeButton];
    [shakeButton addTarget:self action:@selector(setShake:) forControlEvents:UIControlEventValueChanged];
    [_rootView addSubview:voice];
    [_rootView addSubview:shake];
    [self setVoiceType];
}


-(void)onOff:(UISwitch *)sender{
    if (sender.on) {
        NSLog(@"打开");
        [UIView animateWithDuration:0.3 animations:^{
            [voice setFrame:CGRectMakeIPHONE6Adapt(0, 15, 375, 65+50+50)];
            [shake setFrame:CGRectMakeIPHONE6Adapt(0, 200, 375, 65)];
        }];
        
        self.model.voiceType = voice1;
        [self setVoiceType];
    }
    else{
        NSLog(@"关闭");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:HXString(@"关闭声音提示") message:HXString(@"关闭后，发生异常将没有任何声音提示") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:HXString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [voiceButton setOn:YES animated:YES];
        }];
        __block VoiceSetting *set = self;
        UIAlertAction *sure = [UIAlertAction actionWithTitle:HXString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  [UIView animateWithDuration:0.3 animations:^{
            [voice setFrame:CGRectMakeIPHONE6Adapt(0, 15, 375, 65)];
            [shake setFrame:CGRectMakeIPHONE6Adapt(0, 100, 375, 65)];
                  }];
            
            set.model.voiceType = Mute;
            NSLog(@"%ld",self.model.voiceType);
            [self.model setDefault];
        }];
        
        [alert addAction:cancel];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    [self.model setDefault];
}

-(void)setShake:(UISwitch *)sender{
    if (sender.on) {
        self.model.isShake = YES;
    }else{
        self.model.isShake = NO;
    }
    [self.model setDefault];
    
}


-(void)click:(UIButton *)button{
    if (button.tag==1) {
        button.selected = YES;
        voiceButton2.selected = NO;
        self.model.voiceType = voice1;
        NSLog(@"%ld",self.model.voiceType);
        [self.model setDefault];
    }else{
        button.selected = YES;
        voiceButton1.selected = NO;
        self.model.voiceType = voice2;
        NSLog(@"%ld",self.model.voiceType);
        [self.model setDefault];
    }
}

-(void)setVoiceType{
    switch (_model.voiceType) {
        case Mute:
        {
            [voice setFrame:CGRectMakeIPHONE6Adapt(0, 15, 375, 65)];
            [shake setFrame:CGRectMakeIPHONE6Adapt(0, 100, 375, 65)];
            voiceButton1.selected = NO;
            voiceButton2.selected = NO;
        }
            break;
        case voice1:
        {
            
            voiceButton1.selected = YES;
            voiceButton2.selected = NO;
        }
            break;
        case voice2:
        {
            voiceButton1.selected = NO;
            voiceButton2.selected = YES;
        }
            break;
        default:
            break;
    }
    if (_model.isShake) {
        [shakeButton setOn:YES];
    }else{
        [shakeButton setOn:NO];
    }
    
}


-(void)getDefaultModel{
    self.model = [NSKeyedUnarchiver unarchiveObjectWithData:currentD];
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
