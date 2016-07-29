// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ReportsSearchCellObjectsBuilderImplementation.h"

#import "LecturePlainObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"

#import "ReportEventTableViewCellObject.h"
#import "ReportSpeakerTableViewCellObject.h"
#import "ReportLectureTableViewCellObject.h"
#import "UIColor+ConferencesPallete.h"
#import "DateFormatter.h"

@implementation ReportsSearchCellObjectsBuilderImplementation

- (instancetype)initWithDateFormatter:(DateFormatter *)dateFormatter {
    self = [super init];
    if (self) {
        _dateFormatter = dateFormatter;
    }
    return self;
}

- (ReportEventTableViewCellObject *)eventCellObjectFromPlainObject:(EventPlainObject *)event selectedText:(NSString *)selectedText {

    NSString *eventDate = [self.dateFormatter obtainDateWithDayMonthYearFormat:event.startDate];
    
    NSAttributedString *highlightedString = [self highlightInString:event.name
                                                       selectedText:selectedText
                                                              color:[UIColor colorForSelectedTextEventCellObject]];
    ReportEventTableViewCellObject *cellObject = [ReportEventTableViewCellObject objectWithEvent:event
                                                                                         andDate:eventDate
                                                                                 highlightedText:highlightedString];
    return cellObject;
}

- (ReportLectureTableViewCellObject *)lectureCellObjectFromPlainObject:(LecturePlainObject *)lecture selectedText:(NSString *)selectedText {
    NSAttributedString *highlightedString = [self highlightInString:lecture.name
                                                       selectedText:selectedText
                                                              color:[UIColor colorForSelectedTextLectureCellObject]];
    ReportLectureTableViewCellObject *cellObject = [ReportLectureTableViewCellObject objectWithLecture:lecture
                                                                                       highlightedText:highlightedString];
    return cellObject;
}

- (ReportSpeakerTableViewCellObject *)speakerCellObjectFromPlainObject:(SpeakerPlainObject *)speaker selectedText:(NSString *)selectedText {
    NSAttributedString *highlightedString = [self highlightInString:speaker.name
                                                       selectedText:selectedText
                                                              color:[UIColor colorForSelectedTextSpeakerCellObject]];
    ReportSpeakerTableViewCellObject *cellObject = [ReportSpeakerTableViewCellObject objectWithSpeaker:speaker
                                                                                       highlightedText:highlightedString];
    return cellObject;
}

#pragma mark - private methods

- (NSAttributedString *)highlightInString:(NSString *)string selectedText:(NSString *)selectedText color:(UIColor *)color {
    if (!string) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *highlightedString = [[NSMutableAttributedString alloc] initWithString:string];
    if ([selectedText length] != 0) {
        NSRange range = [[string lowercaseString] rangeOfString:selectedText];
        [highlightedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return [highlightedString copy];
}

@end
