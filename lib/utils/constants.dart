class AppConstants {
  // App Info
  static const String appName = 'TasteSmoke';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Делись рецептами, находи вдохновение';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String postsCollection = 'posts';
  static const String commentsCollection = 'comments';
  static const String likesCollection = 'likes';
  static const String reportsCollection = 'reports';

  // Storage Paths
  static const String avatarsPath = 'avatars';
  static const String postImagesPath = 'post_images';
  static const String tempPath = 'temp';

  // Limits
  static const int maxPostImages = 5;
  static const int maxImageSizeMB = 10;
  static const int maxPostTitleLength = 100;
  static const int maxPostDescriptionLength = 1000;
  static const int maxRecipeLength = 5000;
  static const int maxIngredients = 20;
  static const int maxTags = 10;
  static const int feedPostsLimit = 20;
  static const int popularPostsLimit = 20;
  static const int maxUsernameLength = 30;
  static const int maxBioLength = 200;

  // Validation
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const int minPasswordLength = 6;
  static const int minUsernameLength = 2;

  // Image Settings
  static const int imageQuality = 80;
  static const int maxImageWidth = 1080;
  static const int maxImageHeight = 1080;
  static const int avatarSize = 512;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration uploadTimeout = Duration(minutes: 5);

  // Cache
  static const Duration imageCacheDuration = Duration(days: 7);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // URLs
  static const String termsUrl = 'https://tastesmoke.app/terms';
  static const String privacyUrl = 'https://tastesmoke.app/privacy';
  static const String supportEmail = 'support@tastesmoke.app';
  static const String websiteUrl = 'https://tastesmoke.app';

  // Error Messages
  static const String networkError = 'Проблемы с подключением к интернету';
  static const String unknownError = 'Произошла неизвестная ошибка';
  static const String authError = 'Ошибка аутентификации';
  static const String permissionError = 'Недостаточно прав доступа';
  static const String validationError = 'Ошибка валидации данных';

  // Success Messages
  static const String loginSuccess = 'Вход выполнен успешно';
  static const String registerSuccess = 'Регистрация прошла успешно';
  static const String profileUpdated = 'Профиль обновлен';
  static const String postCreated = 'Пост создан';
  static const String postUpdated = 'Пост обновлен';
  static const String postDeleted = 'Пост удален';

  // Shared Preferences Keys
  static const String keyFirstLaunch = 'first_launch';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyLastSyncTime = 'last_sync_time';
  static const String keyUserPreferences = 'user_preferences';

  // Analytics Events
  static const String eventAppOpen = 'app_open';
  static const String eventLogin = 'login';
  static const String eventRegister = 'register';
  static const String eventLogout = 'logout';
  static const String eventViewPost = 'view_post';
  static const String eventLikePost = 'like_post';
  static const String eventSharePost = 'share_post';
  static const String eventCreatePost = 'create_post';
  static const String eventUpdateProfile = 'update_profile';

  // Remote Config Keys
  static const String rcMaintenanceMode = 'maintenance_mode';
  static const String rcMaintenanceMessage = 'maintenance_message';
  static const String rcMinAppVersion = 'min_app_version';
  static const String rcMaxImageSize = 'max_image_size_mb';
  static const String rcEnableComments = 'enable_comments';
  static const String rcEnablePushNotifications = 'enable_push_notifications';
  static const String rcProfanityFilterEnabled = 'profanity_filter_enabled';
}
