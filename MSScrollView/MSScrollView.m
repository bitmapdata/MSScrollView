//
//  MSScrollView.m
//  MSScrollView
//
//  Created by Shim Minseok on 13. 5. 26..
//  Copyright (c) 2013 Shim Minseok All rights reserved.
//

#import "MSScrollView.h"

#define PAGE_CONTROL_WIDTH  38
#define PAGE_CONTROL_HEIGHT 36

@interface MSScrollView()<UIScrollViewDelegate>
{
    ScrollViewState _state;
    ScrollViewDirection _direction;
    ScrollViewAction _action;
    CGFloat _dragStartX;
    CGFloat _dragEndX;
    CGFloat _dragOutStartX;
    CGFloat _dragStartY;
    CGFloat _dragEndY;
    CGFloat _dragOutStartY;
}
@property (nonatomic, strong) UIPageControl *innerPageControl;
@end
@implementation MSScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (void)setPageControl:(CGPoint)centerPoint;
{
    if(!_innerPageControl)
    {
        self.innerPageControl = [[UIPageControl alloc] initWithFrame:(CGRect){0,0,PAGE_CONTROL_WIDTH,PAGE_CONTROL_HEIGHT}];
        _innerPageControl.numberOfPages = (_mode == HORIZONTAL_SCROLL_MODE)?self.contentSize.width / self.frame.size.width:
                                                                            self.contentSize.height / self.frame.size.height;
    }
    
    [self.superview addSubview:_innerPageControl];
    
    _innerPageControl.center = centerPoint;
}

- (void)didMoveToSuperview
{
    if(_innerPageControl)
        [self.superview addSubview:_innerPageControl];
    
    [super didMoveToSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_mode == HORIZONTAL_SCROLL_MODE)
    {
        if(_state & (BEGIN_DRAGGING + END_DRAGGING))
        {
            if(_dragStartX - scrollView.contentOffset.x < 0)
            {
                _direction = LEFT_SCROLLING;
            }
            else if(_dragStartX - scrollView.contentOffset.x > 0)
            {
                _direction = RIGHT_SCROLLING;
            }
            
            if(_didscroll)
                _didscroll(NO, _direction, _action);
        }
        else if(_state == BEGIN_DECELARTING)
        {
            if(_direction == LEFT_SCROLLING)
            {
                if(_dragOutStartX==0)
                    _dragOutStartX = scrollView.contentOffset.x;
                
                if(_dragOutStartX - _dragEndX >= 1)
                {
                    _action = GO_THROUGH;
                    if(_didscroll)
                        _didscroll(YES, _direction, _action);
                }
                else
                {
                    if(scrollView.contentOffset.x > (2*_dragStartX+self.frame.size.width)*0.5)
                    {
                        _action = GO_THROUGH;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                    else
                    {
                        _action = BOUNCE_BACK;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                }
            }
            else if(_direction == RIGHT_SCROLLING)
            {
                if(_dragOutStartX==0)
                    _dragOutStartX = scrollView.contentOffset.x;
                
                if(_dragOutStartX - _dragEndX <= 1)
                {
                    _action = GO_THROUGH;
                    if(_didscroll)
                        _didscroll(YES, _direction, _action);
                }
                else
                {
                    if(scrollView.contentOffset.x < (2*_dragStartX-self.frame.size.width)*0.5)
                    {
                        _action = GO_THROUGH;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                    else
                    {
                        _action = BOUNCE_BACK;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                }
            }
        }
        
        if(_innerPageControl)
        {
            CGFloat pageWidth = scrollView.frame.size.width;
            float fractionalPage = scrollView.contentOffset.x / pageWidth;
            _innerPageControl.currentPage = lround(fractionalPage);
        }
    }
    else if(_mode == VERTICAL_SCROLL_MODE)
    {
        if(_state & (BEGIN_DRAGGING + END_DRAGGING))
        {
            if(_dragStartY - scrollView.contentOffset.y < 0)
            {
                _direction = UP_SCROLLING;
            }
            else if(_dragStartY - scrollView.contentOffset.y > 0)
            {
                _direction = DOWN_SCROLLING;
            }
            
            if(_didscroll)
                _didscroll(NO, _direction, _action);
        }
        else if(_state == BEGIN_DECELARTING)
        {
            if(_direction == UP_SCROLLING)
            {
                if(_dragOutStartY==0)
                    _dragOutStartY = scrollView.contentOffset.y;
                
                if(_dragOutStartY - _dragEndY > 1)
                {
                    _action = GO_THROUGH;
                    if(_didscroll)
                        _didscroll(YES, _direction, _action);
                }
                else
                {
                    if(scrollView.contentOffset.y > (2*_dragStartY+self.frame.size.height)*0.5)
                    {
                        _action = GO_THROUGH;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                    else
                    {
                        _action = BOUNCE_BACK;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                }
            }
            else if(_direction == DOWN_SCROLLING)
            {
                if(_dragOutStartY==0)
                    _dragOutStartY = scrollView.contentOffset.y;
                
                if(_dragOutStartY - _dragEndY < 1)
                {
                    _action = GO_THROUGH;
                    if(_didscroll)
                        _didscroll(YES, _direction, _action);
                }
                else
                {
                    if(scrollView.contentOffset.y < (2*_dragStartY-self.frame.size.height)*0.5)
                    {
                        _action = GO_THROUGH;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                    else
                    {
                        _action = BOUNCE_BACK;
                        if(_didscroll)
                            _didscroll(YES, _direction, _action);
                    }
                }
            }
        }
        
        if(_innerPageControl)
        {
            CGFloat pageHeight = scrollView.frame.size.height;
            float fractionalPage = scrollView.contentOffset.y / pageHeight;
            _innerPageControl.currentPage = lround(fractionalPage);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _state = BEGIN_DRAGGING;

    if(_mode == HORIZONTAL_SCROLL_MODE)
    {
        _dragOutStartX = 0;
        
        _dragStartX = scrollView.contentOffset.x;
    }
    else if(_mode == VERTICAL_SCROLL_MODE)
    {
        _dragOutStartY = 0;
        
        _dragStartY = scrollView.contentOffset.y;
    }
    
    _action = UNKNOWN_ACTION;
    
    if(_beginDragging)
        _beginDragging();
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _state = END_DRAGGING;

    if(_mode == HORIZONTAL_SCROLL_MODE)
    {
        _dragEndX = scrollView.contentOffset.x;
        
        if(decelerate)
        {
            if (_dragStartX < scrollView.contentOffset.x)
            {
                _direction = LEFT_SCROLLING;
            }
            else if (_dragStartX > scrollView.contentOffset.x)
            {
                _direction = RIGHT_SCROLLING;
            }
        }
    }
    else if(_mode == VERTICAL_SCROLL_MODE)
    {
        _dragEndY = scrollView.contentOffset.y;
        
        if(decelerate)
        {
            if (_dragStartY < scrollView.contentOffset.y)
            {
                _direction = UP_SCROLLING;
            }
            else if (_dragStartY > scrollView.contentOffset.y)
            {
                _direction = DOWN_SCROLLING;
            }
        }
    }
        
    if(_endDragging)
        _endDragging();
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    _state = BEGIN_DECELARTING;
    
    if(_beginDecelerating)
        _beginDecelerating();
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _state = END_DECELARTING;
    
    if(_mode == HORIZONTAL_SCROLL_MODE)
    {
        if(_action == GO_THROUGH)
        {
            _action = GO_THROUGH_COMPLETE;
            if(_didscroll)
                _didscroll(YES, _direction, _action);
        }
        else if(_action == BOUNCE_BACK)
        {
            _action = BOUNCE_BACK_COMPLETE;
            if(_didscroll)
                _didscroll(YES, _direction, _action);
        }
        
        _dragStartX = 0;
        _dragEndX = 0;
    }
    else if(_mode == VERTICAL_SCROLL_MODE)
    {
        if(_action == GO_THROUGH)
        {
            _action = GO_THROUGH_COMPLETE;
            if(_didscroll)
                _didscroll(YES, _direction, _action);
        }
        else if(_action == BOUNCE_BACK)
        {
            _action = BOUNCE_BACK_COMPLETE;
            if(_didscroll)
                _didscroll(YES, _direction, _action);
        }
        
        _dragStartY = 0;
        _dragEndY = 0;
    }
    
    if(_endDecelerating)
        _endDecelerating();
}

@end
