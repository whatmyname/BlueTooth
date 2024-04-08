//
//  Model.m
//  Bugoo
//
//  Created by bugoo on 4/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "Model.h"
//@property (nonatomic,strong)NSString *name;
//@property (nonatomic,assign)MotorType type;
//@property (nonatomic,strong)NSString *lfid;
//@property (nonatomic,strong)NSString *rfid;
//@property (nonatomic,strong)NSString *lrid;
//@property (nonatomic,strong)NSString *rrid;
//@property (nonatomic,assign)float flUp;
//@property (nonatomic,assign)float rlUp;
//@property (nonatomic,assign)float flLow;
//@property (nonatomic,assign)float rlLow;
//@property (nonatomic,assign)float temp;
//@property (nonatomic,assign)float fUpRate;
//@property (nonatomic,assign)float rUpRate;
//@property (nonatomic,assign)float fLowRate;
//@property (nonatomic,assign)float rLowRate;
@implementation Model
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.lfid = [aDecoder decodeObjectForKey:@"lfid"];
        self.lrid = [aDecoder decodeObjectForKey:@"lrid"];
        self.rfid = [aDecoder decodeObjectForKey:@"rfid"];
        self.rrid = [aDecoder decodeObjectForKey:@"rrid"];
        self.flUp = [aDecoder decodeFloatForKey:@"flup"];
        self.rlUp = [aDecoder decodeFloatForKey:@"rlup"];
        self.flLow = [aDecoder decodeFloatForKey:@"fllow"];
        self.rlLow = [aDecoder decodeFloatForKey:@"rllow"];
        self.temp = [aDecoder decodeFloatForKey:@"temp"];
        self.fUpRate = [aDecoder decodeFloatForKey:@"fuprate"];
        self.rUpRate = [aDecoder decodeFloatForKey:@"ruprate"];
        self.fLowRate = [aDecoder decodeFloatForKey:@"flowrate"];
        self.rLowRate = [aDecoder decodeFloatForKey:@"rlowrate"];
        self.pressUnit = [aDecoder decodeObjectForKey:@"pressunit"];
        self.tempUnit = [aDecoder decodeObjectForKey:@"tempunit"];
        self.isVoice = [aDecoder decodeBoolForKey:@"voice"];
        self.fRule = [aDecoder decodeFloatForKey:@"frule"];
        self.rRule = [aDecoder decodeFloatForKey:@"rrule"];
        self.voiceType = [aDecoder decodeIntegerForKey:@"voicetype"];
        self.isShake = [aDecoder decodeBoolForKey:@"shake"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_type forKey:@"type"];
    [aCoder encodeObject:_lfid forKey:@"lfid"];
    [aCoder encodeObject:_rfid forKey:@"rfid"];
    [aCoder encodeObject:_lrid forKey:@"lrid"];
    [aCoder encodeObject:_rrid forKey:@"rrid"];
    [aCoder encodeFloat:_flUp forKey:@"flup"];
    [aCoder encodeFloat:_rlUp forKey:@"rlup"];
    [aCoder encodeFloat:_flLow forKey:@"fllow"];
    [aCoder encodeFloat:_rlLow forKey:@"rllow"];
    [aCoder encodeFloat:_temp forKey:@"temp"];
    [aCoder encodeFloat:_fUpRate forKey:@"fuprate"];
    [aCoder encodeFloat:_rUpRate forKey:@"ruprate"];
    [aCoder encodeFloat:_fLowRate forKey:@"flowrate"];
    [aCoder encodeFloat:_rLowRate forKey:@"rlowrate"];
    [aCoder encodeObject:_pressUnit forKey:@"pressunit"];
    [aCoder encodeObject:_tempUnit forKey:@"tempunit"];
    [aCoder encodeFloat:_fRule forKey:@"frule"];
    [aCoder encodeFloat:_rRule forKey:@"rrule"];
    [aCoder encodeBool:_isVoice forKey:@"voice"];
    [aCoder encodeInteger:_voiceType forKey:@"voicetype"];
    [aCoder encodeBool:_isShake forKey:@"shake"];
}

-(void)setDefault{
    NSMutableArray *arr = Peripherals_Arr?[NSMutableArray arrayWithArray:Peripherals_Arr]:[NSMutableArray array];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [arr replaceObjectAtIndex:0 withObject:data];
    DEFAULTS_INFO(data, @"Device");
    DEFAULTS_SYNCHRONIZE;
    
    DEFAULTS_INFO(arr, @"Per");
    
    DEFAULTS_SYNCHRONIZE;
}

-(void)check{
    NSLog(@"lfid:%@",self.lfid);
    NSLog(@"lrid:%@",self.lrid);
    NSLog(@"rfid:%@",self.rfid);
    NSLog(@"rrid:%@",self.rrid);
    NSLog(@"name:%@",self.name);
    NSLog(@"pressUnit:%@",self.pressUnit);
    NSLog(@"tempUnit:%@",self.tempUnit);
    NSLog(@"type:%lu",(unsigned long)self.type);
    NSLog(@"flUp:%f",self.flUp);
    NSLog(@"rlUp:%f",self.rlUp);
    NSLog(@"flLow:%f",self.flLow);
    NSLog(@"rlLow:%f",self.rlLow);
    NSLog(@"temp:%f",self.temp);
    NSLog(@"fUpRate:%f",self.fUpRate);
    NSLog(@"rUpRate:%f",self.rUpRate);
    NSLog(@"fLowRate:%f",self.fLowRate);
    NSLog(@"rLowRate:%f",self.rLowRate);
    NSLog(@"voice:%d",_isVoice);
    NSLog(@"frule:%f",_fRule);
    NSLog(@"rrule:%f",_rRule);
    NSLog(@"voiceType:%lu",(unsigned long)_voiceType);
    NSLog(@"shake:%d",_isShake);
    
}

-(void)setDefaultValue{
    self.fRule = 240;
    self.rRule = 240;
    self.flUp = self.fRule*1.25;
    self.rlUp = self.rRule*1.25;
    self.flLow = self.fRule*0.75;
    self.rlLow = self.rRule*0.75;
    self.fUpRate = 0.25;
    self.rUpRate = 0.25;
    self.fLowRate = 0.25;
    self.rLowRate = 0.25;
    self.temp = 80;
    [self setDefault];
}

@end
