//
//  Server.m
//  Server
//
//  Created by Takayuki Sei on 2021/12/21.
//

#import "Server.h"
#import "Protocol.h"

@interface Server() <NSPortDelegate>
@property(nonatomic, strong) NSPort *port;
@end

@implementation Server

- (instancetype)init
{
    self = [super init];
    if (self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    self.port = [[NSMachBootstrapServer sharedInstance] servicePortWithName:SERVERNAME];
#pragma clang diagnostic pop
        if (self.port == nil) {
            NSLog(@"ポートが開けませんでした");
        }
        self.port.delegate = self;
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:self.port forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)run {
    NSLog(@"サーバー起動");
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop run];
}

#pragma mark - NSPortDelegate
- (void)handlePortMessage:(NSPortMessage *)message {
    if ([_delegate respondsToSelector:@selector(server:receiveMessage:)]) {
        [_delegate server:self receiveMessage:message];
        return;
    }
    
    switch (message.msgid) {
        case MessageIDString: {
            NSString *string = [[NSString alloc] initWithData:message.components[0] encoding:NSUTF8StringEncoding];
            NSLog(@"received: %@", string);
            NSPortMessage *response = [[NSPortMessage alloc] initWithSendPort:message.sendPort
                                                                  receivePort:nil
                                                                   components:@[[[NSString stringWithFormat:@"%@ というメッセージ受信したよ", string] dataUsingEncoding:NSUTF8StringEncoding]]];
            response.msgid = message.msgid;
            NSDate *timeout = [NSDate dateWithTimeIntervalSinceNow:1.0];
            [response sendBeforeDate:timeout];
        }
            break;
    }
}

@end
