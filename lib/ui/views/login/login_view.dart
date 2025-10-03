// Login Screen
import 'package:find_intern/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewmodel> {
  const LoginView({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return ViewContent(
      viewModel: viewModel,
    );
  }

  @override
  viewModelBuilder(BuildContext context) => LoginViewmodel();
}

class ViewContent extends StatefulWidget {
  final LoginViewmodel viewModel;
  const ViewContent({
    super.key,
    required this.viewModel,
  });

  @override
  State<ViewContent> createState() => _ViewContentState();
}

class _ViewContentState extends State<ViewContent>
    with TickerProviderStateMixin {
  late AnimationController fadeAnimationController;
  late AnimationController slideAnimationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this, // this yerine tickerProvider kullanın
    );

    slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this, // this yerine tickerProvider kullanın
    );

    fadeAnimation = CurvedAnimation(
      parent: fadeAnimationController,
      curve: Curves.easeInOut,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: slideAnimationController,
      curve: Curves.easeOutCubic,
    ));

    fadeAnimationController.forward();
    slideAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    fadeAnimationController.dispose();
    slideAnimationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Logo ve başlık
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: .2),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.work_outline,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Hoş Geldin!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Hesabına giriş yap ve staj aramaya başla',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: .8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Login formu
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Email field
                            widget.viewModel.buildTextField(
                              controller: emailController,
                              label: 'E-mail',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 20),

                            // Password field
                            widget.viewModel.buildTextField(
                              controller: passwordController,
                              label: 'Şifre',
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),

                            const SizedBox(height: 10),

                            // Şifremi unuttum
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Şifremi Unuttum',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: .8),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Giriş butonu
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: widget.viewModel.isLoading
                                    ? null
                                    : widget.viewModel.login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF667eea),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 8,
                                  shadowColor:
                                      Colors.black.withValues(alpha: .3),
                                ),
                                child: widget.viewModel.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Color(0xFF667eea),
                                        strokeWidth: 3,
                                      )
                                    : const Text(
                                        'Giriş Yap',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Sosyal medya giriş
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                        color: Colors.white
                                            .withValues(alpha: .3))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'veya',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: .7),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Divider(
                                        color: Colors.white
                                            .withValues(alpha: .3))),
                              ],
                            ),

                            const SizedBox(height: 24),

                            Row(
                              children: [
                                Expanded(
                                  child: widget.viewModel.buildSocialButton(
                                    icon: Icons.g_mobiledata,
                                    label: 'Google',
                                    onPressed: () {},
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: widget.viewModel.buildSocialButton(
                                    icon: Icons.facebook,
                                    label: 'Facebook',
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Kayıt ol linki
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hesabın yok mu? ',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .8),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
