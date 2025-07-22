import 'package:ecommerceapp/bloc/addDataWithGoogle/store_google_cubit.dart';
import 'package:ecommerceapp/bloc/age/age_control_cubit.dart';
import 'package:ecommerceapp/bloc/choose/choose_cubit.dart';
import 'package:ecommerceapp/bloc/forgetpass/forget_pass_cubit.dart';
import 'package:ecommerceapp/bloc/google/sign_inwith_google_cubit.dart';
import 'package:ecommerceapp/bloc/signup/sign_up_cubit.dart';
import 'package:ecommerceapp/bloc/thememode/theme_mode_cubit.dart';
import 'package:ecommerceapp/splash/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'bloc/signIn/sign_in_cubit.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ThemeModeCubit()),
            BlocProvider(create: (context) => ChooseCubit()),
            BlocProvider(create: (context) => AgeControlCubit()),
            BlocProvider(create: (context) => SignUpCubit()),
            BlocProvider(create: (context) => SignInCubit()),
            BlocProvider(create: (context) => SignInwithGoogleCubit()),
            BlocProvider(create: (context) => StoreGoogleCubit()),
            BlocProvider(create: (context) => ForgetPassCubit()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'CircularStd',
              primaryColor: Color(0xff8E6CEF),
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Colors.black,
                onPrimary: Colors.black26,
                secondary: Colors.white,
                onSecondary: Colors.white,
                error: Colors.white,
                onError: Colors.white,
                surface: Colors.white,
                onSurface: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              fontFamily: 'CircularStd',
              primaryColor: Color(0xff8E6CEF),
              colorScheme: ColorScheme(
                brightness: Brightness.dark,
                primary: Colors.white,
                onPrimary: Color(0xff272727),
                secondary: Colors.black,
                onSecondary: Colors.black,
                error: Colors.black,
                onError: Colors.black,
                surface: Colors.black,
                onSurface: Colors.black,
              ),
            ),

            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
