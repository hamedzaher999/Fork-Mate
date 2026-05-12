import 'package:flutter/material.dart';
import 'package:fork_mate/app/services/app_services.dart';
import 'package:fork_mate/binding/customer_app_binding.dart';
import 'package:fork_mate/controller/benefits_controller.dart';
import 'package:fork_mate/controller/location_page_controller.dart';
import 'package:fork_mate/controller/password_controller.dart';
import 'package:fork_mate/controller/personal_info_controller.dart';
import 'package:fork_mate/controller/setting_controller.dart';
import 'package:fork_mate/middleware/authentication_middleware.dart';
import 'package:fork_mate/translations/app_translations.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/authentication/hello_page.dart';
import 'package:fork_mate/view/authentication/login_controller.dart';
import 'package:fork_mate/view/authentication/login_page.dart';
import 'package:fork_mate/view/authentication/signup_controller.dart';
import 'package:fork_mate/view/authentication/signup_page.dart';
import 'package:fork_mate/view/customer/customer_app.dart';
import 'package:fork_mate/view/customer/pages/archive_page.dart';
import 'package:fork_mate/view/customer/pages/coupons_page.dart';
import 'package:fork_mate/view/customer/pages/edit_personal_info_page.dart';
import 'package:fork_mate/view/customer/pages/gifts_page.dart';
import 'package:fork_mate/view/customer/pages/customize_item_page.dart';
import 'package:fork_mate/view/customer/pages/location_page.dart';
import 'package:fork_mate/view/customer/pages/customize_offer_page.dart';
import 'package:fork_mate/view/customer/pages/password_page.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await AppServices.init();
  runApp(MyApp());
}

class MyApp extends GetView<AppServices> {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(
      title: 'RTL App',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'AE'),
        Locale('es', 'ES'),
      ],
      locale: AppServices.appLocale,
      fallbackLocale: const Locale('ar'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'IBM',
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'IBM',
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          // shape: Border(bottom: BorderSide(color: white, width: 0.2)),
        ),
      ),
      themeMode: AppServices.themeMode,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HelloPage(),
          middlewares: [AuthenticationMiddleware()],
        ),
        GetPage(
          name: '/customerApp',
          page: () => CustomerApp(),
          binding: CustomerAppBinding(),
        ),
        GetPage(
          name: '/loginPage',
          page: () => LoginPage(),
          // binding: LoginBinding(),
          binding: BindingsBuilder(() {
            Get.put(LoginController());
          }),
        ),
        GetPage(
          name: '/signupPage',
          page: () => SignupPage(),
          // binding: SignupBinding(),
          binding: BindingsBuilder(() {
            Get.put(SignupController());
          }),
        ),
        GetPage(
          name: '/editPersonalInfoPage',
          page: () => EditPersonalInfoPage(),
          binding: BindingsBuilder(() {
            Get.put(PersonalInfoController());
          }),
        ),
        GetPage(
          name: '/locationPage',
          page: () => LocationPage(),
          binding: BindingsBuilder(() {
            Get.put(LocationController());
          }),
        ),
        GetPage(
          name: '/giftsPage',
          page: () => GiftsPage(),
          binding: BindingsBuilder(() {
            Get.put(BenefitsController());
          }),
        ),
        GetPage(
          name: '/couponPage',
          page: () => CouponsPage(),
          binding: BindingsBuilder(() {
            Get.put(BenefitsController());
          }),
        ),
        GetPage(
          name: '/archivePage',
          page: () => ArchivePage(),
          binding: BindingsBuilder(() {
            Get.put(SettingController());
          }),
        ),
        GetPage(
          name: '/changePasswordPage',
          page: () => PasswordPage(),
          binding: BindingsBuilder(() {
            Get.put(PassWordController());
          }),
        ),
        GetPage(name: '/customizeItemPage', page: () => CustomizeItemPage()),
        GetPage(name: '/customizeOfferPage', page: () => CustomizeOfferPage()),
      ],
    );
  }
}
