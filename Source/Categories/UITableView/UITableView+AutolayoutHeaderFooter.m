//
//  UITableView+AutolayoutHeaderFooter.m
//  JKNews
//
//  Created by Sid on 19/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UITableView+AutolayoutHeaderFooter.h"

@implementation UITableView (AutolayoutHeaderFooter)

- (void)autolayoutHeaderOrFooter:(UIView *)headerOrFooter {
    headerOrFooter.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat width = self.bounds.size.width;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:headerOrFooter
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0f
                                                                              constant:width
                                                 ];
    [headerOrFooter addConstraint:constraint];
    CGFloat height = [headerOrFooter systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [headerOrFooter removeConstraint:constraint];
    headerOrFooter.frame = CGRectMake(0, 0,width, height);
    headerOrFooter.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)configureAutolayoutHeaderView:(UIView *)header {
    [self autolayoutHeaderOrFooter:header];
    self.tableHeaderView = header;
}

- (void)configureAutolayoutFooterView:(UIView *)footer {
    [self autolayoutHeaderOrFooter:footer];
    self.tableFooterView = footer;
}

@end
