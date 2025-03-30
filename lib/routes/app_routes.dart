import 'package:get/get.dart';
import 'package:store/view/account/account_view.dart';
import 'package:store/view/auth/login_view.dart';
import 'package:store/view/auth/register_view.dart';
import 'package:store/view/main_view.dart';
import 'package:store/view/cart/cart_view.dart';
import 'package:store/view/products/homepage_view.dart';
import 'package:store/view/products/saveditems_view.dart';
import 'package:store/view/products/searchview.dart';
import 'package:store/view/splash/splash_view.dart';

class AppRoutes {
  static final String splash="/";
  static final String login="/login";
  static final String register="/register";
  static final String main="/main";
  static final String resetPassword="/resetPassword";
  static final String homepage="/homepage";
  static final String search="/search";
  static final String searchActive="/searchActive";
  static final String seved="/seved";
  static final String cart="/cart";
  static final String account="/account";
  
  static final routes = [
    GetPage(name: splash, page: () => SplashView() ),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: register, page: () => RegisterView()),
    GetPage(name: main, page: () => MainPageView()),
    GetPage(name: homepage, page: () => HomepageView()), 
    GetPage(name: search, page: () => SearchView()),
    GetPage(name: seved, page: () => SavedItemsView()),
    GetPage(name: cart, page: () => CartView()),
    GetPage(name: account, page: () => AccountView()),
  ];
}
