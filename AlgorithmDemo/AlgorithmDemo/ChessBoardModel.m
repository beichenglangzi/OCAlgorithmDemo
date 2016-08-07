//
//  ChessBoardModel.m
//  AlgorithmDemo
//
//  Created by 周际航 on 16/8/7.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ChessBoardModel.h"

const NSInteger kUnDefinedValue = 1000000;
@interface ChessBoardModel ()

@property (nonatomic, assign) NSInteger value;

@end

@implementation ChessBoardModel

- (instancetype)init{
    if (self = [super init]) {
        self.value = kUnDefinedValue;
    }
    return self;
}

- (NSInteger)evaluate{
    if (self.value != kUnDefinedValue) {return self.value;}
    
    self.value = (NSInteger)arc4random_uniform(100) - 50; // 棋子取值范围 -5000 ... 5000
    
    return self.value;
}

@end
