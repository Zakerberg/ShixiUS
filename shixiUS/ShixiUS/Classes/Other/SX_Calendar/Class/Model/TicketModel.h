#import <Foundation/Foundation.h>

@interface TicketModel : NSObject
/**
 *  年
 */
@property (nonatomic, assign) NSInteger year;
/**
 *  月
 */
@property (nonatomic, assign) NSInteger month;
/**
 *  日
 */
@property (nonatomic, assign) NSInteger day;
/**
 *  剩余数量
 */
@property (nonatomic, assign) NSInteger ticketCount;
/**
 *  单价
 */
@property (nonatomic, assign) float ticketPrice;

@end
