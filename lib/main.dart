import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'myApp.dart';

void main() async {
  await GetStorage.init();
  runApp(
    MyApp(),
  );
}
