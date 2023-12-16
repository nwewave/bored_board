import 'package:get/get.dart';

import '../modules/create_new_post/bindings/create_new_post_binding.dart';
import '../modules/create_new_post/views/create_new_post_view.dart';
import '../modules/detail_post/bindings/detail_post_binding.dart';
import '../modules/detail_post/views/detail_post_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sub/bindings/sub_binding.dart';
import '../modules/sub/views/sub_view.dart';
import '../modules/update_post/bindings/update_post_binding.dart';
import '../modules/update_post/views/update_post_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SUB,
      page: () => const SubView(),
      binding: SubBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_NEW_POST,
      page: () => const CreateNewPostView(),
      binding: CreateNewPostBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_POST,
      page: () => const UpdatePostView(),
      binding: UpdatePostBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_POST,
      page: () => const DetailPostView(),
      binding: DetailPostBinding(),
    ),
  ];
}
