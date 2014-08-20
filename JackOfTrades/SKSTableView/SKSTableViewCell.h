//
//  SKSTableViewCell.h
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  SKSTableViewCell is a custom table view cell class extended from UITableViewCell class. This class is used to represent the
 *  expandable rows of the SKSTableView object.
 */

@interface SKSTableViewCell : UITableViewCell

/**
 * The boolean value showing the receiver is expandable or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpandable) BOOL expandable;

/**
 * The boolean value showing the receiver is the current cell to be expanded for the left image or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpandingLeft) BOOL expandingLeft;

/**
 * The boolean value showing the receiver is the current cell to be expanded for the riggt image or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpandingRight) BOOL expandingRight;


/**
 * The boolean value showing the receiver is already expanded for the left image or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpandedLeft) BOOL expandedLeft;

/**
 * The boolean value showing the receiver is already expanded for the right image or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpandedRight) BOOL expandedRight;

/**
 * Adds an indicator view into the receiver when the relevant cell is expanded.
 */
- (void)addIndicatorView;

/**
 * Removes the indicator view from the receiver when the relevant cell is collapsed.
 */
- (void)removeIndicatorView;

/**
 * Returns a boolean value showing if the receiver contains an indicator view or not.
 *
 *  @return The boolean value for the indicator view.
 */
- (BOOL)containsIndicatorView;

- (void)accessoryViewAnimation;

@end