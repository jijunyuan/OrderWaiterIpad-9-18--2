//
//  JJYGloble.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-12.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#ifndef OrderWaiterIpad_JJYGloble_h
#define OrderWaiterIpad_JJYGloble_h

#define KEY_REMBERPWD @"remberpassword"
#define KEY_NAME @"keyname"
#define KEY_PWD @"keypassword"

#define KEY_CURR_USERID @"userid_curr"
#define KEY_CURR_RESTID @"restid_curr"

#define ROOT_URL @"http://dmd.tiankong360.com/"
#import "MyActivceView.h"
#import "MyAlert.h"
#import "NSString+JsonString.h"
#import "ASIHTTPRequest.h"
#import "WebService.h"
#import "UIColor+ConverHTML.h"

#define ALL_URL @"http://interface.hcgjzs.com"
#define CLASS_URL @"http://dmd.tiankong360.com/OM_Interface/Cuisines.asmx"
#define CLASS_NAME @"GetList"  //获取某一餐馆的菜系分类列表
#define PRODUCT_URL @"http://dmd.tiankong360.com/OM_Interface/Product.asmx"
#define PRODUCT_NAME @"ProductList"  //根据分类id，获取对应id的菜列表
#define ALL_NO_IMAGE @"no.png"

#define LOGIN_IN @"http://dmd.tiankong360.com/OM_Interface/Waiter.asmx?op=WaiterLogin"
#define GET_ORDER_LIST @"http://dmd.tiankong360.com/OM_Interface/Waiter.asmx?op=GetOrderList"
#define SEARCH_ORDER_LIST @"http://dmd.tiankong360.com/OM_Interface/Waiter.asmx?op=GetOrderForSearch"
#define GET_DOT_DISHES_LIST @"http://dmd.tiankong360.com/OM_Interface/Order.asmx?op=GetProductList"
#define CHECK_ORDER @"http://dmd.tiankong360.com/OM_Interface/Waiter.asmx?op=AuditOrderInfo"
#define GET_TABLE_LIST @"http://dmd.tiankong360.com/OM_Interface/Waiter.asmx?op=GetTableList"
#define ADD_ORDER @"http://dmd.tiankong360.com/OM_Interface/OrderInterface.asmx?op=SubmitOrder"
#define EDIT_ORDER @"http://dmd.tiankong360.com/OM_Interface/Waiter.asmx?op=EditOrderInfo"
#define EDIT_TABLE @"http://dmd.tiankong360.com/OM_Interface/Waiter.asmx?op=EditTableNum"
#define ADD_DISHES @"http://dmd.tiankong360.com/OM_Interface/OrderInterface.asmx?op=addOrderinfo"

#endif
