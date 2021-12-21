//
//  Server.h
//  Server
//
//  Created by Takayuki Sei on 2021/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Server;

@protocol ServerDelegate <NSObject>
@optional
- (void)server:(nonnull Server *)server receiveMessage:(nonnull NSPortMessage *)message;

@end

@interface Server : NSObject
@property (nullable, weak) id <ServerDelegate> delegate;

- (void)run;

@end

NS_ASSUME_NONNULL_END
