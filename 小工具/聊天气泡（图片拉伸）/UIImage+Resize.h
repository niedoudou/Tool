//
//  UIImage+Resize.h


#import <UIKit/UIKit.h>

@interface UIImage (Resize)

#pragma mark 默认从图片中心点开始拉伸图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

@end
