//
//  UIPanGestureRecognizer+Direction.h
//  05-滑动方向判断


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIPanGestureMoveDirection) {
    UIPanGestureMoveDirectionNone,   // 没有滑动
    UIPanGestureMoveDirectionLeft,   // 向左滑动
    UIPanGestureMoveDirectionRight,  // 向右滑动
    UIPanGestureMoveDirectionUp,     // 向上滑动
    UIPanGestureMoveDirectionDown    // 向下滑动
};

@interface UIPanGestureRecognizer (Direction)

// 添加判断滑动方向的方法
- (UIPanGestureMoveDirection)judgeTheMoveDirection:(CGPoint)translation;

@end
