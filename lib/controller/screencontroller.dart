import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenController extends GetxController {
  final ScrollController scrollCtrl = ScrollController();

  final Map<String, GlobalKey> keys = {
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'education': GlobalKey(),
    'contact': GlobalKey(),
  };
  void scrollTo(String key) {
    final ctx = keys[key]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
    }
  }

}