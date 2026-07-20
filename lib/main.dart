import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/routing/app_router.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/injection_container.dart';

void main() async {
  //! Merge the initialization in the initialize app class with initialize method and call it here instead of do all initialization in main
  //! where     WidgetsFlutterBinding.ensureInitialized(); ?
  //! stop rotaion of the app
  //! set the system overlay to be transparent (the grey system appbar)
  //  SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  //   );
//    await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]).then((_) {
//  runApp(const MyApp());
//   });
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //* you can stop the user fonts configuration to affect the size of your app 

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        //  builder: (context, child) {
        //     final mediaQuery = MediaQuery.of(context);
        //     return MediaQuery(
        //       data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
        //       child: child!,
        //     );
        //   },
        onGenerateRoute: onGenerateRoute,
        initialRoute: AppRoutes.landingPage,
      ),
    );
  }
}
