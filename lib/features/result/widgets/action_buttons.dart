import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';

class ActionButtons extends StatelessWidget {
  final bool isFavorite;

  final VoidCallback onFavorite;
  final VoidCallback onExportPdf;
  final VoidCallback onSharePdf;
  final VoidCallback onReminder;

  const ActionButtons({
    super.key,
    required this.isFavorite,
    required this.onFavorite,
    required this.onExportPdf,
    required this.onSharePdf,
    required this.onReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context) ||
        Responsive.isTablet(context)
        ? Row(
      children: [
        Expanded(
          child: _Button(
            icon: isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
            text: "Favorite",
            color: Colors.red,
            onTap: onFavorite,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _Button(
            icon: Icons.notifications_active_outlined,
            text: "Reminder",
            color: Colors.orange,
            onTap: onReminder,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _Button(
            icon: Icons.picture_as_pdf,
            text: "Export PDF",
            color: Colors.green,
            onTap: onExportPdf,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _Button(
            icon: Icons.share,
            text: "Share PDF",
            color: Colors.blue,
            onTap: onSharePdf,
          ),
        ),
      ],
    )
        : Column(
      children: [
        _Button(
          icon: isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
          text: "Favorite",
          color: Colors.red,
          onTap: onFavorite,
        ),

        const SizedBox(height: 16),

        _Button(
          icon: Icons.notifications_active_outlined,
          text: "Reminder",
          color: Colors.orange,
          onTap: onReminder,
        ),

        const SizedBox(height: 16),

        _Button(
          icon: Icons.picture_as_pdf,
          text: "Export PDF",
          color: Colors.green,
          onTap: onExportPdf,
        ),

        const SizedBox(height: 16),

        _Button(
          icon: Icons.share,
          text: "Share PDF",
          color: Colors.blue,
          onTap: onSharePdf,
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _Button({
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}