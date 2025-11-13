class ApiRouteConstant {
  // Auth Endpoints
  // static const login = '/auth/login';
  static const login = '/account/token';
  static const refreshToken = '/account/refreshToken';
  static const logout = '/account/logout';
  static const signup = '/account/register';
  static const resendOtp = '/account/otp/resend';
  static const validateResetOtp = '/account/reset/otp/validate';
  static const requestPasswordReset = '/account/reset';
  static const validateOtp = '/account/otp/validate';
  static const updateUserProfile = '/accts/account/Profile';
  static const getVisitorSource = '/api/VisitorSource/list';


  // Auth Notifications
  // static const updateNotificationSettings = '/notification/Notification/settings/update';
  static const fetchNotificationSettings = '/notify/notification/Notification/settings';
  static const updateNotificationSettings = '/notify/notification/Notification/settings/update';

  // Auth Endpoints
  static const getAllReferral = '/Referral';


  // Product Endpoints
  static const getAllProducts = '/mktplc/products';
  static const getProductById = '/mktplc/api/Product/{productId}';
  static const getProductPaymentSchedule = '/mktplc/api/Product/{productId}/payment-breakdown';
  static const searchForProduct = '/mktplc/api/Product/search';
  static const getPopularProduct = '/mktplc/api/product/category/popular';

  // Category Endpoints
  static const getAllCategories = '/mktplc/api/product/category';
  static const getPopularCategories = '/mktplc/api/product/category/popular';

  // Brands Endpoints
  static const getAllBrands = '/mktplc/api/Product/brand';


  // Order Endpoints
  static const getAllOrders = '/mktplc/api/Order';
  static const getOrderById = '/mktplc/api/Order/{orderId}';
  static const updateOrder = '/mktplc/api/Order/update/{Id}';
  static const deleteOrder = '/mktplc/orders/{id}';
  static const orderStatus = '/mktplc/api/admin/order/status';
  static const orderSearch = '/mktplc/api/admin/order/search';
  static const getOrderPaymentSchedule = '/mktplc/api/Order/{orderId}/payment-breakdown';
  static const getStates = '/mktplc/api/Order/states';
  static const getLGAs = '/mktplc/api/Order/lgas';
  static const getAreas = '/mktplc/api/Order/areas';
  static const getDeliveryFee = '/mktplc/api/Order/deliveryFee';
  static const updateDeliveryPhoneNumber = '/mktplc/api/Order/update/';
  static const getRepaymentHistory = '/loanacct/LoanAccount/user/order/{orderId}/repayments';
  static const confirmOrder = '/mktplc/api/Cart/confirm-order';

  // User Endpoints
  static const getAllUsers = '/users';
  static const getUserData = '/account/Profile';
  static const getIfUserEligibleForMarketplace = '/mktplc/api/UserEligibility/check';
  static const updateUser = '/users/{id}';
  static const deleteUser = '/account/deletionRequest';
  static const contactUs = '/proprt/Contact';
  static const getMarketPlaceCredit = '/mktplc/api/UserEligibility/eligible-amount';

  static const getRentDueDate = '/accts/account/Profile/rentDuedate';
  static const updateRentDueDate = '/accts/account/Profile/rentDuedate/update';
  static const uploadProfilePic = '/accts/account/Profile/picture/upload';
  static const deleteProfilePic = '/accts/account/Profile/picture';

  //Referral Endpoints
  static const getReferralCode = '/refer/Referral/code';
  static const getUserReferrals = '/refer/Referral';

  //Billings Endpoints
  static const getBillings = '/LoanAccount/billing';


  // Cart Endpoints
  static const getCart = '/mktplc/api/Cart';
  static const addToCart = '/mktplc/api/Cart/item';
  static const checkoutCart = '/mktplc/api/Cart/checkout';
  static const deleteCart = '/mktplc/api/Cart/item/{cartItemId}';
  static const getCartVatFee = '/mktplc/api/Cart/{cartItemId}/vat-fee';
  static const getCartDeliveryFee = '/mktplc/api/Cart/{cartItemId}/delivery-fee';
  static const getCartPaymentBreakdown = '/mktplc/api/Cart/{cartItemId}/payment/breakdown';

  // Payment Endpoints
  static const initiatePayment = '/mktplc/api/Payment/initialize';
  static const verifyPayment = '/mktplc/api/Payment/verify';
  static const getPaymentStatus = '/mktplc/api/Payment/status/{transactionId}';
  static const paymentMethods = '/mktplc/api/Payment/methods';


  // Rent Account Endpoints
  static const uploadPaymentProof = '/LoanAccount/uploadBankReceipt';
  static const getAccountById = '/LoanAccount/{accountId}';
  static const getAccounts = '/LoanAccount';
  static const completeCardRepayment = '/LoanAccount/completeCardRepayment';
  static const startCardRepayment = '/LoanAccount/startCardPayment';
  static const getBankList =  '/LoanApplication/banks';
  static const getBankList2 =  '/LoanAccount/banks';
  static const getPaymentMethodsList =  '/LoanAccount/paymentMethod';
  static const setupDirectDebit =  '/loanacct/LoanAccount/dd/initiate';
  static const validateSetupDirectDebit =  '/loanacct/LoanAccount/dd/verify';



  // Rent Application Endpoints
  static const getLoanApplications = '/LoanApplication';
  static const getRentApplicationEligibility = '/loanapp/LoanApplication/check/eligiblity';
  static const validateReferredByEmployer = '/partnr/api/Partner/employee/get/';
  static const getEmploymentStatusTypes = '/loanapp/LoanApplication/employmentStatuses';
  static const getPropertyTypes = '/proprt/property/Property/propertyTypes';
  static const getSaveProperty = '/proprt/property/Property/admin/property';
  static const getTenorTypes = '/loanapp/LoanApplication/tenor';
  static const updateRentApplication = '/loanapp/LoanApplication/application/property/update';
  static const saveApplication = '/loanapp/LoanApplication/registration/save'; //?stage=&isB2B=false
  static const getApplicationById = '/loanapp/LoanApplication/{applicationId}';
  static const uploadApplicationDocument = '/loanapp/LoanApplication/uploadDocument';
  static const getApplicationPropertyById = '/proprt/property/Property/{applicationId}';
  static const getApplicationRequestedDocumentsById = '/LoanApplication/application/documentrequests/{applicationId}';
  static const getApplicationDocumentById = '/loanapp/LoanApplication/application/documents/{applicationId}';
  static const getApplicationPaymentSchedule = '/partnrexp/api/Applications/payment-schedule/{applicationId}';
  static const withdrawRentApplication = '/loanapp/LoanApplication/{applicationId}/withdraw';
  static const uploadRequestedDoc = '/LoanApplication/document/request/complete/{documentRequestID}';




  //Utils Endpoints
  static const tenancyDoc = 'http://dev2.yalo.ng.s3-website.us-east-2.amazonaws.com/assets/media/tenancy-agreement.pdf';
  static const offerLetterDoc = 'http://dev2.yalo.ng.s3-website.us-east-2.amazonaws.com/assets/media/offer-letter.pdf';
  static const bankStatementDoc = 'http://dev2.yalo.ng.s3-website.us-east-2.amazonaws.com/assets/media/bank-statement.pdf';


}
