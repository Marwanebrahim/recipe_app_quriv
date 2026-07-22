import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_quriv/core/theme/cubit/theme_cubit.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButtonWidget(
          height: 56,
          width: 300,
          borderRadius: 10,
          onTap: () {
            context.read<ThemeCubit>().updateTheme(
              Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
          },
          child: const Text('Toggle theme'),
        ),
      ),
    );
  }
}
