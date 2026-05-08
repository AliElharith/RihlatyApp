// ignore_for_file: constant_identifier_names

class AppConstants {
  // ============================================
  // Backend Configuration
  // ============================================
  // IMPORTANT: These should be set via environment variables or BuildConfig
  // NEVER hardcode sensitive credentials in source code
  
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://eoummwkbnitxn.supabase.com',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_I82K0Ve1wt14kWdtHe6QHA_y3tLlEwS',
  );
  
  static const String mapsApiKey = String.fromEnvironment(
    'MAPS_API_KEY',
    defaultValue: 'joH9s6UVgKaNlFpKBHhE',
  );
  
  // ============================================
  // API Configuration
  // ============================================
  static const int readTimeout = 30000; // milliseconds
  static const int writeTimeout = 30000; // milliseconds
  static const int connectionTimeout = 15000; // milliseconds
  
  // Location & Maps
  static const double searchRadius = 5.0; // km
  static const double defaultZoom = 15.0;
  static const int maxSearchResults = 10;
  
  // Trip Management
  static const int tripRequestTimeout = 15; // seconds
  static const int maxTripsPerDriver = 5;
  static const int maxRejectionCount = 5;
  static const double rejectionPenalty = 0.3; // 30% penalty
  
  // Pricing
  static const double baseCommissionRate = 0.1; // 10%
  static const double baseFare = 5.0; // base fare
  static const double pricePerKm = 2.0; // price per kilometer
  
  // OTP
  static const int otpLength = 4;
  static const int otpExpirySeconds = 300; // 5 minutes
  
  // Validation
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  
  // File Upload
  static const int maxImageSize = 5242880; // 5 MB
  static const int maxFileSize = 10485760; // 10 MB
  
  // Pagination
  static const int pageSize = 20;
  
  // Retry Configuration
  static const int maxRetries = 3;
  static const int retryDelayMs = 1000;
  
  // User Roles
  static const String roleDriver = 'driver';
  static const String roleMerchant = 'merchant';
  static const String roleAdmin = 'admin';
  
  // Trip Status
  static const String tripStatusPending = 'pending';
  static const String tripStatusAccepted = 'accepted';
  static const String tripStatusInProgress = 'in_progress';
  static const String tripStatusCompleted = 'completed';
  static const String tripStatusCancelled = 'cancelled';
  
  // Driver Status
  static const String driverStatusOnline = 'online';
  static const String driverStatusOffline = 'offline';
  static const String driverStatusBusy = 'busy';
  
  // Notification Types
  static const String notificationTypeNewTrip = 'new_trip';
  static const String notificationTypeTripCancelled = 'trip_cancelled';
  static const String notificationTypePaymentReceived = 'payment_received';
  static const String notificationTypeAccountApproved = 'account_approved';
  static const String notificationTypeDriverFound = 'driver_found';
  static const String notificationTypeDriverArrived = 'driver_arrived';
  static const String notificationTypeTripStarted = 'trip_started';
  static const String notificationTypeTripCompleted = 'trip_completed';
  
  // Rating
  static const double minRating = 0.0;
  static const double maxRating = 5.0;
  static const int minRatingsForBadge = 50;
  static const double minRatingForBadge = 4.5;
  
  // Trial Period
  static const int trialPeriodDays = 30;
  
  // Shared Preferences Keys
  static const String prefUserId = 'user_id';
  static const String prefUserRole = 'user_role';
  static const String prefUserName = 'user_name';
  static const String prefUserPhone = 'user_phone';
  static const String prefFcmToken = 'fcm_token';
  static const String prefThemeMode = 'theme_mode';
  static const String prefLanguage = 'language';
  static const String prefIsLoggedIn = 'is_logged_in';
  
  // Error Messages
  static const String errorNetworkConnection = 'خطأ في الاتصال بالإنترنت';
  static const String errorServerError = 'حدث خطأ في الخادم';
  static const String errorUnauthorized = 'غير مصرح لك بهذا الإجراء';
  static const String errorNotFound = 'لم يتم العثور على البيانات المطلوبة';
  static const String errorInvalidInput = 'البيانات المدخلة غير صحيحة';
  static const String errorTimeout = 'انتهت مهلة الانتظار';
  
  // Success Messages
  static const String successOperationCompleted = 'تم إكمال العملية بنجاح';
  static const String successDataSaved = 'تم حفظ البيانات بنجاح';
  static const String successDataDeleted = 'تم حذف البيانات بنجاح';
  
  // Regex Patterns
  static const String phoneRegex = r'^[0-9]{10,15}$';
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String transactionIdRegex = r'^[A-Z0-9]{6,20}$';
}

class AppDimensions {
  // Padding & Margin
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  
  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  
  // Button Heights
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMedium = 44.0;
  static const double buttonHeightLarge = 52.0;
  
  // Elevation
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
}
