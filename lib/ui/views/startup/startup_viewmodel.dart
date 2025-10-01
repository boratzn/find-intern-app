import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:find_intern/app/app.locator.dart';
import 'package:find_intern/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  late AnimationController logoController;
  late AnimationController textController;
  late Animation<double> logoAnimation;
  late Animation<double> textAnimation;

  navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 3500));

    _navigationService.replaceWithLoginView();
  }

  startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    logoController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    textController.forward();
  }
}
