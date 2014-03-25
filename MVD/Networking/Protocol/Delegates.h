//
//  MCProtocol.h
//  MobileBanking
//
//  Created by Sergey Sasin on 15.04.13.
//  Copyright (c) 2013 BPC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountInformation.h"
#import "CardInformation.h"
#import "OperationInformation.h"
#import "PointInformation.h"
#import "CurrencyInformation.h"
#import "TransferTemplateInformation.h"
#import "PaymentTemplateInformation.h"
#import "NewsInformation.h"
#import "LimitInformation.h"

#import "TransferParams.h"
#import "PaymentParams.h"
#import "ResourceRec.h"

@protocol HelloDelegate <NSObject>
- (void) helloComplete:(NSString*)text;
@end
@protocol LoginDelegate <NSObject>
- (void) loginComplete:(int)result accessToken:(NSString*)accessToken;
- (void) loginCancelled:(int)result;
@end
@protocol LogoutDelegate <NSObject>
- (void) logoutComplete:(int)result;
@end
@protocol PasswordDelegate <NSObject>
- (void) passwordChangeComplete:(int)result;
@end
@protocol ServerCapabilitiesDelegate <NSObject>
- (void) supportedCurrencies:(NSArray*)currenciesList;
- (void) serverCapabilitiesComplete:(int)result;
@end
@protocol ResourcesExchangeDelegate <NSObject>
- (void) getImageComplete:(int)result image:(UIImage*)image imgId:(NSString*)imageId reqId:(id)requestId;
@end
@protocol AccountsDelegate <NSObject>
- (void) accountsComplete:(int)result accounts:(NSArray*)accountsList;
@end
@protocol AccountDetailsDelegate <NSObject>
- (void) accountDetailsComplete:(int)result details:(AccountInformation*)accountDetails;
@end
@protocol CardsDelegate <NSObject>
- (void) cardsComplete:(int)result cards:(NSArray*)cardsList;
@end
@protocol CardDetailsDelegate <NSObject>
- (void) cardDetailsComplete:(int)result details:(CardInformation*)cardDetails;
@end
@protocol CardHistoryDelegate <NSObject>
- (void) cardHistoryComplete:(int)result history:(NSArray*)cardHistory;
@end
@protocol CardChangeDelegate <NSObject>
- (void) cardChangeComplete:(int)result;
@end
@protocol AccountHistoryDelegate <NSObject>
- (void) accountHistoryComplete:(int)result history:(NSArray*)accountHistory;
@end
@protocol AccountChangeDelegate <NSObject>
- (void) accountChangeComplete:(int)result;
@end
@protocol PointsDelegate <NSObject>
- (void) pointsComplete:(int)result points:(NSArray*)pointsList;
@end
@protocol ExchangeDelegate <NSObject>
- (void) exchangeRatesComplete: (int) result rates:(NSMutableArray*) rates;
@end
@protocol PaymentsDescriptionDelegate <NSObject>
- (void) paymentsDescriptionComplete: (int) result providers: (NSArray*)providers;
@end
@protocol PaymentCategoriesDelegate <NSObject>
- (void) paymentCategoriesComplete: (int) result categories: (NSArray*)categories;
@end
@protocol  CheckExecutePaymentDelegate <NSObject>
- (void) paymentCheckComplete : (int) result params: (PaymentParams*)paymentParams;
- (void) paymentExecuteComplete:(int)result params: (PaymentParams*)paymentParams;
- (void) paymentSaveComplete:(int)result params:(PaymentTemplateInformation*)paymentTemplate;
@end
@protocol TransferDelegate <NSObject>
- (void) transferCheckComplete:(int)result params:(TransferParams*)transferParams;
- (void) transferExecComplete:(int)result params:(TransferParams*)transferParams;
- (void) transferSaveComplete:(int)result params:(TransferTemplateInformation*)transferTemplate;
@end
@protocol TemplatesDelegate <NSObject>
- (void) templatesComplete:(int)result payments:(NSArray*)paymentsList transfers:(NSArray*)transfersList;
- (void) templatesDeleteComplete:(int)result uid:(NSString*)templateUid;
@end

@protocol NewsDelegate <NSObject>
- (void) newsComplete:(int)result date:(NSDate*)timestamp news:(NSArray*)newsList;
@end
@protocol OffersDelegate <NSObject>
- (void) offersComplete:(int)result date:(NSDate*)timestamp offers:(NSArray*)offersList;
@end
@protocol ContactsDelegate <NSObject>
- (void) contactsComplete:(int)result contacts:(ResourceRec*)contactsInfo;
@end
@protocol AboutDelegate <NSObject>
- (void) aboutComplete:(int)result about:(ResourceRec*)aboutInfo;
@end
@protocol DeviceValidationDelegate <NSObject>
- (void) attachDeviceCompleted: (int) result;
- (void) confirmDeviceCompleted: (int) result;
@end
@protocol OTPDelegate <NSObject>
- (void) OTPCompleted: (int) result;
@end
@protocol LimitsDelegate <NSObject>
@optional
- (void) limitsComplete: (int) result limits: (NSArray*) limits reqId:(id)requestId;
- (void) addLimitComplete: (int) result limitIdentifier: (NSString *) uid description: (NSString*)description reqId:(id)requestId;
- (void) changeLimitComplete: (int) result description: (NSString*)description reqId:(id)requestId;
- (void) deleteLimitComplete: (int) result description: (NSString*)description reqId:(id)requestId;
@end


