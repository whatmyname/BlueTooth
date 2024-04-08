//
//  SynchroVoiceViewController_3.m
//  Bugoo
//
//  Created by bugoo on 14/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "SynchroVoiceViewController_3.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "SearchView.h"
#define endian8         1
#define Poly8_Normal	0x07
#define Poly8_Mirror	0xE0
#define Crc8_Init       0x00
#define Crc8_XorOut     0x00
@interface SynchroVoiceViewController_3 ()<CBCentralManagerDelegate, CBPeripheralDelegate>
{
    NSTimer *timer;
    UIView *syView;
    UIButton *sybutton;
}
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic, strong) CBCentralManager *cbCentralManager;
@property (strong, nonatomic) CBPeripheral *peripheral;
@property (strong,nonatomic)SearchView *searchView;
@property (strong,nonatomic)CBCharacteristic *characteristic;
@property (strong,nonatomic)Model *model;
@property (strong,nonatomic)UIImageView *icon;
@property (nonatomic,strong)UILabel *nickName;
@end

@implementation SynchroVoiceViewController_3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = HXString(@"同步语音棒-3");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:HXString(@"关闭") style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    
    NSData *data = currentD;
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [Utility colorWithHexString:@"ffffff"];
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[Utility colorWithHexString:@"ffffff"]}];
    self.model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64)];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    
    [self.view addSubview:_rootView];
    [self createUI];
    
    // Do any additional setup after loading the view.
}

-(void)createUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(32), WIDTH(self.view), Adapt_IPHONE6_scaleV(56))];
    [_rootView addSubview:label];
    
    label.text = HXString(@"搜索语音棒\n同步信息到语音棒中");
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [Utility colorWithHexString:@"333333"];
    label.font = [UIFont systemFontOfSize:20];
    [_rootView addSubview:label];
    
    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(47, 91, 280, 50)];
    [search setTitle:HXString(@"搜索语音棒") forState:UIControlStateNormal];
    [search setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];
    [search setBackgroundColor:[Utility colorWithHexString:@"d8d8d8"]];
    search.layer.cornerRadius = 25;
    if (kIsIphone5) {
        search.layer.cornerRadius = 15;
    }
    search.layer.borderWidth = 1;
    search.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
    [search addTarget:self action:@selector(scan:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:search];
    
    _icon = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(150, 171, 75, 241)];
    _icon.image = [UIImage imageNamed:@"s3"];
    _icon.hidden = YES;
    [_rootView addSubview:_icon];
    
    _nickName = [[UILabel alloc]initWithFrame:CGRectMake(0, Adapt_IPHONE6_scaleV(421), WIDTH(self.view), Adapt_IPHONE6_scaleV(22))];
    _nickName.textAlignment = NSTextAlignmentCenter;
    _nickName.font = [UIFont systemFontOfSize:16];
    _nickName.textColor = [Utility colorWithHexString:@"323232"];
    
    [_rootView addSubview:_nickName];
    
    
    
    sybutton = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(98, 499, 180, 50)];
    [sybutton setTitle:HXString(@"开始同步") forState:UIControlStateNormal];
    [sybutton setTitleColor:[Utility colorWithHexString:@"555555"] forState:UIControlStateNormal];
    [sybutton setBackgroundColor:[Utility colorWithHexString:@"d8d8d8"]];
    sybutton.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor;
    sybutton.layer.cornerRadius = 15;
    sybutton.hidden = YES;
    sybutton.layer.borderWidth = 1;
    [sybutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    sybutton.userInteractionEnabled = NO;
    [_rootView addSubview:sybutton];
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -蓝牙搜索区
- (void)scan:(UIButton *)button{
    if (_cbCentralManager==nil) {
        _cbCentralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }else{
        [_cbCentralManager scanForPeripheralsWithServices:nil options:nil];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(time) userInfo:nil repeats:NO];
    _searchView = [[SearchView alloc]initWithFrame:_rootView.bounds];
    _searchView.string = @"搜索设备中";
    __block CBCentralManager *cb = self.cbCentralManager;
    _searchView.Cancel = ^{
        [cb stopScan];
        [timer invalidate];
        timer = nil;
    };
    [_rootView addSubview:_searchView];
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *string = [advertisementData objectForKey:@"kCBAdvDataLocalName"] ;
    NSLog(@"%@",string);
    if ([string hasPrefix:@"TPMS_Dongle"]) {
        self.peripheral = peripheral;
        [_searchView removeFromSuperview];
        _nickName.text = [string stringByReplacingOccurrencesOfString:@"TPMS_Dongle" withString:@"Bugoo_MotoGo"];
        [sybutton setTitleColor:[Utility colorWithHexString:@"007acc"] forState:UIControlStateNormal];
        sybutton.userInteractionEnabled = YES;
        sybutton.hidden = NO;
        [timer invalidate];
        _icon.hidden = NO;
    
        
        [_cbCentralManager connectPeripheral:self.peripheral options:nil];
        
    }
    
}

-(void)time{
    [_searchView removeFromSuperview];
    [_cbCentralManager stopScan];
    [Utility topAlertView:@"请确定语音棒是否处于可搜索状态并手动开始搜索语音棒"];
}

-(void)click:(UIButton *)button{
    if ([button.currentTitle isEqualToString:HXString(@"开始同步")]) {
        syView = [[UIView alloc]initWithFrame:self.view.bounds];
        UIView *whiteView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0,Adapt_IPHONE6_scaleL(320),Adapt_IPHONE6_scaleV(130))];
        whiteView.backgroundColor = [Utility colorWithHexString:@"ffffff"];
        whiteView.center =CGPointMake(WIDTH(syView)/2, HEIGHT(syView)/2);
        whiteView.layer.cornerRadius = 15;
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0,Adapt_IPHONE6_scaleV(25), WIDTH(whiteView),Adapt_IPHONE6_scaleV(18))];
        title.text = @"资料同步中";
        title.textColor = [Utility colorWithHexString:@"000000"];
        title.font = [UIFont systemFontOfSize:18 weight:10];
        title.textAlignment = NSTextAlignmentCenter;
        [whiteView addSubview:title];
        
        
        UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,Adapt_IPHONE6_scaleL(290), HEIGHT(whiteView)-MAXY(whiteView))];
        detail.text = @"1、语音棒需接入电源 \n2、请勿强制退出APP \n3、确保语音棒为蓝牙配对模式";
        detail.font = [UIFont systemFontOfSize:14];
        detail.textColor = [Utility colorWithHexString:@"000000"];
        detail.center = CGPointMake(WIDTH(whiteView)/2, HEIGHT(whiteView)/2+10);
        detail.numberOfLines = 4;
        [whiteView addSubview:detail];
        [syView addSubview:whiteView];
        [[Utility mainWindow] addSubview:syView];
        
        [self write:0];

        [button setTitle:HXString(@"完成") forState:UIControlStateNormal];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
        
 
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state==CBManagerStatePoweredOn) {
        [_cbCentralManager scanForPeripheralsWithServices:nil options:nil];
        
    }
}


-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [_cbCentralManager stopScan];
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
}



- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    if(error){
        NSLog(@"%@",error);
    }
    for (CBService *service in peripheral.services)
    {
        
        [peripheral discoverCharacteristics:nil forService:service];
    }
}



- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    for (CBCharacteristic *characteristic in service.characteristics){
        NSLog(@"%@",characteristic);
        
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        //如果需要更新Characteristic的值
        [peripheral readValueForCharacteristic:characteristic];
        
        //如果搜索Characteristic的Descriptors
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FD01"]]) {
            NSLog(@"%@",characteristic.value);
        }
        
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FD02"]]){
            self.characteristic = characteristic;
            
        }
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FD01"]]) {
        NSString *read = [[Utility toBtye:characteristic.value.bytes length:characteristic.value.length] uppercaseString];
        if ([read isEqualToString:@"74"]) {
            [self write:1];
        }else if ([read isEqualToString:@"B4"]) {
            _model.isVoice = YES;
            [_model setDefault];
            [self.cbCentralManager cancelPeripheralConnection:self.peripheral];
            sleep(1);
            [syView removeFromSuperview];
            
            
        }
    }
}

- (void)write:(int)tireID{

    
    float FHString = _model.flUp;
    float FLString = _model.flLow;
    float RHString = _model.rlUp;
    float RLString = _model.rlLow;
    
    NSString *FH = [Utility ToHex:FHString/2.5];
    NSString *FL = [Utility ToHex:FLString/2.5];
    NSString *RH = [Utility ToHex:RHString/2.5];
    NSString *RL = [Utility ToHex:RLString/2.5];
    
    NSString *unitString;
    
    if ([self.model.pressUnit isEqualToString:@"KPA"]) {
        unitString = @"02";
        
    }else if ([self.model.pressUnit isEqualToString:@"BAR"]){
        
        unitString = @"04";
    }else{
        
        unitString = @"01";
    }
    
    
    NSString *temp = [Utility ToHex:self.model.temp+40];
    
    NSString *string_content;
    if (tireID==0) {
        
        string_content = [NSString stringWithFormat:@"5510000%@00%@00%@%@%@",_model.lfid,FH,FL,temp,unitString];
        
    }else if(tireID==1){
        
        string_content = [NSString stringWithFormat:@"5550000%@00%@00%@%@%@",_model.rfid,RH,RL,temp,unitString];
        
    }
    
    char *data = [string_content cStringUsingEncoding:NSASCIIStringEncoding];
    
    int i,len=strlen(data)/2;
    unsigned char *a=(unsigned char *)malloc(sizeof(char)*len);
    for(i=0;i<len;i++){
        sscanf(data+i*2,"%2X",a+i);
        
        printf("%02X ",a[i]);
    }
    
    unsigned char crc8Result;
    init_crc8_table();
    crc8Init(&crc8Result);
    crc8Update(&crc8Result, a, 12);
    crc8Finish(&crc8Result);
    
    printf("%x",crc8Result);
    
    
    NSString *string = [NSString stringWithFormat:@"%@%X",string_content,crc8Result];
    
    NSLog(@"%@",string);
    
    if ([string length]%2!=0)
    {
        string = [NSString stringWithFormat:@"%@0%x",string_content,crc8Result];
    }
    
    
    NSLog(@"+++++++%@+++++++++",[self stringToByte:string]);
    if (self.characteristic) {
        
        [self.peripheral writeValue:[self stringToByte:string] forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    }
    
    
    
}


- (NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0)
    {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16; //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        tempbyt[0] = int_ch1+int_ch2; ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}


-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"%@",characteristic);
    if (error) {
        NSLog(@"%@",error);
    }else{
        //        [syView removeFromSuperview];
        //        [_cbCentralManager cancelPeripheralConnection:self.peripheral];
    }
}


#pragma CRC8


unsigned char crc8table[256];
void init_crc8_table() {
    //#if endian8
    unsigned char Poly = Poly8_Normal;
    for (int i=0; i<256; i++) {
        unsigned char crc = i;
        for (unsigned char j=0; j<8; j++)
            crc = (crc << 1) ^ ((crc & 0x80) ? Poly : 0);
        crc8table[i] = crc & 0xFF;
    }
    //#else
    //    unsigned char Poly = Poly8_Mirror;
    //    for (unsigned short i = 0; i < 256; i++ ) {
    //        unsigned short crc = i;
    //        for ( unsigned char j = 0; j < 8; j++ )
    //            crc = (crc >> 1) ^ ((crc & 0x01) ? Poly : 0);
    //        crc8table[i] = crc & 0xFF;
    //    }
    //#endif
}
void crc8Init(unsigned char *pCrc8) {
    *pCrc8 = Crc8_Init;
}
void crc8Update(unsigned char *pCrc8, unsigned char *pData, unsigned int uSize){
    //#if endian8
    for (unsigned int i = 0; i < uSize; i++)
        *pCrc8 = crc8table[pData[i] ^ *pCrc8];
    //*pCrc8 = ((*pCrc8) << 8) ^ crc8table[(pData[i] ^ (*pCrc8 >> 0)) & 0xFF];
    //*pCrc8 = 0 ^ crc8table[(pData[i] ^ *pCrc8) & 0xFF];
    //#else
    //    for(unsigned int i = 0; i < uSize; i++)
    //        *pCrc8 = ((*pCrc8) >> 8) ^ crc8table[(pData[i] ^ *pCrc8) & 0xFF];
    //#endif
}
void crc8Update_Direct(unsigned char *pCrc8, unsigned char *pData, unsigned int uSize) {
    //#if endian8
    //code needed
    //#else
    for (int i = 0; i < uSize; i++) {
        *pCrc8 ^= pData[i];
        for (int j = 0; j < 8; j++) {
            *pCrc8 = (*pCrc8 >> 1) ^ ((*pCrc8 & 0x01) ? Poly8_Mirror : 0);
        }
    }
    //#endif
}
void crc8Finish(unsigned char *pCrc8) {
    *pCrc8 ^= Crc8_XorOut;
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
