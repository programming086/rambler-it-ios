//
//  ReportListInteractorTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ReportListInteractor.h"
#import "ReportListInteractorOutput.h"

#import "EventService.h"
#import "EventTypeDeterminator.h"
#import "EventPlainObject.h"
#import "EventModelObject.h"
#import "ROSPonsomizer.h"

#import "XCTestCase+RCFHelpers.h"
#import "TestConstants.h"
typedef void (^ProxyBlock)(NSInvocation *);

@interface ReportListInteractorTests : XCTestCase

@property (strong, nonatomic) ReportListInteractor *interactor;
@property (strong, nonatomic) EventTypeDeterminator *mockEventTypeDeterminator;
@property (strong, nonatomic) id <ReportListInteractorOutput> mockOutput;
@property (strong, nonatomic) id <EventService> mockEventService;
@property (strong, nonatomic) id <ROSPonsomizer> mockPonsomizer;

@end

@implementation ReportListInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [ReportListInteractor new];
    self.mockOutput = OCMProtocolMock(@protocol(ReportListInteractorOutput));
    self.mockEventService = OCMProtocolMock(@protocol(EventService));
    self.mockEventTypeDeterminator = OCMClassMock([EventTypeDeterminator class]);
    self.mockPonsomizer = OCMProtocolMock(@protocol(ROSPonsomizer));
    
    self.interactor.output = self.mockOutput;
    self.interactor.eventService = self.mockEventService;
    self.interactor.eventTypeDeterminator = self.mockEventTypeDeterminator;
    self.interactor.ponsomizer = self.mockPonsomizer;
}

- (void)tearDown {
    self.interactor = nil;
    self.mockOutput = nil;
    self.mockEventService = nil;
    self.mockEventTypeDeterminator = nil;
    self.mockPonsomizer = nil;

    [super tearDown];
}

- (void)testSuccessUpdateEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *data = @[event];
    NSArray *eventsPonso = @[@1];
    XCTestExpectation *expectation = [self expectationForCurrentTest];
    
    ProxyBlock proxyBlock = ^(NSInvocation *invocation){
        void(^completionBlock)(id data, NSError *error);
        
        [invocation getArgument:&completionBlock atIndex:3];
        [expectation fulfill];
        completionBlock(data, nil);
    };
    
    OCMStub([self.mockEventService updateEventWithPredicate:OCMOCK_ANY completionBlock:OCMOCK_ANY]).andDo(proxyBlock);
    OCMStub([self.mockPonsomizer convertObject:data]).andReturn(eventsPonso);
    // when
    [self.interactor updateEventList];
    
    // then
    [self waitForExpectationsWithTimeout:kTestExpectationTimeout
                                 handler:^(NSError * _Nullable error) {
                                     OCMVerify([self.mockOutput didUpdateEventList:OCMOCK_ANY]);
                                     OCMVerify([self.mockPonsomizer convertObject:data]);
                                     OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
                                 }];
}

- (void)testSuccessObtainEventList {
    // given
    NSObject *event = [NSObject new];
    NSArray *events = @[event];
    
    OCMStub([self.mockEventService obtainEventWithPredicate:nil]).andReturn(events);
    OCMStub([self.mockPonsomizer convertObject:OCMOCK_ANY]).andReturn(events);
    // when
    id result = [self.interactor obtainEventList];
    
    // then
    XCTAssertNotNil(result);
    OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:events]);
    OCMVerify([self.mockEventService obtainEventWithPredicate:OCMOCK_ANY]);
}

- (void)testSuccessObtainEventListWithPredicate {
    // given
    EventPlainObject *event = [EventPlainObject new];
    event.name = @"Test PrediCate";
    
    NSArray *events = @[event];
    NSArray *eventsPonso = @[@1];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", @"Test"];
    OCMStub([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]).andReturn(PastEvent);
    OCMStub([self.mockEventService obtainEventWithPredicate:predicate]).andReturn(events);
    OCMStub([self.mockPonsomizer convertObject:events]).andReturn(eventsPonso);
    
    // when
    id result = [self.interactor obtainEventListWithPredicate:predicate];
    
    // then
    XCTAssertNotNil(result);
    OCMVerify([self.mockEventTypeDeterminator determinateTypeForEvent:OCMOCK_ANY]);
    OCMVerify([self.mockPonsomizer convertObject:events]);
    OCMVerify([self.mockEventService obtainEventWithPredicate:OCMOCK_ANY]);
}
@end
