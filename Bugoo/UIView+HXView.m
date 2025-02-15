//
//  UIView+HXView.m
//  Masonry
//
//  Created by bugoo on 17/5/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//




#import "UIView+HXView.h"

#define IPHONE6_P_Height 736
#define IPHONE6_P_Wideth 414

#define IPHONE6_Height 667
#define IPHONE6_Wideth 375

#define IPHONE5_Height 568
#define IPHONE5_Wideth 320

#define IPHONE4_Height 480
#define IPHONE4_Wideth 320

/**
 比例数据    供参考
 
 6p/6 width: 736/667 = 1.103448  height:414/375 = 1.104
 
 6/5  width: 667/568 = 1.174296  height:375/320 = 1.171875
 
 6p/5 width: 736/568 = 1.295775  height:414/320 = 1.29
 
 5/4  width: 568/480 = 1.183333  height:320/320 = 1.0
 
 // 选择适配方法为 : 比例尺 =  设备屏幕物理尺寸宽/设计图物理尺寸宽 (pt/pt)
 */

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/** 获取分辨率尺寸 */
#define SCREEN_SCALE_WIDTH [[UIScreen mainScreen] currentMode].size.width;
#define SCREEN_SCALE_HEIGHT [[UIScreen mainScreen] currentMode].size.height;

/** 获取物理屏尺寸 */
#define ZM_SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define ZM_SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

// 比例
#define Adapt_PROPORTION_IPHONE_4_WIDTH ZM_SCREENWIDTH / IPHONE4_Wideth
#define Adapt_PROPORTION_IPHONE_4_HEIGHT ZM_SCREENHEIGHT / IPHONE4_Height

#define Adapt_PROPORTION_IPHONE_5_WIDTH ZM_SCREENWIDTH /IPHONE5_Wideth
#define Adapt_PROPORTION_IPHONE_5_HEIGHT ZM_SCREENHEIGHT /IPHONE5_Height

#define Adapt_PROPORTION_IPHONE_6_WIDTH ZM_SCREENWIDTH / IPHONE6_Wideth
#define Adapt_PROPORTION_IPHONE_6_HEIGHT ZM_SCREENHEIGHT / IPHONE6_Height

#define Adapt_PROPORTION_IPHONE_6_PLUS_WIDTH ZM_SCREENWIDTH / IPHONE6_P_Wideth
#define Adapt_PROPORTION_IPHONE_6_PLUS_HEIGHT ZM_SCREENHEIGHT / IPHONE6_P_Height




@implementation UIView (HXView)

#pragma mark - 枚举 设计图类型
/**  适配类型 设计图类型 */
typedef NS_ENUM(NSInteger, kAdaptModelType) {
    /**  5/5s设计图适配 */
    kTypeIPHONE5   = 0 ,
    /**  6设计图适配 */
    kTypeIPHONE6   = 1,
    /**  6+设计图适配 */
    kTypeIPHONE6P  = 2,
    /**  4设计图适配 */
    kTypeIPHONE4   = 3
};




// 比例尺
kAdaptModelType kType = kTypeIPHONE6;

#pragma mark - 默认选择iPhone5设计图模板

CGPoint CGPointMakeAdapt(CGFloat x, CGFloat y)
{
    kType = kTypeIPHONE5;
    
    return AdaptCGPointMake(x,y);
}

CGSize CGSizeMakeAdapt(CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE5;
    
    return AdaptCGSizeMake( width , height );
}

CGRect CGRectMakeAdapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE5;
    
    return AdaptCGRectMake(x, y, width, height);
}

UIEdgeInsets UIEdgeInsetsMakeAdapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    kType = kTypeIPHONE5;
    
    return AdaptUIEdgeInsetsMake( top, left, bottom, right);
}

#pragma mark - 选择适配方式

#pragma mark 设计图为IPHONE4

CGFloat Adapt_IPHONE4_scaleL(CGFloat level){
    
    kType = kTypeIPHONE4;
    
    return  Adapt_scaleL(level);
}

CGFloat Adapt_IPHONE4_scaleV(CGFloat vertical){
    
    kType = kTypeIPHONE4;
    
    return Adapt_scaleV(vertical);
}

CGPoint CGPointMakeIPHONE4Adapt(CGFloat x, CGFloat y)
{
    kType = kTypeIPHONE4;
    
    return AdaptCGPointMake(x,y);
}

CGSize CGSizeMakeIPHONE4Adapt(CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE4;
    
    return AdaptCGSizeMake( width , height );
}

CGRect CGRectMakeIPHONE4Adapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE4;
    
    return AdaptCGRectMake(x, y, width, height);
}

UIEdgeInsets UIEdgeInsetsMakeIPHONE4Adapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    kType = kTypeIPHONE4;
    
    return AdaptUIEdgeInsetsMake( top, left, bottom, right);
}

#pragma mark 设计图为IPHONE5/5s

CGFloat Adapt_IPHONE5_scaleL(CGFloat level){
    
    kType = kTypeIPHONE5;
    
    return  Adapt_scaleL(level);
}

CGFloat Adapt_IPHONE5_scaleV(CGFloat vertical){
    
    kType = kTypeIPHONE5;
    
    return Adapt_scaleV(vertical);
}

CGPoint CGPointMakeIPHONE5Adapt(CGFloat x, CGFloat y)
{
    kType = kTypeIPHONE5;
    
    return AdaptCGPointMake(x,y);
}

CGSize CGSizeMakeIPHONE5Adapt(CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE5;
    
    return AdaptCGSizeMake( width , height );
}

CGRect CGRectMakeIPHONE5Adapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE5;
    
    return AdaptCGRectMake(x, y, width, height);
}

UIEdgeInsets UIEdgeInsetsMakeIPHONE5Adapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    kType = kTypeIPHONE5;
    
    return AdaptUIEdgeInsetsMake( top, left, bottom, right);
}

#pragma mark 设计图为IPHONE6

CGFloat Adapt_IPHONE6_scaleL(CGFloat level){
    
    kType = kTypeIPHONE6;
    
    return  Adapt_scaleL(level);
}

CGFloat Adapt_IPHONE6_scaleV(CGFloat vertical){
    
    kType = kTypeIPHONE6;
    
    return Adapt_scaleV(vertical);
}

CGPoint CGPointMakeIPHONE6Adapt(CGFloat x, CGFloat y)
{
    kType = kTypeIPHONE6;
    
    return AdaptCGPointMake(x,y);
}

CGSize CGSizeMakeIPHONE6Adapt(CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE6;
    
    return AdaptCGSizeMake( width , height );
}

CGRect CGRectMakeIPHONE6Adapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE6;
    
    return AdaptCGRectMake(x, y, width, height);
}

UIEdgeInsets UIEdgeInsetsMakeIPHONE6Adapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    kType = kTypeIPHONE6;
    
    return AdaptUIEdgeInsetsMake( top, left, bottom, right);
}

#pragma mark 设计图为IPHONE6P

CGFloat Adapt_IPHONE6P_scaleL(CGFloat level){
    
    kType = kTypeIPHONE6P;
    
    return  Adapt_scaleL(level);
}

CGFloat Adapt_IPHONE6P_scaleV(CGFloat vertical){
    
    kType = kTypeIPHONE6P;
    
    return Adapt_scaleV(vertical);
}

CGPoint CGPointMakeIPHONE6PAdapt(CGFloat x, CGFloat y)
{
    kType = kTypeIPHONE6P;
    
    return AdaptCGPointMake(x,y);
}

CGSize CGSizeMakeIPHONE6PAdapt(CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE6P;
    
    return AdaptCGSizeMake( width , height );
}

CGRect CGRectMakeIPHONE6PAdapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    kType = kTypeIPHONE6P;
    
    return AdaptCGRectMake(x, y, width, height);
}

UIEdgeInsets UIEdgeInsetsMakeIPHONE6PAdapt(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    kType = kTypeIPHONE6P;
    
    return AdaptUIEdgeInsetsMake( top, left, bottom, right);
}

#pragma mark - 适配

#pragma mark scale

//CGFloat scale_L(CGFloat level)      {return Adapt_scaleL(level);}
//CGFloat scale_V(CGFloat vertical)   {return Adapt_scaleV(vertical);}

CGFloat Adapt_scaleL(CGFloat level){
    
    CGFloat scale_L = Adapt_PROPORTION_IPHONE_5_WIDTH;
    
    switch (kType) {
        case kTypeIPHONE4:
            scale_L = Adapt_PROPORTION_IPHONE_4_WIDTH;
            break;
        case kTypeIPHONE6:
            scale_L = Adapt_PROPORTION_IPHONE_6_WIDTH;
            break;
        case kTypeIPHONE6P:
            scale_L = Adapt_PROPORTION_IPHONE_6_PLUS_WIDTH;
            break;
        default:
            break;
    }
    
    return level*scale_L;
}

CGFloat Adapt_scaleV(CGFloat vertical){
    
    return Adapt_scaleL(vertical);
}

#pragma mark adapt

CGPoint AdaptCGPointMake(CGFloat x, CGFloat y)
{
    return CGPointMake(Adapt_scaleL(x), Adapt_scaleV(y));
}

CGSize AdaptCGSizeMake(CGFloat width, CGFloat height)
{
    return CGSizeMake( Adapt_scaleL(width) , Adapt_scaleV(height));
}

CGRect AdaptCGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    return CGRectMake(Adapt_scaleL(x), Adapt_scaleV(y), Adapt_scaleL(width), Adapt_scaleV(height));
}

UIEdgeInsets AdaptUIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    return UIEdgeInsetsMake(Adapt_scaleV(top), Adapt_scaleL(left), Adapt_scaleV(bottom), Adapt_scaleL(right));
}


@end
