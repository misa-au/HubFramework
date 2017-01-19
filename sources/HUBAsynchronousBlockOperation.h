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

#import <Foundation/Foundation.h>

#import "HUBHeaderMacros.h"

NS_ASSUME_NONNULL_BEGIN

/// Block type for completion handlers used with Hub Framework operations
typedef void(^HUBOperationCompletionBlock)(void);

/// Block type for asynchronous Hub Framework operations
typedef void(^HUBOperationAsynchronousBlock)(HUBOperationCompletionBlock);

/**
 *  An asynchronous block based `NSOperation`
 *
 *  Provides an `NSOperation` that will call a block with a completion block. The provides block is responsible for
 *  calling the operations completion block once the task has finished.
 */
@interface HUBAsynchronousBlockOperation : NSOperation


/**
 *  Initializes the operation with an asynchronous block.
 *
 *  @param block The block that makes up the operation
 *
 *  The operation constructed this way will call its completion handler once its block's completion handler
 *  has been called.
 */
- (instancetype)initWithBlock:(HUBOperationAsynchronousBlock)block HUB_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
