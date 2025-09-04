# Changelog

All notable changes to TasteSmoke Flutter will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-01

### Added
- Initial release of TasteSmoke Flutter app
- Email authentication with verification
- User registration and login
- Feed screen with posts display
- Popular posts screen sorted by likes
- Likes/Favorites screen for user's liked posts
- User profile with avatar upload
- Settings screen with app preferences
- Firebase integration:
  - Authentication
  - Firestore database
  - Storage for images
  - Analytics
  - Remote Config
- iOS support with AltStore installation
- GitHub Actions for automated iOS builds
- Cached network images for better performance
- Offline support with Firestore
- Material Design 3 UI
- Russian localization
- Comprehensive error handling
- Form validation
- Image picker for avatars and posts
- Post likes/unlikes functionality
- User profile editing
- Settings management

### Technical Features
- Provider state management
- Firebase SDK integration
- iOS ExportOptions.plist for IPA generation
- GitHub Actions workflow for macOS builds
- AltStore deployment support
- Comprehensive test coverage
- Analytics integration
- Remote configuration
- Constants and utilities
- Input validation
- Helper functions
- Error handling

### Documentation
- Comprehensive README.md
- AltStore installation guide
- Deployment instructions
- Firebase setup guide
- GitHub Actions configuration
- Code documentation

### Security
- Firebase security rules
- Input validation
- Secure authentication
- Image upload restrictions
- Profanity filtering support

### Performance
- Image caching
- Lazy loading
- Optimized builds
- Efficient state management
- Memory management

## [Unreleased]

### Planned Features
- Push notifications (requires Apple Developer Program)
- Post creation and editing
- Comments system
- Search functionality
- User following/followers
- Dark theme
- Multiple language support
- Advanced image editing
- Recipe sharing
- Ingredient management
- Cooking timers
- Meal planning
- Social features
- Content moderation
- Admin panel

### Known Issues
- Push notifications not available without Apple Developer Program
- Limited to 3 apps with free Apple ID
- App signature expires every 7 days with AltStore
- No background app refresh without paid developer account

### Breaking Changes
None in this release.

### Migration Guide
This is the initial release, no migration required.
