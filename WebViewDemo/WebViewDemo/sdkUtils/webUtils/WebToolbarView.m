//
//  WebToolbarView.m
//  LeanCloudTest
//
//  Created by ZhangFan on 2019/7/31.
//  Copyright © 2019 Rahman Hamid. All rights reserved.
//

#import "WebToolbarView.h"

@interface WebToolbarView()

@property (strong, nonatomic) UIButton *prevBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) UIButton *homeBtn;
@property (strong, nonatomic) UIButton *refrushBtn;

@property (strong, nonatomic) UIStackView *stackView;

@end

@implementation WebToolbarView

- (UIButton *)prevBtn {
    if(_prevBtn == nil) {
        _prevBtn = [[UIButton alloc]init];
        [_prevBtn setTitle:@"后退" forState:UIControlStateNormal];
        [_prevBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _prevBtn.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Regular" size:10.0];
        _prevBtn.contentEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -17);
        _prevBtn.titleEdgeInsets = UIEdgeInsetsMake(44, -47, 0, 0);
        
    }
    return _prevBtn;
}

- (UIButton *)nextBtn {
    if(_nextBtn == nil) {
        _nextBtn = [[UIButton alloc]init];
        [_nextBtn setTitle:@"前进" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Regular" size:10.0];
        _nextBtn.contentEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -17);
        _nextBtn.titleEdgeInsets = UIEdgeInsetsMake(44, -47, 0, 0);
    }
    return _nextBtn;
}

- (UIButton *)homeBtn {
    if(_homeBtn == nil) {
        _homeBtn = [[UIButton alloc]init];
        [_homeBtn setTitle:@"主页" forState:UIControlStateNormal];
        [_homeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _homeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Regular" size:10.0];
        _homeBtn.contentEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -17);
        _homeBtn.titleEdgeInsets = UIEdgeInsetsMake(44, -47, 0, 0);
    }
    return _homeBtn;
}

- (UIButton *)refrushBtn {
    if(_refrushBtn == nil) {
        _refrushBtn = [[UIButton alloc]init];
        [_refrushBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [_refrushBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _refrushBtn.titleLabel.font = [UIFont fontWithName:@"PingFangTC-Regular" size:10.0];
        _refrushBtn.contentEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -17);
        _refrushBtn.titleEdgeInsets = UIEdgeInsetsMake(44, -47, 0, 0);
    }
    return _refrushBtn;
}

- (UIStackView *)stackView {
    if(_stackView == nil) {
        _stackView = [[UIStackView alloc]init];
    }
    return _stackView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.stackView];
        self.stackView.axis = UILayoutConstraintAxisHorizontal;
        self.stackView.alignment = UIStackViewAlignmentFill;
        self.stackView.distribution = UIStackViewDistributionEqualSpacing;
        self.stackView.spacing = 20;
        [self.stackView addArrangedSubview:self.prevBtn];
        //[self.prevBtn setTitle:@"<<" forState:UIControlStateNormal];
        [self.prevBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self.prevBtn sizeToFit];
        [self.prevBtn addTarget:self action:@selector(toPrevPage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.stackView addArrangedSubview:self.nextBtn];
        //[self.nextBtn setTitle:@">>" forState:UIControlStateNormal];
        [self.nextBtn setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
        [self.nextBtn sizeToFit];
        [self.nextBtn addTarget:self action:@selector(toNextPage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.stackView addArrangedSubview:self.homeBtn];
        //[self.nextBtn setTitle:@">>" forState:UIControlStateNormal];
        [self.homeBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
        [self.homeBtn sizeToFit];
        [self.homeBtn addTarget:self action:@selector(toHomePage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.stackView addArrangedSubview:self.refrushBtn];
        //[self.refrushBtn setTitle:@"reload" forState:UIControlStateNormal];
        [self.refrushBtn setImage:[UIImage imageNamed:@"reload"] forState:UIControlStateNormal];
        [self.refrushBtn sizeToFit];
        [self.refrushBtn addTarget:self action:@selector(reloadPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat safeAreaInsetBottom = 0.0;
    if (@available(iOS 11.0, *)) {
        safeAreaInsetBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    
    self.stackView.frame = CGRectMake(20.0, 0.0, self.bounds.size.width - 40, self.bounds.size.height - safeAreaInsetBottom);
    self.stackView.backgroundColor = [UIColor redColor];
}

- (void)toPrevPage {
    if(self.delegate != nil) {
        if([self.delegate respondsToSelector:@selector(webtoolbarDidToPrev)]) {
            [self.delegate webtoolbarDidToPrev];
        }
    }
}

- (void)toNextPage {
    if(self.delegate != nil) {
        if([self.delegate respondsToSelector:@selector(webtoolbarDidToNext)]) {
            [self.delegate webtoolbarDidToNext];
        }
    }
}

- (void)toHomePage {
    if(self.delegate != nil) {
        if([self.delegate respondsToSelector:@selector(webtoolbarDidToHome)]) {
            [self.delegate webtoolbarDidToHome];
        }
    }
}

- (void)reloadPage {
    if(self.delegate != nil) {
        if([self.delegate respondsToSelector:@selector(webtoolbarDidReload)]) {
            [self.delegate webtoolbarDidReload];
        }
    }
}

@end
