import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_assets.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_state.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _registerAnimation;
  late Animation<double> _loginAnimation;

  @override
  void initState() {
    super.initState();
    _animationIntializer();
  }

  void _animationIntializer() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _registerAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.3, 0.7, curve: Curves.elasticOut),
    );
    _loginAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.5, 0.9, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthErrorState || current is AuthCheckeckedState,
      listener: (context, state) {
        if (state is AuthCheckeckedState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.mainNavigation,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Image.asset(AppAssets.langingPageImage),
              Container(color: Colors.black87.withValues(alpha: 0.3)),
              Center(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 100.h),
                              Text(
                                "RECI",
                                style: textStyles.logo.copyWith(
                                  color: colors.lightBackground,
                                  height: 1,
                                ),
                              ),
                              Text(
                                'cook it yourself',
                                style: textStyles.bodySmall.copyWith(
                                  color: colors.lightBackground,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return child!;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeTransition(
                              opacity: _registerAnimation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1.5),
                                  end: Offset.zero,
                                ).animate(_registerAnimation),
                                child: CustomButtonWidget(
                                  height: 55,
                                  width: 361,
                                  borderRadius: 6,
                                  backgroundColor: colors.primary,
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.register,
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      'REGISTER',
                                      style: textStyles.buttonLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            FadeTransition(
                              opacity: _loginAnimation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 2.5),
                                  end: Offset.zero,
                                ).animate(_loginAnimation),
                                child: CustomButtonWidget(
                                  height: 55,
                                  width: 361,
                                  borderRadius: 6,
                                  borderColor: colors.primary,
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.login,
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      'LOG IN',
                                      style: textStyles.buttonLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
