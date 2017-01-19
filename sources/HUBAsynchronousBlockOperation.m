/*
 *  Copyright (c) 2016 Spotify AB.
 *
 *  Licensed to the Apache Software Foundation (ASF) under one
 *  or more contributor license agreements.  See the NOTICE file
 *  distributed with this work for additional information
 *  regarding copyright ownership.  The ASF licenses this file
 *  to you under the Apache License, Version 2.0 (the
 *  "License"); you may not use this file except in compliance
 *  with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */

#import "HUBAsynchronousBlockOperation.h"

@interface HUBAsynchronousBlockOperation ()

@property (nonatomic, copy, readonly) HUBOperationAsynchronousBlock block;

@end

@implementation HUBAsynchronousBlockOperation {
    BOOL _isExecuting;
    BOOL _isFinished;
}

#pragma mark - Initializer

- (instancetype)initWithBlock:(HUBOperationAsynchronousBlock)block
{
    NSParameterAssert(block != nil);
    
    self = [super init];
    
    if (self) {
        _block = [block copy];
    }
    
    return self;
}


#pragma mark - NSOperation overrides

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
- (BOOL)isFinished
{
    return _isFinished;
}

- (void)setFinished:(BOOL)isFinished
{
    [self willChangeValueForKey:@"isFinished"];

    _isFinished = isFinished;

    [self didChangeValueForKey:@"isFinished"];
}


- (BOOL)isExecuting
{
    return _isExecuting;
}


- (void)setExecuting:(BOOL)isExecuting
{
    [self willChangeValueForKey:@"isExecuting"];

    _isExecuting = isExecuting;

    [self didChangeValueForKey:@"isExecuting"];
}
#pragma clang diagnostic pop

- (void)start
{
    [self setExecuting:YES];

    self.block(^{
        [self setExecuting:NO];
        [self setFinished:YES];
    });
}

@end
