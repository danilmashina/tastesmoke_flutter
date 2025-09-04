import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/main_navigation.dart';
import 'providers/auth_provider.dart';
import 'providers/feed_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/remote_config_provider.dart';
import 'services/analytics_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Log app open event
  await AnalyticsService.logAppOpen();
  
  runApp(const TasteSmokeApp());
}

class TasteSmokeApp extends StatelessWidget {
  const TasteSmokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => RemoteConfigProvider()..initialize()),
      ],
      child: MaterialApp(
        title: 'TasteSmoke',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          useMaterial3: true,
        ),
        navigatorObservers: [AnalyticsService.observer],
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            
            if (authProvider.user == null) {
              return const AuthScreen();
            }
            
            return const MainNavigation();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
