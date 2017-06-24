//
//  main.m
//  XMLGenerator
//
//  Created by Mengzhiqi on 17/5/6.
//  Copyright © 2017年 Mengzhiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLDocument.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*------这里，只把元素节点看做节点------*/

        //创建根节点
        XMLElementNode *rootElement = [[XMLElementNode alloc] init];
        rootElement = [rootElement createRootNodeWithNodeName:@"CategoryList"];
        
        XMLElementNode *element1 = [[XMLElementNode alloc] init];
        element1 = [element1 createElementNodeWithNodeName:@"Category" andNodeText:@"" andAttributeName:@"" andAttributeValue:@""];
        //给element1节点一添加属性
        [element1 addAttributeWithAttributeName:@"ID" andAttributeValue:@"1"];
        
        XMLElementNode *element2 = [[XMLElementNode alloc] init];
        element2 = [element2 createElementNodeWithNodeName:@"MainCategory" andNodeText:@"XML" andAttributeName:@"" andAttributeValue:@""];
        [element1 addChildNode:element2];
        
        XMLElementNode *element3 = [[XMLElementNode alloc] createElementNodeWithNodeName:@"Description" andNodeText:@"This is a list my XML articles" andAttributeName:@"" andAttributeValue:@""];
        [element1 addChildNode:element3];
        
        XMLElementNode *element4 = [[XMLElementNode alloc] createElementNodeWithNodeName:@"Active" andNodeText:@"true" andAttributeName:@"" andAttributeValue:@""];
        [element1 addChildNode:element4];
        
        [rootElement addChildNode:element1];
        
        
        XMLDocument *document = [[XMLDocument alloc] init];
        //创建xml文档
        [document createXMLWithEncoding:@"GB2312" withRootNode:rootElement];
        NSMutableString *xml = [[NSMutableString alloc] init];
        xml = [document readXML];
        //打印文档内容
        NSLog(@"\n\n**这是文档内容{\n%@\n}**\n\n", xml);
        
        //演示删除节点
        [element1 deleteChildNode:element2];
        [document createXMLWithEncoding:document -> encodingType withRootNode:document -> rootElementNode];
        xml = [document readXML];
        //打印文档内容
        NSLog(@"\n\n**这是删除节点后文档内容{\n%@\n}**\n\n", xml);
        
        //演示获取父节点对象
        XMLElementNode *parentNode = [element2 getParrentNode];
        NSLog(@"\n****这是element2的父亲节点:%@****\n", parentNode);
        
        //获取子节点对象
        NSArray *childArray = [element1 getChildNodes];
        NSLog(@"\n****这是 element1的子节点对象{\n%@\n}****\n", childArray);
        
        //获取节点属性
        NSString *attribute = [element1 getElementAttribute];
        NSLog(@"\n***这是element1的节点属性:{\n%@\n}****", attribute);
        
        //获取当前节点和所有子节点的内容
        NSMutableString *xmlString = [[NSMutableString alloc] init];
        xmlString = [element1 getAllXML];
        NSLog(@"\n\n****这是element1的和它所有子节点的内容:{%@\n}****\n", xmlString);
    }
    return 0;
}
