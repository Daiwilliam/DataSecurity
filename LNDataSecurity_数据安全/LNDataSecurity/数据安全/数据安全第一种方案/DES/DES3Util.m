//
//  DES3Util.m
//  Public_不知名开发者 | https://github.com/CoderLN 
//  各位厂友, 由于「时间 & 知识」有限, 总结的文章难免有「未全、不足」, 该模块将系统化学习, 后续「坚持新增文章, 替换、补充文章内容」
//  

#import "DES3Util.h"
#define gkey            @"app_key_ioved1cm!@#$5678"
//#define gkey            @"liuyunqiang@lx100$#365#$"
#define gIv             @"01234567"


@implementation DES3Util


 const Byte iv[] = {1,2,3,4,5,6,7,8};

// Des加密
+(NSString *) encryptUseDES:(NSString *)string keyString:(NSString *)keyString
{
    
    NSString *ciphertext = nil;
    NSData *textData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [keyString UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }
    return ciphertext;
}



// Des解密
+(NSString *)decryptUseDES:(NSString *)base64EncodedString keyString:(NSString *)keyString
{
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeString:base64EncodedString];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [keyString UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess)
    {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}


@end
