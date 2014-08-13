//
//  FunctionalArrayTests.m
//  FunctionalArrayTests
//
//  Created by Alex Robinson on 8/6/14.
//  Copyright (c) 2014 Alex Robinson. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import <XCTest/XCTest.h>
#import "NSArray+Functional.h"

// Create NSObject subclass to use in tests
@interface City : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic) NSInteger population;

-(instancetype)initWithName:(NSString*)name population:(NSInteger)population;

@end

@implementation City

-(instancetype)initWithName:(NSString*)name population:(NSInteger)population {
    self = [super init];
    if (self) {
        self.name = name;
        self.population = population;
    }
    return self;
}

@end

@interface ARFunctionalTests : XCTestCase

@end

@implementation ARFunctionalTests

-(void)setUp {
    [super setUp];
}

-(void)tearDown {
    [super tearDown];
}

-(void)testMapWithNilBlock {
    NSArray *testArray = @[@"one",@"two",@"three"];
    NSArray *newArray = [testArray map:nil];
    NSArray *exptectedArray = @[@"one",@"two",@"three"];
    XCTAssert([newArray isEqualToArray:exptectedArray], @"Expected array %@", exptectedArray);
}

- (void)testMap {
    NSArray *testArray = @[@"one",@"two",@"three"];
    NSArray *newArray = [testArray map:^NSString*(NSString* string) {
        return [string stringByAppendingString:@"test"];
    }];
    NSArray *exptectedArray = @[@"onetest",@"twotest",@"threetest"];
    XCTAssert([newArray isEqualToArray:exptectedArray], @"Expected array %@", exptectedArray);
}

-(void)testFilterWithNilBlock {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    NSArray *newArray = [testArray filter:nil];
    NSArray *exptectedArray = @[@1,@2,@3,@4,@5,@6,@7];
    XCTAssert([newArray isEqualToArray:exptectedArray], @"Expected array %@", exptectedArray);
}

-(void)testFilter {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    NSArray *newArray = [testArray filter:^BOOL(NSNumber *obj) {
        return [obj integerValue] % 2 == 0;
    }];
    NSArray *exptectedArray = @[@2,@4,@6];
    XCTAssert([newArray isEqualToArray:exptectedArray], @"Expected array %@", exptectedArray);
}

-(void)testRejectWithNilBlock {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    NSArray *newArray = [testArray reject:nil];
    NSArray *exptectedArray = @[@1,@2,@3,@4,@5,@6,@7];
    XCTAssert([newArray isEqualToArray:exptectedArray], @"Expected array %@", exptectedArray);
}

-(void)testReject {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    NSArray *newArray = [testArray reject:^BOOL(NSNumber *obj) {
        return [obj integerValue] % 2 == 0;
    }];
    NSArray *exptectedArray = @[@1,@3,@5,@7];
    XCTAssert([newArray isEqualToArray:exptectedArray], @"Expected array %@", exptectedArray);
}

-(void)testAnyWithNilBlock {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    
    BOOL match = [testArray any:nil];
    
    XCTAssertFalse(match, @"Expected no negative numbers");
}

-(void)testAny {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    
    BOOL negativeNumbers = [testArray any:^BOOL(NSNumber *obj) {
        return [obj integerValue] < 0;
    }];
    
    XCTAssertFalse(negativeNumbers, @"Expected no negative numbers");
    
    
    BOOL evenNumbers = [testArray any:^BOOL(NSNumber *obj) {
        return [obj integerValue] % 2 == 0;
    }];
    
    XCTAssertTrue(evenNumbers, @"Expected at least one even numbers");
}

-(void)testAllWithNilBlock {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    
    BOOL match = [testArray all:nil];
    
    XCTAssertFalse(match, @"Expected no match");
}

-(void)testAll {
    NSArray *testArray = @[@1,@2,@3,@4,@5,@6,@7];
    
    BOOL positiveNumbers = [testArray all:^BOOL(NSNumber *obj) {
        return [obj integerValue] > 0;
    }];
    
    XCTAssertTrue(positiveNumbers, @"Expected positive numbers");
    
    
    BOOL evenNumbers = [testArray all:^BOOL(NSNumber *obj) {
        return [obj integerValue] % 2 == 0;
    }];
    
    XCTAssertFalse(evenNumbers, @"Expected not all even numbers");
}

-(void)testMapAndFilter {
    NSArray *cities = @[[[City alloc] initWithName:@"Cincinnati" population:296],
        [[City alloc] initWithName:@"Dayton" population:141],
        [[City alloc] initWithName:@"Columbus" population:787],
        [[City alloc] initWithName:@"Cleveland" population:396]];
    
   NSArray *results = [[[cities map:^City*(City *city) {
       // Cities populations listed in 1,000s
       city.population = city.population * 1000;
       return city;
   }] filter:^BOOL(City *city) {
       // Filter cities to only cities with population more than 200,000
       return city.population > 200000;
   }] map:^NSString*(City *city) {
       // Map city name to new array of strings
       return city.name;
   }];
    
    
    NSArray *exptectedArray = @[@"Cincinnati",@"Columbus",@"Cleveland"];
    
    // sort arrays for easy comparison
    results = [results sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    exptectedArray = [exptectedArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    XCTAssert([results isEqualToArray:exptectedArray], @"Expected array %@", exptectedArray);
}


@end



