import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_toggle_switch/flutter_toggle_switch.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: const Color(0xFF6366F1),
      scaffoldBackgroundColor: const Color(0xFFF5F6FA),
    ),
    home: const ShowcasePage(),
  ),
);

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              const _Header(),
              const SizedBox(height: 20),

              const _SectionTitle('New Features'),

              // ── v2-1: Glow + sliding pill + elastic + shimmer ─────────
              sectionCard(
                title: 'Glow Sliding Pill',
                child: FlutterToggle(
                  initialLabelIndex: 1,
                  totalSwitches: 3,
                  labels: const ['Day', 'Week', 'Month'],
                  minWidth: 150,
                  minHeight: 48,
                  cornerRadius: 24,
                  animate: true,
                  animationDuration: 450,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.elastic,
                  pillElevation: 4,
                  pillInset: const EdgeInsets.all(4),
                  glowRadius: 18,
                  enableActiveShimmer: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF6B7280),
                  inactiveBgColor: const Color(0xFFEEF0F6),
                  activeBgColor: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  onToggle: (i) => debugPrint('Tab $i'),
                ),
              ),

              // ── v2-2: Per-tab gradient + morph ───────────────────────
              sectionCard(
                title: 'Per-Tab Gradient',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: const ['Male', 'Both', 'Female'],
                  icons: const [
                    FontAwesomeIcons.mars,
                    FontAwesomeIcons.venusMars,
                    FontAwesomeIcons.venus,
                  ],
                  minWidth: 150,
                  minHeight: 54,
                  cornerRadius: 20,
                  animate: true,
                  animationDuration: 420,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillElevation: 4,
                  pillInset: const EdgeInsets.all(4),

                  enableIconWiggle: true,
                  iconSize: 16,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF9CA3AF),
                  inactiveBgColor: const Color(0xFFF3F4F6),
                  activeBgColors: const [
                    [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    [Color(0xFFA855F7), Color(0xFF7C3AED)],
                    [Color(0xFFEC4899), Color(0xFFDB2777)],
                  ],
                  hapticFeedback: true,
                  onToggle: (i) => debugPrint('Gender $i'),
                ),
              ),

              // ── v2-3: Glassmorphism ───────────────────────────────────
              sectionCard(
                title: 'Glassmorphism',
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF6B9D), Color(0xFF7B2CBF)],
                    ),
                  ),
                  child: FlutterToggle(
                    initialLabelIndex: 0,
                    totalSwitches: 3,
                    labels: const ['Photos', 'Videos', 'Music'],
                    minWidth: 150,
                    minHeight: 44,
                    cornerRadius: 22,
                    animate: true,
                    animationDuration: 400,
                    slidingPill: true,
                    decorationStyle: ToggleDecorationStyle.glass,
                    glassBlur: 18,
                    pillInset: const EdgeInsets.all(4),
                    activeFgColor: Colors.white,
                    inactiveFgColor: Colors.white70,
                    inactiveBgColor: Colors.white.withValues(alpha: 0.18),
                    activeBgColor: [Colors.white.withValues(alpha: 0.30)],
                    onToggle: (i) => debugPrint('Media $i'),
                  ),
                ),
              ),

              // ── v2-4: Neumorphic soft UI ──────────────────────────────
              sectionCard(
                title: 'Neumorphic Style',
                child: FlutterToggle(
                  initialLabelIndex: 1,
                  totalSwitches: 3,
                  labels: const ['Home', 'Office', 'Other'],
                  icons: const [
                    FontAwesomeIcons.house,
                    FontAwesomeIcons.briefcase,
                    FontAwesomeIcons.ellipsis,
                  ],
                  minWidth: 150,
                  minHeight: 64,
                  cornerRadius: 20,
                  iconPosition: IconPosition.top,
                  iconSize: 16,
                  animate: true,
                  slidingPill: true,
                  decorationStyle: ToggleDecorationStyle.neumorphic,
                  inactiveBgColor: const Color(0xFFE0E5EC),
                  inactiveFgColor: const Color(0xFF6B7280),
                  activeFgColor: Colors.white,
                  activeBgColor: const [Color(0xFF6366F1)],
                  pillInset: const EdgeInsets.all(6),
                  pillElevation: 4,
                  animationDuration: 300,
                  hapticFeedback: true,
                  onToggle: (i) => debugPrint('Address $i'),
                ),
              ),

              // ── v2-5: Ripple wave on tap ──────────────────────────────
              sectionCard(
                title: 'Ripple Wave',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: const ['Free', 'Pro', 'Team'],
                  minWidth: 150,
                  minHeight: 48,
                  cornerRadius: 14,
                  animate: true,
                  slidingPill: false,
                  animationStyle: ToggleAnimationStyle.slide,
                  enableRippleWave: true,
                  rippleWaveColor: Colors.white,
                  splashColor: Colors.white24,
                  activeFgColor: Colors.white,
                  inactiveFgColor: Colors.white70,
                  inactiveBgColor: const Color(0xFF111827),
                  activeBgColor: const [Color(0xFF10B981), Color(0xFF059669)],
                  pillInset: const EdgeInsets.all(4),
                  pillElevation: 3,
                  enableActiveShimmer: true,
                  onToggle: (i) => debugPrint('Plan $i'),
                ),
              ),

              // ── v2-6: Outlined + animated border ──────────────────────
              sectionCard(
                title: 'Animated Border',
                child: FlutterToggle(
                  initialLabelIndex: 2,
                  totalSwitches: 3,
                  labels: const ['S', 'M', 'L'],
                  minWidth: 150,
                  minHeight: 48,
                  cornerRadius: 18,
                  borderWidth: 2.5,
                  borderColor: const [
                    Color(0xFF06B6D4),
                    Color(0xFF8B5CF6),
                    Color(0xFFEC4899),
                  ],
                  animateBorder: true,
                  borderAnimationDuration: const Duration(seconds: 4),
                  decorationStyle: ToggleDecorationStyle.outlined,
                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.slide,
                  pillInset: const EdgeInsets.all(4),
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF374151),
                  inactiveBgColor: Colors.white,
                  activeBgColor: const [Color(0xFF6366F1), Color(0xFFEC4899)],

                  glowRadius: 14,
                  onToggle: (i) => debugPrint('Size $i'),
                ),
              ),

              // ── v2-7: Bottom-nav style ────────────────────────────────
              sectionCard(
                title: 'Bottom Navigation Style',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: const ['Home', 'Search', 'Profile'],
                  icons: const [
                    FontAwesomeIcons.house,
                    FontAwesomeIcons.magnifyingGlass,
                    FontAwesomeIcons.user,
                  ],
                  iconPosition: IconPosition.top,
                  iconSize: 16,
                  minWidth: 150,
                  minHeight: 68,
                  cornerRadius: 20,
                  animate: true,
                  animationDuration: 380,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.elastic,
                  pillInset: const EdgeInsets.all(4),

                  enableIconWiggle: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF6B7280),
                  inactiveBgColor: const Color(0xFFF9FAFB),
                  activeBgColor: const [Color(0xFF14B8A6), Color(0xFF0D9488)],
                  onToggle: (i) => debugPrint('Nav $i'),
                ),
              ),

              const SizedBox(height: 24),
              const _SectionTitle('Classic Examples'),

              // ── 1. Basic ──────────────────────────────────────────────
              sectionCard(
                title: 'Basic Toggle',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  minWidth: 120,
                  totalSwitches: 3,
                  labels: const ['America', 'Canada', 'Mexico'],
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 2. Elevated + haptic ──────────────────────────────────
              sectionCard(
                title: 'Elevation & Haptic',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  minWidth: 150,
                  labels: const ['Day', 'Week', 'Month'],
                  cornerRadius: 20.0,
                  activeBgColor: const [Colors.deepPurple],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey.shade200,
                  inactiveFgColor: Colors.black87,
                  elevation: 6.0,
                  hapticFeedback: true,
                  animate: true,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 3. Sliding-pill (classic) ─────────────────────────────
              sectionCard(
                title: 'Sliding Pill',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: const ['All', 'Active', 'Done'],
                  cornerRadius: 30.0,
                  minWidth: 150,
                  activeBgColor: const [Colors.indigo, Colors.indigoAccent],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.indigo.shade50,
                  inactiveFgColor: Colors.indigo,
                  animate: true,
                  curve: Curves.easeInOutCubic,
                  slidingPill: true,
                  pillElevation: 4.0,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 4. Sliding-pill + per-tab gradient (classic) ──────────
              sectionCard(
                title: 'Sliding Pill with Gradients',
                child: FlutterToggle(
                  initialLabelIndex: 1,
                  totalSwitches: 3,
                  labels: const ['Male', 'Both', 'Female'],
                  icons: const [
                    FontAwesomeIcons.mars,
                    FontAwesomeIcons.venusMars,
                    FontAwesomeIcons.venus,
                  ],
                  cornerRadius: 20.0,
                  minWidth: 150,
                  minHeight: 52.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey.shade200,
                  inactiveFgColor: Colors.grey.shade600,
                  activeBgColors: [
                    [Colors.blue.shade400, Colors.blue.shade700],
                    [Colors.purple.shade400, Colors.deepPurple.shade700],
                    [Colors.pink.shade300, Colors.pink.shade600],
                  ],
                  animate: true,
                  curve: Curves.easeInOutBack,
                  slidingPill: true,
                  pillElevation: 5.0,
                  activeScale: 1.05,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 5. Active scale + bounce ──────────────────────────────
              sectionCard(
                title: 'Scale & Bounce',
                child: FlutterToggle(
                  minWidth: 90.0,
                  minHeight: 70.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: const [
                    FontAwesomeIcons.lightbulb,
                    FontAwesomeIcons.solidLightbulb,
                  ],
                  iconSize: 28.0,
                  activeBgColors: const [
                    [Colors.black45, Colors.black26],
                    [Colors.yellow, Colors.orange],
                  ],
                  animate: true,
                  curve: Curves.bounceOut,
                  activeScale: 1.1,
                  hapticFeedback: true,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 6. Icon position: top ─────────────────────────────────
              sectionCard(
                title: 'Icon on Top',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  minHeight: 70.0,
                  minWidth: 90.0,
                  labels: const ['Home', 'Search', 'Profile'],
                  icons: const [
                    FontAwesomeIcons.house,
                    FontAwesomeIcons.magnifyingGlass,
                    FontAwesomeIcons.user,
                  ],
                  iconPosition: IconPosition.top,
                  cornerRadius: 20.0,
                  activeBgColor: const [Colors.teal],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.teal.shade50,
                  inactiveFgColor: Colors.teal,
                  animate: true,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 7. Icon position: bottom ──────────────────────────────
              sectionCard(
                title: 'Icon on Bottom',
                child: FlutterToggle(
                  initialLabelIndex: 1,
                  totalSwitches: 3,
                  minHeight: 70.0,
                  minWidth: 90.0,
                  labels: const ['Music', 'Video', 'Photo'],
                  icons: const [
                    FontAwesomeIcons.music,
                    FontAwesomeIcons.film,
                    FontAwesomeIcons.camera,
                  ],
                  iconPosition: IconPosition.bottom,
                  cornerRadius: 20.0,
                  activeBgColor: const [Colors.orange],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.orange.shade50,
                  inactiveFgColor: Colors.orange,
                  animate: true,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 8. Tooltips ───────────────────────────────────────────
              sectionCard(
                title: 'Tooltips',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  icons: const [
                    FontAwesomeIcons.bitcoin,
                    FontAwesomeIcons.ethereum,
                    FontAwesomeIcons.dollarSign,
                  ],
                  minWidth: 80.0,
                  minHeight: 60.0,
                  iconSize: 24.0,
                  cornerRadius: 16.0,
                  activeBgColors: const [
                    [Color(0xFFF2A900)],
                    [Color(0xFF5ca6ce)],
                    [Color(0xFF388E3C)],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.black87,
                  inactiveFgColor: Colors.white70,
                  tooltips: const ['Bitcoin', 'Ethereum', 'US Dollar'],
                  animate: true,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              // ── 9. Splash color ───────────────────────────────────────
              sectionCard(
                title: 'Splash Color',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 4,
                  labels: const ['Spring', 'Summer', 'Fall', 'Winter'],
                  cornerRadius: 12.0,
                  minWidth: 72.0,
                  activeBgColor: [Colors.green.shade600],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey.shade100,
                  inactiveFgColor: Colors.black87,
                  splashColor: Colors.green.shade200,
                  animate: true,
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              sectionCard(
                title: 'Custom Size & Font',
                child: FlutterToggle(
                  minWidth: 100.0,
                  minHeight: 100.0,
                  fontSize: 15.0,
                  initialLabelIndex: 1,
                  cornerRadius: 50.0,
                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  activeBgColor: const [Color(0xFF7C2D12)],
                  activeFgColor: const Color(0xFFFDE68A),
                  inactiveBgColor: const Color(
                    0xFFFDE68A,
                  ).withValues(alpha: 0.15),
                  inactiveFgColor: const Color(0xFF7C2D12),
                  totalSwitches: 3,
                  labels: const ['Tall', 'Grande', 'Venti'],
                  onToggle: (i) => debugPrint('Coffee: $i'),
                ),
              ),

              sectionCard(
                title: 'Custom Tab Widths',
                child: FlutterToggle(
                  customWidths: const [100.0, 60.0],
                  cornerRadius: 30.0,
                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.elastic,
                  activeBgColors: const [
                    [Color(0xFF10B981), Color(0xFF059669)],
                    [Color(0xFFEF4444), Color(0xFFDC2626)],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: const Color(0xFFF1F5F9),
                  inactiveFgColor: const Color(0xFF94A3B8),
                  totalSwitches: 2,
                  labels: const ['ACCEPT', ''],
                  icons: const [null, FontAwesomeIcons.xmark],
                  onToggle: (i) => debugPrint('Action: $i'),
                ),
              ),

              sectionCard(
                title: 'Gradient Border',
                child: FlutterToggle(
                  minWidth: 100.0,
                  minHeight: 75.0,
                  initialLabelIndex: 0,
                  cornerRadius: 22.0,
                  animate: true,
                  slidingPill: true,
                  animateBorder: true,
                  borderWidth: 3.0,
                  animationStyle: ToggleAnimationStyle.morph,
                  activeFgColor: Colors.white,
                  inactiveBgColor: const Color(0xFFF8FAFC),
                  inactiveFgColor: const Color(0xFF64748B),
                  totalSwitches: 3,
                  icons: const [
                    FontAwesomeIcons.facebook,
                    FontAwesomeIcons.twitter,
                    FontAwesomeIcons.instagram,
                  ],
                  iconSize: 28.0,
                  borderColor: const [
                    Color(0xff3b5998),
                    Color(0xff1DA1F2),
                    Color(0xffE1306C),
                    Color(0xffFCAF45),
                  ],
                  activeBgColors: const [
                    [Color(0xff3b5998), Color(0xff1877F2)],
                    [Color(0xff1DA1F2), Color(0xff00acee)],
                    [
                      Color(0xfffeda75),
                      Color(0xfffa7e1e),
                      Color(0xffd62976),
                      Color(0xff962fbf),
                    ],
                  ],
                  onToggle: (i) => debugPrint('Social: $i'),
                ),
              ),

              sectionCard(
                title: 'Pill Radius Style',
                child: FlutterToggle(
                  minWidth: 150.0,
                  minHeight: 48.0,
                  cornerRadius: 24.0,
                  animate: true,
                  slidingPill: true,
                  radiusStyle: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillInset: const EdgeInsets.all(4),
                  activeBgColors: const [
                    [Color(0xFF10B981), Color(0xFF059669)],
                    [Color(0xFFEF4444), Color(0xFFDC2626)],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: const Color(0xFFF1F5F9),
                  inactiveFgColor: const Color(0xFF94A3B8),
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: const ['ONLINE', 'OFFLINE'],
                  onToggle: (i) => debugPrint('Status: $i'),
                ),
              ),

              sectionCard(
                title: 'Custom Text Style',
                child: FlutterToggle(
                  minWidth: 100.0,
                  minHeight: 52.0,
                  cornerRadius: 16.0,
                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  activeBgColor: const [Color(0xFF1F2937)],
                  activeFgColor: Colors.white,
                  inactiveBgColor: const Color(0xFFF3F4F6),
                  inactiveFgColor: const Color(0xFF9CA3AF),
                  initialLabelIndex: null,
                  doubleTapDisable: true,
                  totalSwitches: 3,
                  labels: const ['Regular', 'Bold', 'Italic'],
                  customTextStyles: const [
                    TextStyle(fontSize: 14.0),
                    TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                    TextStyle(
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Serif',
                    ),
                  ],
                  onToggle: (i) => debugPrint('Text style: $i'),
                ),
              ),

              // ── 15. Custom icons ──────────────────────────────────────
              sectionCard(
                title: 'Custom Icons',
                child: FlutterToggle(
                  minWidth: 110.0,
                  minHeight: 85.0,
                  cornerRadius: 24.0,
                  animate: true,
                  animationDuration: 400,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillInset: const EdgeInsets.all(6),
                  pillElevation: 6,
                  inactiveBgColor: const Color(0xFF111827),
                  inactiveFgColor: const Color(0xFF9CA3AF),
                  activeFgColor: Colors.white,
                  initialLabelIndex: 1,
                  totalSwitches: 3,
                  labels: const ['Visa', 'Master', 'Amex'],
                  iconPosition: IconPosition.top,
                  fontSize: 12.0,
                  customIcons: const [
                    Icon(
                      FontAwesomeIcons.ccVisa,
                      color: Colors.white,
                      size: 36.0,
                    ),
                    Icon(
                      FontAwesomeIcons.ccMastercard,
                      color: Colors.white,
                      size: 36.0,
                    ),
                    Icon(
                      FontAwesomeIcons.ccAmex,
                      color: Colors.white,
                      size: 36.0,
                    ),
                  ],
                  activeBgColors: const [
                    [Color(0xFF1A1F71), Color(0xFF2E3B8F)],
                    [Color(0xFFEB001B), Color(0xFFFF5F00)],
                    [Color(0xFF007BC1), Color(0xFF2E77BB)],
                  ],
                  onToggle: (i) => debugPrint('Payment $i'),
                ),
              ),

              // ── 16. Vertical + active borders ─────────────────────────
              sectionCard(
                title: 'Vertical Layout',
                child: FlutterToggle(
                  isVertical: true,
                  minWidth: 160.0,
                  minHeight: 56.0,
                  cornerRadius: 28.0,
                  initialLabelIndex: 0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: const Color(0xFFF3F4F6),
                  inactiveFgColor: const Color(0xFF9CA3AF),
                  radiusStyle: true,
                  animate: true,
                  animationDuration: 300,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillInset: const EdgeInsets.all(4),
                  hapticFeedback: true,
                  icons: const [
                    FontAwesomeIcons.leaf,
                    FontAwesomeIcons.sun,
                    FontAwesomeIcons.cloudSun,
                    FontAwesomeIcons.snowflake,
                  ],
                  labels: const ['Spring0', 'Summer', 'Fall', 'Winter'],
                  activeBgColors: const [
                    [Color(0xFF10B981), Color(0xFF059669)],
                    [Color(0xFFF59E0B), Color(0xFFD97706)],
                    [Color(0xFFF43F5E), Color(0xFFE11D48)],
                    [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  ],
                  onToggle: (i) => debugPrint('Season $i'),
                ),
              ),

              sectionCard(
                title: 'Multi-Line Labels',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  minHeight: 72.0,
                  minWidth: 160.0,
                  cornerRadius: 18.0,
                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillInset: const EdgeInsets.all(4),
                  activeBgColor: const [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  activeFgColor: Colors.white,
                  inactiveBgColor: const Color(0xFFF8FAFC),
                  inactiveFgColor: const Color(0xFF64748B),
                  multiLineText: true,
                  centerText: true,
                  totalSwitches: 2,
                  labels: const ["Personal\nPlan", "Business\nAccount"],
                  customTextStyles: const [
                    TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                    TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ],
                  onToggle: (i) => debugPrint('Account Type $i'),
                ),
              ),

              sectionCard(
                title: 'Cancel Toggle',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  minHeight: 80.0,
                  minWidth: 150.0,
                  cornerRadius: 24.0,
                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  inactiveBgColor: const Color(0xFFF1F5F9),
                  inactiveFgColor: const Color(0xFF64748B),
                  activeFgColor: Colors.white,
                  activeBgColors: const [
                    [Color(0xFFF59E0B), Color(0xFFD97706)],
                    [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    [Color(0xFF10B981), Color(0xFF059669)],
                  ],
                  icons: const [
                    FontAwesomeIcons.bitcoin,
                    FontAwesomeIcons.ethereum,
                    FontAwesomeIcons.dollarSign,
                  ],
                  iconSize: 32.0,
                  onToggle: (i) => debugPrint('Selected currency: $i'),
                  cancelToggle: (i) async {
                    final label = i == 0
                        ? 'Bitcoin'
                        : i == 1
                        ? 'Ethereum'
                        : 'Fiat';
                    return await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Text(
                              'Confirm Selection',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: Text('Do you want to switch to $label?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text(
                                  'Switch',
                                  style: TextStyle(
                                    color: Color(0xFF6366F1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) ??
                        true;
                  },
                ),
              ),

              sectionCard(
                title: 'Custom Widgets',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  minHeight: 85.0,
                  minWidth: 150,
                  cornerRadius: 20.0,

                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillInset: const EdgeInsets.all(4),
                  activeBgColor: const [Color(0xFFEEF2FF)],
                  activeFgColor: const Color(0xFF4F46E5),
                  inactiveBgColor: const Color(0xFFF8FAFC),
                  inactiveFgColor: const Color(0xFF64748B),
                  dividerColor: Colors.transparent,
                  customWidgets: [
                    _planWidget(FontAwesomeIcons.star, null, 'Starter', 'Free'),
                    _planWidget(
                      FontAwesomeIcons.solidStar,
                      const Color(0xffC0C0C0),
                      'Pro',
                      '\$9/mo',
                    ),
                    _planWidget(
                      FontAwesomeIcons.crown,
                      const Color(0xffFFD700),
                      'Elite',
                      '\$29/mo',
                    ),
                  ],
                  onToggle: (i) => debugPrint('switched to: $i'),
                ),
              ),

              sectionCard(
                title: 'Tab Indicator Style',
                child: FlutterToggle(
                  isSelectedLableIndicator: true,
                  indicatorWidth: 28,
                  indicatorHeight: 4,
                  minWidth: 150,
                  iconPosition: IconPosition.top,
                  indicatorColor: const Color(0xFF6366F1),
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  minHeight: 60,
                  cornerRadius: 16,
                  activeFgColor: const Color(0xFF6366F1),
                  inactiveFgColor: const Color(0xFF94A3B8),
                  inactiveBgColor: Colors.white,
                  animate: true,
                  icons: const [
                    FontAwesomeIcons.house,
                    FontAwesomeIcons.magnifyingGlass,
                    FontAwesomeIcons.user,
                  ],
                  labels: const ['Home', 'Search', 'Profile'],
                  onToggle: (i) => debugPrint('Tab $i'),
                ),
              ),

              const SizedBox(height: 24),
              const _SectionTitle('Creative Variants'),

              sectionCard(
                title: 'Neon Gaming',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: const ['FPS', 'RPG', 'Sports'],
                  icons: const [
                    FontAwesomeIcons.crosshairs,
                    FontAwesomeIcons.hatWizard,
                    FontAwesomeIcons.trophy,
                  ],
                  minWidth: 150,
                  minHeight: 58,
                  cornerRadius: 14,
                  animate: true,
                  animationDuration: 380,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.elastic,
                  pillInset: const EdgeInsets.all(4),
                  pillElevation: 6,
                  enableRippleWave: true,
                  enableActiveShimmer: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.black,
                  inactiveFgColor: const Color(0xFF64748B),
                  inactiveBgColor: const Color(0xFF0F172A),
                  activeBgColors: const [
                    [Color(0xFF00FF94), Color(0xFF00C96B)],
                    [Color(0xFFBF00FF), Color(0xFF8B00CC)],
                    [Color(0xFF00D4FF), Color(0xFF0099CC)],
                  ],
                  glowRadius: 20,
                  onToggle: (i) => debugPrint('Game mode $i'),
                ),
              ),

              // ── NEW-2: Sunset Time of Day ─────────────────────────────────
              sectionCard(
                title: 'Time of Day',
                child: FlutterToggle(
                  initialLabelIndex: 1,
                  totalSwitches: 4,
                  labels: const ['Dawn', 'Noon', 'Dusk', 'Night'],
                  icons: const [
                    FontAwesomeIcons.cloudSun,
                    FontAwesomeIcons.sun,
                    FontAwesomeIcons.cloudMoon,
                    FontAwesomeIcons.moon,
                  ],
                  minWidth: 80,
                  minHeight: 64,
                  cornerRadius: 20,
                  iconPosition: IconPosition.top,
                  iconSize: 16,
                  animate: true,
                  animationDuration: 420,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillInset: const EdgeInsets.all(5),
                  pillElevation: 5,
                  enableIconWiggle: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF9CA3AF),
                  inactiveBgColor: const Color(0xFFFFF8F0),
                  activeBgColors: const [
                    [Color(0xFFFF9A56), Color(0xFFFFBF7A)],
                    [Color(0xFFFFD700), Color(0xFFFFA500)],
                    [Color(0xFFFF6B35), Color(0xFFD63031)],
                    [Color(0xFF1E3A5F), Color(0xFF0D1F3C)],
                  ],
                  onToggle: (i) => debugPrint('Time of day $i'),
                ),
              ),

              // ── NEW-3: Emoji Mood Selector ────────────────────────────────
              sectionCard(
                title: 'Mood Selector',
                child: FlutterToggle(
                  initialLabelIndex: 2,
                  totalSwitches: 5,
                  minWidth: 62,
                  minHeight: 74,
                  cornerRadius: 18,
                  animate: true,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.elastic,
                  pillInset: const EdgeInsets.all(4),
                  pillElevation: 4,
                  enableActiveShimmer: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF9CA3AF),
                  inactiveBgColor: const Color(0xFFF8FAFC),
                  activeBgColors: const [
                    [Color(0xFFEF4444), Color(0xFFDC2626)],
                    [Color(0xFFF97316), Color(0xFFEA580C)],
                    [Color(0xFFEAB308), Color(0xFFCA8A04)],
                    [Color(0xFF22C55E), Color(0xFF16A34A)],
                    [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  ],
                  customWidgets: [
                    _moodWidget('😡', 'Angry'),
                    _moodWidget('😕', 'Sad'),
                    _moodWidget('😐', 'Okay'),
                    _moodWidget('😊', 'Good'),
                    _moodWidget('🤩', 'Great'),
                  ],
                  onToggle: (i) => debugPrint('Mood $i'),
                ),
              ),

              // ── NEW-4: RTL Direction Support ──────────────────────────────
              sectionCard(
                title: 'RTL Support',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: const ['يومي', 'أسبوعي', 'شهري'],
                  minWidth: 100,
                  minHeight: 48,
                  cornerRadius: 24,
                  animate: true,
                  animationDuration: 350,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  pillInset: const EdgeInsets.all(4),
                  pillElevation: 4,
                  textDirectionRTL: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF6B7280),
                  inactiveBgColor: const Color(0xFFF3F4F6),
                  activeBgColor: const [Color(0xFF7C3AED), Color(0xFF5B21B6)],
                  enableActiveShimmer: true,
                  onToggle: (i) => debugPrint('Period RTL $i'),
                ),
              ),

              // ── NEW-5: Dark / Light Mode Switch ──────────────────────────
              sectionCard(
                title: 'Dark / Light Mode',
                child: FlutterToggle(
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: const ['Dark', 'Light'],
                  icons: const [FontAwesomeIcons.moon, FontAwesomeIcons.sun],
                  minWidth: 150,
                  minHeight: 56,
                  cornerRadius: 28,
                  iconPosition: IconPosition.left,
                  iconSize: 18,
                  animate: true,
                  animationDuration: 400,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  decorationStyle: ToggleDecorationStyle.neumorphic,
                  pillInset: const EdgeInsets.all(5),
                  pillElevation: 5,
                  enableIconWiggle: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF6B7280),
                  inactiveBgColor: const Color(0xFFE0E5EC),
                  activeBgColors: const [
                    [Color(0xFF1E1B4B), Color(0xFF312E81)],
                    [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                  ],
                  glowRadius: 16,
                  onToggle: (i) => debugPrint('Theme $i'),
                ),
              ),

              // ── NEW-6: Aurora Liquid Mode Tab ──────────────────────────
              sectionCard(
                title: 'Aurora Liquid',
                child: FlutterToggle(
                  initialLabelIndex: 1,
                  totalSwitches: 3,
                  labels: const ['Focus', 'Flow', 'Deep'],
                  semanticLabels: const [
                    'Focus mode',
                    'Flow mode',
                    'Deep work mode',
                  ],
                  icons: const [
                    FontAwesomeIcons.bolt,
                    FontAwesomeIcons.waveSquare,
                    FontAwesomeIcons.brain,
                  ],
                  minWidth: 112,
                  minHeight: 58,
                  cornerRadius: 22,
                  animate: true,
                  animationDuration: 420,
                  slidingPill: true,
                  animationStyle: ToggleAnimationStyle.morph,
                  decorationStyle: ToggleDecorationStyle.aurora,
                  pillStyle: TogglePillStyle.liquid,
                  pillInset: const EdgeInsets.all(5),
                  pillElevation: 5,
                  iconSize: 15,
                  enableActiveShimmer: true,
                  enableIconWiggle: true,
                  hapticFeedback: true,
                  activeFgColor: Colors.white,
                  inactiveFgColor: const Color(0xFF475569),
                  inactiveBgColor: Colors.white,
                  activeBgColor: const [Color(0xFF06B6D4), Color(0xFF7C3AED)],
                  trackBorderColor: Colors.white70,
                  onToggle: (i) => debugPrint('Mode $i'),
                ),
              ),

              // ── NEW-7: Underline Tabs Mode Tab ──────────────────────────
              sectionCard(
                title: 'Underline Tabs',
                child: FlutterToggle(
                  style: ToggleStyle.underline,
                  labels: const ['Overview', 'Activity', 'Reports', 'Team'],
                  initialLabelIndex: 1,
                  minHeight: 48,
                  onToggle: (i) => debugPrint('Mode $i'),
                  activeFgColor: const Color(0xFF111827),
                  inactiveFgColor: const Color(0xFF94A3B8),
                  indicatorColor: const Color(0xFF6366F1),
                  semanticLabels: const [
                    'Overview tab',
                    'Activity tab',
                    'Reports tab',
                    'Team tab',
                  ],
                ),
              ),

              // ── NEW-8: Stacked Cards Tabs Mode Tab ──────────────────────────
              sectionCard(
                title: 'Stacked Cards',
                child: FlutterToggle(
                  style: ToggleStyle.stackedCards,
                  labels: const ['Inbox', 'Drafts', 'Sent'],
                  icons: const [
                    FontAwesomeIcons.inbox,
                    FontAwesomeIcons.fileLines,
                    FontAwesomeIcons.paperPlane,
                  ],
                  initialLabelIndex: 0,
                  minHeight: 74,
                  onToggle: (i) => debugPrint('Mode $i'),
                  activeBgColor: const [Color(0xFF0EA5E9)],
                  inactiveBgColor: const Color(0xFFF1F5F9),
                  semanticLabels: const ['Inbox tab', 'Drafts tab', 'Sent tab'],
                ),
              ),

              // ── NEW-9: Magnetic Blob Tabs Mode Tab ──────────────────────────
              sectionCard(
                title: 'Magnetic Blob',
                child: FlutterToggle(
                  style: ToggleStyle.magneticBlob,
                  labels: const ['Latest', 'Trending', 'For You'],
                  initialLabelIndex: 1,
                  minHeight: 54,
                  onToggle: (i) => debugPrint('Mode $i'),
                  activeBgColor: const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  inactiveBgColor: const Color(0xFFF1F5F9),
                  semanticLabels: const [
                    'Latest tab',
                    'Trending tab',
                    'For you tab',
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const _SectionTitle('Toggle Switch Styles'),

              sectionCard(title: 'iOS Style', child: const IosToggleRow()),
              sectionCard(
                title: 'Square Style',
                child: const SquareToggleRow(),
              ),
              sectionCard(
                title: 'Android Style',
                child: const AndroidToggleRow(),
              ),
              sectionCard(
                title: 'Custom Style',
                child: const CustomToggleRow(),
              ),
              sectionCard(title: 'Neon Dark', child: const NeonToggleRow()),
              sectionCard(
                title: 'Outline Style',
                child: const OutlineToggleRow(),
              ),
              sectionCard(title: 'Neumorphic', child: const RaisedToggleRow()),
              sectionCard(
                title: 'Gradient Thumb',
                child: const GradientThumbToggleRow(),
              ),
              sectionCard(title: 'Prism Facet', child: const PrismSwitchRow()),
              sectionCard(title: 'Orbit Ring', child: const OrbitSwitchRow()),
              sectionCard(title: 'Wave Fill', child: const WaveSwitchRow()),
              sectionCard(title: 'Flip Card', child: const FlipCardSwitchRow()),
              sectionCard(
                title: 'Pulse Heartbeat',
                child: const PulseSwitchRow(),
              ),
              sectionCard(
                title: 'Day / Night Sky',
                child: const DayNightSwitchRow(),
              ),
              sectionCard(title: 'Power Button', child: const PowerSwitchRow()),
              sectionCard(
                title: 'Segment Bar',
                child: const SegmentBarSwitchRow(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helper: wrap a demo in a mobile-friendly card ───────────────────────
  Widget sectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Center(child: child),
        ],
      ),
    );
  }

  Widget _planWidget(
    IconData icon,
    Color? iconColor,
    String title,
    String price,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor ?? const Color(0xFF6366F1), size: 20),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        Text(price, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _moodWidget(String emoji, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Binary toggle switches — all public, each shows ONE realistic settings row.
// ─────────────────────────────────────────────────────────────────────────────

// Shared settings-row layout.
Widget _settingsRow({
  required IconData icon,
  required Color iconBg,
  required Color iconColor,
  required String title,
  required String subtitle,
  required Widget toggle,
}) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF1F2937),
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
      toggle,
    ],
  );
}

// ── 1. iOS Style ──────────────────────────────────────────────────────────────
class IosToggleRow extends StatefulWidget {
  const IosToggleRow({super.key});
  @override
  State<IosToggleRow> createState() => _IosToggleRowState();
}

class _IosToggleRowState extends State<IosToggleRow> {
  bool _val = true;
  static const _color = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.bell,
      iconBg: _color.withValues(alpha: 0.12),
      iconColor: _color,
      title: 'Notifications',
      subtitle: _val ? 'Enabled' : 'Disabled',
      toggle: CupertinoSwitch(
        value: _val,
        activeTrackColor: _color,
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 2. Square Style ───────────────────────────────────────────────────────────
class SquareToggleRow extends StatefulWidget {
  const SquareToggleRow({super.key});
  @override
  State<SquareToggleRow> createState() => _SquareToggleRowState();
}

class _SquareToggleRowState extends State<SquareToggleRow> {
  bool _val = true;
  static const _color = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.moon,
      iconBg: _color.withValues(alpha: 0.12),
      iconColor: _color,
      title: 'Dark Mode',
      subtitle: _val ? 'On' : 'Off',
      toggle: GestureDetector(
        onTap: () => setState(() => _val = !_val),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          width: 56,
          height: 30,
          decoration: BoxDecoration(
            color: _val
                ? _color.withValues(alpha: 0.15)
                : const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _val ? _color : const Color(0xFFD1D5DB),
              width: 1.5,
            ),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            alignment: _val ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: _val ? _color : const Color(0xFF9CA3AF),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: (_val ? _color : Colors.black).withValues(
                      alpha: 0.2,
                    ),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(FontAwesomeIcons.star, color: Colors.white, size: 10),
            ),
          ),
        ),
      ),
    );
  }
}

// ── 3. Android Style ──────────────────────────────────────────────────────────
class AndroidToggleRow extends StatefulWidget {
  const AndroidToggleRow({super.key});
  @override
  State<AndroidToggleRow> createState() => _AndroidToggleRowState();
}

class _AndroidToggleRowState extends State<AndroidToggleRow> {
  bool _val = true;
  static const _color = Color(0xFFFBBF24);

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.volumeHigh,
      iconBg: _color.withValues(alpha: 0.12),
      iconColor: _color,
      title: 'Sound',
      subtitle: _val ? 'On' : 'Silent',
      toggle: Switch(
        value: _val,
        activeThumbColor: _color,
        activeTrackColor: _color.withValues(alpha: 0.35),
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: Colors.grey.shade200,
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 4. Custom Style — 3 variants stacked ──────────────────────────────────────
class CustomToggleRow extends StatefulWidget {
  const CustomToggleRow({super.key});
  @override
  State<CustomToggleRow> createState() => _CustomToggleRowState();
}

class _CustomToggleRowState extends State<CustomToggleRow> {
  bool _wifi = true, _loc = false, _lock = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _wifiRow(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(height: 1),
        ),
        _locationRow(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(height: 1),
        ),
        _lockRow(),
      ],
    );
  }

  // Gradient-track toggle
  Widget _wifiRow() {
    return _settingsRow(
      icon: FontAwesomeIcons.wifi,
      iconBg: const Color(0xFF6366F1).withValues(alpha: 0.12),
      iconColor: const Color(0xFF6366F1),
      title: 'Wi-Fi',
      subtitle: _wifi ? 'Connected' : 'Off',
      toggle: GestureDetector(
        onTap: () => setState(() => _wifi = !_wifi),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: _wifi
                ? const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  )
                : null,
            color: _wifi ? null : const Color(0xFFE5E7EB),
            boxShadow: _wifi
                ? [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: _wifi ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ON/OFF label toggle
  Widget _locationRow() {
    return _settingsRow(
      icon: FontAwesomeIcons.locationDot,
      iconBg: const Color(0xFF10B981).withValues(alpha: 0.12),
      iconColor: const Color(0xFF10B981),
      title: 'Location',
      subtitle: _loc ? 'Active' : 'Off',
      toggle: GestureDetector(
        onTap: () => setState(() => _loc = !_loc),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 64,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _loc ? const Color(0xFF10B981) : const Color(0xFFE5E7EB),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _loc ? null : 3,
                right: _loc ? 3 : null,
                top: 3,
                bottom: 3,
                child: Container(
                  width: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: _loc ? 8 : null,
                right: _loc ? null : 8,
                child: Text(
                  _loc ? 'ON' : 'OFF',
                  style: TextStyle(
                    color: _loc ? Colors.white : Colors.grey.shade500,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Icon-thumb toggle
  Widget _lockRow() {
    return _settingsRow(
      icon: FontAwesomeIcons.lock,
      iconBg: const Color(0xFFEF4444).withValues(alpha: 0.12),
      iconColor: const Color(0xFFEF4444),
      title: 'Auto-Lock',
      subtitle: _lock ? 'Active' : 'Inactive',
      toggle: GestureDetector(
        onTap: () => setState(() => _lock = !_lock),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _lock ? const Color(0xFFEF4444) : const Color(0xFFE5E7EB),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: _lock ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                _lock ? FontAwesomeIcons.check : FontAwesomeIcons.xmark,
                size: 10,
                color: _lock ? const Color(0xFFEF4444) : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── 5. Neon Dark Style ────────────────────────────────────────────────────────
class NeonToggleRow extends StatefulWidget {
  const NeonToggleRow({super.key});
  @override
  State<NeonToggleRow> createState() => _NeonToggleRowState();
}

class _NeonToggleRowState extends State<NeonToggleRow> {
  bool _val = true;
  static const _neon = Color(0xFF00FF94);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _neon.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _neon.withValues(alpha: 0.3), width: 1),
            ),
            child: const Icon(FontAwesomeIcons.gamepad, size: 18, color: _neon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gaming Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _val ? 'Active' : 'Inactive',
                  style: TextStyle(
                    fontSize: 12,
                    color: _val ? _neon : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _val = !_val),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _val
                    ? _neon.withValues(alpha: 0.18)
                    : const Color(0xFF1E293B),
                border: Border.all(
                  color: _val ? _neon : const Color(0xFF334155),
                  width: 1.5,
                ),
                boxShadow: _val
                    ? [
                        BoxShadow(
                          color: _neon.withValues(alpha: 0.5),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: _val ? Alignment.centerRight : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _val ? _neon : const Color(0xFF475569),
                    boxShadow: _val
                        ? [
                            BoxShadow(
                              color: _neon.withValues(alpha: 0.8),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 6. Outline / Minimal Style ────────────────────────────────────────────────
class OutlineToggleRow extends StatefulWidget {
  const OutlineToggleRow({super.key});
  @override
  State<OutlineToggleRow> createState() => _OutlineToggleRowState();
}

class _OutlineToggleRowState extends State<OutlineToggleRow> {
  bool _val = false;
  static const _color = Color(0xFF6366F1);

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.plane,
      iconBg: _color.withValues(alpha: 0.12),
      iconColor: _color,
      title: 'Airplane Mode',
      subtitle: _val ? 'On' : 'Off',
      toggle: GestureDetector(
        onTap: () => setState(() => _val = !_val),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color: _val ? _color : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: _val ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 20,
              height: 20,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _val ? _color : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── 7. Neumorphic Raised Style ────────────────────────────────────────────────
class RaisedToggleRow extends StatefulWidget {
  const RaisedToggleRow({super.key});
  @override
  State<RaisedToggleRow> createState() => _RaisedToggleRowState();
}

class _RaisedToggleRowState extends State<RaisedToggleRow> {
  bool _val = true;
  static const _color = Color(0xFF6366F1);
  static const _bg = Color(0xFFE0E5EC);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.85),
                  offset: const Offset(-3, -3),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  offset: const Offset(3, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Icon(
              FontAwesomeIcons.moon,
              size: 18,
              color: _val ? _color : const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Do Not Disturb',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
                Text(
                  _val ? 'Active' : 'Inactive',
                  style: TextStyle(
                    fontSize: 12,
                    color: _val ? _color : const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _val = !_val),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _bg,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.85),
                    offset: const Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: _val ? Alignment.centerRight : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _val ? _color : const Color(0xFFCDD5DF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.9),
                        offset: const Offset(-2, -2),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 8. Gradient Thumb Style ───────────────────────────────────────────────────
class GradientThumbToggleRow extends StatefulWidget {
  const GradientThumbToggleRow({super.key});
  @override
  State<GradientThumbToggleRow> createState() => _GradientThumbToggleRowState();
}

class _GradientThumbToggleRowState extends State<GradientThumbToggleRow> {
  bool _val = true;
  static const _g = [Color(0xFF6366F1), Color(0xFFEC4899)];

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.crown,
      iconBg: const Color(0xFF6366F1).withValues(alpha: 0.12),
      iconColor: const Color(0xFF6366F1),
      title: 'Premium Features',
      subtitle: _val ? 'Unlocked' : 'Locked',
      toggle: GestureDetector(
        onTap: () => setState(() => _val = !_val),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _val
                ? _g[0].withValues(alpha: 0.12)
                : const Color(0xFFE5E7EB),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: _val ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 22,
              height: 22,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _val
                    ? const LinearGradient(
                        colors: _g,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: _val ? null : const Color(0xFFD1D5DB),
                boxShadow: _val
                    ? [
                        BoxShadow(
                          color: _g[0].withValues(alpha: 0.45),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── 9. Prism Facet Style ─────────────────────────────────────────────────────
class PrismSwitchRow extends StatefulWidget {
  const PrismSwitchRow({super.key});
  @override
  State<PrismSwitchRow> createState() => _PrismSwitchRowState();
}

class _PrismSwitchRowState extends State<PrismSwitchRow> {
  bool _val = true;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.gem,
      iconBg: const Color(0xFF2563EB).withValues(alpha: 0.12),
      iconColor: const Color(0xFF2563EB),
      title: 'Crystal Sync',
      subtitle: _val ? 'Live updates' : 'Paused',
      toggle: PrismToggleSwitch(
        value: _val,
        width: 74,
        height: 38,
        semanticLabel: 'Crystal sync',
        activeColor: const Color(0xFF2563EB),
        activeAccentColor: const Color(0xFF22D3EE),
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 10. Orbit Ring Style ─────────────────────────────────────────────────────
class OrbitSwitchRow extends StatefulWidget {
  const OrbitSwitchRow({super.key});
  @override
  State<OrbitSwitchRow> createState() => _OrbitSwitchRowState();
}

class _OrbitSwitchRowState extends State<OrbitSwitchRow> {
  bool _val = false;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.satellite,
      iconBg: const Color(0xFFF59E0B).withValues(alpha: 0.13),
      iconColor: const Color(0xFFD97706),
      title: 'Satellite Mode',
      subtitle: _val ? 'Tracking' : 'Standby',
      toggle: OrbitToggleSwitch(
        value: _val,
        width: 76,
        height: 38,
        semanticLabel: 'Satellite mode',
        activeColor: const Color(0xFF111827),
        orbitColor: const Color(0xFFF59E0B),
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 11. Wave Fill Style ──────────────────────────────────────────────────────
class WaveSwitchRow extends StatefulWidget {
  const WaveSwitchRow({super.key});
  @override
  State<WaveSwitchRow> createState() => _WaveSwitchRowState();
}

class _WaveSwitchRowState extends State<WaveSwitchRow> {
  bool _val = true;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.droplet,
      iconBg: const Color(0xFF0F766E).withValues(alpha: 0.12),
      iconColor: const Color(0xFF0F766E),
      title: 'Hydration Alert',
      subtitle: _val ? 'Reminders on' : 'Quiet',
      toggle: WaveToggleSwitch(
        value: _val,
        width: 78,
        height: 38,
        semanticLabel: 'Hydration alert',
        activeColor: const Color(0xFF0F766E),
        waveColor: const Color(0xFF2DD4BF),
        inactiveColor: const Color(0xFFE0F2FE),
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 12. Flip Card Style ──────────────────────────────────────────────────────
class FlipCardSwitchRow extends StatefulWidget {
  const FlipCardSwitchRow({super.key});
  @override
  State<FlipCardSwitchRow> createState() => _FlipCardSwitchRowState();
}

class _FlipCardSwitchRowState extends State<FlipCardSwitchRow> {
  bool _val = false;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.shieldHalved,
      iconBg: const Color(0xFF16A34A).withValues(alpha: 0.12),
      iconColor: const Color(0xFF16A34A),
      title: 'Privacy Shield',
      subtitle: _val ? 'Protected' : 'Manual',
      toggle: FlipCardToggleSwitch(
        value: _val,
        width: 74,
        height: 38,
        semanticLabel: 'Privacy shield',
        activeColor: const Color(0xFF16A34A),
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 13. Pulse Heartbeat Style ────────────────────────────────────────────────
class PulseSwitchRow extends StatefulWidget {
  const PulseSwitchRow({super.key});
  @override
  State<PulseSwitchRow> createState() => _PulseSwitchRowState();
}

class _PulseSwitchRowState extends State<PulseSwitchRow> {
  bool _val = true;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.heartPulse,
      iconBg: const Color(0xFFE11D48).withValues(alpha: 0.12),
      iconColor: const Color(0xFFE11D48),
      title: 'Live Broadcast',
      subtitle: _val ? 'On air' : 'Off air',
      toggle: PulseToggleSwitch(
        value: _val,
        width: 76,
        height: 38,
        semanticLabel: 'Live broadcast',
        activeColor: const Color(0xFFE11D48),
        pulseColor: const Color(0xFFFB7185),
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 14. Day / Night Sky Style ────────────────────────────────────────────────
class DayNightSwitchRow extends StatefulWidget {
  const DayNightSwitchRow({super.key});
  @override
  State<DayNightSwitchRow> createState() => _DayNightSwitchRowState();
}

class _DayNightSwitchRowState extends State<DayNightSwitchRow> {
  bool _val = false;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.cloudSun,
      iconBg: const Color(0xFF60A5FA).withValues(alpha: 0.14),
      iconColor: const Color(0xFF2563EB),
      title: 'Appearance',
      subtitle: _val ? 'Day mode' : 'Night mode',
      toggle: DayNightToggleSwitch(
        value: _val,
        width: 86,
        height: 40,
        semanticLabel: 'Appearance',
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 15. Power Button Style ───────────────────────────────────────────────────
class PowerSwitchRow extends StatefulWidget {
  const PowerSwitchRow({super.key});
  @override
  State<PowerSwitchRow> createState() => _PowerSwitchRowState();
}

class _PowerSwitchRowState extends State<PowerSwitchRow> {
  bool _val = true;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.powerOff,
      iconBg: const Color(0xFF10B981).withValues(alpha: 0.14),
      iconColor: const Color(0xFF059669),
      title: 'System Armed',
      subtitle: _val ? 'Active' : 'Standby',
      toggle: PowerToggleSwitch(
        value: _val,
        width: 72,
        height: 38,
        semanticLabel: 'System armed',
        activeColor: const Color(0xFF10B981),
        glowColor: const Color(0xFF34D399),
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ── 16. Segment Bar Style ────────────────────────────────────────────────────
class SegmentBarSwitchRow extends StatefulWidget {
  const SegmentBarSwitchRow({super.key});
  @override
  State<SegmentBarSwitchRow> createState() => _SegmentBarSwitchRowState();
}

class _SegmentBarSwitchRowState extends State<SegmentBarSwitchRow> {
  bool _val = false;

  @override
  Widget build(BuildContext context) {
    return _settingsRow(
      icon: FontAwesomeIcons.bolt,
      iconBg: const Color(0xFF8B5CF6).withValues(alpha: 0.14),
      iconColor: const Color(0xFF7C3AED),
      title: 'Turbo Boost',
      subtitle: _val ? 'Engaged' : 'Off',
      toggle: SegmentBarToggleSwitch(
        value: _val,
        width: 92,
        height: 38,
        semanticLabel: 'Turbo boost',
        activeColor: const Color(0xFF8B5CF6),
        activeAccentColor: const Color(0xFFEC4899),
        onChanged: (v) => setState(() => _val = v),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Presentation widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.2,
            color: Color(0xFF6366F1),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FlutterToggle v2',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Modern animations · Glow · Ripple · Glass · Neumorphic',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
