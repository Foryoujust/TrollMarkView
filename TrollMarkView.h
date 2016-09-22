//
//  TrollMarkView.h
//  UIDemo
//
//  Created by Troll on 16/9/19.
//  Copyright © 2016年 Troll. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct MarkMargin{
    CGFloat leftMargin;
    CGFloat rightMargin;
    CGFloat topMargin;
    CGFloat bottomMargin;
}MarkMargin;

typedef NS_ENUM(NSUInteger, MarkTextAlignment) {
    MarkTextAlignmentDefault =  1 << 0,
    MarkTextAlignmentLeft = MarkTextAlignmentDefault,
    MarkTextAlignmentCenter = 1 << 1,
    MarkTextAlignmentRight = 1 << 2
};

@interface TrollMarkView : UIView

@property (nonatomic, assign) BOOL canSelection;
@property (nonatomic, strong) UIFont *markFont;
@property (nonatomic, strong) UIColor *markTextColor;
@property (nonatomic, strong) UIColor *markBackgroundColor;
@property (nonatomic, strong) UIColor *markBorderColor;
@property (nonatomic, assign) CGFloat markBorderWidth;
@property (nonatomic, assign) MarkTextAlignment markTextAlignment;
@property (nonatomic, assign) CGFloat markCornerRadius;

/**
 设置文本内容左、右空白间距
 仅当文本内容和空白间距总共只有一行时有效
 */
@property (nonatomic, assign) NSInteger markTextLeftSpaceCount;
@property (nonatomic, assign) NSInteger markTextRightSpaceCount;
@property (nonatomic, assign) CGFloat markTextTopMargin;
@property (nonatomic, assign) CGFloat markTextBottomMargin;



- (instancetype)initWithFrame:(CGRect)frame Margin:(MarkMargin)margin;
- (void)setMarksContent:(NSArray *)marks;
- (void)addMarks:(NSArray *)marks;


@end
