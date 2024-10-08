import 'package:bandu/routes/app_router.dart';
import 'package:bandu/screens/ai_chat/ai_chat_provider.dart';
import 'package:bandu/screens/home/home_gantt/home_gantt_provider.dart';
import 'package:bandu/services/SharedPref.dart';
import 'package:bandu/services/db_manager.dart';
import 'package:bandu/services/gemini_manager.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'constants/BUTheme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPref.instance.init();
  await AuthManager.instance.init();
  await GeminiManager.instance.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) {
        Ai_chatProvider ai_chatProvider = Ai_chatProvider();
        ai_chatProvider.init();
        return ai_chatProvider;
      },
    ),
    ChangeNotifierProvider(create: (_) => Home_ganttProvider()..init()),
  ], child: const MyApp()));
}

final appRouter = AppRouter();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final lightTheme = BUTheme.lightTheme;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
        ));
  }
}
