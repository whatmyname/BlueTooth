//
//  Model.h
//  Bugoo
//
//  Created by bugoo on 4/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    lightMotor,
    athletic,
    heavymotor
   
}MotorType;

typedef enum: NSUInteger{
    voice1,
    voice2,
    Mute,
}VoiceType ;

@interface Model : NSObject <NSCoding>
@property (nonatomic,strong)NSString *name;     //设备名
@property (nonatomic,assign)MotorType type;     //设备类型
@property (nonatomic,strong)NSString *lfid;     //左前轮ID
@property (nonatomic,strong)NSString *rfid;     //右前轮ID
@property (nonatomic,strong)NSString *lrid;     //左后轮ID
@property (nonatomic,strong)NSString *rrid;     //右后轮ID
@property (nonatomic,assign)float flUp;         //前轮上限
@property (nonatomic,assign)float rlUp;         //后轮上限
@property (nonatomic,assign)float flLow;        //前轮下限
@property (nonatomic,assign)float rlLow;        //后轮下限
@property (nonatomic,assign)float fRule;        //前轮标准值
@property (nonatomic,assign)float rRule;        //后轮标准值
@property (nonatomic,assign)float temp;         //温度上限
@property (nonatomic,assign)float fUpRate;      //前轮上限警戒范围
@property (nonatomic,assign)float rUpRate;      //后轮上限警戒范围
@property (nonatomic,assign)float fLowRate;     //前轮下限警戒范围
@property (nonatomic,assign)float rLowRate;     //后轮下限警戒范围
@property (nonatomic,strong)NSString *pressUnit;  //压力单位
@property (nonatomic,strong)NSString *tempUnit;   //温度单位
@property (nonatomic,assign)BOOL isVoice;   //是否拥有语音棒
@property (nonatomic,assign)VoiceType voiceType;   //报警声音
@property (nonatomic,assign)BOOL isShake;   //是否震动
-(void)check;
-(void)setDefault;
-(void)setDefaultValue;
@end
