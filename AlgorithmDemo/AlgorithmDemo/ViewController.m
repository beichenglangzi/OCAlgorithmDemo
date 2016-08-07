//
//  ViewController.m
//  AlgorithmDemo
//
//  Created by 周际航 on 16/7/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ViewController.h"
#import "ChessBoardModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *marr = [@[@4,@11,@9,@3,@14,@22,@2,@3,@100,@19,@1,@21] mutableCopy];
    NSLog(@"初始:%@", [self stringFromArray:marr head:0 tail:marr.count-1]);
    
//    [self maopaoDemo:marr];
//    [self fastDemo:marr head:0 tail:marr.count-1];
//    [self directInsetDemo:marr];
//    [self dichotomyInsetDemo:marr];
    [self alpha_betaDemo];
    
    NSLog(@"最终:%@", [self stringFromArray:marr head:0 tail:marr.count-1]);
}
#pragma mark - 冒泡排序
- (void)maopaoDemo:(NSMutableArray *)marr{
    if (marr.count <= 1) {return;}
    
    for (int i=0; i<marr.count; i++) {
        for (int j=i+1; j<marr.count; j++) {
            if ([marr[i] integerValue] > [marr[j] integerValue]) {
                NSNumber *t = marr[j];
                marr[j] = marr[i];
                marr[i] = t;
            }
        }
    }
    NSLog(@"marr:%@",marr);
}
#pragma mark - 快速排序
- (void)fastDemo:(NSMutableArray *)marr head:(NSInteger)head tail:(NSInteger)tail{
    if (marr.count <= 1) {return;}
    if (head<0 || tail>marr.count-1) {return;}
    if (head>=tail) {return;}
    
    NSInteger low = head;
    NSInteger hight = tail;
    BOOL kRight = NO;       // 比较的基数是否已交换到右边
    while (1) {
        if (low == hight){
            if (low-head>0) {
                // 左边递归
                NSLog(@"左边递归:%@",[self stringFromArray:marr head:head tail:low-1]);
                [self fastDemo:marr head:head tail:low-1];
            }
            if (tail-hight>0) {
                // 右边递归
                NSLog(@"右边递归:%@",[self stringFromArray:marr head:hight+1 tail:tail]);
                [self fastDemo:marr head:hight+1 tail:tail];
            }
            break;
        }
        
        // 交换
        if (marr[low] > marr[hight]) {
            id t = marr[hight];
            marr[hight] = marr[low];
            marr[low] = t;
            kRight = !kRight;
            NSLog(@"交换后:%@",[self stringFromArray:marr head:head tail:tail]);
        }
        kRight ? low++ : hight--;
    }
}
- (NSString *)stringFromArray:(NSArray *)arr head:(NSInteger)head tail:(NSInteger)tail{
    NSMutableString *mstr = [@"" mutableCopy];
    for (NSInteger i=head; i<=tail; i++) {
        [mstr appendString:[NSString stringWithFormat:@"%@,",arr[i]]];
    }
    return [mstr copy];
}
#pragma mark - 插入排序
// 直接插入排序
- (void)directInsetDemo:(NSMutableArray *)marr{
    if (marr.count <= 1) {return;}

    for (int i=1; i<marr.count; i++) {
        // 顺序不对
        if (marr[i]<marr[i-1]) {
            id inset = marr[i];
            
            // 开始插入交换
            for (int j=i; j>0; j--) {
                if (marr[j] > marr[j-1]) {
                    break;
                }
                marr[j] = marr[j-1];
                marr[j-1] = inset;
            }
        }
    }
}
// 二分插入排序
- (void)dichotomyInsetDemo:(NSMutableArray *)marr{
    if (marr.count <= 1) {return;}
    
    for (int i=1; i<marr.count; i++) {
        if (marr[i] < marr[i-1]) {
            
            id inset = marr[i];
            // 开始二分查找排序
            NSLog(@"开始二分查找排序 obj:%@ array:%@", inset, [self stringFromArray:marr head:0 tail:i-1]);
            NSInteger insetIndex = [self insetIndexOfObject:inset inArray:marr head:0 fail:i-1];
            
            for (int j=i; j>insetIndex; j--) {
                marr[j] = marr[j-1];
            }
            marr[insetIndex] = inset;
            NSLog(@"替换后的数组：%@", [self stringFromArray:marr head:0 tail:marr.count-1]);
        }
    }
}
// 二分查找法
static const NSInteger kErrorIndex = -99;       // 查找错误，比如不满足查找条件时，返回此值
- (NSInteger)insetIndexOfObject:(id)obj inArray:(NSArray *)arr head:(NSInteger)head fail:(NSInteger)fail{
    NSInteger errorIndex = kErrorIndex;
    if (!obj) {return errorIndex;}
    if (head < 0 || fail > arr.count-1) {return errorIndex;}
    if (head > fail) {return errorIndex;}
    
    NSInteger insetIndex = errorIndex;
    NSInteger centerIndex = head + (fail - head)/2;
    if (arr[centerIndex] == obj) {
        insetIndex = centerIndex+1;
        NSLog(@"--中心值相等center:%ld insetIndex:%ld", centerIndex, insetIndex);
    }else if (arr[centerIndex] > obj) {
        if (centerIndex <= head){
            // 最小
            insetIndex = centerIndex;
            NSLog(@"--比最左还小 insetIndex:%ld", insetIndex);
        }else{
            NSLog(@"--head:%ld fail:%ld center:%ld 左边二分查找obj:%@ arr:%@", head, fail, centerIndex, obj , [self stringFromArray:arr head:head tail:centerIndex]);
            insetIndex = [self insetIndexOfObject:obj inArray:arr head:head fail:centerIndex];
        }
    }else {
        if (centerIndex >= fail) {
            // 最大
            insetIndex = centerIndex+1;
            NSLog(@"--比最右还大 insetIndex:%ld", insetIndex);
        }else{
            NSLog(@"--head:%ld fail:%ld center:%ld 右边二分查找obj:%@ arr:%@", head, fail, centerIndex, obj , [self stringFromArray:arr head:centerIndex+1 tail:fail]);
            insetIndex = [self insetIndexOfObject:obj inArray:arr head:centerIndex+1 fail:fail];
        }
    }
    return insetIndex;
}
#pragma mark - 合并排序

#pragma mark - 翻转二叉树


#pragma mark - alpha_beta 剪枝搜索
static long long nodeNumber = 0;
static long long cutCount = 0;
- (void)alpha_betaDemo{
    NSInteger alpha = -2000000;
    NSInteger beta = 2000000;
    
    NSInteger bestValue = [self alpha_betaSearchBoard:[ChessBoardModel new] alpha:alpha beta:beta deep:2];
    
    NSLog(@"最优解为:%ld", bestValue);
    NSLog(@"遍历节点数：%lld  剪枝次数:%lld", nodeNumber, cutCount);
}

// beta剪枝
- (NSInteger)alpha_betaSearchBoard:(ChessBoardModel *)board alpha:(NSInteger)alpha beta:(NSInteger)beta deep:(NSInteger)deep{
    if (deep == 0) {return [board evaluate];}
    
    NSLog(@"===============alpha:%ld  beta:%ld  deep:%ld", alpha, beta, deep);
    NSArray<ChessBoardModel *> *steps = [self nextStepArrayForBoard:board];
    nodeNumber += steps.count;
    for (int i=0; i<steps.count; i++) {
        ChessBoardModel *nextBoard = steps[i];
        
        // 取负数替代找最大和找最小的切换，算法就能统一为找最大
        NSInteger nextValue = -[self alpha_betaSearchBoard:nextBoard alpha:-beta beta:-alpha deep:deep-1];
        NSLog(@"得到deep:%ld层节点的值 value:%ld", deep, nextValue);
        
        // 找到更大的最小值，更新alpha
        if (nextValue > alpha) {
            alpha = nextValue;
            NSLog(@"更新alpha后： alpha:%ld beta:%ld deep:%ld", alpha, beta, deep);
        }
        
        // 剪枝
        if (nextValue >= beta) {
            NSLog(@"执行最大剪枝 nextEvaluate:%ld alpha:%ld beta:%ld deep:%ld", nextValue, alpha, beta, deep);
            cutCount++;
            break;
        }
    }
    NSLog(@"返回deep:%ld层的结果 alpha:%ld", deep, alpha);
    return alpha;
}
// 列出下一步可走棋局
- (NSArray<ChessBoardModel *> *)nextStepArrayForBoard:(ChessBoardModel *)board{
    NSInteger step = arc4random_uniform(40);
    NSMutableArray *marr = [@[] mutableCopy];
    while (step>0) {
        [marr addObject:[ChessBoardModel new]];
        step--;
    }
    return [marr copy];
}
// 评价函数，返回board当前棋盘评分,总以黑棋视角评分
- (NSInteger)evaluateBoard:(ChessBoardModel *)board{
    return board.evaluate;
}

@end


