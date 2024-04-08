//
//  FMDBManager.m
//  BlueSQL
//
//  Created by bugoo on 24/11/16.
//  Copyright © 2016年 bugoo. All rights reserved.
//

#import "FMDBManager.h"

@interface FMDBManager()
@property (nonatomic,assign)NSInteger tireID;
@property (nonatomic,strong)FMDatabase *dateBase;

@end


@implementation FMDBManager
static FMDBManager *fm;
static FMDBManager *fm1;

-(instancetype)init{
    if (self = [super init]) {
        [self connectDBbase];
    }
    return self;
}

+(FMDBManager *)createDBbase{
    @synchronized(self) {
        if (!fm) {
            fm = [[FMDBManager alloc]init];
        }
    }

    return fm;
}


+(FMDBManager *)createDBbase1{
    @synchronized(self) {
        if (!fm1) {
            fm1 = [[FMDBManager alloc]init];
        }
    }
    
    return fm1;
}



- (void)connectDBbase{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/tireData.sqlite",NSHomeDirectory()];
#if defined(DEBUG)
    NSLog(@"%@",path);
#endif
    _dateBase = [[FMDatabase alloc]initWithPath:path];
    
    if ([_dateBase open]) {
        NSLog(@"数据库打开成功");
        NSString * createTable = @"CREATE TABLE IF NOT EXISTS  TireLog (id integer,d integer,v integer(1),p integer(2),t integer(1),mac text,tchangvalue integer(1),upload integer(1),n integer(1))";
        NSString * createPTable = @"CREATE TABLE IF NOT EXISTS q (i INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,n INTEGER);";

        BOOL flag = [_dateBase executeUpdate:createTable];
        BOOL pflag = [_dateBase executeUpdate:createPTable];
#if defined(DEBUG)
        if (flag) {
            NSLog(@"----创建表成功----");
        }else{
            NSLog(@"++++创建表失败+++");
        }
        if (pflag) {
            NSLog(@"-----创建表成功-----");
        }else{
            NSLog(@"------创建P表失败-----");
        }
        
#endif
    }else{
#if defined(DEBUG)
            NSLog(@"数据库打开失败");
#endif
    }
    
}
- (NSMutableArray *)selectDB:(NSString*)maxID{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    if([_dateBase open]){
        self.tireID = 0;
        _isUse = YES;
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM TireLog where id<=? and upload = 0"];
        //    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM TireLog "];
        
        //    @"select * from TireLog where upload = 0";
        FMResultSet *set = [_dateBase executeQuery:selectSql,maxID];
 
        
        while(set.next) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            
            
            [dic setValue:[set stringForColumn:@"d"] forKey:@"d"];
            //        NSLog(@"%@",model.time);
            
            [dic setValue:[set stringForColumn:@"v"] forKey:@"v"];
            //        NSLog(@"%@",model.tele);
            
            [dic setValue:[set stringForColumn:@"p"] forKey:@"p"];
            //        NSLog(@"%@",model.tpress);
            
            [dic setValue:[set stringForColumn:@"t"] forKey:@"t"];
            //        NSLog(@"%@",model.ttemp);
            
            [dic setValue:[set stringForColumn:@"n"] forKey:@"n"];
            //        NSLog(@"%@",model.tno);
            
            [dic setValue:[set stringForColumn:@"mac"] forKey:@"mac"];
            //        NSLog(@"%@",model.tmac);
            
            //        NSLog(@"%@",model.tchangvalue);
            //        [dic setValue:[set stringForColumn:@"tchangvalue"] forKey:@"tchangvalue"];
            //        NSLog(@"%@",[set stringForColumn:@"upload"]);
            //        [dic setValue:[set stringForColumn:@"upload"] forKey:@"upload"];
            //        [dic setObject:[set stringForColumn:@"id"] forKey:@"id"];
            
            [arr addObject:dic];
        }
#if defined(DEBUG)
        //       NSLog(@"%@",arr);
#endif
        _isUse = NO;
//        [_dateBase close];
    }
    return arr;
}


- (FMResultSet *)selectDB:(NSString *)beginTime and:(NSString *)endTime andUnite:(int)unit{
    
    
    NSString *sql =[NSString stringWithFormat:@"select * from  (select i,(%@/60)*60+(i-1)*60 as stime,(%@/60)*60+(i-1)*60+59 as etime   from q   where i<=   ((%@-%@)/60)) a left join (select    (d/60)*60 as td ,max(case n when 0 then p end) p0,max(case n when 1 then p end) p1,max(case n when 2 then p end) p2,max(case n when 3 then p end) p3 ,max(case n when 0 then t end) t0,max(case n when 1 then t end) t1,max(case n when 2 then t end) t2,max(case n when 3 then t end) t3  from TireLog t where d between %@ and %@ group by  (d/60)*60) b on b.td between a.stime and a.etime  order by i",beginTime,beginTime,endTime,beginTime,beginTime,endTime];

    

    NSString *pressSql =[NSString stringWithFormat:@"select * from  (select i,(%@/(3600*24))*(3600*24)+(i-1)*(3600*24) as stime,(%@/(3600*24))*(3600*24)+(i-1)*(3600*24)+((3600*24)-1) as etime   from q   where i<=   ((%@-%@)/(3600*24))) a left join (select    (d/(3600*24))*(3600*24) as td ,max(case n when 0 then p end) p0,max(case n when 1 then p end) p1,max(case n when 2 then p end) p2,max(case n when 3 then p end) p3 from TireLog t where mac = '%@' and d between %@ and %@ group by  (d/(3600*24))*(3600*24)) b on b.td between a.stime and a.etime  order by i",beginTime,beginTime,endTime,beginTime,USER(@"MAC"),beginTime,endTime];
    
    
    
    NSString *tempSql =[NSString stringWithFormat:@"select * from  (select i,(%@/(3600*24))*(3600*24)+(i-1)*(3600*24) as stime,(%@/(3600*24))*(3600*24)+(i-1)*(3600*24)+((3600*24)-1) as etime   from q   where i<=   ((%@-%@)/(3600*24))) a left join (select    (d/(3600*24))*(3600*24) as td ,max(case n when 0 then t end) t0,max(case n when 1 then t end) t1,max(case n when 2 then t end) t2,max(case n when 3 then t end) t3 from TireLog t where mac = '%@' and d between %@ and %@ group by  (d/(3600*24))*(3600*24)) b on b.td between a.stime and a.etime  order by i",beginTime,beginTime,endTime,beginTime,USER(@"MAC"),beginTime,endTime];
    NSLog(@"%@",USER(@"MAC"));
    FMResultSet *set;
    if([_dateBase open]){
    if (unit==1) {
        set = [_dateBase executeQuery:pressSql];
    }else if(unit==2){
        set = [_dateBase executeQuery:tempSql];
    }else{
        set = [_dateBase executeQuery:sql];
    } 
    }
    

    return set;
}

- (void)insertQ{
    if([_dateBase open]){
        NSString *sql =@"insert into q (n) select i from q union select 0;";
        for (int i=14; i; i--) {
            [_dateBase executeUpdate:sql];
        }
        //[_dateBase close];
    }
  
}


- (BOOL)insertData:(NSMutableDictionary *)dic{
    BOOL flag = NO;
    
    if([_dateBase open]){
        
    //NSString *sql = @"INSERT INTO TireLog(id,d,v,p,t,upload,mac,tchangvalue,n) VALUES(?,?,?,?,?,?,?,?,?)";  这个句是bug   id之间有看不见的空格
          NSString *sql = @"INSERT INTO TireLog(id,d,v,p,t,upload,mac,tchangvalue,n) VALUES(?,?,?,?,?,?,?,?,?)";
      [_dateBase executeUpdate:sql,dic[@"id"],dic[@"d"],dic[@"v"],dic[@"p"],dic[@"t"],dic[@"upload"],dic[@"mac"],dic[@"tchangvalue"],dic[@"n"]];
    
   //    [_dateBase close];
          flag = YES;

        
    }
    
//   
    return  flag;
}


- (void)parserDate{
    NSString *sql = @"SELECT `id`, `mac`, `n`, `d`, `p`, `t`, `v` \
    ,p*CASE ? when '1' then 100 when 2 then 6.9 else 1 \
    end as pp FROM `TireLog` WHERE 1";
    if([_dateBase open]){
        FMResultSet *set = [_dateBase executeQuery:sql,@"1"];
        while (set.next) {
            NSLog(@"%@",[set stringForColumn:@"pp"]);
        }
        
        
    }
    
}

- (NSString *)getMaxID{
    
    NSString *sql = @"select max(id) as maxid from (SELECT id FROM TireLog WHERE upload = 0 LIMIT 1000) a";
    NSString *maxId = [[NSString alloc]init];
    
    if([_dateBase open]){
        FMResultSet *set = [_dateBase executeQuery:sql];
        while (set.next) {
            maxId = [set stringForColumn:@"maxid"];
        }
     
    }
    
    return maxId;
}
- (BOOL)updateData:(NSString *)tid{
    BOOL flag = false;
    if([_dateBase open]){
        NSString *sql = @"update TireLog set upload = 1 where id <= ? and upload=0";
        flag = [_dateBase executeUpdate:sql,tid];
        
    }
    
    return flag;
}

- (void)close{
    if(!_isUse){
        [_dateBase close];
    }
}
-(BOOL)deleteData{
    BOOL flag = YES;
    if([_dateBase open]){
      NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSString *deleteSql = [NSString stringWithFormat:@"delete from TireLog where d < %@",[NSString stringWithFormat:@"%f",interval-30*24*60*60*1000]];
        flag = [_dateBase executeQuery:deleteSql];
        
    }
    
    return flag;
}

@end
