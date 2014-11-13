//
//  VRGViewController.m
//  Vurig Calendar
//
//  Created by in 't Veen Tjeerd on 5/29/12.
//  Copyright (c) 2012 Vurig. All rights reserved.
//

#import "VRGViewController.h"
#import "NSDate+convenience.h"

@interface VRGViewController ()
{
    VRGCalendarView *calendar;
    UILabel *monthLabel;
}
@end

@implementation VRGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
//    monthLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 44)];
//    monthLabel.text=@"2014年4月";
//    [self.view addSubview:monthLabel];
//    [monthLabel release];
    
    calendar = [[VRGCalendarView alloc] init];
    //[calendar setFrame:CGRectMake(0, 108, 320, 400)];不要在外部设置frame
    UISwipeGestureRecognizer *left=[[UISwipeGestureRecognizer alloc] init];
    [left setDirection:UISwipeGestureRecognizerDirectionLeft];
    [left addTarget:self action:@selector(test:)];

    [calendar addGestureRecognizer:left];
    UISwipeGestureRecognizer *right=[[UISwipeGestureRecognizer alloc] init];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [right addTarget:self action:@selector(test:)];
    
    [calendar addGestureRecognizer:right];

    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    
    
}
-(void)test:(UISwipeGestureRecognizer *)aRecognizer
{
    if (aRecognizer.direction==UISwipeGestureRecognizerDirectionRight) {
         NSLog(@"滑动右");
        [calendar showPreviousMonth];

    }else
    {
         [calendar showNextMonth];
         NSLog(@"滑动左");
    }
    

}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM yyyy"];
    monthLabel.text = [formatter stringFromDate:calendar.currentMonth];
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5],[NSNumber numberWithInt:8], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    //NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSLog(@"Selected date = %@",[df stringFromDate:date]);
}
-(void)currentMonth:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MMMM "];
    NSLog(@"-----%@",[formatter stringFromDate:date]);
    monthLabel.text=[formatter stringFromDate:date];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
