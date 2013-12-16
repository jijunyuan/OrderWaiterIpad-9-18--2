//
//  DataBase.m
//  OrderMenu
//
//  Created by tiankong360 on 13-7-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "DataBase.h"

@interface DataBase()
@end

@implementation DataBase
+(FMDatabase *)ShareDataBase
{
    NSString * doucumentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dbPath = [doucumentPath stringByAppendingPathComponent:@"diancai.db"];
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    NSString * createTB = @"create table orderMenu(proID int,Menuid int,proName nvarchar(50),price double,proImage varchar(50),number int,typeID int,typeName nvarchar(50))";
    BOOL result = [db executeUpdate:createTB];
    if (result)
    {
        NSLog(@"创建表orderMenu成功");
    }
    [db close];
    return db;
}
+(NSMutableArray *)selectAllProduct
{
    NSMutableArray * mutableArr = [NSMutableArray arrayWithCapacity:0];
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    FMResultSet * rs = [db executeQueryWithFormat:@"select * from orderMenu"];
    while([rs next])
    {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        NSString * proid = [rs stringForColumn:@"proID"];
        NSString * Menuid = [rs stringForColumn:@"Menuid"];
        NSString * proName = [rs stringForColumn:@"proName"];
        NSString * price = [rs stringForColumn:@"price"];
        NSString * proImage = [rs stringForColumn:@"proImage"];
        NSString * number = [rs stringForColumn:@"number"];
        NSString * typeID = [rs stringForColumn:@"typeID"];
        NSString * typeName = [rs stringForColumn:@"typeName"];
        [dic setValue:proid forKey:@"ProID"];
        [dic setValue:Menuid forKey:@"Menuid"];
        [dic setValue:proName forKey:@"ProName"];
        [dic setValue:price forKey:@"prices"];
        [dic setValue:proImage forKey:@"ProductImg"];
        [dic setValue:number forKey:@"number"];
        [dic setValue:typeID forKey:@"typeID"];
        [dic setValue:typeName forKey:@"typeName"];
        [mutableArr addObject:dic];
    }
    [rs close];
    [db close];
    return mutableArr;
}
#pragma mark - 选择出所有商品的id
+(NSMutableArray *)selectAllArrayProId
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = @"select proID from orderMenu";
    FMResultSet * rs = [db executeQuery:sql];
    NSMutableArray * mutableArr = [NSMutableArray arrayWithCapacity:0];
    while([rs next])
    {
        NSString * proID= [rs stringForColumn:@"proID"];
        [mutableArr addObject:proID];
    }
    [db close];
    return mutableArr;
}
#pragma mark - 选择出所有商品的id，并将拼接成字符串
+(NSString *)selectAllProId
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = @"select proID from orderMenu";
    FMResultSet * rs = [db executeQuery:sql];
    NSMutableString * mutableStr = [[NSMutableString alloc] initWithFormat:@""];
    while([rs next])
    {
        NSString * proID= [rs stringForColumn:@"proID"];
        [mutableStr appendFormat:@"%@,",proID];
    }
    NSString * str;
    if(mutableStr.length>0)
    {
        str = [mutableStr substringWithRange:NSMakeRange(0, mutableStr.length-1)];
    }
    [db close];
    return str;
}
#pragma mark - 根据id选出所点的数量
+(NSMutableArray *)selectNumberFromProId:(int)aProid
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = [NSString stringWithFormat:@"select number,price from orderMenu where proID='%d'",aProid];
    FMResultSet * rs = [db executeQuery:sql];
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    while([rs next])
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
        NSString * number = [rs stringForColumn:@"number"];
        NSString * price = [rs stringForColumn:@"price"];
        [dic setValue:number forKey:@"number"];
        [dic setValue:price forKey:@"price"];
        [arr addObject:dic];
    }
    [rs close];
    [db close];
    return arr;
}
#pragma mark - 根据id选出所点的数量,拼接成字符串
+(NSString *)selectNumber
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = [NSString stringWithFormat:@"select number from orderMenu"];
    FMResultSet * rs = [db executeQuery:sql];
    NSMutableString * mutableStr = [[NSMutableString alloc] initWithFormat:@""];
    while([rs next])
    {
        NSString * number = [rs stringForColumn:@"number"];
        [mutableStr appendFormat:@"%@,",number];
    }
    NSString * str;
    if(mutableStr.length>0)
    {
        str = [mutableStr substringWithRange:NSMakeRange(0, mutableStr.length-1)];
    }
    [rs close];
    [db close];
    return str;
}

#pragma mark - 删除指定id的菜
+(void)deleteProID:(int)aProID
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = [NSString stringWithFormat:@"delete from orderMenu where proID='%d'",aProID];
    BOOL isSuccess = [db executeUpdate:sql];
    if (isSuccess)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
    [db close];
}
#pragma mark - 更改当前点菜的份数
+(void)UpdateDotNumber:(int)aProid currDotNumber:(int)aDotNumber
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = [NSString stringWithFormat:@"update orderMenu set number='%d' where proID = '%d'",aDotNumber,aProid];
    BOOL isSuccess = [db executeUpdate:sql];
    if (isSuccess)
    {
        NSLog(@"更改成功");
    }
    else
    {
        NSLog(@"更改失败");
    }
   
    [db close];
}
#pragma mark - 向orderMenu中插入数据
+(void)insertProID:(int)aProID menuid:(int)aMenuId proName:(NSString *)aName price:(double)aPrice image:(NSString *)aImage andNumber:(int)aNumber typeID:(int)aTypeID typeName:(NSString *)aTypeName
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = [NSString stringWithFormat:@"insert into orderMenu(proID,Menuid,proName,price,proImage,number,typeID,typeName) values('%d','%d','%@','%g','%@','%d','%d','%@')",aProID,aMenuId,aName,aPrice,aImage,aNumber,aTypeID,aTypeName];
    BOOL isSuccess = [db executeUpdate:sql];
    if (isSuccess)
    {
        NSLog(@"插入成功");
    }
    else
    {
        NSLog(@"插入失败");
    }
    [db close];
}
#pragma mark - 清楚orderMenu
+(void)clearOrderMenu
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * deleteSql = @"delete from orderMenu where 1=1";
    BOOL result = [db executeUpdate:deleteSql];
    if (result)
    {
        NSLog(@"清除orderMenu成功");
    }
    else
    {
        NSLog(@"清除orderMenu失败");
    }
    [db close];
}
#pragma mark - 选择出所有的typeName 和 typeID
+(NSMutableArray *)SelectAllTypeNameAndTypeID
{
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * sql = @"select distinct typeID,typeName from orderMenu";
    FMResultSet * rs = [db executeQuery:sql];
    NSMutableArray * mutableArr = [NSMutableArray arrayWithCapacity:0];
    while([rs next])
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
        NSString * typeID= [rs stringForColumn:@"typeID"];
        NSString * typeName= [rs stringForColumn:@"typeName"];
        [dic setValue:typeID forKey:@"typeID"];
        [dic setValue:typeName forKey:@"typeName"];
        [mutableArr addObject:dic];
    }
    [db close];
    return mutableArr;
}
#pragma mark - 根据菜id，选择出相应的菜
+(NSMutableArray *)SelectProductByTypeID:(NSString *)aTypeID
{
    NSMutableArray * mutableArr = [NSMutableArray arrayWithCapacity:0];
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * str1 = [NSString stringWithFormat:@"select * from orderMenu where typeID='%@'",aTypeID];
    FMResultSet * rs = [db executeQuery:str1];
    while([rs next])
    {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        NSString * proid = [rs stringForColumn:@"proID"];
        NSString * Menuid = [rs stringForColumn:@"Menuid"];
        NSString * proName = [rs stringForColumn:@"proName"];
        NSString * price = [rs stringForColumn:@"price"];
        NSString * proImage = [rs stringForColumn:@"proImage"];
        NSString * number = [rs stringForColumn:@"number"];
        NSString * typeID = [rs stringForColumn:@"typeID"];
        NSString * typeName = [rs stringForColumn:@"typeName"];
        [dic setValue:proid forKey:@"ProID"];
        [dic setValue:Menuid forKey:@"Menuid"];
        [dic setValue:proName forKey:@"ProName"];
        [dic setValue:price forKey:@"prices"];
        [dic setValue:proImage forKey:@"ProductImg"];
        [dic setValue:number forKey:@"number"];
        [dic setValue:typeID forKey:@"typeID"];
        [dic setValue:typeName forKey:@"typeName"];
        [mutableArr addObject:dic];
    }
    [rs close];
    [db close];
    return mutableArr;
}
+(NSString *)SelectNumberByTypeName:(NSString *)aTypeName
{
    NSString* number = [NSString string];
    FMDatabase * db = [DataBase ShareDataBase];
    [db open];
    NSString * str1 = [NSString stringWithFormat:@"select proID from orderMenu where typeName = '%@'",aTypeName];
    FMResultSet * rs = [db executeQuery:str1];
    NSMutableArray * arr_id = [NSMutableArray arrayWithCapacity:0];
    while([rs next])
    {
        number = [rs stringForColumn:@"proID"];
        [arr_id addObject:number];
    }
    NSMutableArray * tempArr = [NSMutableArray arrayWithCapacity:0];
    [arr_id enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
        [tempArr addObject:[DataBase selectNumberFromProId:[obj intValue]]];
    }];
    __block int sum = 0;
    [tempArr enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL *stop) {
        sum += [[[obj objectAtIndex:0] valueForKey:@"number"] intValue];
    }];
    NSString * sumStr = [NSString stringWithFormat:@"%d",sum];
    [rs close];
    [db close];
    return sumStr;
}
@end
