import 'package:flutter/material.dart';
import 'package:SiBuy/providers/chat_provider.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/providers/order.dart';
import 'package:provider/provider.dart';

import 'constant/theme.dart';

import 'user_app/splash_screen/splashh.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DealProvider()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SiBuy365',
        theme: theme(),
        home: const UserSplash(),
      ),
    );
  }
}
