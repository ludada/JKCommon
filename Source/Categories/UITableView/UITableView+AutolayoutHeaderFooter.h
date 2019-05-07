//
//  UITableView+AutolayoutHeaderFooter.h
//  JKNews
//
//  Created by Sid on 19/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (AutolayoutHeaderFooter)

- (void)configureAutolayoutHeaderView:(UIView *)header;
- (void)configureAutolayoutFooterView:(UIView *)footer;

@end
