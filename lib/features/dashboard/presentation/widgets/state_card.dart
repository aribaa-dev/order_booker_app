import 'package:flutter/material.dart';

//  MODEL
class StatCardModel {
  final String title;
  final String value;
  final bool showCurrency;
  final String diffLabel;
  final bool hasTarget;
  final double progressValue;
  final Widget iconWidget;

  const StatCardModel({
    required this.title,
    required this.value,
    this.showCurrency = false,
    required this.diffLabel,
    this.hasTarget = false,
    this.progressValue = 0.0,
    required this.iconWidget,
  });
}

//  ICON BADGE HELPERS
Widget _iconBadge({
  required Color bg,
  required Widget child,
  BoxShape shape = BoxShape.rectangle,
}) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: bg,
      shape: shape,
      borderRadius: shape == BoxShape.rectangle
          ? BorderRadius.circular(10)
          : null,
    ),
    child: Center(child: child),
  );
}

Widget _shipmentIcon() => _iconBadge(
  bg: const Color(0xFFFFF3E8),
  child: const Icon(Icons.monetization_on, color: Color(0xFFE8872A), size: 20),
);

Widget _orderIcon() => _iconBadge(
  bg: const Color(0xFFFFF3E8),
  child: const Icon(Icons.receipt_long, color: Color(0xFFE8872A), size: 20),
);

Widget _revenueIcon() => _iconBadge(
  bg: const Color(0xFFEAF0FB),
  child: const Icon(Icons.storefront, color: Color(0xFF4A7FD4), size: 22),
  shape: BoxShape.circle,
);

Widget _deliveredIcon() => _iconBadge(
  bg: const Color(0xFFEAF7F0),
  child: const Icon(
    Icons.account_balance_wallet,
    color: Color(0xFF2EAA6E),
    size: 20,
  ),
);

//  CARD DATA
final List<StatCardModel> statCards = [
  StatCardModel(
    title: "Today's Sales",
    value: '84,456',
    showCurrency: true,
    diffLabel: '100,000',
    hasTarget: true,
    progressValue: 84456 / 100000,
    iconWidget: _shipmentIcon(),
  ),
  StatCardModel(
    title: 'Orders Booked',
    value: '125 Orders',
    diffLabel: '18 booked today',
    iconWidget: _orderIcon(),
  ),
  StatCardModel(
    title: 'Outlet Visits',
    value: '45/50',
    diffLabel: '8 remaining',
    hasTarget: true,
    progressValue: 45 / 50,
    iconWidget: _revenueIcon(),
  ),
  StatCardModel(
    title: 'Collections',
    value: '45,455',
    showCurrency: true,
    diffLabel: '12 invoices connected',
    iconWidget: _deliveredIcon(),
  ),
];

class StatCard extends StatelessWidget {
  final StatCardModel model;

  const StatCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Title row + icon badge ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  model.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              model.iconWidget,
            ],
          ),

          const SizedBox(height: 15),

          // ── Main value ──
          model.showCurrency
              ? Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Rs. ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: model.value,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(height: 1.1),
                )
              : Text(
                  model.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),

          const SizedBox(height: 12),

          // ── Progress bar ──
          if (model.hasTarget) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: model.progressValue.clamp(0.0, 1.0),
                minHeight: 5,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // ── Diff / footer label ──
          Text(
            model.diffLabel,
            style: const TextStyle(
              fontSize: 10.5,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
