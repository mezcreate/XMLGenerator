//
//  XMLNameSpace.h
//  XMLGenerator
//
//  Created by Mengzhiqi on 2017/5/7.
//  Copyright © 2017年 Mengzhiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLNameSpace : NSObject

//判断节点命名是否有错 如果有错则返回YES
- (BOOL)checkNodeError:(NSString *)node;

//检查节点是否含有不规范字符 如果有则返回YES
- (BOOL)isContainAlertCharater:(NSString *)node;

@end
