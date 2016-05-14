//
//  UIPanGestureRecognizer+Direction.m
//  05-滑动方向判断

#import "UIPanGestureRecognizer+Direction.h"
// 设置一个最小的响应值
static CGFloat kGestureMinValue = 10.f;

@implementation UIPanGestureRecognizer (Direction)

// 添加判断滑动方向的方法
- (UIPanGestureMoveDirection)judgeTheMoveDirection:(CGPoint)translation
{
    // fabs取绝对值
    // 先判断X轴
    if (fabs(translation.x) >= kGestureMinValue) {
        // 设置一个横向移动的BOOL值，当为YES的时候为横向移动
        BOOL gestureHorizontal = NO;
        
        // 判断手在哪个方向移动
        if (translation.y == 0.0f) {
            gestureHorizontal = YES;
        }else{
            gestureHorizontal = fabs(translation.x / translation.y) >= 1.0;
        }
        
        // 判断是否为横向移动
        if (gestureHorizontal) {
            // 当小于0的时候，肯定向左
            if (translation.x < 0) {
                return UIPanGestureMoveDirectionLeft;
            }else{
                return UIPanGestureMoveDirectionRight;
            }
        }
    }
    // 后判断Y轴
    else if (fabs(translation.y) >= kGestureMinValue) {
        // 设置一个纵向移动的BOOL值，当为YES的时候为纵向移动
        BOOL gestureVertical = NO;
        
        // 判断手在哪个方向移动
        if (translation.x == 0.0f) {
            gestureVertical = YES;
        }else{
            gestureVertical = fabs(translation.x / translation.y) <= 1.0;
        }
        
        // 判断是否为纵向移动
        if (gestureVertical) {
            // 当小于0的时候，肯定向上
            if (translation.y < 0) {
                return UIPanGestureMoveDirectionUp;
            }else{
                return UIPanGestureMoveDirectionDown;
            }
        }
    }
    
    return UIPanGestureMoveDirectionNone;
}

@end
