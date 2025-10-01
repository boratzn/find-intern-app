import 'package:find_intern/app/app.locator.dart';
import 'package:find_intern/app/app.router.dart';
import 'package:find_intern/app/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewmodel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final appService = locator<AppService>();
  final supabase = Supabase.instance.client;
  late AuthResponse response;

  bool isPasswordVisible = false;
  bool isLoading = false;

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withValues(alpha: .7)),
          prefixIcon: Icon(icon, color: Colors.white.withValues(alpha: .7)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withValues(alpha: .7),
                  ),
                  onPressed: () {
                    isPasswordVisible = !isPasswordVisible;
                    rebuildUi();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white.withValues(alpha: .9)),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: .9),
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: .1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.white.withValues(alpha: .2),
              width: 1,
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Future<void> loadData() async {
    var futures = [appService.getUserInfo()];
    await Future.wait(futures);
  }

  void login() async {
    // if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    //   EasyLoading.showToast('Email veya şifre boş olamaz!',
    //       toastPosition: EasyLoadingToastPosition.bottom);
    //   return;
    // }

    try {
      response = await supabase.auth.signInWithPassword(
          email: 'developer3442@gmail.com', password: '159753');

      if (response.user != null) {
        isLoading = true;
        notifyListeners();
        loadData();
        //await appService.getCategories();
        EasyLoading.showToast('Giriş İşlemi Başarılı',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } on AuthApiException catch (e) {
      if (e.statusCode == '400') {
        EasyLoading.showToast(e.message);
        return;
      }
    }

    // Simulated login delay
    await Future.delayed(const Duration(seconds: 2));

    navigationService.replaceWithHomeView();

    isLoading = false;
    notifyListeners();
  }
}
