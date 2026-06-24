import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:order_booker/features/dashboard/presentation/screens/dashboard_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _generalExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),

        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // ── General Settings Card ──────────────────────────────
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () =>
                      setState(() => _generalExpanded = !_generalExpanded),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Row(
                      children: [
                        const Text(
                          'General Settings',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          _generalExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black54,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),

                if (_generalExpanded) ...[
                  // Profile row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD9C5B8),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/DSC_0022.JPG",
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Sajeel Sohail',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Edit Your Profile',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.black45,
                                letterSpacing: -0.1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  _Divider(),

                  // Account Settings label
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                    child: Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.black54,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ),

                  // Push Notifications toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Text(
                          'Push Notifications',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          value: _pushNotifications,
                          activeTrackColor: Colors.black,
                          onChanged: (v) =>
                              setState(() => _pushNotifications = v),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),
                  _Divider(indent: 16),

                  // Address Settings
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Text(
                      'Address Settings',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Security ──────────────────────────────────────────
          _SectionCard(
            child: _ArrowRow(icon: Icons.shield_outlined, label: 'Security'),
          ),

          const SizedBox(height: 12),

          // ── Redeem a code ─────────────────────────────────────
          _SectionCard(
            child: _ArrowRow(
              icon: Icons.card_giftcard_outlined,
              label: 'Redeem a code',
            ),
          ),

          const SizedBox(height: 12),

          // ── Contact us ────────────────────────────────────────
          _SectionCard(
            child: _ArrowRow(
              icon: Icons.chat_bubble_outline,
              label: 'Contact us',
            ),
          ),

          const SizedBox(height: 12),

          // ── Log out ───────────────────────────────────────────
          _SectionCard(
            child: _ArrowRow(icon: Icons.logout, label: 'Log out'),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

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

class _ArrowRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ArrowRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
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

class _Divider extends StatelessWidget {
  final double indent;
  const _Divider({this.indent = 0});

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
