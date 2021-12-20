//
//  main.m
//  Client
//
//  Created by Takayuki Sei on 2021/12/21.
//

#import <Foundation/Foundation.h>
#import "Client.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Client *client = [[Client alloc] init];
        
        if (argc > 1) {
            NSString *string = [[NSString alloc] initWithUTF8String:argv[1]];
            [client sendMessage: string];
        } else {
            [client sendMessage:@"hoge"];
        }
    }
    return 0;
}
