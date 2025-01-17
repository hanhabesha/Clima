import 'package:clima/core/global/enums.dart';
import 'package:clima/core/helper/functions.dart';
import 'package:clima/core/utils/app_images.dart';
import 'package:clima/features/home/data/model/weather_model.dart';
import 'package:clima/features/home/data/model/weather_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/global/variables.dart';
import '../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository repository;
  HomeCubit(this.repository) : super(HomeLoadingState());

  getTodayWeather({
    required double? latitude,
    required double? longitude,
  }) async {
    final data = await repository.getTodayWeather(latitude, longitude);
    try {
      data.fold((error) {
        emit(HomeErrorState(error: error.message));
      }, (weather) {
        /// [isNight] is a global value => lib/core/constant/variables.dart
        GlobalVariablesState.isNight = isNightTime(
            weather.sys.sunrise.toInt(), weather.sys.sunset.toInt());
        WeatherTheme theme = WeatherTheme.fromWeatherState(
            weather.weatherState.mapToWeatherState());
        emit(
          HomeSuccessState(
            weatherData: weather,
            todayDate: convertTimeToReadableDate(weather.time.toInt()),
            temperature:
                convertTemperatureToCelsius(weather.temperature.toDouble()),
            weatherImage: GlobalVariablesState.isNight
                ? theme.nightImage
                : theme.dayImage,
            textColor: theme.textColor,
          ),
        );
      });
    } catch (e) {
      print("/////////////////////////////////////////////\n $e");
    }
  }
}
