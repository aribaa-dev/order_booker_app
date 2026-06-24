import 'package:flutter/material.dart';

// ── Reusable stateless widgets ─────────────────────────────────────────────

class SectionCard extends StatelessWidget {
  final Widget child;
  const SectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ArrowRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const ArrowRow({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.black54),
            const SizedBox(width: 14),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                letterSpacing: -0.2,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 20, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  final double indent;
  const SettingsDivider({super.key, this.indent = 0});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: indent,
      color: Colors.black12,
    );
  }
}
