class Strings {
  // static const baseUrl = 'https://staging-api.thinknlocal.com/v2/'; /// For development
  static const baseUrl = 'https://api.thinknlocal.com/v2/';

  /// For production
  static const dummyToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOm51bGwsImRhdGEiOm51bGx9.rTBYjY035F8ni5Jprku9A_YTugZGMp3G3n7xgNX-Gqw';

  ///update this token when you need to test cases
  static const testingToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImRhdGEiOm51bGwsImV4cCI6MTY4NDU3NTk2NX0.VUWhCIHoQCVlx_EIo5yOA7OQNjlHQF68ikyVhhLIkYs';

  static const googleAuthToken =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc0ODNhMDg4ZDRmZmMwMDYwOWYwZTIyZjNjMjJkYTVmZTM5MDZjY2MiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI1OTI3MTc0ODE5MC02czZsYmkzMmw3czY0ZDYxYjVzYjJ1bm5ldWlrcTEyZi5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjU5MjcxNzQ4MTkwLWlrYzlydDZlMmtrZTFta2Rxamttc3M4dmE4bDUzdWJuLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTExMDQ3MTMxNzQ3MzM3MjQ3Mzc1IiwiaGQiOiJ0aGlua25sb2NhbC5jb20iLCJlbWFpbCI6InN0ZXZlLnN0bWFydGluQHRoaW5rbmxvY2FsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiU3RlcGhlbiBTdC4gTWFydGluIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBVFhBSnhMUEY1Rkt0TE11OVk0NWtRYVBDa244aFRWM2trUHFWeUk4SHJxPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlN0ZXBoZW4iLCJmYW1pbHlfbmFtZSI6IlN0LiBNYXJ0aW4iLCJsb2NhbGUiOiJlbiIsImlhdCI6MTY1NDg2ODQxMSwiZXhwIjoxNjU0ODcyMDExfQ.Gsv9eeuFBX9W_AZ_oDZhSM1ohFYkEIgfKzm4YfvXlg-RGoJKKE4ksxuePNpf79fpOz2sFg_d0RHYpGJ2stouK-4X-HJDqJ2W9Qx8CwpV9XQDOVLq6dptaciXq6HIz-5VSZ3HryZAG4jFXXzFcwmqpUFT_gMezto_IBLeGVqq0CgpfVk9KwcIxo6UdjrMGB37dHLVbkBYUGcvoILdVtyhscveuL3wvEiQyToi6xbkbefSu3EN60th7LheFs9XKZ7j95BMhX1W7F-VZqtJu1BJaAbtjyMvHFb_FDsDFuXtiXX3rBufvH7aIIFAdxZ293cQUFYYF8vFt0mE7Kq3cWgJtw';
  static const String loginUserId = "loginUserId";
  static const String loginName = "loginName";
  static const String loginEmail = "loginEmail";
  static const String loginPassword = "loginPassword";
  static const String showHome = "showHome";
  static const String cause = "Cause";
  static const String causes = "Causes";
  static const String business = "Business";
  static const String businesses = "Businesses";
  static const String nearby = "nearby";
  static const String featured = "featured";
  static const String overview = "Overview";
  static const String updates = "Updates";
  static const String token = "token";
  static const String status = "status";
  static const String pending = "pending";
  static const String approved = "approved";
  static const String denied = "denied";
  static const String stats = "Stats";
  static const String featuredSponsors = "Featured Sponsors";
  static const String corporateSponsors = "Corporate Sponsors";
  static const String trending = "trending";
  static const String favorites = "favorites";
  static const String favorite = "favorite";
  static const String past = "past";
  static const String recent = "recent";
  static const String recentCauses = "Recent causes";
  static const String active = "active";
  static const String upcoming = "upcoming";
  static const String unknown = "";
  static const String email = "email";
  static const String provider = "provider";
  static const String apple = "apple";
  static const String google = "google";
  static const String authorization = "authorization";
  static const String password = "password";
  static const String passwordConfirmation = "password_confirmation";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String zip = "zip";
  static const String groupCode = "group_code";
  static const String businessId = "business_id";
  static const String causeId = "cause_id";
  static const String categoryId = "category_id";
  static const String parentCategoryId = "parent_category_id";
  static const String allCauses = "All causes ";
  static const String allBusinesses = "All businesses ";
  static const String upcomingCausesNearYou = "Upcoming causes near you";
  static const String businessesNearYou = "Businesses near you";
  static const String upcomingCauses = "Upcoming causes";
  static const String nothing = '';
  static const String recentlyStarted = "Recently Started";
  static const String recentlyFundedBusinessCauses = "Recently funded causes";
  static const String pastFundedBusinessCauses = "Past funded causes";
  static const String recentlyAddedBusiness = "Recently added businesses";
  static const String seeAll = "See All";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String cityId = "city_id";
  static const String dummyLatitude = '33.9898';
  static const String dummyLongitude = "-117.7326";
  static const String yes = "Yes";
  static const String no = "No";
  static const String organizationId = "organization_id";
  static const String businessNear = "Businesses near";
  static const String noLocation = 'Loading';
  static const String of = 'of';
  static const String ended = 'Ended';
  static const String ends = 'Ends';
  static const String dummyLocation = "Chino Hills, CA";
  static const String searchBusiness = "Search for a business";
  static const String foodDrink = "Food & Drink";
  static const String toDoThings = "Things to do";
  static const String personalServices = "Personal Services";
  static const String retail = "Retail";
  static const String retry = "RETRY";
  static const String services = "Services";
  static const String parents = "parents";
  static const String type = "type";
  static const String contributionsOverTime = "Contributions over time";
  static const String numberOfContributions =
      'Number of contributions from individuals over time.';
  static const String recentContributions = "Recent Contributions";
  static const String topContributions = "Top Contributors";
  static const String recentlyAdded = "Recently Added";
  static const String tellUsAboutVisit = "Tell us about your visit!";
  static const String howWasYourExperience = 'How was your experience?';
  static const String whereDidYouGo = 'Where did you go?';
  static const String businessName = 'Business name';
  static const String lowerCaseBusinessName = 'business name,';
  static const String causeName = 'Cause name';
  static const String howWasYourVisit = 'How was your visit?';
  static const String wasThisFirstTime = 'Was this your first time?';
  static const String whatCauseYouSupport =
      'What cause do you want to support?';
  static const String looksGood = 'Looks Good!';
  static const String hello = 'Hello,';
  static const String accountSettings = 'Account Settings';
  static const String pushNotifications = 'Push Notifications';
  static const String enablePushNotifications = 'Enable push notifications.';
  static const String emails = 'Emails';
  static const String next = 'next';
  static const String allowSystemEmails = 'Allow system emails for causes.';
  static const String locationServices = 'Location Services';
  static const String allowLocationServices =
      'Allow location services while the app is running.';
  static const String otherOption = 'Other Option';
  static const String otherOptionDescription =
      'Other option description related to something.';
  static const String otherOption2 = 'Other Option 2';
  static const String help = 'Help';
  static const String signOut = 'Sign out';
  static const String signIn = 'Sign In';
  static const String signUpKeyButton = 'signUpKeyButton';
  static const String partOfClubOrGroup =
      '*Part of a club, organization or special group?';
  static const String alreadyAnAccount = "Already have an account? ";
  static const String editAccountInfo = 'Edit Account Info';
  static const String showingCausesNear = 'Showing causes near';
  static const String searchForCause = 'Search for a cause';
  static const String raising = 'Raising';
  static const String starting = 'Starting';
  static const String started = 'Started';
  static const String yourNotifications = 'Your Notifications';
  static const String wantToEditNotification =
      'Want to edit your notification settings?';
  static const String editSettings = 'Edit Settings';
  static const String notifications = 'Notifications';
  static const String account = 'Account';
  static const String pendingReceipts = 'Pending Receipts';
  static const String sentReceipts = 'Sent Receipts';
  static const String approvedReceipts = 'Approved Receipts';
  static const String deniedReceipts = 'Denied Receipts';
  static const String currentLat = 'currentLat';
  static const String currentLong = 'currentLong';
  static const String currentLocationAddress = 'currentLocationAddress';
  static const String ago = 'ago';
  static const String makeSure = 'Make sure ';
  static const String total = 'total';
  static const String areClearlyVisible = 'are clearly visible';
  static const String cancel = 'Cancel';
  static const String resetIt = 'Reset it';
  static const String and = 'and';
  static const String forgotPassword = 'Forgot password? ';
  static const String emailTextField = 'emailTextField';
  static const String passwordTextField = 'passwordTextField';
  static const String signInKeyButton = 'signInKeyButton';
  static const String didNotHaveAccount = "Don't have an account? ";
  static const String register = 'Register';
  static const String orContinueWith = 'Or continue with';
  static const String tryAgain = 'Try Again';
  static const String helloScan = 'Hello Scan';
  static const String showingResultsFor = 'Showing results for';
  static const String contributing = 'Contributing';
  static const String joined = 'Joined';
  static const String customerRatings = 'customer ratings';
  static const String outOf5 = 'out of 5';
  static const String recentlyFunded = 'Recently Funded';
  static const String currentCauses = 'Current Causes';
  static const String pastFundedCauses = 'Past Funded Causes';
  static const String searchForA = 'Search for a';
  static const String noInternetConnection = 'No Internet Connection';
  static const String pleaseTryAgain = 'Please Try Again';
  static const String fileName = 'file_name';
  static const String contentType = 'content_type';
  static const String byteSize = 'byte_size';
  static const String checksum = 'checksum';
  static const String uploadId = 'upload_id';
  static const String rating = 'rating';
  static const String firstPurchase = 'first_purchase';
  static const String thinknLocal = 'ThinknLocal';
  static const String notificationId = 'high_importance_channel';
  static const String notificationTitle = 'High Importance Notifications';
  static const String notificationDesc =
      'This channel is used for important notifications';
  static const String mipmapIcLauncher = '@mipmap/ic_launcher';
  static const String dynamicLinkInitialUrl = 'https://links.thinknlocal.com';
  static const String dynamicLinkImageUrl =
      'https://www.thinknlocal.com/assets/welcome/logo-dark-07b7bfc0671b940febf94d1af4f88fb133e8cd1e.png';
  static const String q = 'q';
  static const String cities = 'cities';
  static const String page = 'page';
  static const String searchForCity = 'Search for a city...';
  static const String citiesNearYou = 'Cities near you';
  static const String noUpcomingCauses = 'There are no upcoming causes';
  static const String noCauses = 'There are no causes';
  static const String noCausesFavorites = 'You have no favorited causes';
  static const String noBusinessFavorites = 'You have no favorited businesses';
  static const String noBusinessesFound =
      'There are no businesses available in this category';
  static const String noRecentCauses = 'There are no recent started causes';
  static const String noBusinesses = 'There are no businesses';
  static const String noRecentBusinesses = 'There are no added businesses';
  static const String noNearbyBusinesses = 'There are no nearby businesses';
  static const String noFeaturedSponsors = 'There are no featured sponsors';
  static const String noCauseUpdates = 'There are no cause updates';
  static const String noRecentContributions =
      'There are no recent contributions';
  static const String noRecentFundedCauses =
      'There are no recent funded causes';
  static const String noPastFundedCauses = 'There are no past funded causes';
  static const String noNotifications = 'There are no notifications';
  static const String noPendingReceipts = 'There are no pending receipts';
  static const String noApprovedReceipts = 'There are no approved receipts';
  static const String noDeniedReceipts = 'There are no denied receipts';
  static const String corporate = 'corporate';
  static const String zipCodeError = 'Zip code should be of 5 digits';
  static const String requiredFieldError = 'Please add all the required fields';
  static const String passwordError = 'Password should be minimum 6 characters';
  static const String notLoggedIn = 'You are not logged in';
  static const String fetchingLocation = 'Fetching location';
  static const String updateRequired = 'Update Required';
  static const String updateRequiredDesc =
      'Your app is out of date and needs to be updated to continue.';
  static const String updateAppNow = 'Update App Now';
  static const String underMaintenance = 'Under Maintenance';
  static const String underMaintenanceDesc =
      'We are currently under maintenance, please try again later.';
  static const String somethingWrong = 'Oops something went wrong!';
  static const String somethingWrongDesc =
      'Sorry we encountered an error please try again later.';
  static const String loadingMoreData = 'Loading more data';
  static const String dummyBgImage =
      "https://img.freepik.com/free-photo/abstract-grunge-decorative-relief-navy-blue-stucco-wall-texture-wide-angle-rough-colored-background_1258-28311.jpg?w=2000";
  static const String dummyLogo =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJvAoOOgHtZloYXgy0AFzd9SuxDlVw8s0sVg&usqp=CAU";
  static const String dummyLogoForDialog =
      "https://cdn.dribbble.com/users/24078/screenshots/15522433/media/e92e58ec9d338a234945ae3d3ffd5be3.jpg?compress=1&resize=400x300";
}
