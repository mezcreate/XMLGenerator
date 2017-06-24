//
//  XMLElementNode.h
//  XMLGenerator
//
//  Created by Mengzhiqi on 17/5/6.
//  Copyright © 2017年 Mengzhiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLElementNode : NSObject {
    //子节点集合
    NSMutableArray *childElementNodes;
    //属性
    NSString *attribute;
    //节点名
    NSString *nodeName;
    //节点文本值
    NSString *textValue;
    //节点的父节点
    XMLElementNode *parentNode;
}

//创建根节点
- (XMLElementNode *)createRootNodeWithNodeName:(NSString  *)nodeName1;

- (XMLElementNode *)createElementNodeWithNodeName:(NSString *)nodeName1 andNodeText:(NSString *)text andAttributeName:(NSString *)attributeName andAttributeValue:(NSString *)attributeValue;

//插入孩子节点
- (void)addChildNode:(XMLElementNode *)childNode;

//删除孩子节点
- (void)deleteChildNode:(XMLElementNode *)childNode;

//获取当前节点及其子节点的内容
- (NSMutableString *)getAllXML;

//获取孩子节点内容
- (NSMutableString *)getChildNodesXML;

//获取所有孩子节点对象
- (NSArray *)getChildNodes;

//获取父亲节点对象
- (XMLElementNode *)getParrentNode;

//打印当前节点和子孙节点
- (void)printCurrentNodeAndChildNodesXML;

//添加属性
- (NSString *)addAttributeWithAttributeName:(NSString *)attributeName andAttributeValue:(NSString *)attributeValue;

//读取当前节点的属性
- (NSString *)getElementAttribute;

@end
