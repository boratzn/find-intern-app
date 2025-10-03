import 'package:find_intern/app/app.locator.dart';
import 'package:find_intern/app/app.router.dart';
import 'package:find_intern/app/services/app_service.dart';
import 'package:find_intern/ui/common/app_tops.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final appService = locator<AppService>();
  List<String> categories = [];

  List<Map<String, dynamic>> featuredInternships = [
    {
      'title': 'Flutter Developer Stajyeri',
      'company': 'TechCorp',
      'location': 'İstanbul',
      'duration': '3 ay',
      'type': 'Tam Zamanlı',
      'logo': Icons.code,
      'salary': '₺3,500',
      'color': const Color(0xFF667eea),
    },
    {
      'title': 'UI/UX Design Intern',
      'company': 'DesignStudio',
      'location': 'Ankara',
      'duration': '6 ay',
      'type': 'Yarı Zamanlı',
      'logo': Icons.design_services,
      'salary': '₺2,800',
      'color': const Color(0xFF764ba2),
    },
    {
      'title': 'Digital Marketing Stajyeri',
      'company': 'MarketPro',
      'location': 'İzmir',
      'duration': '4 ay',
      'type': 'Hibrit',
      'logo': Icons.campaign,
      'salary': '₺3,000',
      'color': const Color(0xFFf093fb),
    },
  ];

  void init() async {
    loadData();
    categories = AppTops.categories;
    notifyListeners();
  }

  Future<void> loadData() async {
    var futures = [appService.getCategories()];
    await Future.wait(futures);
  }

  void logOut() {
    navigationService.replaceWithLoginView();
  }
}
