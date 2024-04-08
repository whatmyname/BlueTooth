//
//  FMDBManager.h
//  BlueSQL
//
//  Created by bugoo on 24/11/16.
//  Copyright © 2016年 bugoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface FMDBManager : NSObject
@property (nonatomic,assign)BOOL isUse;
+(FMDBManager *)createDBbase;
+(FMDBManager *)createDBbase1;
- (void)connectDBbase;
- (NSMutableArray *)selectDB:(NSString*)maxID;
- (BOOL)insertData:(NSDictionary*)dic;
-(BOOL)deleteData;
- (BOOL)updateData:(NSString *)tid;
- (NSString *)getMaxID;
- (void)parserDate;
- (FMResultSet *)selectDB:(NSString *)beginTime and:(NSString *)endTime andUnite:(int)unit;
- (void)insertQ;
//- (void)close;
@end
