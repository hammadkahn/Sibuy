import 'package:flutter/material.dart';
import 'package:SiBuy/providers/chat_provider.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/providers/order.dart';
import 'package:provider/provider.dart';

import 'constant/theme.dart';
import 'user_app/splash_screen/splash.dart';
import 'user_app/splash_screen/splashh.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DealProvider()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        home: const user_splash(),
      ),
    );
  }
}
