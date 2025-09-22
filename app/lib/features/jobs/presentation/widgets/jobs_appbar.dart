import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:jobs_dashboard/core/theme/app_colors.dart';

class JobsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showAppliedOnly;
  final VoidCallback onFilterPressed;

  const JobsAppBar({
    super.key,
    required this.showAppliedOnly,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Job Applications'),
      actions: [
        IconButton(
          tooltip: 'Filters',
          onPressed: onFilterPressed,
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                MdiIcons.tune,
                color: showAppliedOnly ? Colors.amber : AppColors.textPrimary,
              ),
              if (showAppliedOnly)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
