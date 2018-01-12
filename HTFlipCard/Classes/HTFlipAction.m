//
//  HTFlipCardLayer.m
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import "HTFlipAction.h"

@interface HTFlipAction ()
@end

@implementation HTFlipAction
+ (instancetype)flipActionWithDirection:(HTFlipDirection)flipDirection willFlipHandler:(HTFlipActionWillFlipHandler)willFlipHandler completeHandler:(HTFlipActionDidFlipCompleteHandler)completeHandler {
    HTFlipAction *action = [HTFlipAction new];
    action.willFlipHandler = willFlipHandler;
    action.didFlipCompleteHandler = completeHandler;
    action.flipDirection = flipDirection;
    return action;
}
@end
