import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tastesmoke_flutter/main.dart';

void main() {
  testWidgets('App starts with auth screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TasteSmokeApp());

    // Verify that auth screen is displayed
    expect(find.text('TasteSmoke'), findsOneWidget);
    expect(find.text('Делись рецептами, находи вдохновение'), findsOneWidget);
    expect(find.text('Вход'), findsOneWidget);
    expect(find.text('Регистрация'), findsOneWidget);
  });

  testWidgets('Login form validation', (WidgetTester tester) async {
    await tester.pumpWidget(const TasteSmokeApp());

    // Find login button and tap it without filling fields
    final loginButton = find.text('Войти');
    await tester.tap(loginButton);
    await tester.pump();

    // Should show validation errors
    expect(find.text('Введите email'), findsOneWidget);
    expect(find.text('Введите пароль'), findsOneWidget);
  });

  testWidgets('Switch between login and register tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const TasteSmokeApp());

    // Initially on login tab
    expect(find.text('Войти'), findsOneWidget);

    // Tap register tab
    await tester.tap(find.text('Регистрация'));
    await tester.pump();

    // Should show register form
    expect(find.text('Зарегистрироваться'), findsOneWidget);
    expect(find.text('Имя'), findsOneWidget);
    expect(find.text('Подтвердите пароль'), findsOneWidget);
  });
}
