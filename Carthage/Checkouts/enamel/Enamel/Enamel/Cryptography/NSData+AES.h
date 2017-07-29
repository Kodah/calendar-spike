//
//  NSData+AES.h
//  Enamel
//
//  Created by Wroblewski, Dominic (Developer) on 05/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(AES)

- (NSData *)AES128EncryptedWithKey:(NSString *)key;
- (NSData *)AES128DecryptedWithKey:(NSString *)key;

@end
