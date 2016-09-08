//
//  FollowButton.h
//
//
//  Created by Phan Nguyen on 3/27/2015.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FollowButton;
@protocol FollowButtonDelegate
- (void) followButton:(FollowButton *)button didTapWithSectionIndex:(NSInteger)index;
@end

@interface FollowButton : UIButton

@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, weak) id <FollowButtonDelegate> delegate;
@end
