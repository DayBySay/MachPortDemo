//
//  main.m
//  Server
//
//  Created by Takayuki Sei on 2021/12/21.
//

#import <Foundation/Foundation.h>
#import "Server.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Server *server = [[Server alloc] init];
        [server run];
    }
    return 0;
}
