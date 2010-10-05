#import <Foundation/Foundation.h>

typedef enum {
  RequestMethodGet,
  RequestMethodPost
} RequestMethodType;


@interface URLRequestBuilder : NSObject 
{
  RequestMethodType   method;
  NSString            *url;
  NSDictionary        *params;
  
  // file's data
  NSMutableArray      *fileParams;
  NSMutableArray      *fileNames;
  NSMutableArray      *fileMimeTypes;
  NSMutableArray      *fileContents;
  
  NSURLRequest        *_request;
}

- (id)initWithMethod:(RequestMethodType)method url:(NSString *)url parameters:(NSDictionary *)parameters;
- (void)addFile:(NSData *)data paramName:(NSString *)paramName contentType:(NSString *)contentType fileName:(NSString *)fileName;
- (NSURLRequest *)request;
@end
