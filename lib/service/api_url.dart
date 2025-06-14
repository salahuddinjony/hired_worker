
class ApiUrl {
  static const String baseUrl =
      "http://10.0.60.52:5002/api/v1"; //   //http://10.0.60.55:5002/v1 , https://912f-103-174-189-193.ngrok-free.app/v1 http://10.0.60.52:5002/api/v1
  static const String imageUrl = "http://10.0.60.52:5002/api/v1";
  static String socketUrl({required String id}) =>
      "https://912f-103-174-189-193.ngrok-free.app?userId=$id";
  // server url : http://103.174.189.219:5002/api/v1
  // local url : http://10.0.60.55:5002/v1
  ///========================= Authentication =========================
  static const String register = "/auth/register";
  static const String activeUser = "/auth/activate-user";
  static const String activeResend = "/auth/active-resend";
  static const String veryfiOTP = "/auth/verify-otp";
  static const String veryfiOTPresend = "/auth/forgot-resend";
  static const String login = "/auth/login";
  static const String forgetPassword = "/auth/forgot-password";
  static String setNewPassword({required String email}) =>
      "/auth/reset-password?email=$email";

  /// ================== Global =============

  static const String getProfile = "/auth/profile";
  static const String changePassword = "/auth/change-password";
  static const String privacyPolicy = "/dashboard/get-privacy-policy";
  static const String termsCondition = "/dashboard/get-rules";
  static String deleteAccount({required String userId}) =>
      "/auth/delete-account?authId=$userId";

  /// ==================   candidate part =============

  static const String updateCandidateProfile = "/auth/user/edit-profile";
  static const String getSavedJobs = "/jobs/get_user_favorites_jobs";
  static const String getCategories = "/jobs/get_category_&count_jobs";

  static String filterJobCatagory({required String categorisId}) =>
      '/jobs/get_search_filter?page=1&limit=10&category=[ "$categorisId"]';

  static String toggleSavedJob({required String jobId}) =>
      "/jobs/toggle_favorite/$jobId";
  static String allApplyedJobs({required int currentPage}) =>
      "/jobs/get_all_apply_candidate?page=$currentPage&limit=20";

  static String getCandidateAllJobs({
    required int currentPage,
    required String authId,
  }) => "/jobs/get_recent_jobs?authId=$authId&limit=10&page=$currentPage";

  /// ==================  employer part =============

  static const String updateEmployerProfile = "/auth/employer/edit-profile";
  static const String getSavedCandidate = "/jobs/get_favorites_user_list";
  static String toggleSaved({required String userId}) =>
      "/jobs/toggle_user_favorite/$userId";
  static String getEmployerAllJobs({required int currentPage}) =>
      "/jobs/all/employer?page=$currentPage&limit=10";
  static String getApplyedCandidate({
    required int currentPage,
    required String jobId,
  }) => "/jobs/applications?page=$currentPage&limit=10&jobId=$jobId";

  static String userDetails({required String userId}) =>
      "/jobs/get_user_profile_details/$userId";

  ///============================= not need ===================================

  static const String mailForgetOtp = "/auth/forget-password/send-otp";
  static const String getCustomerProfile = "/users/me";
  static const String resetPassword = "/user/auth/reset-password";
  static const String farmaciesNearby = "/farmacies/nearby";
  static const String getServices = "/services/";
  static const String postAddToCart = "/carts/add-to-cart";
  static const String getHomeService = "/service-category/retrive/all";

  static const String aboutUs = "/about-us/retrive";
  static const String getSliderImage = "/slider/retrive/all";
  static const String getPopularService = "/service/popular/retrive";
  static const String getOffersService = "/service/offered/retrive";
  static const String getPayment = "/booking/retrive/search?query=upcomming";
  static const String postConversation = "/conversation/create";
  static const String getCategoryList = "/speciality/retrive/search";
  static const String getSubscriptionList = "/subscription/retrive/search";
  static const String getPopularTherapist = "/user/retrive/therapists/popular";
  static String getTherapistBySpeciality({
    required String specialityId,
    required int currentPage,
  }) =>
      "/user/retrive/therapists/speciality/$specialityId?page=$currentPage&limit=12";
  static const String postAppointment = "/appointment/create";
  static String getInvoiceByAppointmentId({required String appointmentId}) =>
      "/invoice/retrieve/appointment/$appointmentId";
  static const String postContactUs = "/contact-us/send-email";
  static String getRecommendService({required String cetagoryId}) =>
      "/outlet/retrive/recommended/category/$cetagoryId/search";
  static String getOutletByService({required String cetagoryId}) =>
      "/outlet/retrive/category/$cetagoryId/search";
  static String getSearchServiceOutlet({
    required String userId,
    required String searchText,
  }) => "/outlet/retrive/category/$userId/search?query=$searchText";
  static String getServiceOutlet({required String userId}) =>
      "/outlet/retrive/category/$userId/search";
  static String getUserProfile({required String userId}) =>
      "/user/retrive/$userId";
  static String getTherapistRegister({required String userId}) =>
      "/user/retrive/$userId";
  static String updateUserProfile({required String userId}) =>
      "/user/update/$userId";
  static String getInvoice({required String userId}) =>
      "/invoice/retrive/user/$userId/search";
  static String getInvoiceByUser({required String userId}) =>
      "/invoice/retrive/$userId";
  static String getPaymentHistory({required String userId}) =>
      "/payment-history/retrive/user/$userId";
  static String getServiceByOutlet({required String outlateId}) =>
      "/service/retrive/for-user/outlet/$outlateId";
  static String getOrderHistory({required String userId}) =>
      "/booking/retrive/user/$userId";
  static String getNotification({required String userId}) =>
      "/notification/retrive/consumer/$userId";
  static String updateTherapistProfile({required String userId}) =>
      "/user/update/$userId";
  static String dismisSingleNotification({required String notificationId}) =>
      '/notification/dismiss/$notificationId';

  static String clearAllNotification({required String userId}) =>
      '/notification/clear/consumer/$userId';
  static String getMessage({required String userId}) =>
      "/message/retrieve/$userId";
  static String delReason({required String appointmentId}) =>
      "/appointment/cancel/after-approval/$appointmentId";
  static String getConversationByUser({required String conversationId}) =>
      "/conversation/retrive/$conversationId";
  static String getSearchInvoce({required String text}) =>
      "/invoice/retrive/user/678f908a41bd1b6dcc108946/search?query=$text";

  static String deleteUser({required String userId}) => "/user/delete/$userId";
  static String getWallet({required String userId}) =>
      "/wallet/retrive/user/$userId";
  static String updateProfile({required String userId}) =>
      "/user/update/$userId";
  // static String updateProfileImage ({required String userId}) => '/user/update/profile-picture/67b813b7421435769e24e547';
  static String updateProfileImage({required String userId}) =>
      "/user/update/profile-picture/$userId";
  static String getDrugsCategory({required String categoriesName}) =>
      "/drugs/category/$categoriesName";
  static String getSingleDrugs({required String userId}) => "/drugs/$userId";
  static String getSearchService({required String text}) =>
      "/service/retrive/search?query=$text";
  static String getAppointment({
    required String userId,
    required String role,
    required String status,
  }) =>
      "/appointment/retrive/$userId?role=$role&appointmentStatus=$status&page=1&limit=100";

  //============================= Send Message =======================

  static String sendMessage = '/message/send';

  ///========================= salon api all implementation =========================
  static String salonProfileShow({required String outletId}) =>
      "/outlet/retrive/$outletId";

  ///========================= salon userProfile update implementation =========================
  static String userProfileUpdate({required String outletId}) =>
      "/outlet/update/$outletId";

  ///========================= salon cover photos update implementation =========================
  static String coverPhotosUpdate({required String outletId}) =>
      "/outlet/change/cover/$outletId";

  ///========================= salon scheduleByDay api implementation =========================

  static String scheduleByDay({required String outletId}) =>
      "/schedule/retrive/$outletId";

  ///========================= salon Service manager api implementation =========================
  static String serviceRetriveById({required String outletId}) =>
      "/service/retrive/outlet/$outletId";

  ///========================= salon Service manager api implementation =========================
  static String serviceCreate = "/service/create";

  ///========================= salon userPhotosUpdate  api implementation =========================
  static String userPhotosUpdate({required String outletId}) =>
      "/outlet/change/profile/$outletId";

  ///========================= salon Service Update api implementation =========================

  static String serviceUpdate({required String serviceId}) =>
      "/service/update/$serviceId";

  ///========================= salon upcomming Booking Show api implementation =========================
  static String upcommingBookingShow({
    required String outletId,
    required String date,
  }) => "/booking/upcomming/retrive/outlet/$outletId?date=$date";

  ///========================= earning retrive outlet  api implementation =========================
  static String earningOutlet({required String outletId}) =>
      "/earning/retrive/outlet/$outletId";

  ///========================= earning retrive outlet  api implementation =========================
  static String earningCompleted = "/booking/retrive/search?query=completed";

  ///========================= feedback retrive   api implementation =========================
  ///
  static String feedbackReview({required String outletId}) =>
      "/feedback/retrive/all/outlet/$outletId";

  ///========================= salon scheduleBy Day create api implementation =========================
  static String createDaySlots = "/schedule/create-or-update";

  // user //  Booking service =====================================

  static const String createBooking = "/booking/create";

  //============================= Wish list ==========================

  static const String addWishList =
      "/wishlist/add-to-wishlist"; // add to wish list
  static String getWishList({required String userId}) =>
      "/wishlist/retrive/user/$userId"; // Get wish list
  static String deleteWishList({required String userId}) => "/wishlist/delete";

  //============================= Next Appointment ==========================

  static String nextAppointment({required String userId}) =>
      "/booking/upcomming/retrive/user/$userId";
  static String acceptedAppointment({required String appointmentID}) =>
      "/appointment/accept/$appointmentID";

  static String acceptedAllAppointmentbyTherapist({required String userID}) =>
      "/appointment/retrive/$userID?role=therapist&appointmentStatus=approved";
  static String allToadyAppointments({required String userID}) =>
      "/appointment/retrive/todays/approved/$userID";
  //static String getNotification({required String userId}) => "/notification/user/$userId";

  //============================== Reschedule Booking =========================
  static String rescheduleBooking({required String bookingId}) =>
      "/booking/reschedule/$bookingId";

  //======================================= Messaqge ===============================

  static String getConversationByUserid({required String userID}) =>
      "/conversation/retrive/$userID";
  static String getNessage({required String conversationId}) =>
      "/message/retrive/$conversationId";
  static String createConversation({required String appointmentID}) =>
      '/conversation/retrive/specific/$appointmentID';

  //=============================== Amount Top up ==================== >>

  static const String amountTopUp = '/wallet/initiate-top-up';
}
