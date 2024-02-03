import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mulyankan/core/routes.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/firebase_options.dart';
import 'package:mulyankan/logic/cubits/category_cubit/category_cubit.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:mulyankan/logic/cubits/subcategory_cubit/subcategory_cubit.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_cubit.dart';
import 'package:mulyankan/presentation/screens/auth/signin.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mulyankan/presentation/screens/home/providers/profile_provider.dart';
import 'package:mulyankan/presentation/screens/splash/splash_screen.dart';
import 'firebase_options.dart';

Future main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("main build widget called");
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => SubCategoryCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
        theme: AppTheme.defaultTheme,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    //print("block created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    //print("changes in bloc $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    //print("transition in bloc $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    //print("closing bloc: $bloc");
    super.onClose(bloc);
  }
}
