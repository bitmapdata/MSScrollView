//
//  MSScrollView.h
//  MSScrollView
//
//  Software License Agreement (BSD License)
//
//  Copyright (c) 2013 Shim Minseok. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in
//  the documentation and/or other materials provided with the
//  distribution.
//
//  3. Neither the name of Infrae nor the names of its contributors may
//  be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INFRAE OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BEGIN_DRAGGING      = 1<<1,
    END_DRAGGING        = 1<<2,
    BEGIN_DECELARTING   = 1<<3,
    END_DECELARTING     = 1<<4
}ScrollViewState;

typedef enum
{
    LEFT_SCROLLING,
    RIGHT_SCROLLING,
}ScrollViewDirection;

typedef enum
{
    GO_THROUGH,
    GO_THROUGH_COMPLETE,
    BOUNCE_BACK,
    BOUNCE_BACK_COMPLETE,
    UNKNOWN_ACTION
}ScrollViewAction;

/**
 *  @block-function  ScrollViewDidScroll
 *
 *  @abstract        This method notify when scroll view didScrolling. a little different UIScrollView delegate didscroll.
 *
 *  @note            Only the implementation of the horizontal direction.
 *                   in the vertical direction for the next version will include direction.
 *
 *  @return          isDecelerating
 *                     - Tells you whether or not decelerating.
 *
 *                   direction
 *                     - a ScrollViewDirection show a below image
 *
 *                                 LEFT_SCROLLING
 *                                |             |
 *                                |             |
 *                                |   <=======  |
 *                                |             |
 *                                |             |
 *
 *                                RIGHT_SCROLLING
 *                                |             |
 *                                |             |
 *                                |  =======>   |
 *                                |             |
 *                                |             |
 *
 *                   action
 *                     - During dragging the scroll view always return UNKNOWN_ACTION. 
 *                       After dragging(begin decelerating) there are two kinds of behavior are expected. Just moving go through direction,
 *                       or bounce back to the original position.
 *                      
 *
*/
typedef void (^ScrollViewDidScroll) (BOOL isDecelerating, ScrollViewDirection direction, ScrollViewAction action);

/**
 *  @block-function  ScrollViewWillBeginDragging
 *
 *  @abstract        This method notify when scroll view didScrolling. same as UIScrollView delegate scrollViewBeginDragging.
 *
 */
typedef void (^ScrollViewWillBeginDragging) ();

/**
 *  @block-function  ScrollViewDidEndDragging
 *
 *  @abstract        This method notify when scroll view beginDragging. same as UIScrollView delegate scrollViewDidEndDragging.
 *
 */
typedef void (^ScrollViewDidEndDragging) ();

/**
 *  @block-function  ScrollViewWillBeginDecelerating
 *
 *  @abstract        This method notify when scroll view didEndDragging. same as UIScrollView delegate scrollViewWillBeginDecelerating.
 *
 */
typedef void (^ScrollViewWillBeginDecelerating) ();

/**
 *  @block-function  ScrollViewDidEndDecelerating
 *
 *  @abstract        This method notify when scroll view beginDecelerating. same as UIScrollView delegate scrollViewDidEndDecelerating.
 *
 */
typedef void (^ScrollViewDidEndDecelerating) ();
@interface MSScrollView : UIScrollView
@property (nonatomic, copy) ScrollViewDidScroll didscroll;
@property (nonatomic, copy) ScrollViewWillBeginDragging beginDragging;
@property (nonatomic, copy) ScrollViewDidEndDragging endDragging;
@property (nonatomic, copy) ScrollViewWillBeginDecelerating beginDecelerating;
@property (nonatomic, copy) ScrollViewDidEndDecelerating endDecelerating;
- (void)setPageControl:(CGPoint)centerPoint;
@end

