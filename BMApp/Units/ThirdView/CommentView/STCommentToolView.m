//
//  NFCommentToolView.m
//  CommentDemo
//
//  Created by menghua liu on 2018/5/8.
//  Copyright © 2018年 hih-d-11371. All rights reserved.
//

#import "STCommentToolView.h"
#import "UIView+Frame.h"
#import "UIFont+Extension.h"
#import "UIColor+Extension.h"

#define TOOL_VIEW_HEIGHT 50.f *AutoSizeScaleY

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_X ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && ([[UIScreen mainScreen] bounds].size.height == 812))
#define IPHONE_X_BOTTOM_USELESS_HEIGHT 33.f


typedef NS_ENUM(NSUInteger, NFCommentToolViewAction) {
    NFCommentToolViewActionContent = 1,
    NFCommentToolViewActionArticle,
    NFCommentToolViewActionShare
};

@interface STCommentToolView()

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation STCommentToolView

- (instancetype)initWithDeafultFrame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self loadSubViewsWithDefaultFrame:YES frame:CGRectZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self loadSubViewsWithDefaultFrame:NO frame:frame];
    }
    return self;
}

- (void)loadSubViewsWithDefaultFrame:(BOOL)defaultFrame frame:(CGRect)frame {
    
    if (defaultFrame) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - TOOL_VIEW_HEIGHT, SCREEN_WIDTH, TOOL_VIEW_HEIGHT);
        if (IS_IPHONE_X) {
            self.frame = CGRectMake(0, SCREEN_HEIGHT - TOOL_VIEW_HEIGHT - IPHONE_X_BOTTOM_USELESS_HEIGHT, SCREEN_WIDTH, TOOL_VIEW_HEIGHT);
        }
    } else {
        self.frame = CGRectMake(0, frame.origin.y, SCREEN_WIDTH, TOOL_VIEW_HEIGHT);
    }
    
    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:0.13].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 10;
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1.f)];
//    lineView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2f];
//    [self addSubview:lineView];
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:0.13].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 10;
    UIButton *contentButton = [[UIButton alloc]initWithFrame:CGRectMake(15 * AutoSizeScaleX, 8 * AutoSizeScaleY, SCREEN_WIDTH - 125 * AutoSizeScaleX , self.height - 16 * AutoSizeScaleY)];
    contentButton.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    contentButton.layer.borderWidth = 1.f;
    contentButton.layer.borderColor = [UIColor colorWithHexString:@"#EDEDED"].CGColor;
    contentButton.layer.cornerRadius = contentButton.height/2;
    contentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [contentButton setTitle:@"围观群众说啥…" forState:UIControlStateNormal];
    contentButton.titleLabel.font = [UIFont customFontWithName:@"PingFangSC-Regular" size:14.f];
    contentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [contentButton setTitleColor:[UIColor colorWithHexString:@"#C6C1C1"] forState:UIControlStateNormal];
    contentButton.tag = NFCommentToolViewActionContent;
    [contentButton addTarget:self action:@selector(buttonClicled:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contentButton];
    
    UIButton * sendButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100 * AutoSizeScaleX, 10 * AutoSizeScaleX, 85 * AutoSizeScaleX, 30 * AutoSizeScaleY)];
    [sendButton addTarget:self action:@selector(buttonClicled:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"发布" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont customFontWithName:@"PingFangSC-Regular" size:14.f];
    sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [sendButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    sendButton.tag = NFCommentToolViewActionContent;
    [sendButton setBackgroundColor:[UIColor getUsualColorWithString:@"#07BFD9"]];
    ZViewBorderRadius(sendButton, 2 * AutoSizeScaleX, 0, [UIColor getUsualColorWithString:@"#07BFD9"]);
    [self addSubview:sendButton];
    
    return;
    UIButton *articleButton = [self createButtonWithNormalImage:@"title_comment_icon_normal" selectImage:@"title_comment_icon_highlight"];
    articleButton.frame = CGRectMake(SCREEN_WIDTH - 63 - 19, (self.height - 19)/2, 19, 19);
    articleButton.tag = NFCommentToolViewActionArticle;
    [articleButton addTarget:self action:@selector(buttonClicled:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:articleButton];
    
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.font =  [UIFont customFontWithName:@"PingFangSC-Semibold" size:9.f];
    self.countLabel.textColor = [UIColor colorWithHexString:@"#F85959"];
    self.countLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.countLabel];
    
    UIButton *shareButton = [self createButtonWithNormalImage:@"title_share_icon_normal" selectImage:@"title_share_icon_highlight"];
    shareButton.frame = CGRectMake(SCREEN_WIDTH - 18 - 15, (self.height - 18)/2, 18, 18);
    shareButton.tag = NFCommentToolViewActionShare;
    [shareButton addTarget:self action:@selector(buttonClicled:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
}

- (void)buttonClicled:(UIButton *)button {
    switch (button.tag) {
        case NFCommentToolViewActionContent:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(commentToolViewContentButtonClicked)]) {
                [self.delegate commentToolViewContentButtonClicked];
            }
        }
            break;
        case NFCommentToolViewActionArticle:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(commentToolViewArticleButtonClicked)]) {
                [self.delegate commentToolViewArticleButtonClicked];
            }
        }
            break;
        case NFCommentToolViewActionShare:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(commentToolViewShareButtonClicked)]) {
                [self.delegate commentToolViewShareButtonClicked];
            }
        }
            break;
    }
}

#pragma mark - Setter

- (void)setCommentCount:(NSUInteger)commentCount {
    _commentCount = commentCount;
    
    if (_commentCount < 10000) {
       self.countLabel.text = [NSString stringWithFormat:@"%zd", _commentCount];
    } else {
        CGFloat newCount = _commentCount/10000.0;
        self.countLabel.text = [NSString stringWithFormat:@"%.1f万", newCount];
    }
    
    CGSize labelSize = [self.countLabel sizeThatFits:CGSizeMake(0, 0)];
    self.countLabel.frame = CGRectMake(self.width - 63 - labelSize.width/2, (self.height - 19)/2 - labelSize.height/2 + 3, labelSize.width, 8);
}

#pragma mark - Private method

- (UIButton *)createButtonWithNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateHighlighted];
    return button;
}

- (void)sendButtonClicked:(UIButton *)sendBtn{

}

@end
