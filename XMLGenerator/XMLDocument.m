//
//  XMLDocument.m
//  XMLGenerator
//
//  Created by Mengzhiqi on 17/5/6.
//  Copyright © 2017年 Mengzhiqi. All rights reserved.
//

#import "XMLDocument.h"

@implementation XMLDocument

- (void)createXMLWithEncoding:(NSString *)encoding withRootNode:(XMLElementNode *)rootNode {
    
    if (rootNode == nil) {
        NSLog(@"\n\n-----根节点不能为空------\n\n");
    } else {
        self -> rootElementNode = rootNode;
        self -> encodingType = encoding;
        
        NSMutableString *head = [[NSMutableString alloc] init];
        head = [NSMutableString stringWithFormat:@"<?xml version=\"1.0\""];
        [head appendFormat:@" encoding=\"%@\"?>", encoding];
        NSMutableString *xmlStr = [[NSMutableString alloc] init];
        xmlStr = [rootNode getAllXML];
        [head appendFormat:@"%@", xmlStr];
        NSData *data = [[NSData alloc] init];
        data = [head dataUsingEncoding:NSUTF8StringEncoding];
        //沙盒的Documents目录
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *str = [documentPaths objectAtIndex:0];
        
        NSString *path = [str stringByAppendingPathComponent:@"myfirst.xml"];
        [data writeToFile:path atomically:YES];
    }
}

- (NSMutableString *)readXML {
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"myfirst.xml"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSMutableString *readString = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return readString;
}

@end
