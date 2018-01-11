//
//  HTViewController.m
//  HTFlipCard
//
//  Created by squarepants1991 on 01/11/2018.
//  Copyright (c) 2018 squarepants1991. All rights reserved.
//

#import "HTViewController.h"
@import HTFlipCard;

@interface HTViewController ()
@property (weak, nonatomic) IBOutlet HTFlipCardView *flipCard;

@end

@implementation HTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *greenView = [UILabel new];
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.cornerRadius = 5;
    [greenView setClipsToBounds:YES];
    
    UILabel *redView = [UILabel new];
    redView.backgroundColor = UIColor.redColor;
    redView.layer.cornerRadius = 5;
    [redView setClipsToBounds:YES];
    
    [self.flipCard setFrontView:redView backView:greenView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.flipCard flip:HTFlipDirectionHorizontal completed:^(UIView *frontView, UIView *backView) {
        UILabel *backLabel = (UILabel *)backView;
        backLabel.text = @"Back";
        UILabel *frontLabel = (UILabel *)frontView;
        frontLabel.text = @"Front";
    }];
}

@end
