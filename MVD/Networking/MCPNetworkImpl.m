//
//  MCPNetworkImpl.m
//  MobileBanking
//
//  Created by Denis Kurochkin on 25.03.14.
//  Copyright (c) 2014 BPC. All rights reserved.
//

#import "MCPNetworkImpl.h"
#import "AppSettings.h"
#import "NwobjHello.h"
#import "NwobjLogin.h"
#import "NwobjLogout.h"
#import "NwobjPassword.h"
#import "NwobjCapabilities.h"
#import "NwobjGetImage.h"
#import "NwobjAccounts.h"
#import "NwobjAccountDetails.h"
#import "NwobjAccountHistory.h"
#import "NwobjAccountChange.h"
#import "NwobjCards.h"
#import "NwobjCardDetails.h"
#import "NwobjCardHistory.h"
#import "NwobjCardChange.h"
#import "NwobjPaymentCategories.h"
#import "NwobjPaymentProviders.h"
#import "NwobjCheckExecutePayment.h"
#import "NwobjTransfer.h"
#import "NwobjTemplates.h"
#import "NwobjSavePayment.h"

#import "NwobjPoints.h"
#import "NwobjExchangeRates.h"
#import "NwobjNews.h"
#import "NwobjOffers.h"
#import "NwobjAbout.h"
#import "NwobjContacts.h"
#import "NwobjValidateDevice.h"
#import "NwobjOTP.h"
#import "NwobjLimits.h"

static NwobjLogin *nwobjLogin = Nil;

@implementation MCPNetworkImpl

@synthesize accessToken = _accessToken;
@synthesize lastResult = _lastResult;

- (id) init
{
    self = [super init];
    
    if ( self )
    {
        [self clearSession];
    }
    
    return self;
}

- (void) dealloc
{
    [_accessToken release];
    
    [super dealloc];
}

- (void) clearSession
{
    self.accessToken = @"";
    self.lastResult = 0;
}

- (void) hello:(id<HelloDelegate>) delegate;
{
    NwobjHello* nwobjHello = [[[NwobjHello alloc] init] autorelease];
    nwobjHello.sessionId = @"SESSID";
    nwobjHello.delegate = delegate;
    [nwobjHello run: [AppSettings instance].serverAddress];
    
}

- (void) login:(NSString *)name pwd:(NSString *)pwd deviceId:(NSString *)devId devCode:(NSString *)devCode delegate:(id<LoginDelegate>)delegate
{
    if ( nwobjLogin )
        [nwobjLogin release];
    nwobjLogin = [[NwobjLogin alloc] init];
    nwobjLogin.userName = name;
    nwobjLogin.userPassword = pwd;
    nwobjLogin.delegate = delegate;
    nwobjLogin.devId = devId;
    nwobjLogin.devCode = devCode;
    [nwobjLogin run: [AppSettings instance].serverAddress];
}

- (void) attachDevice:(NSString *)token deviceId:(NSString *)devId key:(NSString *)devKey delegate:(id<DeviceValidationDelegate>)delegate
{
    NwobjAttachDevice* nwobjAttach = [[[NwobjAttachDevice alloc] init] autorelease];
    nwobjAttach.accessToken = token?token:self.accessToken;
    nwobjAttach.delegate = delegate;
    nwobjAttach.devId = devId;
    nwobjAttach.devKey = devKey;
    [nwobjAttach run:[AppSettings instance].serverAddress];
}

- (void) confirmDevice:(NSString *)token deviceId:(NSString *)devId code:(NSString *)devCode delegate:(id<DeviceValidationDelegate>)delegate
{
    NwobjConfirmDevice* nwobjConfirm = [[[NwobjConfirmDevice alloc] init] autorelease];
    nwobjConfirm.accessToken = token?token:self.accessToken;
    nwobjConfirm.delegate = delegate;
    nwobjConfirm.devId = devId;
    nwobjConfirm.devCode = devCode;
    [nwobjConfirm run:[AppSettings instance].serverAddress];
}

- (void) loginCancel:(NSString*)name delegate:(id<LoginDelegate>)delegate
{
    if ( nwobjLogin )
    {
        [nwobjLogin cancel];
        [nwobjLogin release];
        nwobjLogin = Nil;
    }
}

- (void) logout:(NSString *)token delegate:(id<LogoutDelegate>)delegate
{
    NwobjLogout* nwobjLogout = [[[NwobjLogout alloc] init] autorelease];
    nwobjLogout.accessToken = token?token:self.accessToken;
    nwobjLogout.delegate = delegate;
    [nwobjLogout run: [AppSettings instance].serverAddress];
}

- (void) passwordChange:(NSString *)token oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd delegate:(id<PasswordDelegate>)delegate
{
    NwobjPassword* nwobjPass = [[[NwobjPassword alloc] init] autorelease];
    nwobjPass.accessToken = token?token:self.accessToken;
    nwobjPass.currentPassword = oldPwd;
    nwobjPass.changedPassword = newPwd;
    nwobjPass.delegate = delegate;
    [nwobjPass run: [AppSettings instance].serverAddress];
}

- (void) serverCapabilities:(NSString*)token delegate:(id<ServerCapabilitiesDelegate>)delegate
{
    NwobjServerCapabilities* nwobjSrvCaps = [[[NwobjServerCapabilities alloc] init] autorelease];
    nwobjSrvCaps.accessToken = token?token:self.accessToken;
    nwobjSrvCaps.delegate = delegate;
    [nwobjSrvCaps run: [AppSettings instance].serverAddress];
}

- (void) getImage:(NSString*)token imgId:(NSString*)imageId reqId:(id)requestId delegate:(id<ResourcesExchangeDelegate>)delegate
{
    NwobjGetImage* nwobjGetRes = [[[NwobjGetImage alloc] init] autorelease];
    nwobjGetRes.accessToken = token?token:self.accessToken;
    nwobjGetRes.imageId = imageId;
    nwobjGetRes.requestId = requestId;
    nwobjGetRes.delegate = delegate;
    [nwobjGetRes run: [AppSettings instance].serverAddress];
}

- (void) accounts:(NSString*)token delegate:(id<AccountsDelegate>)delegate
{
    NwobjAccounts* nwobjAccounts = [[[NwobjAccounts alloc] init] autorelease];
    nwobjAccounts.accessToken = token?token:self.accessToken;
    nwobjAccounts.delegate = delegate;
    [nwobjAccounts run: [AppSettings instance].serverAddress];
}

- (void) accountDetails:(NSString*)token account:(NSString*)accountNumber delegate:(id<AccountDetailsDelegate>)delegate
{
    NwobjAccountDetails* nwobjAccountDetails = [[[NwobjAccountDetails alloc] init] autorelease];
    nwobjAccountDetails.accessToken = token?token:self.accessToken;
    nwobjAccountDetails.accountNumber = accountNumber;
    nwobjAccountDetails.delegate = delegate;
    [nwobjAccountDetails run: [AppSettings instance].serverAddress];
}

- (void) accountHistory:(NSString *)token account:(NSString *)accountNumber page:(NSInteger)dataPage delegate:(id<AccountHistoryDelegate>)delegate
{
    NwobjAccountHistory* nwobjAccountHistory = [[[NwobjAccountHistory alloc] init] autorelease];
    nwobjAccountHistory.accessToken = token?token:self.accessToken;
    nwobjAccountHistory.accountNumber = accountNumber;
    nwobjAccountHistory.pageNumber = dataPage;
    nwobjAccountHistory.delegate = delegate;
    [nwobjAccountHistory run: [AppSettings instance].serverAddress];
}

- (void) accountChange:(NSString*)token account:(NSString*)accountNumber name:(NSString*)accountName status:(int)accountStatus delegate:(id<AccountChangeDelegate>)delegate
{
    NwobjAccountChange* nwobjAccountChange = [[[NwobjAccountChange alloc] init] autorelease];
    nwobjAccountChange.accessToken = token?token:self.accessToken;
    nwobjAccountChange.accountNumber = accountNumber;
    if ( accountName.length > 0 )
        nwobjAccountChange.accountName = accountName;
    if ( accountStatus >= 0 )
        nwobjAccountChange.accountStatus = accountStatus;
    nwobjAccountChange.delegate = delegate;
    [nwobjAccountChange run: [AppSettings instance].serverAddress];
}

- (void) cards:(NSString*)token delegate:(id<CardsDelegate>)delegate
{
    NwobjCards* nwobjCards = [[[NwobjCards alloc] init] autorelease];
    nwobjCards.accessToken = token?token:self.accessToken;
    nwobjCards.delegate = delegate;
    [nwobjCards run: [AppSettings instance].serverAddress];
}

- (void) cardDetails:(NSString*)token card:(NSString*)cardNumber delegate:(id<CardDetailsDelegate>)delegate
{
    NwobjCardDetails* nwobjCardDetails = [[[NwobjCardDetails alloc] init] autorelease];
    nwobjCardDetails.accessToken = token?token:self.accessToken;
    nwobjCardDetails.cardNumber = cardNumber;
    nwobjCardDetails.delegate = delegate;
    [nwobjCardDetails run: [AppSettings instance].serverAddress];
}

- (void) cardHistory:(NSString *)token card:(NSString *)cardScid page:(NSInteger)dataPage delegate:(id<CardHistoryDelegate>)delegate
{
    NwobjCardHistory* nwobjCardHistory = [[[NwobjCardHistory alloc] init] autorelease];
    nwobjCardHistory.accessToken = token?token:self.accessToken;
    nwobjCardHistory.cardNumber = cardScid;
    nwobjCardHistory.pageNumber = dataPage;
    nwobjCardHistory.delegate = delegate;
    [nwobjCardHistory run: [AppSettings instance].serverAddress];
}


- (void) cardChange:(NSString*)token card:(NSString*)cardNumber name:(NSString*)cardName status:(int)cardStatus delegate:(id<CardChangeDelegate>)delegate
{
    NwobjCardChange* nwobjCardChange = [[[NwobjCardChange alloc] init] autorelease];
    nwobjCardChange.accessToken = token?token:self.accessToken;
    nwobjCardChange.cardNumber = cardNumber;
    if ( cardName.length > 0 )
        nwobjCardChange.cardName = cardName;
    if ( cardStatus >= 0 )
        nwobjCardChange.cardStatus = cardStatus;
    nwobjCardChange.delegate = delegate;
    [nwobjCardChange run: [AppSettings instance].serverAddress];
}

- (void) points:(int)type withLatitude:(double)latitude withLongitude:(double)longitude page:(NSInteger)dataPage delegate:(id<PointsDelegate>)delegate
{
    NwobjPoints* nwobjPoints = [[[NwobjPoints alloc] init] autorelease];
    nwobjPoints.currentLatitude = latitude;
    nwobjPoints.currentLongitude = longitude;
    if ( type > 0 )
        nwobjPoints.pointType = type;
    if ( dataPage >= 0 )
        nwobjPoints.pageNumber = dataPage;
    nwobjPoints.delegate = delegate;
    [nwobjPoints run: [AppSettings instance].serverAddress];
}

- (void) exchangeRates:(id<ExchangeDelegate>)delegate
{
    NwobjExchangeRates* nwobjExchange = [[[NwobjExchangeRates alloc] init] autorelease];
    nwobjExchange.delegate = delegate;
    [nwobjExchange run: [AppSettings instance].serverAddress];
}

- (void) paymentsDescription:(NSString*)cid delegate:(id<PaymentsDescriptionDelegate>)delegate
{
    NwobjPaymentProviders* providers = [[[NwobjPaymentProviders alloc] init] autorelease];
    providers.accessToken = self.accessToken;
    providers.delegate = delegate;
    providers.cid = cid;
    [providers run:[AppSettings instance].serverAddress];
}

- (void) paymentCategoriesWithDelegate:(id<PaymentCategoriesDelegate>)delegate
{
    NwobjPaymentCategories* nwobjPaymentCategories = [[[NwobjPaymentCategories alloc] init] autorelease];
    nwobjPaymentCategories.accessToken = self.accessToken;
    nwobjPaymentCategories.delegate = delegate;
    [nwobjPaymentCategories run:[AppSettings instance].serverAddress];
}

- (void) checkPayment:(NSString *)token withParameters:(PaymentParams *)parameters delegate:(id<CheckExecutePaymentDelegate>)delegate
{
    NwobjCheckExecutePayment *obj = [[[NwobjCheckExecutePayment alloc] init] autorelease];
    obj.check = YES;
    obj.params = parameters;
    obj.delegate = delegate;
    obj.accessToken = token?token:self.accessToken;
    [obj run:[AppSettings instance].serverAddress];
}

- (void) executePayment:(NSString *)token withParameters:(PaymentParams *)parameters delegate:(id<CheckExecutePaymentDelegate>)delegate
{
    NwobjCheckExecutePayment *obj = [[[NwobjCheckExecutePayment alloc] init] autorelease];
    obj.check = NO;
    obj.delegate = delegate;
    obj.params = parameters;
    obj.accessToken = token?token:self.accessToken;
    [obj run:[AppSettings instance].serverAddress];
}

- (void) paymentSave:(NSString *)token params:(PaymentTemplateInformation *)paymentTemplate delegate:(id<CheckExecutePaymentDelegate>)delegate
{
    NwobjSavePayment *save = [[[NwobjSavePayment alloc] init] autorelease];
    save.delegate = delegate;
    save.params = paymentTemplate;
    save.accessToken = save.accessToken = token?token:self.accessToken;
    [save run:[AppSettings instance].serverAddress];
    
  //  save.params
    
}

- (void) transferCheck:(NSString *)token params:(TransferParams *)transferParams delegate:(id<TransferDelegate>)delegate
{
    NwobjTransfer *transfer = [[[NwobjTransfer alloc] init] autorelease];
    transfer.accessToken = token?token:self.accessToken;
    transfer.mode = OnlyCheckingMode;
    transfer.transferParams = transferParams;
    transfer.delegate = delegate;
    [transfer run:[AppSettings instance].serverAddress withMode:OnlyCheckingMode];
}

- (void) transferExec:(NSString *)token params:(TransferParams *)transferParams delegate:(id<TransferDelegate>)delegate
{
    NwobjTransfer *transfer = [[[NwobjTransfer alloc] init] autorelease];
    transfer.accessToken = token?token:self.accessToken;
    transfer.mode = RealExecutionMode;
    transfer.transferParams = transferParams;
    transfer.delegate = delegate;
    [transfer run:[AppSettings instance].serverAddress withMode:RealExecutionMode];
}

- (void) transferSave:(NSString *)token params:(TransferTemplateInformation *)transferTemplate delegate:(id<TransferDelegate>)delegate
{
    NwobjSaveTransfer *transfer = [[[NwobjSaveTransfer alloc] init] autorelease];
    transfer.accessToken = token?token:self.accessToken;
    transfer.transferTemplate = transferTemplate;
    transfer.delegate = delegate;
    [transfer run:[AppSettings instance].serverAddress];
}

- (void) templates:(NSString *)token delegate:(id<TemplatesDelegate>)delegate
{
    NwobjTemplates *templates = [[[NwobjTemplates alloc] init] autorelease];
    templates.accessToken = token?token:self.accessToken;
    templates.delegate = delegate;
    [templates run:[AppSettings instance].serverAddress];
}

- (void) templatesDelete:(NSString *)token uid:(NSString*)templateUid delegate:(id<TemplatesDelegate>)delegate
{
    NwobjDeleteTemplates *delTemplates = [[[NwobjDeleteTemplates alloc] init] autorelease];
    delTemplates.accessToken = token?token:self.accessToken;
    delTemplates.delegate = delegate;
    delTemplates.templateUid = templateUid;
    [delTemplates run:[AppSettings instance].serverAddress];
}

- (void) news:(NSDate *)timestamp delegate:(id<NewsDelegate>)delegate
{
    NwobjNews *news = [[[NwobjNews alloc] init] autorelease];
    news.delegate = delegate;
    news.timestamp = timestamp;
    [news run:[AppSettings instance].serverAddress];
}

- (void) offers:(NSDate *)timestamp delegate:(id<OffersDelegate>)delegate
{
    NwobjOffers *offers = [[[NwobjOffers alloc] init] autorelease];
    offers.timestamp = timestamp;
    offers.delegate = delegate;
    [offers run:[AppSettings instance].serverAddress];
    
}

- (void) contacts:(id<ContactsDelegate>)delegate
{
    NwobjContacts *contacts = [[[NwobjContacts alloc] init] autorelease];
    contacts.delegate = delegate;
    [contacts run:[AppSettings instance].serverAddress];
}

- (void) about:(id<AboutDelegate>)delegate
{
    NwobjAbout *about = [[[NwobjAbout alloc] init] autorelease];
    about.delegate = delegate;
    [about run:[AppSettings instance].serverAddress];
}

- (void) getOTP:(NSString *)token otpRef:(NSString *)otpRef delegate:(id<OTPDelegate>)delegate
{
    NwobjOTP *otp = [[[NwobjOTP alloc] init] autorelease];
    otp.accessToken = token?token:self.accessToken;
    otp.delegate = delegate;
    otp.otpRef = otpRef;
    [otp run:[AppSettings instance].serverAddress];
}

- (void) limits:(NSString *)token card:(NSString *)cardScid reqId:(id)requestId delegate:(id<LimitsDelegate>)delegate
{
    NwobjLimits *nwobj = [[[NwobjLimits alloc] init] autorelease];
    nwobj.accessToken = token?token:self.accessToken;
    nwobj.card = cardScid;
    nwobj.delegate = delegate;
    
    [nwobj run:[AppSettings instance].serverAddress];
}

- (void) changeLimit:(NSString *)token limitParams:(LimitInformation *)limit reqId:(id)requestId delegate:(id<LimitsDelegate>)delegate
{
    NwobjChangeLimit *changeLimit = [[[NwobjChangeLimit alloc] init] autorelease];
    changeLimit.accessToken = token?token:self.accessToken;
    changeLimit.requestId = requestId;
    changeLimit.limit = limit;
    changeLimit.delegate = delegate;
    
    [changeLimit run:[AppSettings instance].serverAddress];
    
}

- (void) addLimit:(NSString *)token limitParams:(LimitInformation *)limit reqId:(id)requestId delegate:(id<LimitsDelegate>)delegate
{
    NwobjAddLimit *addLimit = [[[NwobjAddLimit alloc] init] autorelease];
    addLimit.accessToken = token?token:self.accessToken;
    addLimit.requestId = requestId;
    addLimit.delegate = delegate;
    addLimit.limit = limit;
    
    [addLimit run:[AppSettings instance].serverAddress];
}

- (void) deleteLimit:(NSString *)token limitParams:(LimitInformation *)limit reqId:(id)requestId delegate:(id<LimitsDelegate>)delegate
{
    NWobjDeleteLimit *deleteLimit = [[[NWobjDeleteLimit alloc] init] autorelease];
    deleteLimit.accessToken = token?token:self.accessToken;
    deleteLimit.delegate = delegate;
    deleteLimit.requestId = requestId;
    deleteLimit.card = limit.card;
    deleteLimit.uid = limit.uid;
    
    [deleteLimit run:[AppSettings instance].serverAddress];
}

@end
