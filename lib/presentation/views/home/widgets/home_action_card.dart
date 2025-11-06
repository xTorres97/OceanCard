import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? svgIconPath;
  final String description;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const HomeActionCard({
    super.key,
    required this.title,
    required this.icon,
    this.svgIconPath,
    required this.description,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 120, maxHeight: 200),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Title and action button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Central icon
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: svgIconPath != null && svgIconPath!.isNotEmpty
                        ? SvgPicture.asset(svgIconPath!, fit: BoxFit.contain)
                        : Icon(icon, size: 48, color: colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Bottom description
              Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
