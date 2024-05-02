import 'dart:convert';

import 'package:flutter/services.dart';

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
    loadData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> loadData() async {
    final String response =
        await rootBundle.loadString('assets/races_data.json');
    final data = await json.decode(response);
    races = List.from(data['items'].map((race) => RaceModel.fromJson(race)));
    update();
  }
}
