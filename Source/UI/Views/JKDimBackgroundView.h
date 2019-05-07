//
//  JKDimBackgroundView.h
//  
//
//  Created by Sid on 24/07/2017.
//
//

#import <UIKit/UIKit.h>

@protocol JKDimBackgroudViewAccessoryViewProtocol <NSObject>

- (void)hideWithCompletion:(void(^)(void))completion;

@end

@interface JKDimBackgroundView : UIView

- (void)showWithAccessoryView:(UIView<JKDimBackgroudViewAccessoryViewProtocol> *)accessoryView;
- (void)showToView:(UIView *)view withAccessoryView:(UIView<JKDimBackgroudViewAccessoryViewProtocol> *)accessoryView;
- (void)hideWithCompletion:(void(^)(UIView<JKDimBackgroudViewAccessoryViewProtocol> *accessoryView))completion;

@end
