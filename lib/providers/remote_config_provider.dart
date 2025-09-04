import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class RemoteConfigProvider extends ChangeNotifier {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  bool _isInitialized = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Default values
  static const Map<String, dynamic> _defaults = {
    'app_version_required': '1.0.0',
    'maintenance_mode': false,
    'maintenance_message': 'Приложение временно недоступно для обслуживания',
    'max_image_upload_size_mb': 10,
    'enable_comments': false,
    'enable_push_notifications': false,
    'feed_posts_limit': 20,
    'popular_posts_limit': 20,
    'max_post_images': 5,
    'profanity_filter_enabled': true,
    'welcome_message': 'Добро пожаловать в TasteSmoke!',
    'support_email': 'support@tastesmoke.app',
    'terms_url': 'https://tastesmoke.app/terms',
    'privacy_url': 'https://tastesmoke.app/privacy',
  };

  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Getters for config values
  String get appVersionRequired => _remoteConfig.getString('app_version_required');
  bool get maintenanceMode => _remoteConfig.getBool('maintenance_mode');
  String get maintenanceMessage => _remoteConfig.getString('maintenance_message');
  int get maxImageUploadSizeMb => _remoteConfig.getInt('max_image_upload_size_mb');
  bool get enableComments => _remoteConfig.getBool('enable_comments');
  bool get enablePushNotifications => _remoteConfig.getBool('enable_push_notifications');
  int get feedPostsLimit => _remoteConfig.getInt('feed_posts_limit');
  int get popularPostsLimit => _remoteConfig.getInt('popular_posts_limit');
  int get maxPostImages => _remoteConfig.getInt('max_post_images');
  bool get profanityFilterEnabled => _remoteConfig.getBool('profanity_filter_enabled');
  String get welcomeMessage => _remoteConfig.getString('welcome_message');
  String get supportEmail => _remoteConfig.getString('support_email');
  String get termsUrl => _remoteConfig.getString('terms_url');
  String get privacyUrl => _remoteConfig.getString('privacy_url');

  Future<void> initialize() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Set default values
      await _remoteConfig.setDefaults(_defaults);

      // Configure settings
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      // Fetch and activate
      await _remoteConfig.fetchAndActivate();

      _isInitialized = true;
      _isLoading = false;

      // Log analytics event
      await _analytics.logEvent(
        name: 'remote_config_initialized',
        parameters: {
          'maintenance_mode': maintenanceMode,
          'comments_enabled': enableComments,
        },
      );

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      _isInitialized = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _remoteConfig.fetchAndActivate();

      _isLoading = false;
      notifyListeners();

      // Log refresh event
      await _analytics.logEvent(name: 'remote_config_refreshed');
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper methods
  bool isFeatureEnabled(String feature) {
    switch (feature) {
      case 'comments':
        return enableComments;
      case 'push_notifications':
        return enablePushNotifications;
      case 'profanity_filter':
        return profanityFilterEnabled;
      default:
        return false;
    }
  }

  Map<String, dynamic> getAllConfig() {
    return {
      'app_version_required': appVersionRequired,
      'maintenance_mode': maintenanceMode,
      'maintenance_message': maintenanceMessage,
      'max_image_upload_size_mb': maxImageUploadSizeMb,
      'enable_comments': enableComments,
      'enable_push_notifications': enablePushNotifications,
      'feed_posts_limit': feedPostsLimit,
      'popular_posts_limit': popularPostsLimit,
      'max_post_images': maxPostImages,
      'profanity_filter_enabled': profanityFilterEnabled,
      'welcome_message': welcomeMessage,
      'support_email': supportEmail,
      'terms_url': termsUrl,
      'privacy_url': privacyUrl,
    };
  }
}
