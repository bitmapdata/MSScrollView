MSScrollView
============

A block-based UIScrollView alternative which runs a handler block when scrolling, instead of using delegation. also notify the below information. 
know when using a didScroll block.

<p align="center" >
<img src="https://raw.github.com/bitmapdata/MSScrollView/master/Resources/ScreenShot1.png">
</p>

* **ScrollView Direction**  

 **`HORIZONTAL_SCROLL_MODE`**  
     - LEFT_SCROLLING  
     - RIGHT_SCROLLING  

 **`VERTICAL_SCROLL_MODE`**
     - UP_SCROLLING  
     - DOWN_SCROLLING  

* **ScrollView Action**  

 **`Dragging`**  
     - UNKNOWN_ACTION
     
 **`After Drag`**    
     - GO_THROUGH
     - GO_THROUGH_COMPLETE
     - BOUNCES_BACK
     - BOUNCES_BACK_COMPLETE
     
* **Options**  

  \- Embedded PageControl (currentPage, numberOfPages automatically update.)

More Information on MSScrollView refer to the header file.

## Installation ##

Drag the included MSScrollView folder into your project.

## Usage ##

These classes was written under the ARC. Be sure to specify `-fobjc-arc` the 'Compile Sources' Build Phase for each file if you aren't using ARC project-wide

## Sample Code ##

    #import "MSScrollView.h"

	- (void)viewDidLoad
	{
		self.myScrollView = [[MSScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		_myScrollView.contentSize = CGSizeMake(320*10, IS_IPHONE_5?568:480);
		_myScrollView.pagingEnabled = YES;
		_myScrollView.backgroundColor = [UIColor whiteColor];
		_myScrollView.mode = HORIZONTAL_SCROLL_MODE;
		for(int i = 0; i<10; i++)
		{
			UIView *view = [[UIView alloc] initWithFrame:(CGRect){320*i,0,320,IS_IPHONE_5?568:480}];
			view.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/100.0f green:(arc4random()%100)/100.0f blue:(arc4random()%100)/100.0f alpha:1.0f];
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
			CGRect rect = label.frame;
			rect.origin.y = (view.frame.size.height - label.frame.size.height*2)/2;
			label.frame = rect;
			label.backgroundColor = [UIColor clearColor];
			label.text = [NSString stringWithFormat:@"Page %d", i+1];
			label.font = [UIFont systemFontOfSize:22.0f];
			label.textAlignment =NSTextAlignmentCenter;
			label.textColor = [UIColor whiteColor];
			[view addSubview:label];
			[_myScrollView addSubview:view];
		}
		
		[self.view addSubview:_myScrollView];
		[_myScrollView setPageControl:CGPointMake(160,IS_IPHONE_5?520:430)];
		
		_myScrollView.didscroll = ^(BOOL isDecelerating, ScrollViewDirection direction, ScrollViewAction action)
		{
			NSLog(@"didScroll | isDecelerating:%d, direction:%d, action:%d", isDecelerating, direction, action);
		};
		
		_myScrollView.beginDragging = ^{
			
			NSLog(@"beginDragging");
		};
		_myScrollView.endDragging = ^{
			
			NSLog(@"endDragging");
		};
		_myScrollView.beginDecelerating = ^{
			
			NSLog(@"beginDecelerating");
		};
		_myScrollView.endDecelerating = ^{
			
			NSLog(@"endDecelerating");
		};
		
		[super viewDidLoad];
	}


## License ##

Software License Agreement (BSD License)

Copyright (c) 2013 Shim Minseok. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   
  2. Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.

  3. Neither the name of Infrae nor the names of its contributors may
     be used to endorse or promote products derived from this software
     without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INFRAE OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Contact ##

bitmapdata.com@gmail.com
