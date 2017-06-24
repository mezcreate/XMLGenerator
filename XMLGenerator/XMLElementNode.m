//
//  XMLElementNode.m
//  XMLGenerator
//
//  Created by Mengzhiqi on 17/5/6.
//  Copyright © 2017年 Mengzhiqi. All rights reserved.
//

#import "XMLElementNode.h"
#import "XMLNameSpace.h"

@implementation XMLElementNode {
    XMLNameSpace *nameSpace;
}

- (XMLElementNode *)createRootNodeWithNodeName:(NSString *)nodeName1 {
    XMLElementNode *element = [[XMLElementNode alloc] init];
    
    if (![nodeName1 isEqualToString:@""] && nodeName1.length != 0) {
        
        if (nameSpace == nil) {
            nameSpace = [[XMLNameSpace alloc] init];
        }
        
        //检查节点名称是否合法
        [nameSpace checkNodeError:nodeName1];
        [nameSpace isContainAlertCharater:nodeName1];
        element -> nodeName = nodeName1;
        
    } else {
        NSLog(@"节点名不能为空");
    }
    return element;
}

- (XMLElementNode *)createElementNodeWithNodeName:(NSString *)nodeName1 andNodeText:(NSString *)text andAttributeName:(NSString *)attributeName andAttributeValue:(NSString *)attributeValue {
     XMLElementNode *element = [[XMLElementNode alloc] init];
    
    if (![nodeName1 isEqualToString:@""] && nodeName1.length != 0) {
        
        if (nameSpace == nil) {
            nameSpace = [[XMLNameSpace alloc] init];
        }
        
        //检查节点名称是否合法
        [nameSpace checkNodeError:nodeName1];
        [nameSpace isContainAlertCharater:nodeName1];
        
        if (![attributeName isEqualToString:@""] && [attributeValue isEqualToString:@""]) {
            NSLog(@"//-----设置属性名后，属性值不能为空-------//");
            exit(0);
        } else if ([attributeName isEqualToString:@""] && ![attributeValue isEqualToString:@""]){
            NSLog(@"------------设置属性值后，属性名不能为空----------");
            exit(0);
        } else if ([attributeName isEqualToString:@""] && [attributeValue isEqualToString:@""]) {
            element -> nodeName = nodeName1;
            element -> textValue = text;
            NSString *attributeStr = [NSString stringWithFormat:@"%@=\"%@\"", attributeName, attributeValue];
            self -> attribute = attributeStr;
        }else if (![attributeName isEqualToString:@""] && ![attributeValue isEqualToString:@""]) {
            element -> nodeName = nodeName1;
            element -> textValue = text;
            NSString *attributeStr = [NSString stringWithFormat:@"%@=\"%@\"", attributeName, attributeValue];
            self -> attribute = attributeStr;
        }
    } else {
        NSLog(@"节点名不能为空");
    }
    return element;
}

- (void) addChildNode:(XMLElementNode *)childNode {
    
    if (![self -> textValue isEqualToString:@""] && self -> textValue.length != 0) {
         NSLog(@"\n\n\n********该父节点已有文本节点，不能添加子节点**********\n\n\n");
    } else {
        if(childNode != nil){
            //如果还没有父节点
            if(childNode -> parentNode == nil){
                if(childElementNodes == nil){
                    childElementNodes = [[NSMutableArray alloc]init];
                }
                [childElementNodes addObject:childNode];
                childNode -> parentNode = self;
            }else{
                NSLog(@"该节点已存在父节点");
            }
        }else{
            NSLog(@"---所要增添的孩子节点为空－－－");
        }
    }
}

- (NSString *)addAttributeWithAttributeName:(NSString *)attributeName andAttributeValue:(NSString *)attributeValue {
    
    if (attributeName.length == 0 || attributeValue.length == 0) {
        NSLog(@"\n\n\n----------添加属性时，属性名和属性值不能为空-------------\n\n\n");
        exit(0);
    } else if (attributeName.length != 0 && attributeValue.length != 0) {
        NSString *attributeStr = [NSString stringWithFormat:@"%@=\"%@\"", attributeName, attributeValue];
        self -> attribute = attributeStr;
    }
    return self -> attribute;
}

- (NSString *)getElementAttribute {
    return self -> attribute;
}

- (void)deleteChildNode:(XMLElementNode *)childNode {
    if ([self -> childElementNodes containsObject:childNode]) {
        [self -> childElementNodes removeObject:childNode];
        NSLog(@"\n\n--删除成功--\n\n");
    } else {
        NSLog(@"/n/n---没有该子节点,删除失败---\n\n");
    }
}

- (NSMutableString *)getAllXML {
    NSMutableString *xmlString = [[NSMutableString alloc] init];
    if (childElementNodes.count != 0 && childElementNodes != nil) {
        if (![[self getElementAttribute] isEqualToString:@""] && [self getElementAttribute].length != 0) {
            [xmlString appendFormat:@"\n<%@ %@>%@\n</%@>",self -> nodeName, [self getElementAttribute], [self getChildNodesXML], self -> nodeName];
        } else {
            [xmlString appendFormat:@"\n<%@>%@\n</%@>", self -> nodeName, [self getChildNodesXML], self -> nodeName];
        }
    } else {
        if (![[self getElementAttribute] isEqualToString:@""] && [self getElementAttribute].length != 0) {
            if (![self -> textValue isEqualToString:@""] && self -> textValue != nil) {
                [xmlString appendFormat:@"\n<%@ %@>%@</%@>", self -> nodeName, [self getElementAttribute], self -> textValue, self -> nodeName];
            } else {
                [xmlString appendFormat:@"\n<%@ %@></%@>", [self getElementAttribute], [self getElementAttribute], [self getElementAttribute]];
            }
        } else {
            if (![self -> textValue isEqualToString:@""] && self.self -> textValue.length != 0) {
                [xmlString appendFormat:@"\n<%@>%@</%@>", self -> nodeName, self -> textValue, self -> nodeName];
            } else {
                [xmlString appendFormat:@"\n<%@></%@>", self -> nodeName, self -> nodeName];
            }
        }
    }
    return  xmlString;
}

//遍历孩子节点
- (NSMutableString *)getChildNodesXML {
    NSMutableString *chileNodeString = [[NSMutableString alloc] init];
    
    for (XMLElementNode *element in childElementNodes) {

        if([element getChildNodes].count != 0 && [element getChildNodes] != nil){
            if (![[element getElementAttribute] isEqualToString:@""] && [element getElementAttribute].length != 0) {
                [chileNodeString appendFormat:@"\n<%@ %@>%@\n</%@>", element -> nodeName, [element getElementAttribute], [element getChildNodesXML], element -> nodeName];
            } else {
                [chileNodeString appendFormat:@"\n<%@>%@\n</%@>", element -> nodeName, [element getChildNodesXML], element -> nodeName];
            }
        } else {
            if (![[element getElementAttribute] isEqualToString:@""] && [element getElementAttribute].length != 0) {
                if (![element -> textValue isEqualToString:@""] && element -> textValue.length != 0) {
                    [chileNodeString appendFormat:@"\n<%@ %@>%@</%@>", element -> nodeName, [element getElementAttribute], element -> textValue, element -> nodeName];
                } else {
                    [chileNodeString appendFormat:@"\n<%@ %@></%@>", element -> nodeName, [element getElementAttribute], element -> nodeName];
                }
            } else {
                if (![element -> textValue isEqualToString:@""] && element -> textValue.length != 0) {
                    [chileNodeString appendFormat:@"\n<%@>%@</%@>", element -> nodeName, element -> textValue, element -> nodeName];
                } else {
                    [chileNodeString appendFormat:@"\n<%@></%@>", element -> nodeName, element -> nodeName];
                }
            }
        }
    }
    return chileNodeString;
}

- (NSArray *)getChildNodes {
    NSArray *array;
    if (childElementNodes.count != 0 && childElementNodes != nil) {
        array = childElementNodes;
    } else {
        //没有子节点
    }
    return array;
}

- (XMLElementNode *)getParrentNode {
    if (self -> parentNode == nil) {
        NSLog(@"\n\n-------%@没有父节点-----------\n\n", self);
    } else {
        NSLog(@"\n\n这是父节%@的父节点%@:{", self, self -> parentNode);
        NSLog(@"%@\n%@\n\n", self -> parentNode -> nodeName, self -> parentNode -> textValue);
    }
    return self -> parentNode;
}

- (void)printCurrentNodeAndChildNodesXML {
    NSMutableString *xmlString = [self getAllXML];
    NSLog(@"\n\n{\n%@\n}\n\n", xmlString);
}

@end
