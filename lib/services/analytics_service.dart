import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver _observer = FirebaseAnalyticsObserver(analytics: _analytics);

  static FirebaseAnalyticsObserver get observer => _observer;

  // User Events
  static Future<void> logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  static Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  static Future<void> logLogout() async {
    await _analytics.logEvent(name: 'logout');
  }

  // Post Events
  static Future<void> logViewPost(String postId, String authorId) async {
    await _analytics.logEvent(
      name: 'view_post',
      parameters: {
        'post_id': postId,
        'author_id': authorId,
      },
    );
  }

  static Future<void> logLikePost(String postId, String authorId) async {
    await _analytics.logEvent(
      name: 'like_post',
      parameters: {
        'post_id': postId,
        'author_id': authorId,
      },
    );
  }

  static Future<void> logUnlikePost(String postId, String authorId) async {
    await _analytics.logEvent(
      name: 'unlike_post',
      parameters: {
        'post_id': postId,
        'author_id': authorId,
      },
    );
  }

  static Future<void> logSharePost(String postId, String method) async {
    await _analytics.logShare(
      contentType: 'post',
      itemId: postId,
      method: method,
    );
  }

  // Profile Events
  static Future<void> logUpdateProfile() async {
    await _analytics.logEvent(name: 'update_profile');
  }

  static Future<void> logUpdateAvatar() async {
    await _analytics.logEvent(name: 'update_avatar');
  }

  // Feed Events
  static Future<void> logViewFeed(String feedType) async {
    await _analytics.logEvent(
      name: 'view_feed',
      parameters: {
        'feed_type': feedType, // 'home', 'popular', 'likes'
      },
    );
  }

  static Future<void> logRefreshFeed(String feedType) async {
    await _analytics.logEvent(
      name: 'refresh_feed',
      parameters: {
        'feed_type': feedType,
      },
    );
  }

  // Search Events
  static Future<void> logSearch(String searchTerm, int resultsCount) async {
    await _analytics.logSearch(
      searchTerm: searchTerm,
      numberOfNights: null,
      numberOfRooms: null,
      numberOfPassengers: null,
      origin: null,
      destination: null,
      startDate: null,
      endDate: null,
      travelClass: null,
    );
    
    await _analytics.logEvent(
      name: 'search_results',
      parameters: {
        'search_term': searchTerm,
        'results_count': resultsCount,
      },
    );
  }

  // App Events
  static Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  static Future<void> logScreenView(String screenName, String screenClass) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  // Error Events
  static Future<void> logError(String error, String location) async {
    await _analytics.logEvent(
      name: 'app_error',
      parameters: {
        'error_message': error,
        'error_location': location,
      },
    );
  }

  // Custom Events
  static Future<void> logCustomEvent(String eventName, Map<String, dynamic>? parameters) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  // User Properties
  static Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  static Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  // Settings Events
  static Future<void> logChangeSettings(String settingName, dynamic oldValue, dynamic newValue) async {
    await _analytics.logEvent(
      name: 'change_settings',
      parameters: {
        'setting_name': settingName,
        'old_value': oldValue.toString(),
        'new_value': newValue.toString(),
      },
    );
  }

  // Performance Events
  static Future<void> logPerformance(String action, int durationMs) async {
    await _analytics.logEvent(
      name: 'performance',
      parameters: {
        'action': action,
        'duration_ms': durationMs,
      },
    );
  }
}
