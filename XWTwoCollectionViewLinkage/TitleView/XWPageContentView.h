//
//  XWPageContentView.h
//  XWTwoCollectionViewLinkageLinkage
//
//  Created by Justin on 2018/5/14.
//  Copyright © 2018年 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWPageContentView;

@protocol XWPageContentViewDelegate <NSObject>

@optional

/**
 XWPageContentView开始滑动
 
 @param contentView XWPageContentView
 */
- (void)XWContentViewWillBeginDragging:(XWPageContentView *)contentView;

/**
 XWPageContentView滑动调用
 
 @param contentView XWPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)XWContentViewDidScroll:(XWPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;

/**
 FSPageContentView结束滑动
 
 @param contentView FSPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)XWContenViewDidEndDecelerating:(XWPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

/**
 scrollViewDidEndDragging
 
 @param contentView FSPageContentView
 */
- (void)XWContenViewDidEndDragging:(XWPageContentView *)contentView;

@end

@interface XWPageContentView : UIView

/**
 对象方法创建FSPageContentView
 
 @param frame frame
 @param childVCs 子VC数组
 @param parentVC 父视图VC
 @param delegate delegate
 @return FSPageContentView
 */
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<XWPageContentViewDelegate>)delegate;

@property (nonatomic, weak) id<XWPageContentViewDelegate>delegate;

/**
 设置contentView当前展示的页面索引，默认为0
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

/**
 设置contentView能否左右滑动，默认YES
 */
@property (nonatomic, assign) BOOL contentViewCanScroll;

@end

