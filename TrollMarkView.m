//
//  TrollMarkView.m
//  UIDemo
//
//  Created by Troll on 16/9/19.
//  Copyright © 2016年 Troll. All rights reserved.
//

#import "TrollMarkView.h"
#import "TrollFlowLayout.h"

#define TrollMarkViewCollectionCellId   @"TrollMarkViewCollectionCellId"


@interface TrollMarkCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *markLabel;

@end


@implementation TrollMarkCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _markLabel.numberOfLines = 0;
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:_markLabel];
        
    }
    return self;
}

- (void)updateLabelFrame{
    _markLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end


@interface TrollMarkView()<UICollectionViewDataSource,UICollectionViewDelegate, TrollFlowLayoutDelegate>

@property (nonatomic, assign) MarkMargin margin;
@property (nonatomic, strong) UICollectionView *cv;
@property (nonatomic, strong) NSMutableArray *marks;
@property (nonatomic, assign) CGFloat singleLineHeight;


@end


@implementation TrollMarkView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        TrollFlowLayout *layout = [[TrollFlowLayout alloc] init];
        layout.delegate = self;
        layout.minimumInteritemSpacing = 5.0;
        layout.minimumLineSpacing = 5.0;
        
        _cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        [_cv registerClass:[TrollMarkCell class] forCellWithReuseIdentifier:TrollMarkViewCollectionCellId];
        _cv.delegate = self;
        _cv.dataSource = self;
        _cv.backgroundColor = [UIColor clearColor];
        [self addSubview:_cv];
        
        [self doMakeDefaultValue];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Margin:(MarkMargin)margin{
    _margin = margin;
    self = [self initWithFrame:frame];
    return self;
}

- (void)doMakeDefaultValue{
    _markFont = [UIFont systemFontOfSize:12];
    _markTextColor = [UIColor blackColor];
    _markBorderColor = [UIColor whiteColor];
    _markBorderWidth= 0;
    _markCornerRadius = 0;
    _markBackgroundColor = [UIColor whiteColor];
    _markTextAlignment = MarkTextAlignmentDefault;
    _canSelection = NO;
    _singleLineHeight = [self computerMarkLabelSizeWithContent:@"1"].height;
}

- (void)setCanSelection:(BOOL)canSelection{
    _canSelection = canSelection;
    _cv.allowsSelection = _canSelection;
}

- (void)setMarksContent:(NSArray *)marks{
    if (_marks == nil) {
        _marks = [NSMutableArray array];
    }
    [_marks removeAllObjects];
    [_marks addObjectsFromArray:marks];
}


#pragma mark - Computer mark label size

- (CGSize)computerMarkLabelSizeWithContent:(NSString *)content{
    CGSize size = [content boundingRectWithSize:CGSizeMake(self.frame.size.width-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_markFont} context:nil].size;
//    NSLog(@"content = %@, size = %@",content,NSStringFromCGSize(size));
    return CGSizeMake(size.width, size.height);
}

#pragma mark - TrollFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView withLayout:(TrollFlowLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *leftStrTmp = @"";
    NSString *rightStrTmp = @"";
    
    for (NSInteger i=0; i<_markTextLeftSpaceCount; i++) {
        leftStrTmp = [leftStrTmp stringByAppendingString:@" "];
    }
    
    for (NSInteger i=0; i<_markTextRightSpaceCount; i++) {
        rightStrTmp = [rightStrTmp stringByAppendingString:@" "];
    }
    
    
    NSString *content = _marks[indexPath.row];
    
    NSString *strTmp = [NSString stringWithFormat:@"%@%@%@",leftStrTmp,content,rightStrTmp];
    
    CGSize size = [self computerMarkLabelSizeWithContent:strTmp];
    if (size.height <= _singleLineHeight) {
        [_marks replaceObjectAtIndex:[_marks indexOfObject:content] withObject:strTmp];
        return CGSizeMake(size.width, size.height+_markTextTopMargin+_markTextBottomMargin);
    }else{
        CGSize resultSize = [self computerMarkLabelSizeWithContent:content];
        return CGSizeMake(resultSize.width, resultSize.height+_markTextTopMargin+_markTextBottomMargin);
    }
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _marks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    TrollMarkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TrollMarkViewCollectionCellId forIndexPath:indexPath];
    
    
    
    NSString *content = _marks[indexPath.row];
    cell.markLabel.text = content;
    cell.markLabel.font = _markFont;
    cell.markLabel.textColor = _markTextColor;
    cell.markLabel.layer.cornerRadius = _markCornerRadius;
    cell.markLabel.layer.borderColor = _markBorderColor.CGColor;
    cell.markLabel.layer.borderWidth = _markBorderWidth;
    cell.markLabel.backgroundColor = _markBackgroundColor;
    
    switch (_markTextAlignment) {
        case MarkTextAlignmentDefault:
            cell.markLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case MarkTextAlignmentRight:
            cell.markLabel.textAlignment = NSTextAlignmentRight;
        case MarkTextAlignmentCenter:
            cell.markLabel.textAlignment = NSTextAlignmentCenter;
        default:
            break;
    }
    
    [cell updateLabelFrame];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_canSelection) {
        
    }
}


@end
