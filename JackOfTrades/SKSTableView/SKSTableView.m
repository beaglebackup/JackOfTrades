//
//  SKSTableView.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"
#import <objc/runtime.h>

static NSString * const kIsExpandedLeftKey = @"isExpandedLeft";
static NSString * const kIsExpandedRightKey = @"isExpandedRight";
static NSString * const kSubrowsLeftKey = @"subrowsLeftCount";
static NSString * const kSubrowsRightKey = @"subrowsRightCount";




CGFloat const kDefaultCellHeight = 44.0f;

#pragma mark - SKSTableView

@interface SKSTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSMutableDictionary *expandableCells;


- (NSInteger)numberOfExpandedSubrowsInSection:(NSInteger)section;

- (NSIndexPath *)correspondingIndexPathForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)setExpandedLeft:(BOOL)isExpanded forCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)setExpandedRight:(BOOL)isExpanded forCellAtIndexPath:(NSIndexPath *)indexPath;


- (IBAction)expandableButtonTouched:(id)sender event:(id)event;

- (NSInteger)numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation SKSTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _shouldExpandOnlyOneCell = YES;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _shouldExpandOnlyOneCell = YES;
    }
    
    return self;
}

- (void)setSKSTableViewDelegate:(id<SKSTableViewDelegate>)SKSTableViewDelegate
{
    self.dataSource = self;
    self.delegate = self;
    
    [self setSeparatorColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
    
    if (SKSTableViewDelegate)
        _SKSTableViewDelegate = SKSTableViewDelegate;
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    [super setSeparatorColor:separatorColor];
    [SKSTableViewCellIndicator setIndicatorColor:separatorColor];
}

- (NSMutableDictionary *)expandableCells
{
    if (!_expandableCells)
    {
        _expandableCells = [NSMutableDictionary dictionary];
        
        NSInteger numberOfSections = [self.SKSTableViewDelegate numberOfSectionsInTableView:self];
        
        for (NSInteger section = 0; section < numberOfSections; section++)
        {
            NSInteger numberOfRowsInSection = [self.SKSTableViewDelegate tableView:self
                                                             numberOfRowsInSection:section];
            
            
            NSMutableArray *rows = [NSMutableArray array];
            for (NSInteger row = 0; row < numberOfRowsInSection; row++)
            {
                NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
                
                NSInteger objectIndexLeft = rowIndexPath.row * 2;
                NSInteger objectIndexRight = rowIndexPath.row * 2 + 1;

                NSInteger numberOfSubrowsLeft = [self.SKSTableViewDelegate tableView:self
                                                      numberOfSubRowsAtObjectIndex:objectIndexLeft];
                NSInteger numberOfSubrowsRight = [self.SKSTableViewDelegate tableView:self
                                                        numberOfSubRowsAtObjectIndex:objectIndexRight];
            
                
                NSMutableDictionary *rowInfo = [NSMutableDictionary dictionaryWithObjects:@[@(NO), @(NO), @(numberOfSubrowsLeft), @(numberOfSubrowsRight)]
                                                                                  forKeys:@[kIsExpandedLeftKey, kIsExpandedRightKey, kSubrowsLeftKey, kSubrowsRightKey]];
                [rows addObject:rowInfo];
            }
            
            
            [_expandableCells setObject:rows forKey:@(section)];
            
            NSLog(@"after");
            
            
        }
    }
    
//    NSLog(@"_expandableCells = %@",_expandableCells);
    
    return _expandableCells;
}

#pragma mark - UITableViewDataSource

#pragma mark - Required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"[_SKSTableViewDelegate tableView:tableView numberOfRowsInSection:section] + [self numberOfExpandedSubrowsInSection:section] = %d",[_SKSTableViewDelegate tableView:tableView numberOfRowsInSection:section] + [self numberOfExpandedSubrowsInSection:section]);
    
    return [_SKSTableViewDelegate tableView:tableView numberOfRowsInSection:section] + [self numberOfExpandedSubrowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *correspondingIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
    if ([correspondingIndexPath subRow] == 0)
    {
        SKSTableViewCell *expandableCell = (SKSTableViewCell *)[_SKSTableViewDelegate tableView:tableView cellForRowAtIndexPath:correspondingIndexPath];
        if ([expandableCell respondsToSelector:@selector(setSeparatorInset:)])
        {
            expandableCell.separatorInset = UIEdgeInsetsZero;
        }
        
        
        BOOL isExpandedLeft = [self.expandableCells[@(correspondingIndexPath.section)][correspondingIndexPath.row][kIsExpandedLeftKey] boolValue];
        BOOL isExpandedRight = [self.expandableCells[@(correspondingIndexPath.section)][correspondingIndexPath.row][kIsExpandedRightKey] boolValue];
    
        

        if (expandableCell.isExpandable)
        {
            
            expandableCell.expandingLeft = isExpandedLeft;
            expandableCell.expandingRight = isExpandedRight;
            
            UIButton *expandableButton = (UIButton *)expandableCell.accessoryView;
            [expandableButton addTarget:tableView
                                 action:@selector(expandableButtonTouched:event:)
                       forControlEvents:UIControlEventTouchUpInside];
            
            if (isExpandedLeft)
            {
                expandableCell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            }
            else
            {
                if ([expandableCell containsIndicatorView])
                {
                    [expandableCell removeIndicatorView];
                }
            }
            
            if (isExpandedRight)
            {
                expandableCell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            }
            else
            {
                if ([expandableCell containsIndicatorView])
                {
                    [expandableCell removeIndicatorView];
                }
            }
        }
        else
        {
            expandableCell.expandingLeft = NO;
            expandableCell.expandingRight = NO;
            expandableCell.accessoryView = nil;
            [expandableCell removeIndicatorView];
        }
        
       return expandableCell;
    }
    else
    {
        NSInteger objectIndex;
        
        BOOL isExpandedLeft = [self.expandableCells[@(correspondingIndexPath.section)][correspondingIndexPath.row][kIsExpandedLeftKey] boolValue];
        BOOL isExpandedRight = [self.expandableCells[@(correspondingIndexPath.section)][correspondingIndexPath.row][kIsExpandedRightKey] boolValue];
        
        if (isExpandedLeft) {
            objectIndex = correspondingIndexPath.row * 2;
        }
        else if (isExpandedRight)
        {
            objectIndex = correspondingIndexPath.row * 2 + 1;
        }
        
        UITableViewCell *cell = [_SKSTableViewDelegate tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:correspondingIndexPath objectIndex:objectIndex];
        cell.backgroundColor = [UIColor colorLavender];
        cell.indentationLevel = 4;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
}

#pragma mark - Optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_SKSTableViewDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)])
    {
        return [_SKSTableViewDelegate numberOfSectionsInTableView:tableView];
    }
    
    return 1;
}

/*
 *  Uncomment the implementations of the required methods.
 */

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:titleForHeaderInSection:)])
//        return [_SKSTableViewDelegate tableView:tableView titleForHeaderInSection:section];
//    
//    return nil;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:titleForFooterInSection:)])
//        return [_SKSTableViewDelegate tableView:tableView titleForFooterInSection:section];
//    
//    return nil;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView canEditRowAtIndexPath:indexPath];
//    
//    return NO;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView canMoveRowAtIndexPath:indexPath];
//    
//    return NO;
//}
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)])
//        [_SKSTableViewDelegate sectionIndexTitlesForTableView:tableView];
//    
//    return nil;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)])
//        [_SKSTableViewDelegate tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
//    
//    return 0;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
//}

#pragma mark - UITableViewDelegate

#pragma mark - Optional

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didSelectSubRowAtIndexPath:)])
    {
        NSIndexPath *correspondingIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
        
        [_SKSTableViewDelegate tableView:self didSelectSubRowAtIndexPath:correspondingIndexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)])
        [_SKSTableViewDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

/*
 *  Uncomment the implementations of the required methods.
 */

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)])
//        [_SKSTableViewDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)])
//        [_SKSTableViewDelegate tableView:tableView willDisplayFooterView:view forSection:section];
//}
//
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
//}
//
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)])
//        [_SKSTableViewDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
//}
//
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)])
//        [_SKSTableViewDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *correspondingIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
    if ([correspondingIndexPath subRow] == 0)
    {
        if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        {
            return [_SKSTableViewDelegate tableView:tableView heightForRowAtIndexPath:correspondingIndexPath];
        }
        
        return kDefaultCellHeight;
    }
    else
    {
        if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:heightForSubRowAtIndexPath:)])
        {
            return [_SKSTableViewDelegate tableView:self heightForSubRowAtIndexPath:correspondingIndexPath];
        }
        
        return kDefaultCellHeight;
    }
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
//        [_SKSTableViewDelegate tableView:tableView heightForHeaderInSection:section];
//    
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
//        [_SKSTableViewDelegate tableView:tableView heightForFooterInSection:section];
//    
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
//    
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)])
//        [_SKSTableViewDelegate tableView:tableView estimatedHeightForHeaderInSection:section];
//    
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)])
//        [_SKSTableViewDelegate tableView:tableView estimatedHeightForFooterInSection:section];
//    
//    return 0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)])
//        [_SKSTableViewDelegate tableView:tableView viewForHeaderInSection:section];
//    
//    return nil;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)])
//        [_SKSTableViewDelegate tableView:tableView viewForFooterInSection:section];
//    
//    return nil;
//}
//
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
//    
//    return NO;
//}
//
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
//}
//
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
//}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
//    
//    return nil;
//}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
//    
//    return nil;
//}
//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
//    
//    return UITableViewCellEditingStyleNone;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
//    
//    return nil;
//}
//
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
//    
//    return NO;
//}
//
//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
//}
//
//- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
//}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
//    
//    return nil;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
//    
//    return 0;
//}
//
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)])
//        [_SKSTableViewDelegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
//    
//    return NO;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)])
//        [_SKSTableViewDelegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
//    
//    return NO;
//}
//
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//{
//    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)])
//        [_SKSTableViewDelegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
//}

#pragma mark - SKSTableViewUtils

- (void) expandCell:(SKSTableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath forObjectIndex:(NSInteger)objectIndex  {
    
    
    NSLog(@"indexPath -- Section: %d, Row: %d", indexPath.section, indexPath.row);

    if ([cell respondsToSelector:@selector(isExpandable)])
    {
        
        NSLog(@"cell.isExpandable: %d",cell.isExpandable);
        
        // SCENARIOS
        // 1. A new cell
        // 2. The same cell, same image (close it)
        // 3. The other image in the same cell (close the existing cell, open the other image)
        // 4. Different cell (close existing cell, opent the other one)

        
        if (cell.isExpandable)
        {
            // Check if left or right expanded based on objectIndex being odd or even
            if (objectIndex % 2) { // odd
                cell.expandingRight = !cell.isExpandingRight;
//                cell.expandedRight = [self isCellExpandedRight:indexPath];
            }
            else { // even
                cell.expandingLeft = !cell.isExpandingLeft;
//                cell.expandedLeft = [self isCellExpandedLeft:indexPath];
            }
            
            NSLog(@"--------------------------");
            NSLog(@"expandingLeft: %d",cell.expandingLeft);
            NSLog(@"expandingRight: %d",cell.expandingRight);
            NSLog(@"expandedRight: %d",cell.expandedRight);
            NSLog(@"expandedLeft: %d",cell.expandedLeft);
            
        
            
            NSIndexPath *_indexPath = indexPath;
            NSIndexPath *correspondingIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
            if (cell.expandingLeft && _shouldExpandOnlyOneCell)
            {
                _indexPath = correspondingIndexPath;
                [self collapseCurrentlyExpandedIndexPathsLeft];
            }
            else if (cell.expandingRight && _shouldExpandOnlyOneCell)
            {
                _indexPath = correspondingIndexPath;
                [self collapseCurrentlyExpandedIndexPathsRight];
            }
//
//            if (cell.expandingLeft) {
//                return;
//            }
            
            NSLog(@"_indexPath -- Section: %d, Row: %d", _indexPath.section, _indexPath.row);
            NSLog(@"correspondingIndexPath -- Section: %d, Row: %d", correspondingIndexPath.section, correspondingIndexPath.row);

            if (_indexPath)
            {
                NSInteger numberOfSubRows = [self numberOfSubRowsAtObjectIndex:objectIndex];
                
                NSLog(@"numberOfSubRows = %d",numberOfSubRows);
                
                NSMutableArray *expandedIndexPaths = [NSMutableArray array];
                NSInteger row = _indexPath.row;
                NSInteger section = _indexPath.section;
                
                for (NSInteger index = 1; index <= numberOfSubRows; index++)
                {
                    NSIndexPath *expIndexPath = [NSIndexPath indexPathForRow:row+index inSection:section];
                    [expandedIndexPaths addObject:expIndexPath];
                    
                    NSLog(@"expandedIndexPaths -- Section: %d, Row: %d", expIndexPath.section, expIndexPath.row);

                }
                
                NSLog(@"expandedIndexPaths.count - %d", expandedIndexPaths.count);

                
                if (cell.isExpandingLeft)
                {
                    [self setExpandedLeft:YES forCellAtIndexPath:correspondingIndexPath];
                    [self beginUpdates];
                    [self insertRowsAtIndexPaths:expandedIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                    [self endUpdates];

                }
                else if (cell.isExpandingRight) {
                    [self setExpandedRight:YES forCellAtIndexPath:correspondingIndexPath];
                    [self beginUpdates];
                    [self insertRowsAtIndexPaths:expandedIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                    [self endUpdates];

                }
                else
                {
                    [self setExpandedLeft:NO forCellAtIndexPath:correspondingIndexPath];
                    [self setExpandedRight:NO forCellAtIndexPath:correspondingIndexPath];
                    [self beginUpdates];
                    [self deleteRowsAtIndexPaths:expandedIndexPaths withRowAnimation:UITableViewRowAnimationTop];
                    [self endUpdates];

                }
                
                [cell accessoryViewAnimation];
            }
        }
        
        if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
        {
            NSIndexPath *correspondingIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
            
            if (correspondingIndexPath.subRow == 0)
            {
                [_SKSTableViewDelegate tableView:self didSelectRowAtIndexPath:correspondingIndexPath];
            }
            else
            {
                [_SKSTableViewDelegate tableView:self didSelectSubRowAtIndexPath:correspondingIndexPath];
            }
        }
    }
    
}


- (NSInteger)numberOfExpandedSubrowsInSection:(NSInteger)section
{
    NSInteger totalExpandedSubrows = 0;
    
    NSArray *rows = self.expandableCells[@(section)];
    for (id row in rows)
    {
        
        if ([row[kIsExpandedLeftKey] boolValue] == YES)
        {
            NSLog(@"left row = %@",row);
            NSLog(@"left [row[kSubrowsLeftKey] integerValue] = %ld",(long)[row[kSubrowsLeftKey] integerValue]);

            totalExpandedSubrows += [row[kSubrowsLeftKey] integerValue];
            
        }
        else if ([row[kIsExpandedRightKey] boolValue] == YES)
        {
            
            NSLog(@"right row = %@",row);
            NSLog(@"right [row[kSubrowsLeftKey] integerValue] = %ld",(long)[row[kSubrowsLeftKey] integerValue]);

            totalExpandedSubrows += [row[kSubrowsRightKey]
                                     integerValue];
            
        }
        
    }
    
    NSLog(@"totalExpandedSubrows = %d",totalExpandedSubrows);
    
    return totalExpandedSubrows;
}

- (IBAction)expandableButtonTouched:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:currentTouchPosition];
    
    if (indexPath)
        [self tableView:self accessoryButtonTappedForRowWithIndexPath:indexPath];
}

//- (NSInteger)numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [_SKSTableViewDelegate tableView:self numberOfSubRowsAtIndexPath:indexPath];
//}

- (NSInteger)numberOfSubRowsAtObjectIndex:(NSInteger)objectIndex
{
    return [_SKSTableViewDelegate tableView:self numberOfSubRowsAtObjectIndex:objectIndex];
}

- (NSIndexPath *)correspondingIndexPathForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSIndexPath *correspondingIndexPath = nil;
    __block NSInteger expandedSubrows = 0;
    
    
    NSArray *rows = self.expandableCells[@(indexPath.section)];
    [rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        BOOL isExpandedLeft = [obj[kIsExpandedLeftKey] boolValue];
        BOOL isExpandedRight = [obj[kIsExpandedRightKey] boolValue];

        NSInteger numberOfSubrows = 0;
        if (isExpandedLeft)
        {
            numberOfSubrows = [obj[kSubrowsLeftKey] integerValue];
        }
        if (isExpandedRight)
        {
            numberOfSubrows = [obj[kSubrowsRightKey] integerValue];
        }
        
        NSInteger subrow = indexPath.row - expandedSubrows - idx;
        if (subrow > numberOfSubrows)
        {
            expandedSubrows += numberOfSubrows;
        }
        else
        {
             correspondingIndexPath = [NSIndexPath indexPathForSubRow:subrow
                                                                inRow:idx
                                                            inSection:indexPath.section];
            
            *stop = YES;
        }
    }];
    
    return correspondingIndexPath;
}

- (void)setExpandedLeft:(BOOL)isExpanded forCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *cellInfo = self.expandableCells[@(indexPath.section)][indexPath.row];
    [cellInfo setObject:@(isExpanded) forKey:kIsExpandedLeftKey];
}



- (void)setExpandedRight:(BOOL)isExpanded forCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *cellInfo = self.expandableCells[@(indexPath.section)][indexPath.row];
    [cellInfo setObject:@(isExpanded) forKey:kIsExpandedRightKey];
}

- (BOOL)isCellExpandedLeft:(NSIndexPath *)indexPath {
    NSMutableDictionary *cellInfo = self.expandableCells[@(indexPath.section)][indexPath.row];
    return [cellInfo[kIsExpandedLeftKey] boolValue];
}

- (BOOL)isCellExpandedRight:(NSIndexPath *)indexPath {
    NSMutableDictionary *cellInfo = self.expandableCells[@(indexPath.section)][indexPath.row];
    return [cellInfo[kIsExpandedRightKey] boolValue];
}


- (void)collapseCurrentlyExpandedIndexPathsLeft
{
    NSMutableArray *totalExpandedIndexPaths = [NSMutableArray array];
    NSMutableArray *totalExpandableIndexPaths = [NSMutableArray array];
    
    [self.expandableCells enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
       
        __block NSInteger totalExpandedSubrows = 0;
        
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           
            NSInteger currentRow = idx + totalExpandedSubrows;
            
            BOOL isExpandedLeft = [obj[kIsExpandedLeftKey] boolValue];
            if (isExpandedLeft)
            {
                NSInteger expandedSubrows = [obj[kSubrowsLeftKey] integerValue];
                for (NSInteger index = 1; index <= expandedSubrows; index++)
                {
                    NSIndexPath *expandedIndexPath = [NSIndexPath indexPathForRow:currentRow + index
                                                                        inSection:[key integerValue]];
                    [totalExpandedIndexPaths addObject:expandedIndexPath];
                }
                
                [obj setObject:@(NO) forKey:kIsExpandedLeftKey];
                totalExpandedSubrows += expandedSubrows;
                
                [totalExpandableIndexPaths addObject:[NSIndexPath indexPathForRow:currentRow inSection:[key integerValue]]];
            }
            
        }];
    }];
    
    for (NSIndexPath *indexPath in totalExpandableIndexPaths)
    {
        SKSTableViewCell *cell = (SKSTableViewCell *)[self cellForRowAtIndexPath:indexPath];
        cell.expandingLeft = NO;
        [cell accessoryViewAnimation];
    }
    
    
    [self deleteRowsAtIndexPaths:totalExpandedIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    
    
}

- (void)collapseCurrentlyExpandedIndexPathsRight
{
    NSMutableArray *totalExpandedIndexPaths = [NSMutableArray array];
    NSMutableArray *totalExpandableIndexPaths = [NSMutableArray array];
    
    [self.expandableCells enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        __block NSInteger totalExpandedSubrows = 0;
        
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSInteger currentRow = idx + totalExpandedSubrows;
            
            BOOL isExpandedRight = [obj[kIsExpandedRightKey] boolValue];
            if (isExpandedRight)
            {
                NSInteger expandedSubrows = [obj[kSubrowsRightKey] integerValue];
                for (NSInteger index = 1; index <= expandedSubrows; index++)
                {
                    NSIndexPath *expandedIndexPath = [NSIndexPath indexPathForRow:currentRow + index
                                                                        inSection:[key integerValue]];
                    [totalExpandedIndexPaths addObject:expandedIndexPath];
                }
                
                [obj setObject:@(NO) forKey:kIsExpandedRightKey];
                totalExpandedSubrows += expandedSubrows;
                
                [totalExpandableIndexPaths addObject:[NSIndexPath indexPathForRow:currentRow inSection:[key integerValue]]];
            }
        }];
    }];
    
    for (NSIndexPath *indexPath in totalExpandableIndexPaths)
    {
        SKSTableViewCell *cell = (SKSTableViewCell *)[self cellForRowAtIndexPath:indexPath];
        cell.expandingRight = NO;
        [cell accessoryViewAnimation];
    }
    
    
    [self deleteRowsAtIndexPaths:totalExpandedIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    
    
}

@end

#pragma mark - NSIndexPath (SKSTableView)

static void *SubRowObjectKey;

@implementation NSIndexPath (SKSTableView)

@dynamic subRow;

//- (NSInteger)subRow
//{
//    id subRowObj = objc_getAssociatedObject(self, SubRowObjectKey);
//    return [subRowObj integerValue];
//}
//
//- (void)setSubRow:(NSInteger)subRow
//{
//    id subRowObj = [NSNumber numberWithInteger:subRow];
//    objc_setAssociatedObject(self, SubRowObjectKey, subRowObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}


- (NSInteger)subRow
{
    id myclass = [SKSTableView class];
    id subRowObj = objc_getAssociatedObject(myclass, SubRowObjectKey);
    return [subRowObj integerValue];
}

- (void)setSubRow:(NSInteger)subRow
{
    id subRowObj = [NSNumber numberWithInteger:subRow];
    id myclass = [SKSTableView class];
    objc_setAssociatedObject(myclass, nil, subRowObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSIndexPath *)indexPathForSubRow:(NSInteger)subrow inRow:(NSInteger)row inSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    indexPath.subRow = subrow;
    
    return indexPath;
}

@end
