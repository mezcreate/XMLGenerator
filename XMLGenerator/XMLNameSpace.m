//
//  XMLNameSpace.m
//  XMLGenerator
//
//  Created by Mengzhiqi on 2017/5/7.
//  Copyright © 2017年 Mengzhiqi. All rights reserved.
//

#import "XMLNameSpace.h"

@implementation XMLNameSpace

- (NSInteger) getCountFromFatherString:(NSString *)fatherString ofSonString:(NSString *)sonString {
    NSScanner *mainScanner = [NSScanner scannerWithString:fatherString];
    NSString *temp;
    NSInteger numberOfCharCount = 0;
    while(![mainScanner isAtEnd]) {
        [mainScanner scanUpToString:sonString intoString:&temp];
        if(![mainScanner isAtEnd]) {
            numberOfCharCount ++;
            [mainScanner scanString:sonString intoString:nil];
        }
    }
    return numberOfCharCount;
}

- (BOOL)checkNodeError:(NSString *)node {
    BOOL errorBOOL = NO;
    NSInteger blankCount = 0;
    blankCount = [self getCountFromFatherString:node ofSonString:@" "];
    //有空格
    if (blankCount >= 1) {
        errorBOOL = YES;
        NSLog(@"节点名含有空格");
        exit(0);
    }
    //有非法字符
    if ([self isNotAllow:node] == YES) {
        errorBOOL = YES;
        NSLog(@"节点名首字母含有非法字符");
        exit(0);
    }
    NSInteger specialCount = 0;
    specialCount = [self getCountFromFatherString:node ofSonString:@":"];
    if (specialCount >= 1) {
        NSLog(@"节点名含有非法字符:");
        exit(0);
    }
    if ([self isStartWithXML:node] == YES) {
        errorBOOL = YES;
        NSLog(@"节点名以xml开始");
        exit(0);
    }
    return errorBOOL;
}

//以xml开头
- (BOOL)isStartWithXML:(NSString *)node {
    BOOL check = NO;
    if (node.length >= 3) {
        NSString *str = [node substringToIndex:3];
        if ([[str uppercaseString] isEqualToString:@"XML"]) {
            check = YES;
        }
    }
    return check;
}

- (BOOL)isContainAlertCharater:(NSString *)node {
    BOOL contain = NO;
    NSInteger count1 = 0;
    NSInteger count2 = 0;
    count1 = [self getCountFromFatherString:node ofSonString:@"-"];
    count2 = [self getCountFromFatherString:node ofSonString:@"."];
    if (count1 >= 1) {
        contain = YES;
        NSLog(@"节点名含有 '-' !!!!!!!!!");
        exit(0);
    }
    if (count2 >= 1) {
        contain = YES;
        NSLog(@"节点名含有 '.' !!!!!!!!!!");
        exit(0);
    }
    return contain;
}

//判断节点第一个字母是否是特殊字符 如果是则返回YES
- (BOOL)isNotAllow:(NSString *)node {
    BOOL hasNotAllow = NO;
    NSCharacterSet *nameCharacters = [[NSCharacterSet
                                       characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    NSRange userNameRange = [node rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        hasNotAllow = YES;
    }
    //判断是否为中文
    int a = [node characterAtIndex:0];
    if (a > 0x4e00 && a < 0x9fff) {
        hasNotAllow = NO;
    }
    return hasNotAllow;
}

@end
