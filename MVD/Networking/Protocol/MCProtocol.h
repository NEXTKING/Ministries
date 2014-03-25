//
//  MCProtocol.h
//  MobileBanking
//
//  Created by Sergey Sasin on 15.04.13.
//  Copyright (c) 2013 BPC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Delegates.h"

@protocol MCProtocol <NSObject>

// Session management
@required
- (NSString*)   accessToken;
- (void)        setAccessToken:(NSString*)token;
- (int)         lastResult;
- (void)        setLastResult:(int)result;
- (void)        clearSession;
   
// Functions
@required
- (void) hello:(id<HelloDelegate>) delegate;

- (void) login:(NSString*)name pwd:(NSString*)pwd deviceId: (NSString*)devId devCode: (NSString*)devCode delegate:(id<LoginDelegate>)delegate;
- (void) loginCancel:(NSString*)name delegate:(id<LoginDelegate>)delegate;
- (void) logout:(NSString*)token delegate:(id<LogoutDelegate>)delegate;
- (void) passwordChange:(NSString*)token oldPwd:(NSString*)oldPwd newPwd:(NSString*)newPwd delegate:(id<PasswordDelegate>)delegate;
- (void) serverCapabilities:(NSString*)token delegate:(id<ServerCapabilitiesDelegate>)delegate;
- (void) getImage:(NSString*)token imgId:(NSString*)imageId reqId:(id)requestId delegate:(id<ResourcesExchangeDelegate>)delegate;

- (void) accounts:(NSString*)token delegate:(id<AccountsDelegate>)delegate;
- (void) accountDetails:(NSString*)token account:(NSString*)accountNumber delegate:(id<AccountDetailsDelegate>)delegate;
- (void) accountHistory:(NSString*)token account:(NSString*)accountNumber page:(NSInteger)dataPage delegate:(id<AccountHistoryDelegate>)delegate;
- (void) accountChange:(NSString*)token account:(NSString*)accountNumber name:(NSString*)accountName status:(int)accountStatus delegate:(id<AccountChangeDelegate>)delegate;
- (void) cards:(NSString*)token delegate:(id<CardsDelegate>)delegate;
- (void) cardDetails:(NSString*)token card:(NSString*)cardScid delegate:(id<CardDetailsDelegate>)delegate;
- (void) cardHistory:(NSString*)token card:(NSString*)cardScid page:(NSInteger)dataPage delegate:(id<CardHistoryDelegate>)delegate;
- (void) cardChange:(NSString*)token card:(NSString*)cardScid name:(NSString*)cardName status:(int)cardStatus delegate:(id<CardChangeDelegate>)delegate;
- (void) points:(int)type withLatitude:(double)latitude withLongitude:(double)longitude page:(NSInteger)dataPage delegate:(id<PointsDelegate>)delegate;
- (void) exchangeRates:(id<ExchangeDelegate>)delegate;
- (void) paymentsDescription: (NSString*)cid delegate: (id<PaymentsDescriptionDelegate>)delegate;
- (void) paymentCategoriesWithDelegate: (id<PaymentCategoriesDelegate>)delegate;
- (void) checkPayment: (NSString*)token withParameters: (PaymentParams*) parameters delegate: (id<CheckExecutePaymentDelegate>) delegate;
- (void) executePayment:(NSString*)token withParameters: (PaymentParams*) parameters delegate: (id<CheckExecutePaymentDelegate>) delegate;
- (void) paymentSave:(NSString*)token params:(PaymentTemplateInformation*)paymentTemplate delegate: (id<CheckExecutePaymentDelegate>) delegate;
- (void) transferCheck:(NSString*)token params:(TransferParams*)transferParams delegate: (id<TransferDelegate>) delegate;
- (void) transferExec:(NSString*)token params:(TransferParams*)transferParams delegate: (id<TransferDelegate>) delegate;
- (void) transferSave:(NSString*)token params:(TransferTemplateInformation*)transferTemplate delegate: (id<TransferDelegate>) delegate;
- (void) templates:(NSString*)token delegate:(id<TemplatesDelegate>)delegate;
- (void) templatesDelete:(NSString*)token uid:(NSString*) templateUid delegate:(id<TemplatesDelegate>)delegate;

- (void) news:(NSDate*)timestamp delegate:(id<NewsDelegate>)delegate;
- (void) offers:(NSDate*)timestamp delegate:(id<OffersDelegate>)delegate;
- (void) contacts:(id<ContactsDelegate>)delegate;
- (void) about:(id<AboutDelegate>)delegate;
- (void) attachDevice:(NSString*)token deviceId: (NSString*)devId key: (NSString*)devKey delegate: (id<DeviceValidationDelegate>)delegate;
- (void) confirmDevice:(NSString*)token deviceId: (NSString*)devId code: (NSString*)devCode delegate: (id<DeviceValidationDelegate>)delegate;
- (void) getOTP: (NSString*) token otpRef: (NSString*) otpRef delegate: (id<OTPDelegate>)delegate;
- (void) addLimit: (NSString*) token limitParams: (LimitInformation*) limit reqId:(id)requestId delegate: (id<LimitsDelegate>) delegate;
- (void) limits: (NSString*) token card: (NSString*) cardScid reqId:(id)requestId delegate: (id<LimitsDelegate>) delegate;
- (void) changeLimit: (NSString *) token limitParams: (LimitInformation*) limit reqId:(id)requestId delegate: (id<LimitsDelegate>) delegate;
- (void) deleteLimit: (NSString *) token limitParams: (LimitInformation*) limit reqId:(id)requestId delegate: (id<LimitsDelegate>) delegate;

@end
