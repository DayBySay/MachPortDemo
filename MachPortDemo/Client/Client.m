//
//  Client.m
//  Client
//
//  Created by Takayuki Sei on 2021/12/21.
//

#import "Client.h"
#import "Protocol.h"

@interface Client() <NSPortDelegate>
@property (nonatomic) BOOL received;
@end

@implementation Client

- (void)sendMessage:(NSString *)string {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSPort *sendPort = [[NSMachBootstrapServer sharedInstance] portForName:SERVERNAME];
#pragma clang diagnostic pop
    if (sendPort == nil) {
        NSLog(@"サーバに接続できませんでした");
        return;
    }
    
    NSPort *receivePort = [NSMachPort port];
    receivePort.delegate = self;
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:receivePort forMode:NSDefaultRunLoopMode];
    
    NSPortMessage *message = [[NSPortMessage alloc] initWithSendPort:sendPort
                                                         receivePort:receivePort
                                                          components:@[[string dataUsingEncoding:NSUTF8StringEncoding]]];
    message.msgid = MessageIDString;
    self.received = NO;
    
    NSDate *timeout = [NSDate dateWithTimeIntervalSinceNow:1.0];
    if (![message sendBeforeDate:timeout]) {
        NSLog(@"メッセージ送信失敗");
    }
    
    while (!self.received) {
        [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

#pragma mark - NSPortDelegate
- (void)handlePortMessage:(NSPortMessage *)message {
    switch (message.msgid) {
        case MessageIDString: {
            NSString *response = [[NSString alloc] initWithData:message.components[0] encoding:NSUTF8StringEncoding];
            NSLog(@"response: %@", response);
        }
            break;
    }
    
    self.received = YES;
}

@end
