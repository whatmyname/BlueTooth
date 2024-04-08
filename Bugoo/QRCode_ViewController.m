 //
//  QRCode_ViewController.m
//  Bugoo
//
//  Created by bugoo on 6/4/17.
//  Copyright © 2017年 LoveGuoGuo. All rights reserved.
//

#import "QRCode_ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface QRCode_ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    float mywidth;
    float myheight;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@end

@implementation QRCode_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mywidth = WIDTH(self.view)/375;
    myheight = HEIGHT(self.view)/667;
    [self createUI];
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if (kIsIphone5) {
         _output.rectOfInterest = CGRectMake(0.3,0.2,230/HEIGHT(self.view), 230/WIDTH(self.view));
      
    }else if(kIsIphone6){
        _output.rectOfInterest = CGRectMake(0.3,0.2,250/HEIGHT(self.view), 250/WIDTH(self.view));
      
    }else{
        _output.rectOfInterest = CGRectMake(0.3,0.2,276/HEIGHT(self.view), 276/WIDTH(self.view));
      
    }
//    _output.rectOfInterest = CGRectMake(0.5,0.5,0.5, 0.5);

    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    [_session startRunning];
}

-(void)createUI{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250*mywidth, 250*mywidth)];
//    view.layer.borderColor = [Utility colorWithHexString:@"ffffff"].CGColor;
//    view.layer.borderWidth = 2;
//    view.center = self.view.center;
//    [self.view addSubview:view];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, MAXY(view.frame)+25*myheight, WIDTH(self.view), 12)];
//    label.text = @"将QR码放入框内，即可自动扫描学习";
//    label.textColor = [Utility colorWithHexString:@"f1f1f1"];
//    label.font = [UIFont systemFontOfSize:12];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:label];
//    UIImageView *image;
//    if (kIsIphone5) {
//            image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QR-code-5"]];
//    }else if(kIsIphone6){
//        image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QR-code-6"]];
//        
//    }else{
//        image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QR-code6p"]];
//    }
//    [image setFrame:self.view.bounds];
//    
//    [self.view addSubview:image];
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    view.backgroundColor = [Utility colorWithHexString:@"000000" andAlpha:.1];
    UIImageView *im = [[UIImageView alloc]initWithFrame:view.bounds];
    im.image = [UIImage imageNamed:@"QRback"];
    [view addSubview:im];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 430, 375, 20)];
    label.text = HXString(@"放入框内，自动扫描");
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [Utility colorWithHexString:@"f1f1f1"];
    [view addSubview:label];
    label.font = [UIFont systemFontOfSize:12];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(78, 180, 220, 220)];
    image.image = [UIImage imageNamed:@"border"];
    [view addSubview:image];
    image.layer.borderColor = [Utility colorWithHexString:@"007acc"].CGColor;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 0, 58, 58)];
    [button setImage:[UIImage imageNamed:@"QR_close"] forState:UIControlStateNormal];
    button.center = CGPointMake(view.center.x, HEIGHT(self.view)-(15+25)*myheight);
    [view addSubview:button];
    [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *light = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(159, 525, 58, 58)];
    [light setBackgroundImage:[UIImage imageNamed:@"light"] forState:UIControlStateNormal];
    [view addSubview:light];
    
    [light addTarget:self action:@selector(onOrOff:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onOrOff:(UIButton *)button{
    button.selected = !button.selected;
    if (button.isSelected == YES) { //打开闪光灯
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
    }else{//关闭闪光灯
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
    }
}




-(void)cancel:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // id 类型不能点语法,所以要先去取出数组中对象
    AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
    
    if (object == nil) return;
    // 只要扫描到结果就会调用
    NSLog(@"%@",object.stringValue);
    NSString *string = object.stringValue;
    [_session stopRunning];
    if (string.length!=5) {
        [Utility topAlertView:@"二维码不正确，请重新扫描"];
    }else{        _callback(string);
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
