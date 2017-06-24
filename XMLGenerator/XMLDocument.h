//
//  XMLDocument.h
//  XMLGenerator
//
//  Created by Mengzhiqi on 17/5/6.
//  Copyright © 2017年 Mengzhiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLElementNode.h"

@interface XMLDocument : NSObject {
    @public
    XMLElementNode *rootElementNode;
    NSString *encodingType;
}

//创建xml
- (void)createXMLWithEncoding:(NSString *)encoding withRootNode:(XMLElementNode *)rootNode;

//读取xml
- (NSMutableString *)readXML;

@end
