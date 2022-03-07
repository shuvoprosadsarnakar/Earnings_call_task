import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/audio_provider.dart';
import 'package:flutter_application_1/screens/player/player_screen.dart';
import 'package:flutter_application_1/widgets/styles/custom_theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AudioProvider>(
        create: (context) => AudioProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earning call',
      theme: CustomTheme.lightTheme,
      home: const PlayerScreen(),
    );
  }
}
