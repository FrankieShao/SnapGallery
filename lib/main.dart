import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:snapgallery/constants.dart';
import 'package:snapgallery/injection_container.dart';
import 'package:snapgallery/presentation/cubit/topics_cubit.dart';
import 'package:snapgallery/presentation/cubit/user_profile_cubit.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/main_page.dart';
import 'presentation/pages/menu_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await dotenv.load(fileName: ".env");
  di.configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopicsCubit>(
          create: (BuildContext context) => di.DI<TopicsCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SnapGallery',
        routes: {
          '/': (context) => const HomeScreen(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: DI<ZoomDrawerController>(),
        style: DrawerStyle.style3,
        borderRadius: 16,
        openCurve: Curves.easeOutSine,
        closeCurve: Curves.easeInCirc,
        slideWidth: MediaQuery.of(context).size.width * 0.75,
        angle: 0.0,
        menuScreenWidth: MediaQuery.of(context).size.width * 0.75,
        duration: const Duration(milliseconds: 200),
        menuBackgroundColor: Colors.grey.shade100,
        mainScreen: const MainPage(),
        menuScreen: BlocProvider<UserProfileCubit>(
          create: (_) => DI<UserProfileCubit>(param1: Constants.ME),
          child: const MenuUserProfile(),
        ));
  }
}
