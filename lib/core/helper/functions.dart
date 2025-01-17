import 'package:clima/core/helper/lotte_cach_helper.dart';
import 'package:clima/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/get_it_service.dart';
import 'bloc_observer.dart';
import 'converter_helper.dart';

String convertTimeToReadableDate(int time) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  return DateFormatter.format(dateTime);
}

String convertTemperatureToCelsius(double temperature) {
  double temperatureInCelsius =
      TemperatureConverter.kelvinToCelsius(temperature);
  return '${temperatureInCelsius.round()}°';
}

// Check if it's night or day based on sunrise and sunset timestamps
bool isNightTime(int sunriseTimestamp, int sunsetTimestamp) {
  int currentTimestamp = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
  return currentTimestamp < sunriseTimestamp ||
      currentTimestamp > sunsetTimestamp;
}

initialization() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();
  setup();
  Bloc.observer = MyBlocObserver();
  LottieCache.cache();
}
