//
//  DataBase.h
//  OrderMenu
//
//  Created by tiankong360 on 13-7-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataBase : NSObject
+(FMDatabase *)ShareDataBase;
+(NSMutableArray *)selectAllProduct;
+(NSMutableArray *)selectAllArrayProId;
+(NSString *)selectAllProId;
+(NSMutableArray *)selectNumberFromProId:(int)aProid;
+(void)deleteProID:(int)aProID;
+(void)UpdateDotNumber:(int)aProid currDotNumber:(int)aDotNumber;
+(void)insertProID:(int)aProID menuid:(int)aMenuId proName:(NSString *)aName price:(double)aPrice image:(NSString *)aImage andNumber:(int)aNumber typeID:(int)aTypeID typeName:(NSString *)aTypeName;
+(void)clearOrderMenu;
+(NSString *)selectNumber;

+(NSMutableArray *)SelectAllTypeNameAndTypeID;
+(NSMutableArray *)SelectProductByTypeID:(NSString *)aTypeID;
+(NSString *)SelectNumberByTypeName:(NSString *)aTypeName;
@end
