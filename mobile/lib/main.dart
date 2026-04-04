import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart' as di;
import 'package:hamrokrishi_app/app/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: 'Hamro Krishi',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D5A27)),
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}

