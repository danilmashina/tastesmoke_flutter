# Руководство по развертыванию TasteSmoke Flutter

## Обзор

Данное руководство описывает процесс развертывания Flutter-приложения TasteSmoke на iOS через GitHub Actions и установку на устройства через AltStore без платного Apple Developer Program.

## Архитектура развертывания

```
GitHub Repository
    ↓
GitHub Actions (macOS runner)
    ↓
Flutter Build & iOS Compilation
    ↓
IPA Generation
    ↓
Artifact Upload
    ↓
Manual Download & AltStore Installation
```

## Предварительные требования

### Для разработки:
- Flutter SDK 3.16.0+
- Xcode 15+ (для iOS сборки)
- Firebase проект с настроенными сервисами
- GitHub репозиторий с Actions

### Для установки на устройство:
- Windows ПК с iTunes и iCloud от Apple
- AltServer
- iPhone с iOS 12.2+
- Бесплатный Apple ID

## Настройка Firebase

### 1. Создание проекта Firebase

```bash
# Установите Firebase CLI
npm install -g firebase-tools

# Войдите в аккаунт
firebase login

# Инициализируйте проект
firebase init
```

### 2. Настройка сервисов

В Firebase Console включите:
- **Authentication** → Email/Password
- **Firestore Database** → Production mode
- **Storage** → Default rules
- **Analytics** → Default settings
- **Remote Config** → Default parameters

### 3. Конфигурационные файлы

Скачайте и добавьте:
- `ios/Runner/GoogleService-Info.plist` для iOS
- `android/app/google-services.json` для Android (если нужно)

### 4. Обновите firebase_options.dart

Замените значения в `lib/firebase_options.dart` на ваши:

```dart
static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'ВАШ_API_KEY',
  appId: 'ВАШ_APP_ID',
  messagingSenderId: 'ВАШ_SENDER_ID',
  projectId: 'ВАШ_PROJECT_ID',
  // ...
);
```

## Настройка GitHub Actions

### 1. Secrets

Добавьте в Settings → Secrets and variables → Actions:

```
FIREBASE_PROJECT_ID=ваш-project-id
APPLE_ID=ваш-apple-id (опционально для будущего использования)
```

### 2. Workflow файл

Workflow уже создан в `.github/workflows/ios_ipa.yml` и включает:
- Установку Flutter
- Установку CocoaPods зависимостей
- Сборку iOS приложения
- Создание IPA файла
- Загрузку артефакта

### 3. Запуск сборки

Сборка запускается:
- Автоматически при push в `main`
- Вручную через GitHub Actions → "Build iOS IPA" → "Run workflow"

## Процесс сборки

### 1. Локальная разработка

```bash
# Клонируйте репозиторий
git clone <your-repo-url>
cd tastesmoke_flutter

# Установите зависимости
flutter pub get

# Для iOS
cd ios
pod install
cd ..

# Запустите приложение
flutter run
```

### 2. Тестирование

```bash
# Запустите тесты
flutter test

# Анализ кода
flutter analyze

# Форматирование
flutter format .
```

### 3. Сборка для продакшена

```bash
# iOS (локально на macOS)
flutter build ios --release

# Создание IPA (выполняется в GitHub Actions)
flutter build ipa --release --export-options-plist=ios/Runner/ExportOptions.plist
```

## Получение IPA файла

### 1. Через GitHub Actions

1. Перейдите в репозиторий → **Actions**
2. Выберите последний успешный workflow "Build iOS IPA"
3. Скачайте артефакт **ios-ipa**
4. Распакуйте архив → получите `app-release.ipa`

### 2. Проверка сборки

Убедитесь, что workflow завершился успешно:
- ✅ Flutter setup
- ✅ Dependencies installation
- ✅ iOS build
- ✅ IPA creation
- ✅ Artifact upload

## Установка через AltStore

### 1. Подготовка Windows ПК

```powershell
# Скачайте и установите (НЕ из Microsoft Store):
# - iTunes от Apple
# - iCloud для Windows от Apple
# - AltServer с altstore.io
```

### 2. Установка AltStore на iPhone

1. Подключите iPhone к ПК через USB
2. AltServer (трей) → Install AltStore → [iPhone]
3. Введите Apple ID и пароль
4. На iPhone: Настройки → Основные → VPN и управление устройством → Доверять

### 3. Установка TasteSmoke

1. Скачайте `app-release.ipa` на iPhone
2. AltStore → My Apps → "+" → выберите IPA
3. Дождитесь установки

## Мониторинг и обслуживание

### 1. Обновление подписи

**Автоматически (рекомендуется):**
- Оставьте AltServer запущенным на ПК
- iPhone и ПК в одной Wi-Fi сети
- AltStore автоматически обновит подпись

**Вручную:**
- Каждые ~7 дней подключайте iPhone к ПК
- AltStore → My Apps → Refresh

### 2. Мониторинг ошибок

Проверяйте:
- Firebase Console → Analytics для статистики
- GitHub Actions для ошибок сборки
- Crashlytics (если настроен) для крашей

### 3. Обновления приложения

1. Внесите изменения в код
2. Обновите версию в `pubspec.yaml`
3. Push в `main` → автоматическая сборка
4. Скачайте новый IPA и переустановите

## Решение проблем

### Ошибки сборки

**Flutter build failed:**
```bash
# Очистите кэш
flutter clean
flutter pub get

# Обновите CocoaPods
cd ios
pod repo update
pod install
```

**Xcode build failed:**
- Проверьте версию Xcode в GitHub Actions
- Убедитесь в корректности bundle identifier
- Проверьте Firebase конфигурацию

### Проблемы с AltStore

**AltServer не видит iPhone:**
- Перезапустите iTunes и iCloud
- Используйте оригинальный кабель
- Перезапустите AltServer

**Ошибка установки IPA:**
- Проверьте размер файла (не более 150MB для AltStore)
- Убедитесь в корректности IPA файла
- Проверьте свободное место на iPhone

### Firebase проблемы

**Authentication не работает:**
- Проверьте настройки Authentication в Firebase Console
- Убедитесь в правильности GoogleService-Info.plist
- Проверьте bundle identifier

**Firestore недоступен:**
- Проверьте правила безопасности
- Убедитесь в инициализации Firebase
- Проверьте сетевое подключение

## Переход на Apple Developer Program

При готовности оплатить $99/год:

### 1. Регистрация

1. Зарегистрируйтесь на developer.apple.com
2. Оплатите подписку $99/год
3. Подтвердите аккаунт

### 2. Настройка сертификатов

```bash
# Создайте App ID
# Создайте Provisioning Profile
# Настройте Push Notifications (APNs)
```

### 3. Обновление CI/CD

Обновите GitHub Actions для:
- Автоматической подписи
- TestFlight загрузки
- App Store Connect интеграции

### 4. Push уведомления

Добавьте APNs ключ в Firebase для FCM:
- Firebase Console → Project Settings → Cloud Messaging
- Upload APNs key

## Безопасность

### 1. Secrets Management

- Никогда не коммитьте API ключи
- Используйте GitHub Secrets для чувствительных данных
- Регулярно ротируйте ключи

### 2. Firebase Security Rules

```javascript
// Firestore rules example
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /posts/{postId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### 3. iOS App Transport Security

Настроено в `ios/Runner/Info.plist` для HTTPS соединений.

## Производительность

### 1. Оптимизация сборки

- Используйте `--split-debug-info` для release сборок
- Включите `--obfuscate` для защиты кода
- Настройте ProGuard для Android

### 2. Оптимизация изображений

- Сжимайте изображения перед загрузкой
- Используйте WebP формат где возможно
- Настройте кэширование в Firebase Storage

### 3. Мониторинг

- Firebase Performance Monitoring
- Crashlytics для отслеживания ошибок
- Analytics для пользовательского поведения

## Поддержка

При возникновении проблем:

1. **Документация:**
   - [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
   - [Firebase Documentation](https://firebase.google.com/docs)
   - [AltStore FAQ](https://altstore.io/faq/)

2. **Сообщества:**
   - Flutter Discord
   - r/FlutterDev на Reddit
   - Stack Overflow

3. **Логи и отладка:**
   - GitHub Actions logs
   - Xcode console
   - Firebase Console

---

**Важно:** Данное руководство предназначено для разработки и тестирования. Для коммерческого использования рекомендуется Apple Developer Program.
