import 'package:ecommerceapp/bloc/addDataWithGoogle/store_google_cubit.dart';
import 'package:ecommerceapp/bloc/addaddress/add_address_cubit.dart';
import 'package:ecommerceapp/bloc/addcartcontrol/add_cart_control_cubit.dart';
import 'package:ecommerceapp/bloc/addrating/add_rating_cubit.dart';
import 'package:ecommerceapp/bloc/age/age_control_cubit.dart';
import 'package:ecommerceapp/bloc/choose/choose_cubit.dart';
import 'package:ecommerceapp/bloc/editaddress/edit_address_cubit.dart';
import 'package:ecommerceapp/bloc/filter/filter_control_cubit.dart';
import 'package:ecommerceapp/bloc/forgetpass/forget_pass_cubit.dart';
import 'package:ecommerceapp/bloc/getAddresses/get_addresses_cubit.dart';
import 'package:ecommerceapp/bloc/getcartcontrol/get_cart_control_cubit.dart';
import 'package:ecommerceapp/bloc/getcategoriesPr/get_categoreies_pr_cubit.dart';
import 'package:ecommerceapp/bloc/gethomepagecat/get_home_page_cat_cubit.dart';
import 'package:ecommerceapp/bloc/getratings/get_ratings_cubit.dart';
import 'package:ecommerceapp/bloc/google/sign_inwith_google_cubit.dart';
import 'package:ecommerceapp/bloc/productchoose/product_choose_color_cubit.dart';
import 'package:ecommerceapp/bloc/productchoose/product_choose_cubit.dart';
import 'package:ecommerceapp/bloc/quantitnycontrol/quantity_control_cubit.dart';
import 'package:ecommerceapp/bloc/removeall/remove_all_cubit.dart';
import 'package:ecommerceapp/bloc/signup/sign_up_cubit.dart';
import 'package:ecommerceapp/bloc/thememode/theme_mode_cubit.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:ecommerceapp/screens/homepage.dart';
import 'package:ecommerceapp/splash/splashscreen.dart';
import 'package:ecommerceapp/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'bloc/filtergender/filter_gender_control_cubit.dart';
import 'bloc/signIn/sign_in_cubit.dart';
import 'firebase/firebase_options.dart';
import 'onetimeadded.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await ProductModelMake.upload20Products();
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
            BlocProvider(create: (context) => GetHomePageCatCubit()),
            BlocProvider(create: (context) => GetCategoreiesPrCubit()),
            BlocProvider(create: (context) => FilterControlCubit()),
            BlocProvider(create: (context) => FilterGenderControlCubit()),
            BlocProvider(create: (context) => ProductChooseColorCubit()),
            BlocProvider(create: (context) => ProductChooseSizeCubit()),
            BlocProvider(create: (context) => QuantityControlCubit()),
            BlocProvider(create: (context) => GetRatingsCubit()),
            BlocProvider(create: (context) => AddRatingCubit()),
            BlocProvider(create: (context) => AddCartControlCubit()),
            BlocProvider(create: (context) => GetCartControlCubit()),
            BlocProvider(create: (context) => GetAddressesCubit()),
            BlocProvider(create: (context) => AddAddressCubit()),
            BlocProvider(create: (context) => EditAddressCubit()),
            BlocProvider(create: (context) => RemoveAllCubit()),
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
