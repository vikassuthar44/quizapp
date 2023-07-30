import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/splash/splash_screen.dart';


class Mutable<T> {
  Mutable(this.value);

  T value;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Bloc.observer = AppBlocObserver();
  runApp(
    const MyApp(),
  );
  /*BlocOverrides.runZoned(
      () => runApp(MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
            )
          ], child: const MyApp())),
      blocObserver: AppBlocObserver());*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
