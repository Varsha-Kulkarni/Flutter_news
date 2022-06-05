import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

const NUM_TABS = 3;

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: NUM_TABS);
    super.onInit();
  }
}
