//
//  HTFlipCardView.m
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import "HTFlipCardView.h"
#import "HTFlipCardLayer.h"

@interface HTFlipCardView () <CAAnimationDelegate> {
    @private
    UIView *_frontView;
    UIView *_backView;
    BOOL _isFlipped;
    HTFlipCardCompleteHandler _flipCompletedHandler;
}
@end

@implementation HTFlipCardView

+ (Class)layerClass {
    return [HTFlipCardLayer class];
}

- (instancetype)initWithFrontView:(UIView *)frontView backView:(UIView *)backView {
    if (self = [super init]) {
        _isFlipped = NO;
        [self setFrontView:frontView backView:backView];
    }
    return self;
}

- (void)setFrontView:(UIView *)frontView backView:(UIView *)backView {
    _frontView = frontView;
    _backView = backView;
    [self addSubview: _backView];
    [self addSubview:_frontView];
    [(HTFlipCardLayer *)self.layer setFrontLayer:_frontView.layer backLayer:_backView.layer];
}

- (void)flip:(HTFlipDirection)direction {
    [self flip:direction completed:nil];
}

- (void)flip:(HTFlipDirection)direction completed:(HTFlipCardCompleteHandler)completed {
    
    _flipCompletedHandler = completed;
    
    [(HTFlipCardLayer *)self.layer setFlipDirection:direction];
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"flipRotation"];
    flipAnimation.fromValue = _isFlipped ? @(M_PI) : @0;
    flipAnimation.toValue = _isFlipped ? @(2 * M_PI) : @(M_PI);
    flipAnimation.duration = 0.5;
    flipAnimation.fillMode = kCAFillModeForwards;
    flipAnimation.removedOnCompletion = NO;
    flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    flipAnimation.delegate = self;
    [self.layer addAnimation:flipAnimation forKey:@"flipRotation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _isFlipped = !_isFlipped;
    if (_flipCompletedHandler != nil) {
        UIView *frontView = _isFlipped ? _backView : _frontView;
        UIView *backView = _isFlipped ? _frontView : _backView;
        _flipCompletedHandler(frontView, backView);
        _flipCompletedHandler = nil;
    }
}
@end
