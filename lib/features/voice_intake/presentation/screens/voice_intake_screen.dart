import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

import 'package:order_booker/features/summary/presentation/screens/summary_screen.dart';

class VoiceIntakeScreen extends StatefulWidget {
  const VoiceIntakeScreen({super.key});

  @override
  State<VoiceIntakeScreen> createState() => _VoiceIntakeScreenState();
}

class _VoiceIntakeScreenState extends State<VoiceIntakeScreen>
    with TickerProviderStateMixin {
  // ── State ────────────────────────────────────
  bool _isRecording = false;
  bool _isPaused = false;
  bool _hasRecording = false;

  // Timer
  int _seconds = 0;
  Timer? _timer;

  // Animation controllers
  late AnimationController _waveController;
  late AnimationController _pulseController;

  // Mock waveform bar heights (randomized once)
  late List<double> _barHeights;

  // Mock summary
  final _mockSummary = {
    'shop': 'Al-Noor General Store',
    'items': [
      {'name': 'Milk', 'qty': '10', 'unit': 'Litre', 'price': '₨ 1,500'},
      {'name': 'Sugar', 'qty': '5', 'unit': 'Kg', 'price': '₨ 650'},
      {'name': 'Rice (Basmati)', 'qty': '2', 'unit': 'Kg', 'price': '₨ 900'},
    ],
    'total': '₨ 3,050',
  };

  // ── Lifecycle ────────────────────────────────
  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    // Generate random bar heights once
    final rng = math.Random(7);
    _barHeights = List.generate(46, (_) => rng.nextDouble() * 0.75 + 0.15);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _waveController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // ── Timer helpers ────────────────────────────
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPaused) setState(() => _seconds++);
    });
  }

  String get _timerLabel {
    final h = _seconds ~/ 3600;
    final m = (_seconds % 3600) ~/ 60;
    final s = _seconds % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  // ── Actions ──────────────────────────────────
  void _startRecording() {
    setState(() {
      _isRecording = true;
      _isPaused = false;
      _hasRecording = false;

      _seconds = 0;
    });
    _waveController.repeat();
    _startTimer();
  }

  void _pauseResume() {
    setState(() => _isPaused = !_isPaused);
    if (_isPaused) {
      _waveController.stop();
    } else {
      _waveController.repeat();
    }
  }

  void _stopRecording() {
    _timer?.cancel();
    _waveController.stop();
    setState(() {
      _isRecording = false;
      _isPaused = false;
      _hasRecording = true;
    });
  }

  void _discard() {
    _timer?.cancel();
    _waveController.stop();
    _waveController.reset();
    setState(() {
      _isRecording = false;
      _isPaused = false;
      _hasRecording = false;

      _seconds = 0;
    });
  }

  // ── Build ────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: SafeArea(child: _buildMainView()),
      ),
    );
  }

  // ── Main recording view ──────────────────────
  Widget _buildMainView() {
    return Column(
      children: [
        _buildTopBar(),

        const SizedBox(height: 8),
        if (!_isRecording && !_hasRecording) _buildHintCard(),
        if (_isRecording || _hasRecording) _buildTimer(),
        Expanded(child: _buildCenterArea()),
        if (_isRecording) _buildSpeakFasterHint(),
        const SizedBox(height: 24),
        _buildControls(),
        const SizedBox(height: 36),
      ],
    );
  }

  // ── Top bar ──────────────────────────────────
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const Expanded(
            child: Text(
              'Recording',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Language toggle
        ],
      ),
    );
  }

  // ── Hint card (idle only) ────────────────────
  Widget _buildHintCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(19, 12, 19, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF2c2c2c)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.lightbulb_outline_rounded,
                color: Color(0xFFFBBF24),
                size: 13,
              ),
              SizedBox(width: 5),
              Text(
                'Tip',
                style: TextStyle(
                  color: Color(0xFFFBBF24),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "Say: Al-Noor Store… Milk 10 litre, Sugar 5 kg…",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Timer display ────────────────────────────
  Widget _buildTimer() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        _timerLabel,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.w300,
          letterSpacing: 4,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }

  // ── Center area ──────────────────────────────
  Widget _buildCenterArea() {
    if (_isRecording) return _buildLiveWaveform();
    if (_hasRecording) return _buildDoneState();
    return const SizedBox.shrink();
  }

  // Recording: scrolling waveform with pause pill
  Widget _buildLiveWaveform() {
    return Center(
      child: AnimatedBuilder(
        animation: _waveController,
        builder: (_, _) {
          return SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Waveform bars
                CustomPaint(
                  size: const Size(double.infinity, 130),
                  painter: _LiveWaveformPainter(
                    progress: _waveController.value,
                    barHeights: _barHeights,
                    isPaused: _isPaused,
                  ),
                ),

                // Pause pill (the white oval in the reference)
              ],
            ),
          );
        },
      ),
    );
  }

  // Done: green check
  Widget _buildDoneState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Recording ready',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _timerLabel,
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // "Try to speak a bit faster" hint
  Widget _buildSpeakFasterHint() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF2c2c2c)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.speed_rounded, color: Colors.white60, size: 15),
          SizedBox(width: 6),
          Text(
            'Try to speak a bit slower',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ── Controls ─────────────────────────────────
  Widget _buildControls() {
    // IDLE STATE
    if (!_isRecording && !_hasRecording) {
      return _BigButton(icon: Icons.mic_rounded, onTap: _startRecording);
    }

    // RECORDING STATE
    if (_isRecording) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stop button
          _SmallButton(
            icon: Icons.stop_rounded,
            bgColor: Colors.white.withValues(alpha: 0.2),
            iconColor: Colors.white,
            onTap: _stopRecording,
          ),
          const SizedBox(width: 28),
          // Pause / Resume — big centre button
          _BigButton(
            icon: _isPaused ? Icons.mic_rounded : Icons.pause_rounded,
            onTap: _pauseResume,
          ),
          const SizedBox(width: 28),
          // Discard
          _SmallButton(
            icon: Icons.delete_outline_rounded,
            bgColor: Colors.white.withValues(alpha: 0.2),
            iconColor: Colors.white,
            onTap: _discard,
          ),
        ],
      );
    }

    // HAS RECORDING STATE
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Discard
        _SmallButton(
          icon: Icons.delete_outline_rounded,
          bgColor: Colors.white.withValues(alpha: 0.2),
          iconColor: Colors.white,
          onTap: _discard,
        ),
        const SizedBox(width: 28),
        // Generate summary
        _BigButton(
          icon: Icons.auto_awesome_rounded,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummaryScreen(
                summaryData: _mockSummary,
                isHistoryView: false,
              ),
            ),
          ),
        ),
        const SizedBox(width: 28),
        // Re-record
        _SmallButton(
          icon: Icons.refresh_rounded,
          bgColor: Colors.white.withValues(alpha: 0.2),
          iconColor: Colors.white,
          onTap: _startRecording,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  LIVE WAVEFORM PAINTER
// ─────────────────────────────────────────────
class _LiveWaveformPainter extends CustomPainter {
  final double progress;
  final List<double> barHeights;
  final bool isPaused;

  _LiveWaveformPainter({
    required this.progress,
    required this.barHeights,
    required this.isPaused,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.5;

    final count = barHeights.length;
    final spacing = size.width / count;
    final cx = size.width / 2;

    for (int i = 0; i < count; i++) {
      final x = i * spacing + spacing / 2;

      // Wave animation: bars to the left of centre scroll/animate
      double animatedHeight;
      if (!isPaused) {
        final phase = (i / count) - progress;
        final wave = math.sin(phase * math.pi * 3);
        animatedHeight = size.height * barHeights[i] * (0.5 + 0.5 * wave.abs());
      } else {
        animatedHeight = size.height * barHeights[i] * 0.5;
      }

      // Bars past the centre (right side) are dimmer — "not yet spoken"
      final isRight = x > cx + 20;
      paint.color = isRight
          ? Colors.white.withValues(alpha: 0.25)
          : Colors.white.withValues(alpha: 0.85);

      canvas.drawLine(
        Offset(x, size.height / 2 - animatedHeight / 2),
        Offset(x, size.height / 2 + animatedHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_LiveWaveformPainter old) =>
      old.progress != progress || old.isPaused != isPaused;
}

// ─────────────────────────────────────────────
//  BUTTON HELPERS
// ─────────────────────────────────────────────
class _BigButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _BigButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        height: 68,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black, size: 30),
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _SmallButton({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }
}
