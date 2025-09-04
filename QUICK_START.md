# 🚀 Быстрый старт TasteSmoke Flutter

## Что уже готово

✅ **Полнофункциональное Flutter приложение**
✅ **iOS сборка через GitHub Actions** 
✅ **AltStore установка без jailbreak**
✅ **Firebase интеграция**
✅ **Все экраны и функции**

## 3 простых шага для запуска

### 1️⃣ Настройте Firebase (5 минут)

```bash
# Создайте проект на https://console.firebase.google.com
# Включите: Authentication, Firestore, Storage, Analytics
# Скачайте GoogleService-Info.plist в ios/Runner/
```

### 2️⃣ Запустите сборку (автоматически)

```bash
git add .
git commit -m "Initial TasteSmoke Flutter app"
git push origin main
# GitHub Actions автоматически создаст .ipa файл
```

### 3️⃣ Установите на iPhone (10 минут)

```bash
# 1. Установите iTunes + iCloud от Apple (не из Microsoft Store)
# 2. Установите AltServer с altstore.io
# 3. Подключите iPhone → AltServer → Install AltStore
# 4. Скачайте .ipa из GitHub Actions → установите через AltStore
```

## 📱 Что получите

- **Регистрация/вход** с email верификацией
- **Лента постов** с изображениями и лайками  
- **Профиль** с загрузкой аватара
- **Популярные посты** и избранное
- **Настройки** и управление аккаунтом
- **Офлайн режим** и кэширование
- **Analytics** и Remote Config

## 🔧 Структура файлов

```
tastesmoke_flutter/
├── 📱 lib/                    # Код приложения
├── 🍎 ios/                    # iOS конфигурация  
├── ⚙️ .github/workflows/      # GitHub Actions
├── 📚 README.md               # Полная документация
├── 📖 ALTSTORE_INSTALL_GUIDE.md # Установка на iPhone
└── 🚀 DEPLOYMENT.md           # Развертывание
```

## ⚡ Команды разработки

```bash
# Установка зависимостей
flutter pub get
cd ios && pod install && cd ..

# Запуск приложения
flutter run

# Тесты
flutter test

# Сборка для iOS (локально на macOS)
flutter build ios --release
```

## 🎯 Важные ограничения

- **7 дней** - срок действия подписи с бесплатным Apple ID
- **3 приложения** - максимум одновременно на устройстве  
- **Нет push уведомлений** без платного Apple Developer Program
- **Переподпись каждые ~7 дней** через AltStore

## 🆘 Если что-то не работает

1. **Сборка не запускается** → проверьте GitHub Actions
2. **Firebase ошибки** → обновите `firebase_options.dart`
3. **AltStore проблемы** → перезапустите iTunes/iCloud
4. **iPhone не устанавливает** → проверьте доверие разработчику

## 📞 Поддержка

- **Документация:** README.md, DEPLOYMENT.md
- **Установка:** ALTSTORE_INSTALL_GUIDE.md  
- **GitHub Issues** для багов и вопросов

---

**🎉 Готово! Ваше приложение TasteSmoke работает на iPhone без jailbreak!**
