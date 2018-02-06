//
//  NSObject+Reflection.h
//  DHBaseProject_ZJ
//
//  Created by 我的大好时光 on 2017/4/1.
//  Copyright © 2017年 dhyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Reflection)

//类名
- (NSString *)dh_className;
+ (NSString *)dh_className;
//父类名称
- (NSString *)dh_superClassName;
+ (NSString *)dh_superClassName;

//实例属性字典
-(NSDictionary *)dh_propertyDictionary;

//属性名称列表
- (NSArray*)dh_propertyKeys;
+ (NSArray *)dh_propertyKeys;

//属性详细信息列表
- (NSArray *)dh_propertiesInfo;
+ (NSArray *)dh_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)dh_propertiesWithCodeFormat;

//方法列表
-(NSArray*)dh_methodList;
+(NSArray*)dh_methodList;

-(NSArray*)dh_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)dh_registedClassList;
//实例变量
+ (NSArray *)dh_instanceVariable;

//协议列表
-(NSDictionary *)dh_protocolList;
+ (NSDictionary *)dh_protocolList;


- (BOOL)dh_hasPropertyForKey:(NSString*)key;
- (BOOL)dh_hasIvarForKey:(NSString*)key;

@end
