//
//  Client.h
//  Client
//
//  Created by Takayuki Sei on 2021/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Client : NSObject
- (void)sendMessage:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
