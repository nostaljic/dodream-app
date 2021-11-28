import 'package:dodream/ui/complete.dart';
import 'package:dodream/ui/purchase.dart';
import 'package:dodream/ui/user_selection.dart';
import 'package:get/get.dart';
import 'package:dodream/ui/file.dart';
import 'package:dodream/ui/login.dart';
import 'package:dodream/ui/plan.dart';

import 'binding/binding.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const PLAN = '/plan';
  static const RESEARCH = '/research';
  static const FIXCAM = '/fixcam';

  // added 1128 - 14:23
  static const SELECT = '/select';

  /// for purchasee
  static const PURCHASE = '/purchase';

  static const COMPLETE = '/complete';
  static const FILESELECT = '/fileselect';
  static const RECORD = '/record';
  static const CAM = '/cam';
}

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => LoginStep(),
        bindings: [MainBinding()]),
    GetPage(name: Routes.PLAN, page: () => Plan(), bindings: [PlanBinding()]),
    GetPage(
        name: Routes.FILESELECT,
        page: () => FileSelect(),
        bindings: [FileBinding()]),
    GetPage(name: Routes.COMPLETE, page: () => Complete()),

    // added 1128 - 14:24
    GetPage(name: Routes.SELECT, page: () => const UserSelection()),

    /// added for purchase
    GetPage(name: Routes.PURCHASE, page: () => const PurchaseView()),
  ];
}
