//
//  HTViewController.m
//  HTFlipCard
//
//  Created by squarepants1991 on 01/11/2018.
//  Copyright (c) 2018 squarepants1991. All rights reserved.
//

#import "HTViewController.h"
@import HTFlipCard;
#import <HTFlipCard/HTFlipCardLayer.h>
#import <HTFlipCard/HTFlipCardView.h>

#define SF(format, ...)  [NSString stringWithFormat:format, __VA_ARGS__]

@interface HTViewController () {
    int _score;
}
@property (weak, nonatomic) IBOutlet HTFlipCardView *flipCard;

@end

@implementation HTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _score = 0;

    UILabel *backView = [UILabel new];
    backView.backgroundColor = UIColor.greenColor;
    backView.layer.cornerRadius = 5;
    [backView setClipsToBounds:YES];
    backView.text = SF(@"%d", _score + 1);
    
    UILabel *frontView = [UILabel new];
    frontView.backgroundColor = UIColor.redColor;
    frontView.layer.cornerRadius = 5;
    [frontView setClipsToBounds:YES];
    frontView.text = SF(@"%d", _score);

    [self setupLabel: frontView];
    [self setupLabel: backView];

    [self.flipCard setFrontView:frontView backView:backView];
}

- (void)setupLabel:(UILabel *)label {
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:140];
    label.textColor = UIColor.whiteColor;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _score++;
    int newScore = _score;
    [self.flipCard flip:HTFlipDirectionVertical beforeFlip:^(UIView *frontView, UIView *backView) {
        ((UILabel *)backView).text = SF(@"%d", newScore);
        NSLog(@"%d", newScore);
    } completed:^(UIView *frontView, UIView *backView) {

    }];
}

@end
