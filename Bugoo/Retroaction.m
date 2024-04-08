//
//  Retroaction.m
//  Bugoo
//
//  Created by bugoo on 18/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "Retroaction.h"
#import "AFNetworking.h"
#import "zlib.h"
//#import "LFCGzipUtillity.h"

#define RetPath @"http://bugoo.vigorddns.com:8888/retroaction"
@interface Retroaction ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,strong)UITextView *text;
@property (nonatomic,strong)UILabel *number;
@property (nonatomic,strong)UITextField *email;
@end

@implementation Retroaction

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootView = [[UIView alloc]initWithFrame:self.view.bounds];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    self.title = HXString(@"意见反馈");
    [self.view addSubview:_rootView];
    [self createUI];
}

-(void)createUI{
    _text = [[UITextView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(24, 16, 327, 171)];
    _text.layer.cornerRadius = 8;
    _text.delegate = self;
    _text.font = [UIFont systemFontOfSize:14];
    _text.text = HXString(@"感谢您提出宝贵的意见");
    _text.textColor = [Utility colorWithHexString:@"a2a2a2"];
    [_rootView addSubview:_text];
    
    _number = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(246, 148, 66, 17)];
    _number.font = [UIFont systemFontOfSize:12];
    _number.textColor = [Utility colorWithHexString:@"999999"];
    _number.text = @"0/200";
    _number.textAlignment = NSTextAlignmentRight;
    [_text addSubview:_number];
    
    _email = [[UITextField alloc]initWithFrame:CGRectMakeIPHONE6Adapt(24, 197, 327, 45)];
    _email.layer.cornerRadius = 8;
    _email.delegate = self;
    _email.textAlignment = NSTextAlignmentCenter;
    _email.backgroundColor = [Utility colorWithHexString:@"ffffff"];
    _email.placeholder = HXString(@"邮箱");
    _email.keyboardType = UIKeyboardTypeEmailAddress;
    [_rootView addSubview:_email];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMakeIPHONE6Adapt(0, 250, 375, 20)];
    label.text = HXString(@"我们会尽快与您联系");
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [Utility colorWithHexString:@"666666"];
    label.textAlignment = NSTextAlignmentCenter;
    [_rootView addSubview:label];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMakeIPHONE6Adapt(98, 310, 180, 50)];
    button.layer.cornerRadius = 15;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [Utility colorWithHexString:@"babfbf"].CGColor; 
    [button setTitle:HXString(@"提交") forState:UIControlStateNormal];
    [button setBackgroundColor:[Utility colorWithHexString:@"d8d8d8"]];
    [button setTitleColor:[Utility colorWithHexString:@"007acc"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [_rootView addSubview:button];
    
    
    
}


-(void)submit:(UIButton *)button{
    
    NSDictionary *parameters = @{@"opinion":_text.text,@"email":_email.text};
    
    
    if ([Utility checkEmail:_email.text]&&_text.text.length>0) {
            //创建URL对象
            NSURL *url =[NSURL URLWithString:RetPath];
            //创建请求对象
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
            NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:nil error:nil];
            NSData *zipData = [self gzipData:data];
            [request setHTTPMethod:@"post"];
            [request setHTTPBody:zipData];
            
            // 3 建立会话 session支持三种类型的任务
            
            //    NSURLSessionDataTask  //加载数据
            //    NSURLSessionDownloadTask  //下载
            //    NSURLSessionUploadTask   //上传
            NSURLSession *session =[NSURLSession sharedSession];
            //    NSLog(@"%d",[[NSThread currentThread] isMainThread]);
            __block UITextView *tt = _text;
            __block UITextField *ee = _email;
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSLog(@"%@",response);
                //解析
                if (error==nil) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    if ([dic[@"success"]isEqualToString:@"true"]) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                        [Utility topAlertView:HXString(@"感谢您提出宝贵的意见")];
                        tt.text = HXString(@"感谢您提出宝贵的意见");
                        tt.textColor = [Utility colorWithHexString:@"a2a2a2"];
                        ee.text = @"";
                        });
                    }
                    
                }else{
                    NSLog(@"%@",response);
                    //            [_sendDataTimer setFireDate:[NSDate distantFuture]];
                }
                //        dispatch_async(dispatch_get_main_queue(), ^{
                //            //            [temp.tableView reloadData];
                //        
                //            
                //        });
            }];
            
            //启动任务
            [dataTask resume];
        

    }else if([_text.text isEqualToString:HXString(@"感谢您提出宝贵的意见")]){
        [Utility topAlertView:HXString(@"请提出您的意见")];
    }else{
        [Utility topAlertView:HXString(@"请填写正确的邮箱地址")];
    }
    
    
    
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_text resignFirstResponder];
    [_email resignFirstResponder];
    if (_text.text.length==0) {
        _text.text =HXString(@"感谢您提出宝贵的意见");
        _text.textColor = [Utility colorWithHexString:@"a2a2a2"];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:HXString(@"感谢您提出宝贵的意见")]) {
        textView.text = nil;
        textView.textColor = [Utility colorWithHexString:@"000000"];
    }else{
        
    }
}


-(void)textViewDidChange:(UITextView *)textView{
    
    _number.text = [NSString stringWithFormat:@"%lu/200",textView.text.length];
    
}


- (NSData *)gzipData:(NSData *)pUncompressedData
{
    if (!pUncompressedData || [pUncompressedData length] == 0) {
        NSLog(@"%s: Error: Can't compress an empty or nil NSData object",__func__);
        return nil;
    }
    
    z_stream zlibStreamStruct;
    zlibStreamStruct.zalloc = Z_NULL;
    zlibStreamStruct.zfree = Z_NULL;
    zlibStreamStruct.opaque = Z_NULL;
    zlibStreamStruct.total_out = 0;
    zlibStreamStruct.next_in = (Bytef *)[pUncompressedData bytes];
    zlibStreamStruct.avail_in = [pUncompressedData length];
    
    int initError = deflateInit2(&zlibStreamStruct, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);
    if (initError != Z_OK) {
        NSString *errorMsg = nil;
        switch (initError) {
            case Z_STREAM_ERROR:
                errorMsg = @"Invalid parameter passed in to function.";
                break;
            case Z_MEM_ERROR:
                errorMsg = @"Insufficient memory.";
                break;
            case Z_VERSION_ERROR:
                errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                break;
            default:
                errorMsg = @"Unknown error code.";
                break;
        }
        NSLog(@"%s:deflateInit2() Error: \"%@\" Message: \"%s\"",__func__,errorMsg,zlibStreamStruct.msg);
        return nil;
    }
    
    NSMutableData *compressedData = [NSMutableData dataWithLength:[pUncompressedData length] * 1.01 + 21];
    
    int deflateStatus;
    do {
        zlibStreamStruct.next_out = [compressedData mutableBytes] + zlibStreamStruct.total_out;
        zlibStreamStruct.avail_out = [compressedData length] - zlibStreamStruct.total_out;
        deflateStatus = deflate(&zlibStreamStruct, Z_FINISH)	;
        
    } while (deflateStatus == Z_OK);
    
    if (deflateStatus != Z_STREAM_END)
    {
        
        NSString *errorMsg = nil;
        switch (deflateStatus) {
            case Z_ERRNO:
                errorMsg = @"Error occured while reading file.";
                break;
            case Z_STREAM_ERROR:
                errorMsg = @"The stream state was inconsistent (e.g., next_in or next_out was NULL).";
                break;
            case Z_DATA_ERROR:
                errorMsg = @"The deflate data was invalid or incomplete.";
                break;
            case Z_MEM_ERROR:
                errorMsg = @"Memory could not be allocated for processing.";
                break;
            case Z_BUF_ERROR:
                errorMsg = @"Ran out of output buffer for writing compressed bytes.";
                break;
            case Z_VERSION_ERROR:
                errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                break;
            default:
                errorMsg = @"Unknown error code.";
                break;
        }
        NSLog(@"%s:zlib error while attempting compression: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        deflateEnd(&zlibStreamStruct);
        return nil;
    }
    
    deflateEnd(&zlibStreamStruct);
    [compressedData setLength:zlibStreamStruct.total_out];
    //	NSLog(@"%s: Compressed file from %d B to %d B", __func__, [pUncompressedData length],[compressedData length]);
    return compressedData;
    
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
