import 'package:racemate_task/app/data/base_request.dart';

import '../../../../index.dart';
import '../../../data/race_model.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<RaceModel> races = [];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
    getData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> getData() async {
    var response = await BaseRequest.dynamicRequest();
    races = List.from(response.map((race) => RaceModel.fromJson(race)));
    update();
  }
}
