//
//  NSArray+Functional.m
//  FunctionalArray
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

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

-(NSArray*)map:(MapBlock)f {
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:self.count];
    if (f) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id newobj = f(obj);
            [results addObject:newobj];
        }];
    } else {
        [results addObjectsFromArray:self];
    }
    return results;
}

-(NSArray*)filter:(TestBlock)f {
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:self.count];
    if (f) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(f(obj)) {
                [results addObject:obj];
            }
        }];
    } else {
        [results addObjectsFromArray:self];
    }
    return results;
}

-(NSArray*)reject:(TestBlock)f {
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:self.count];
    if (f) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(!f(obj)) {
                [results addObject:obj];
            }
        }];
    } else {
        [results addObjectsFromArray:self];
    }
    return results;
}

-(BOOL)any:(TestBlock)f {
    __block BOOL match = NO;
    if (f) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            match = f(obj);
            if(match) {
                *stop = YES;
            }
        }];
    }
    return match;
}

-(BOOL)all:(TestBlock)f {
    __block BOOL match = NO;
    if (f) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            match = f(obj);
            if(!match) {
                *stop = YES;
            }
        }];
    }
    return match;
}

@end
