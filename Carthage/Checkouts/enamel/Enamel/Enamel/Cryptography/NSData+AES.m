//
//  NSData+AES.m
//  Enamel
//
//  Created by Wroblewski, Dominic (Developer) on 05/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData(AES)

- (NSData *)AES128EncryptedWithKey:(NSString *)key {
    return [self AES128Operation:kCCEncrypt key:key];
}

- (NSData *)AES128DecryptedWithKey:(NSString *)key {
    return [self AES128Operation:kCCDecrypt key:key];
}

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));

    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end
