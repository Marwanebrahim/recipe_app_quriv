import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';

class NavBarItem extends StatefulWidget {
  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool showEffect = false;
  @override
  Widget build(BuildContext context) {
    Future<void> runAnimation() async {
      setState(() {
        showEffect = true;
      });
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() {
        showEffect = false;
      });
    }

    return GestureDetector(
      onTap: () {
        runAnimation();
        widget.onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: showEffect ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              height: 75.h,
              width: 85.w,
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: showEffect
                    ? widget.color.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.h,
            children: [
              Icon(widget.icon, color: widget.color, size: 30),
              Text(
                widget.label,
                style: context.appTextStyles.recipeName.copyWith(
                  color: widget.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
