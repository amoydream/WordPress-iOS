//
//  AddUsersBlogCell.m
//  WordPress
//
//  Created by Sendhil Panchadsaram on 5/3/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import "AddUsersBlogCell.h"
#import "WPWalkthroughLineSeparatorView.h"
#import "UIImageView+Gravatar.h"

@interface AddUsersBlogCell() {
    UILabel *_titleLabel;
    UIImageView *_blavatarImage;
    UIImageView *_checkboxImage;
    WPWalkthroughLineSeparatorView *_separator;
    WPWalkthroughLineSeparatorView *_topSeparator;
    
    NSString *_blavatarUrl;
}

@end

@implementation AddUsersBlogCell

CGFloat const AddUsersBlogMaxTextWidth = 208.0;
CGFloat const AddUsersBlogBlavatarSide = 32.0;
CGFloat const AddUsersBlogMinimumHeight = 48.0;
CGFloat const AddUsersBlogOffset = 16.0;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"OpenSans" size:15.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:_titleLabel];
        
        _blavatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(AddUsersBlogOffset, 0.5*AddUsersBlogOffset, AddUsersBlogBlavatarSide, AddUsersBlogBlavatarSide)];
        [self addSubview:_blavatarImage];
        
        UIImage *image = [UIImage imageNamed:@"addBlogsUnselectedImage"];
        _checkboxImage = [[UIImageView alloc] initWithImage:image];
        _checkboxImage.frame = CGRectMake(CGRectGetWidth(self.bounds) - AddUsersBlogOffset - CGRectGetWidth(_checkboxImage.frame), AddUsersBlogOffset, image.size.width , image.size.height);
        [self addSubview:_checkboxImage];
        
        _topSeparator = [[WPWalkthroughLineSeparatorView alloc] init];
        _topSeparator.frame = CGRectZero;
        [self addSubview:_topSeparator];
        
        _separator = [[WPWalkthroughLineSeparatorView alloc] init];
        [self addSubview:_separator];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x,y;
    CGFloat cellWidth = CGRectGetWidth(self.bounds);
    CGFloat cellHeight = CGRectGetHeight(self.bounds);
    
    CGSize textSize = [[self class] sizeForText:_titleLabel.text];
    CGFloat rowHeight = [[self class] rowHeightForTextWithSize:textSize];
    
    // Setup Blavatar
    x = AddUsersBlogOffset;
    y = (rowHeight - AddUsersBlogBlavatarSide)/2.0;
    _blavatarImage.frame = CGRectIntegral(CGRectMake(x, y, AddUsersBlogBlavatarSide, AddUsersBlogBlavatarSide));
    NSURL *blogURL = [NSURL URLWithString:_blavatarUrl];
    [_blavatarImage setImageWithBlavatarUrl:[blogURL host] isWPcom:self.isWPCom];
    
    // Setup Checkbox
    UIImage *image;
    if (self.selected) {
        image = [UIImage imageNamed:@"addBlogsSelectedImage"];
    } else {
        image = [UIImage imageNamed:@"addBlogsUnselectedImage"];
    }
    _checkboxImage.image = image;
    x = cellWidth - AddUsersBlogOffset - CGRectGetWidth(_checkboxImage.frame);
    y = (rowHeight - _checkboxImage.image.size.height)/2.0;
    _checkboxImage.frame = CGRectIntegral(CGRectMake(x, y, image.size.width, image.size.height));
    
    // Setup Title
    x = CGRectGetMaxX(_blavatarImage.frame) + AddUsersBlogOffset;
    y = (rowHeight - textSize.height)/2.0;
    if (self.selected) {
        _titleLabel.textColor = [UIColor whiteColor];
    } else {
        _titleLabel.textColor = [UIColor colorWithRed:188.0/255.0 green:221.0/255.0 blue:236.0/255.0 alpha:1.0];
    }
    _titleLabel.shadowColor = [UIColor colorWithRed:0.0 green:115/255.0 blue:164/255.0 alpha:1.0];
    _titleLabel.frame = CGRectIntegral(CGRectMake(x, y, textSize.width, textSize.height));
    
    // Setup Separators
    _separator.frame = CGRectMake(AddUsersBlogOffset, cellHeight - 2, cellWidth - 2*AddUsersBlogOffset, 2);
    
    if (_showTopSeparator) {
        _topSeparator.frame = CGRectMake(AddUsersBlogOffset, 0, cellWidth - 2*AddUsersBlogOffset, 2);
    } else {
        _topSeparator.frame = CGRectZero;
    }
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setBlavatarUrl:(NSString *)url
{
    if (_blavatarUrl != url) {
        _blavatarUrl = url;
        [self setNeedsLayout];
    }
}

- (void)setShowTopSeparator:(BOOL)showTopSeparator
{
    _showTopSeparator = showTopSeparator;
    [self setNeedsLayout];
}

+ (CGFloat)rowHeightWithText:(NSString *)text
{
    CGSize textSize = [self sizeForText:text];
    return [self rowHeightForTextWithSize:textSize];
}

#pragma mark - Private Methods

+ (CGFloat)rowHeightForTextWithSize:(CGSize)size
{
    if (size.height > AddUsersBlogBlavatarSide) {
        CGFloat blavatarStartY = 0.5*AddUsersBlogMinimumHeight;
        return blavatarStartY + size.height;
    } else {
        return AddUsersBlogMinimumHeight;
    }
}

+ (CGSize)sizeForText:(NSString *)text
{
    UIFont *titleFont = [UIFont fontWithName:@"OpenSans" size:15.0];
    CGSize textSize = [text sizeWithFont:titleFont constrainedToSize:CGSizeMake(AddUsersBlogMaxTextWidth, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    return textSize;
}

@end
