import 'package:get/get.dart';
import 'package:dodream/controller/controller.dart';
import 'package:dodream/repository/repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() {
      return MainController(
        repository: MainRepository(),
      );
    }, fenix: true);
  }
}

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() {
      return PlanController();
    }, fenix: true);
  }
}

class FileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() {
      return FileController(
        repository: FileRepository(),
      );
    });
  }
}

class ResearchBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() {
      return ResearchController();
    }, fenix: false);
  }
}

class RetrieveAndPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => RetrieveAndPurchaseController(repository: RetrieveAndPurchaseRepository()));
  }
}