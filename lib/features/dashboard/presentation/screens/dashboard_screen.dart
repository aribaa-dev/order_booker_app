import 'package:flutter/material.dart';
import 'package:order_booker/features/voice_intake/presentation/screens/voice_intake_screen.dart';
import 'package:order_booker/features/dashboard/presentation/widgets/state_card.dart';
import 'package:order_booker/features/dashboard/presentation/widgets/voice_hintcard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // ── Black header ──
            Container(
              color: Colors.black,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 17.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // app bar
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(225),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: Color(0x0A000000),
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              "assets/images/DSC_0022.JPG",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Good Morning! ",
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Text(
                              "Abdullah ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(225),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: Color(0x0A000000),
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_active_outlined,
                              color: Colors.black,
                              size: 29,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    // date
                    Row(
                      children: const [
                        Icon(
                          Icons.calendar_month,
                          size: 28,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Monday, 12 April",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── White rounded sheet ──
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(19, 20, 19, 110),
                      child: Column(
                        children: [
                          // stat cards
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: statCards.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 1.10,
                                ),
                            itemBuilder: (_, i) {
                              return StatCard(model: statCards[i]);
                            },
                          ),
                          const SizedBox(height: 16),
                          const VoiceHintcard(),
                        ],
                      ),
                    ),

                    // ── Bottom floating nav bar ──
                    Positioned(
                      bottom: 16,
                      left: 24,
                      right: 24,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: const Offset(0, 5),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.grid_view_outlined,
                              size: 30,
                              color: Colors.white,
                            ),

                            Icon(
                              Icons.history_toggle_off_rounded,
                              size: 30,
                              color: Colors.white,
                            ),

                            // mic button
                            GestureDetector(
                              onTap: _openVoiceRecording,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.mic,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(Icons.settings, size: 30, color: Colors.white),

                            Icon(
                              Icons.summarize,
                              size: 30,
                              color: Colors.white,
                            ),
                          ],
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
    );
  }

  void _openVoiceRecording() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, _) => const VoiceIntakeScreen(),
        transitionsBuilder: (_, animation, _, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }
}
