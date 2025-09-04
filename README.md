# TasteSmoke Flutter

Flutter-версия приложения TasteSmoke с полным паритетом функций Android-версии и поддержкой iOS через сайдлоад.

## Особенности

- 🔥 Firebase интеграция (Auth, Firestore, Storage, Analytics, Remote Config)
- 📱 Кроссплатформенность (iOS/Android)
- 🎨 Современный Material Design UI
- 📸 Загрузка и кэширование изображений
- 💾 Офлайн поддержка
- 🔐 Email аутентификация с верификацией

## Структура проекта

```
lib/
├── main.dart                 # Точка входа приложения
├── firebase_options.dart     # Firebase конфигурация
├── models/                   # Модели данных
│   └── post_model.dart
├── providers/                # State management (Provider)
│   ├── auth_provider.dart
│   ├── feed_provider.dart
│   └── profile_provider.dart
├── screens/                  # Экраны приложения
│   ├── auth/
│   ├── feed/
│   ├── popular/
│   ├── likes/
│   ├── profile/
│   └── main_navigation.dart
└── widgets/                  # Переиспользуемые виджеты
    └── post_card.dart
```

## Установка для разработки

### Предварительные требования

- Flutter SDK 3.16.0+
- Dart 3.0.0+
- Xcode 15+ (для iOS)
- CocoaPods

### Настройка проекта

1. Клонируйте репозиторий
2. Перейдите в папку проекта:
   ```bash
   cd tastesmoke_flutter
   ```

3. Установите зависимости:
   ```bash
   flutter pub get
   ```

4. Для iOS установите CocoaPods зависимости:
   ```bash
   cd ios
   pod install
   cd ..
   ```

5. Настройте Firebase:
   - Создайте проект в Firebase Console
   - Добавьте iOS и Android приложения
   - Скачайте `google-services.json` для Android
   - Скачайте `GoogleService-Info.plist` для iOS
   - Поместите файлы в соответствующие папки

## Сборка iOS IPA через GitHub Actions

### Автоматическая сборка

Проект настроен для автоматической сборки .ipa файлов через GitHub Actions на macOS раннерах.

**Workflow запускается:**
- При пуше в ветку `main`
- При создании Pull Request
- Вручную через `workflow_dispatch`

**Процесс сборки:**
1. Настройка Flutter окружения
2. Установка зависимостей (`flutter pub get`)
3. Установка CocoaPods (`pod install`)
4. Сборка iOS приложения без подписи
5. Создание .ipa файла
6. Загрузка артефакта в GitHub Actions

### Получение IPA файла

1. Перейдите в раздел **Actions** вашего GitHub репозитория
2. Выберите последний успешный workflow run
3. Скачайте артефакт `ios-ipa`
4. Распакуйте архив - получите `app-release.ipa`

## Установка на iPhone через AltStore (Windows)

### Подготовка Windows ПК

1. **Установите iTunes и iCloud от Apple:**
   - Скачайте с официального сайта Apple (НЕ из Microsoft Store)
   - iTunes: https://www.apple.com/itunes/download/
   - iCloud: https://support.apple.com/en-us/HT204283

2. **Установите AltServer:**
   - Скачайте с https://altstore.io/
   - Запустите установщик
   - После установки AltServer появится в системном трее

### Установка AltStore на iPhone

1. **Подключите iPhone к ПК через USB кабель**
2. **Доверьте компьютеру на iPhone** (если появится запрос)
3. **В AltServer (системный трей) выберите:**
   - Install AltStore → [Ваш iPhone]
4. **Введите Apple ID и пароль** (данные не сохраняются, используются только для подписи)
5. **На iPhone появится AltStore** - установите его как обычное приложение

### Установка TasteSmoke IPA

1. **Скачайте app-release.ipa** из GitHub Actions на iPhone
2. **Откройте AltStore на iPhone**
3. **Перейдите в "My Apps"**
4. **Нажмите "+" в верхнем углу**
5. **Выберите скачанный app-release.ipa файл**
6. **Дождитесь установки приложения**

### Доверие разработчику

1. **Откройте Настройки → Основные → VPN и управление устройством**
2. **Найдите профиль с вашим Apple ID**
3. **Нажмите "Доверять [Apple ID]"**
4. **Подтвердите доверие**

## Важные ограничения бесплатного Apple ID

### Лимиты подписи
- ⏰ **Подпись действует 7 дней** - приложение перестанет запускаться
- 📱 **Максимум 3 приложения** одновременно на устройстве
- 🔄 **Требуется переподпись** каждые ~7 дней

### Автоматическое обновление подписи

**Через Wi-Fi (рекомендуется):**
1. Оставьте AltServer запущенным на ПК
2. Убедитесь, что iPhone и ПК в одной Wi-Fi сети
3. AltStore автоматически обновит подпись в фоне

**Вручную:**
1. Подключите iPhone к ПК через USB
2. Откройте AltStore → My Apps
3. Нажмите "Refresh" рядом с приложением

## Функциональные возможности

### ✅ Реализовано
- Email регистрация и вход
- Email верификация
- Лента постов с изображениями
- Популярные посты (сортировка по лайкам)
- Избранные посты пользователя
- Лайки и дизлайки постов
- Профиль пользователя с аватаром
- Загрузка и обновление аватара
- Кэширование изображений
- Офлайн режим Firestore
- Firebase Analytics
- Firebase Remote Config
- Настройки приложения

### 🚧 В разработке
- Push уведомления (требует Apple Developer Program)
- Создание новых постов
- Комментарии к постам
- Поиск по постам и пользователям
- Подписки на пользователей
- Темная тема
- Локализация

## Firebase Services

### Используемые сервисы
- **Authentication** - Email/пароль аутентификация
- **Firestore** - База данных постов и пользователей  
- **Storage** - Хранение изображений (посты, аватары)
- **Analytics** - Аналитика использования приложения
- **Remote Config** - Удаленная конфигурация параметров

### Не требуют Apple Developer Program
- ✅ Authentication
- ✅ Firestore
- ✅ Storage  
- ✅ Analytics
- ✅ Remote Config

### Требуют Apple Developer Program
- ❌ Push Notifications (FCM + APNs)
- ❌ TestFlight распространение
- ❌ App Store публикация

## Переход на Apple Developer Program

При готовности оформить платную подписку Apple Developer Program ($99/год):

1. **Настройте APNs ключ** в Firebase для push уведомлений
2. **Обновите GitHub Actions** для автоматической подписи
3. **Настройте Provisioning Profiles** для распространения
4. **Переключитесь на TestFlight** для бета-тестирования
5. **Подготовьте к публикации** в App Store

## Поддержка

При возникновении проблем:
1. Проверьте логи сборки в GitHub Actions
2. Убедитесь в корректности Firebase конфигурации
3. Проверьте версии Flutter и Xcode
4. Обновите CocoaPods зависимости

## Лицензия

MIT License - см. файл LICENSE для деталей.
