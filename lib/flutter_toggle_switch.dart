import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_switch/src/custom_border_paint.dart';
import 'package:flutter_toggle_switch/src/row_to_column.dart';
import 'package:flutter_toggle_switch/src/utils.dart';

typedef OnToggle = void Function(int? index);
typedef CancelToggle = Future<bool> Function(int? index);

/// Backward-compatibility alias.
typedef ToggleSwitch = FlutterToggle;

/// Position of the icon relative to the label text.
enum IconPosition { left, top, right, bottom }

/// Animation style for the selected-tab transition.
///
/// * [slide]   — iOS-style pill slides from old to new position.
/// * [fade]    — active background cross-fades per item (legacy).
/// * [scale]   — active background pops from 0 → 1 scale.
/// * [elastic] — pill slides with an elastic overshoot.
/// * [morph]   — pill slides with a softer easeOutCubic curve.
enum ToggleAnimationStyle { slide, fade, scale, elastic, morph }

/// Visual treatment for the whole track.
///
/// * [solid]      — regular flat background (default).
/// * [glass]      — blurred translucent backdrop (glassmorphism).
/// * [neumorphic] — soft outer + inner-gradient shadows for depth.
/// * [outlined]   — transparent interior, gradient border only.
/// * [tonal]      — Material-style low contrast surface tint.
/// * [floating]   — lifted surface with a soft border and shadow.
/// * [aurora]     — animated ambient gradient track.
enum ToggleDecorationStyle {
  solid,
  glass,
  neumorphic,
  outlined,
  tonal,
  floating,
  aurora,
}

/// Visual treatment for the selected sliding pill.
///
/// * [filled]     — regular gradient fill (default).
/// * [glass]      — translucent fill with a light edge.
/// * [outline]    — transparent pill with a colored stroke.
/// * [soft]       — elevated fill with stronger soft shadow.
/// * [liquid]     — animated layered highlights inside the pill.
enum TogglePillStyle { filled, glass, outline, soft, liquid }

/// Major visual variant of the toggle component.
///
/// * [standard]     — original pill/switch design.
/// * [underline]    — text tabs with an animated underline indicator.
/// * [stackedCards] — separate elevated cards for each tab.
/// * [magneticBlob] — playfully stretching pill indicator.
enum ToggleStyle { standard, underline, stackedCards, magneticBlob }

// ignore: must_be_immutable
class FlutterToggle extends StatefulWidget {
  // ─────────────────────── v3.5 unified style ────────────────────────────────
  final ToggleStyle style;

  // ─────────────────────── existing properties ───────────────────────────────

  final List<Color>? borderColor;
  final Color dividerColor;
  final List<Color>? activeBgColor;
  final Color? activeFgColor;
  final Color? inactiveBgColor;
  final Color? inactiveFgColor;
  final List<String>? labels;
  final List<bool>? states;
  final int? totalSwitches;
  final List<IconData?>? icons;
  final List<List<Color>?>? activeBgColors;
  final List<TextStyle?>? customTextStyles;
  final List<Icon?>? customIcons;
  final List<double>? customWidths;
  final List<double>? customHeights;
  final double minWidth;
  final double minHeight;
  final double cornerRadius;
  final double fontSize;
  final double iconSize;
  final double? dividerMargin;
  final double? borderWidth;
  final OnToggle? onToggle;
  final CancelToggle? cancelToggle;
  final bool changeOnTap;
  final bool animate;
  final int animationDuration;
  final bool radiusStyle;
  final bool textDirectionRTL;
  final Curve curve;
  int? initialLabelIndex;
  final bool doubleTapDisable;
  final bool isVertical;
  List<Border?>? activeBorders;
  final bool centerText;
  final bool multiLineText;
  final List<Widget>? customWidgets;
  final bool isSelectedLableIndicator;
  final Color? indicatorColor;
  final double indicatorHeight;
  final double? indicatorWidth;

  // ─────────────────────── v1.5 properties ───────────────────────────────────

  final double elevation;
  final Color? shadowColor;
  final bool hapticFeedback;
  final List<String?>? tooltips;
  final IconPosition iconPosition;
  final double activeScale;
  final bool slidingPill;
  final double pillElevation;
  final Color? pillShadowColor;
  final Color? splashColor;

  // ─────────────────────── v2 properties ─────────────────────────────────────

  /// Primary animation style when transitioning between tabs.
  final ToggleAnimationStyle? animationStyle;

  /// Overall decoration style for the track.
  final ToggleDecorationStyle decorationStyle;

  /// Blur sigma used when [decorationStyle] is [ToggleDecorationStyle.glass].
  final double glassBlur;

  /// Color of the glow; defaults to the active color at 55 % opacity.
  final Color? glowColor;

  /// Blur radius of the glow halo.
  final double glowRadius;

  /// Shows an expanding ring ripple burst on tap.
  final bool enableRippleWave;

  /// Color of the ripple wave ring.
  final Color? rippleWaveColor;

  /// Plays a shimmer sweep across the active pill after selection.
  final bool enableActiveShimmer;

  /// Color of the shimmer highlight.
  final Color shimmerColor;

  /// Rotates the gradient border continuously.
  final bool animateBorder;

  /// Duration for one full loop of the animated border.
  final Duration borderAnimationDuration;

  /// Padding that insets the sliding pill from the track edges.
  final EdgeInsets pillInset;

  /// Briefly wiggles the active icon after selection.
  final bool enableIconWiggle;

  /// Applies a subtle press-in scale on tap-down.
  final bool enableTapPress;

  // ─────────────────────── v3 design + a11y properties ──────────────────────

  /// Visual treatment for the selected sliding pill.
  final TogglePillStyle pillStyle;

  /// Optional custom gradient for the track background.
  final Gradient? trackGradient;

  /// Optional outline color for styles that draw a track stroke.
  final Color? trackBorderColor;

  /// Opacity used for disabled items.
  final double disabledOpacity;

  /// Accessible labels for each switch item. Falls back to labels/tooltips.
  final List<String?>? semanticLabels;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether the toggle should request focus automatically.
  final bool autofocus;

  /// Enables arrow/home/end/space/enter keyboard interactions.
  final bool enableKeyboardNavigation;

  /// Focus ring color. Defaults to the theme primary color.
  final Color? focusBorderColor;

  FlutterToggle({
    super.key,
    // existing
    this.totalSwitches,
    this.labels,
    this.states,
    this.borderColor,
    this.borderWidth,
    this.dividerColor = Colors.white30,
    this.activeBgColor,
    this.activeFgColor,
    this.inactiveBgColor,
    this.inactiveFgColor,
    this.onToggle,
    this.cancelToggle,
    this.cornerRadius = 8.0,
    this.initialLabelIndex = 0,
    this.minWidth = 72.0,
    this.minHeight = 40.0,
    this.changeOnTap = true,
    this.icons,
    this.activeBgColors,
    this.customTextStyles,
    this.customIcons,
    this.customWidths,
    this.customHeights,
    this.animate = false,
    this.animationDuration = 500,
    this.curve = Curves.easeInOut,
    this.radiusStyle = false,
    this.textDirectionRTL = false,
    this.fontSize = 14.0,
    this.iconSize = 17.0,
    this.dividerMargin = 8.0,
    this.doubleTapDisable = false,
    this.isVertical = false,
    this.activeBorders,
    this.centerText = false,
    this.multiLineText = false,
    this.customWidgets,
    this.isSelectedLableIndicator = false,
    this.indicatorColor,
    this.indicatorHeight = 3.0,
    this.indicatorWidth,
    // v1.5
    this.elevation = 0.0,
    this.shadowColor,
    this.hapticFeedback = false,
    this.tooltips,
    this.iconPosition = IconPosition.left,
    this.activeScale = 1.0,
    this.slidingPill = false,
    this.pillElevation = 0.0,
    this.pillShadowColor,
    this.splashColor,
    // v2
    this.animationStyle,
    this.decorationStyle = ToggleDecorationStyle.solid,
    this.glassBlur = 14.0,
    this.glowColor,
    this.glowRadius = 18.0,
    this.enableRippleWave = false,
    this.rippleWaveColor,
    this.enableActiveShimmer = false,
    this.shimmerColor = Colors.white,
    this.animateBorder = false,
    this.borderAnimationDuration = const Duration(seconds: 3),
    this.pillInset = const EdgeInsets.all(3),
    this.enableIconWiggle = false,
    this.enableTapPress = true,
    // v3
    this.pillStyle = TogglePillStyle.filled,
    this.trackGradient,
    this.trackBorderColor,
    this.disabledOpacity = 0.45,
    this.semanticLabels,
    this.focusNode,
    this.autofocus = false,
    this.enableKeyboardNavigation = true,
    this.focusBorderColor,
    this.style = ToggleStyle.standard,
  });

  @override
  // ignore: no_logic_in_create_state
  FlutterToggleState createState() => FlutterToggleState();
}

class FlutterToggleState extends State<FlutterToggle>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<FlutterToggle> {
  late List<Color> _borderColor;
  late double _borderWidth;
  late double _cornerRadius;
  late int _totalSwitches;

  // Animation controllers
  late AnimationController _borderCtrl;
  late AnimationController _rippleCtrl;
  late AnimationController _shimmerCtrl;
  late AnimationController _wiggleCtrl;

  // Ripple state
  int? _ripplingIndex;
  Offset? _rippleLocalPos;

  // Press-in state
  int? _pressedIndex;
  bool _hasFocus = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _totalSwitches =
        widget.totalSwitches ??
        [
          widget.labels?.length ?? 0,
          widget.icons?.length ?? 0,
          widget.customIcons?.length ?? 0,
          widget.customWidgets?.length ?? 0,
        ].reduce(max);

    _borderColor = widget.borderColor ?? [Colors.transparent];
    if (_borderColor.length == 1) {
      _borderColor = List<Color>.filled(2, _borderColor[0]);
    }
    _borderWidth =
        widget.borderWidth ?? (widget.borderColor == null ? 0.0 : 3.0);
    _cornerRadius = widget.cornerRadius - _borderWidth;

    _borderCtrl = AnimationController(
      vsync: this,
      duration: widget.borderAnimationDuration,
    );
    if (_needsAmbientAnimation) _borderCtrl.repeat();

    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _wiggleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
  }

  @override
  void didUpdateWidget(covariant FlutterToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _totalSwitches = _resolveTotalSwitches();
    if (oldWidget.borderAnimationDuration != widget.borderAnimationDuration) {
      _borderCtrl.duration = widget.borderAnimationDuration;
    }
    if (_needsAmbientAnimation && !_borderCtrl.isAnimating) {
      _borderCtrl.repeat();
    } else if (!_needsAmbientAnimation && _borderCtrl.isAnimating) {
      _borderCtrl.stop();
    }
  }

  @override
  void dispose() {
    _borderCtrl.dispose();
    _rippleCtrl.dispose();
    _shimmerCtrl.dispose();
    _wiggleCtrl.dispose();
    super.dispose();
  }

  // ── Derived helpers ──────────────────────────────────────────────────────

  ToggleAnimationStyle get _effectiveStyle =>
      widget.animationStyle ??
      (widget.slidingPill
          ? ToggleAnimationStyle.slide
          : ToggleAnimationStyle.fade);

  bool get _usesPill {
    final s = _effectiveStyle;
    return widget.slidingPill ||
        s == ToggleAnimationStyle.slide ||
        s == ToggleAnimationStyle.elastic ||
        s == ToggleAnimationStyle.morph;
  }

  Duration get _animDuration =>
      Duration(milliseconds: widget.animate ? widget.animationDuration : 0);

  bool get _needsAmbientAnimation =>
      widget.animateBorder ||
      widget.decorationStyle == ToggleDecorationStyle.aurora ||
      widget.pillStyle == TogglePillStyle.liquid;

  Curve get _effectiveCurve {
    switch (_effectiveStyle) {
      case ToggleAnimationStyle.elastic:
        return Curves.elasticOut;
      case ToggleAnimationStyle.morph:
        return Curves.easeOutCubic;
      default:
        return widget.curve;
    }
  }

  int _resolveTotalSwitches() {
    return widget.totalSwitches ??
        [
          widget.labels?.length ?? 0,
          widget.icons?.length ?? 0,
          widget.customIcons?.length ?? 0,
          widget.customWidgets?.length ?? 0,
        ].reduce(max);
  }

  bool _isEnabled(List<bool> states, int index) =>
      index >= 0 && index < states.length && states[index];

  bool _isActive(List<bool> states, int index) =>
      widget.initialLabelIndex == index && _isEnabled(states, index);

  int? _selectedIndexOrNull() {
    final index = widget.initialLabelIndex;
    if (index == null || _totalSwitches == 0) return null;
    return index.clamp(0, _totalSwitches - 1);
  }

  // ── Build ────────────────────────────────────────────────────────────────

  Widget _buildUnifiedStyle(BuildContext context) {
    final labels = widget.labels ?? [];
    final index = widget.initialLabelIndex ?? 0;
    final activeBg = widget.activeBgColor ?? [Theme.of(context).primaryColor];
    final inactiveBg =
        widget.inactiveBgColor ?? Theme.of(context).disabledColor;
    final activeFg = widget.activeFgColor ?? Colors.white;
    final inactiveFg = widget.inactiveFgColor ?? Colors.grey;

    switch (widget.style) {
      case ToggleStyle.underline:
        return UnderlineTabBar(
          tabs: labels,
          selectedIndex: index,
          onChanged: (i) {
            if (widget.changeOnTap) {
              setState(() => widget.initialLabelIndex = i);
            }
            widget.onToggle?.call(i);
          },
          activeColor: activeFg,
          inactiveColor: inactiveFg,
          indicatorColor: widget.indicatorColor ?? activeBg.first,
          semanticLabels: widget.semanticLabels?.whereType<String>().toList(),
          duration: Duration(milliseconds: widget.animationDuration),
          curve: widget.curve,
          height: widget.minHeight,
        );
      case ToggleStyle.stackedCards:
        return StackedCardsTabBar(
          tabs: labels,
          icons: widget.icons?.whereType<IconData>().toList(),
          selectedIndex: index,
          onChanged: (i) {
            if (widget.changeOnTap) {
              setState(() => widget.initialLabelIndex = i);
            }
            widget.onToggle?.call(i);
          },
          activeAccentColor: activeBg.first,
          inactiveColor: inactiveBg,
          activeLabelColor: activeBg.first,
          inactiveLabelColor: inactiveFg,
          semanticLabels: widget.semanticLabels?.whereType<String>().toList(),
          duration: Duration(milliseconds: widget.animationDuration),
          curve: widget.curve,
          height: widget.minHeight,
          cornerRadius: widget.cornerRadius,
        );
      case ToggleStyle.magneticBlob:
        return MagneticBlobTabBar(
          tabs: labels,
          selectedIndex: index,
          onChanged: (i) {
            if (widget.changeOnTap) {
              setState(() => widget.initialLabelIndex = i);
            }
            widget.onToggle?.call(i);
          },
          blobGradient: activeBg,
          trackColor: inactiveBg,
          activeLabelColor: activeFg,
          inactiveLabelColor: inactiveFg,
          semanticLabels: widget.semanticLabels?.whereType<String>().toList(),
          duration: Duration(milliseconds: widget.animationDuration),
          curve: widget.curve,
          height: widget.minHeight,
        );
      case ToggleStyle.standard:
        return const SizedBox.shrink(); // Handled in main build
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.style != ToggleStyle.standard) {
      return _buildUnifiedStyle(context);
    }
    if (_totalSwitches <= 0) return const SizedBox.shrink();

    final List<bool> states =
        widget.states ?? List<bool>.filled(_totalSwitches, true);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inactiveBgColor =
        widget.inactiveBgColor ?? Theme.of(context).disabledColor;

    Color trackColor;
    Gradient? trackGradient = widget.trackGradient;
    Border? trackBorder;
    List<BoxShadow>? trackShadows;

    switch (widget.decorationStyle) {
      case ToggleDecorationStyle.solid:
        trackColor = inactiveBgColor;
      case ToggleDecorationStyle.glass:
        trackColor = inactiveBgColor.withValues(alpha: 0.35);
      case ToggleDecorationStyle.neumorphic:
        trackColor = inactiveBgColor;
        trackShadows = _neumorphicShadows(inactiveBgColor);
      case ToggleDecorationStyle.outlined:
        trackColor = Colors.transparent;
        trackBorder = Border.all(
          color:
              widget.trackBorderColor ??
              _borderColor.last.withValues(alpha: 0.30),
          width: 1,
        );
      case ToggleDecorationStyle.tonal:
        trackColor = Color.alphaBlend(
          colorScheme.primary.withValues(alpha: 0.08),
          colorScheme.surface,
        );
        trackBorder = Border.all(
          color:
              widget.trackBorderColor ??
              colorScheme.primary.withValues(alpha: 0.14),
          width: 1,
        );
      case ToggleDecorationStyle.floating:
        trackColor = widget.inactiveBgColor ?? colorScheme.surface;
        trackBorder = Border.all(
          color:
              widget.trackBorderColor ??
              colorScheme.outlineVariant.withValues(alpha: 0.65),
          width: 1,
        );
        trackShadows = [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.55),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ];
      case ToggleDecorationStyle.aurora:
        final colors = _normalizedColors(
          widget.activeBgColor ?? [colorScheme.primary, colorScheme.tertiary],
        );
        trackColor =
            widget.inactiveBgColor?.withValues(alpha: 0.72) ??
            colorScheme.surface.withValues(alpha: 0.86);
        trackGradient ??= LinearGradient(
          colors: [
            colors.first.withValues(alpha: 0.18),
            colors.last.withValues(alpha: 0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        trackBorder = Border.all(
          color:
              widget.trackBorderColor ?? Colors.white.withValues(alpha: 0.40),
          width: 1,
        );
    }

    if (widget.elevation > 0 &&
        widget.decorationStyle != ToggleDecorationStyle.neumorphic) {
      trackShadows = [
        BoxShadow(
          color: widget.shadowColor ?? Colors.black.withValues(alpha: 0.22),
          blurRadius: widget.elevation * 2.5,
          spreadRadius: widget.elevation * 0.4,
          offset: Offset(0, widget.elevation),
        ),
      ];
    }

    // Neumorphic inset depth gradient (simulates pressed-in look).
    BoxDecoration? neumorphicFg;
    if (widget.decorationStyle == ToggleDecorationStyle.neumorphic) {
      neumorphicFg = BoxDecoration(
        borderRadius: BorderRadius.circular(_cornerRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withValues(alpha: 0.07),
            Colors.transparent,
            Colors.transparent,
            Colors.white.withValues(alpha: 0.09),
          ],
          stops: const [0.0, 0.35, 0.65, 1.0],
        ),
      );
    }

    Widget trackChild = _usesPill
        ? _buildWithSlidingPill(states: states)
        : RowToColumn(
            isVertical: widget.isVertical,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_totalSwitches * 2 - 1, (i) {
              final active = _isActive(states, i ~/ 2);
              return i % 2 == 1
                  ? _divider(index: i, active: active)
                  : _switchItem(index: i, active: active, states: states);
            }),
          );

    if (widget.decorationStyle == ToggleDecorationStyle.aurora &&
        widget.trackGradient == null) {
      final colors = _normalizedColors(
        widget.activeBgColor ?? [colorScheme.primary, colorScheme.tertiary],
      );
      trackChild = ClipRRect(
        borderRadius: BorderRadius.circular(_cornerRadius),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _AuroraTrackPainter(
                  colors: colors,
                  accent: colorScheme.secondary,
                  animation: _borderCtrl,
                ),
              ),
            ),
            trackChild,
          ],
        ),
      );
    }

    Widget core = Container(
      margin: EdgeInsets.all(_borderWidth),
      decoration: BoxDecoration(
        color: trackColor,
        gradient: trackGradient,
        border: _hasFocus
            ? Border.all(
                color: widget.focusBorderColor ?? colorScheme.primary,
                width: 2,
              )
            : trackBorder,
        borderRadius: BorderRadius.circular(_cornerRadius),
        boxShadow: trackShadows,
      ),
      foregroundDecoration: neumorphicFg,
      height: !widget.isVertical ? widget.minHeight + _borderWidth : null,
      width: widget.isVertical ? widget.minWidth + _borderWidth : null,
      child: trackChild,
    );

    // Glassmorphism blur wrapper.
    if (widget.decorationStyle == ToggleDecorationStyle.glass) {
      core = ClipRRect(
        borderRadius: BorderRadius.circular(widget.cornerRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.glassBlur,
            sigmaY: widget.glassBlur,
          ),
          child: core,
        ),
      );
    }

    Widget result = Directionality(
      textDirection: widget.textDirectionRTL
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: AnimatedBuilder(
        animation: _borderCtrl,
        builder: (context, child) => CustomPaint(
          painter: CustomBorderPaint(
            thickness: _borderWidth,
            radius: Radius.circular(widget.cornerRadius),
            gradient: widget.animateBorder
                ? SweepGradient(colors: _borderColor)
                : LinearGradient(
                    colors: _borderColor,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            animationValue: widget.animateBorder ? _borderCtrl.value : 0.0,
          ),
          child: child,
        ),
        child: core,
      ),
    );

    if (widget.enableKeyboardNavigation) {
      result = Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onFocusChange: (focused) => setState(() => _hasFocus = focused),
        onKeyEvent: (node, event) => _handleKeyEvent(event, states),
        child: result,
      );
    }

    return Semantics(container: true, child: result);
  }

  // ── Neumorphic shadow helpers ────────────────────────────────────────────

  List<BoxShadow> _neumorphicShadows(Color base) {
    final hsl = HSLColor.fromColor(base);
    final lighter = hsl
        .withLightness((hsl.lightness + 0.10).clamp(0.0, 1.0))
        .toColor();
    final darker = hsl
        .withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0))
        .toColor();
    return [
      BoxShadow(
        color: lighter,
        offset: const Offset(-5, -5),
        blurRadius: 12,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: darker,
        offset: const Offset(5, 5),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ];
  }

  // ── Sliding-pill layout ──────────────────────────────────────────────────

  Widget _buildWithSlidingPill({required List<bool> states}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final activeBgColor =
            widget.activeBgColor ?? [Theme.of(context).primaryColor];

        final List<double> itemSizes = List.generate(_totalSwitches, (i) {
          if (widget.isVertical) {
            return widget.customHeights != null &&
                    i < widget.customHeights!.length
                ? widget.customHeights![i]
                : widget.minHeight;
          } else {
            if (widget.customWidths != null &&
                i < widget.customWidths!.length) {
              return widget.customWidths![i];
            }
            final avail = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : _totalSwitches * widget.minWidth;
            return avail / _totalSwitches;
          }
        });

        double pillOffset = 0;
        final int activeIdx = _selectedIndexOrNull() ?? 0;
        if (widget.initialLabelIndex != null) {
          for (int i = 0; i < activeIdx; i++) {
            pillOffset += itemSizes[i];
          }
        }
        final double pillSize = itemSizes[activeIdx];

        List<Color> pillColor =
            (widget.initialLabelIndex != null &&
                widget.activeBgColors != null &&
                widget.initialLabelIndex! < widget.activeBgColors!.length)
            ? (widget.activeBgColors![widget.initialLabelIndex!] ??
                  activeBgColor)
            : activeBgColor;
        pillColor = _normalizedColors(pillColor);

        final glowColor =
            widget.glowColor ?? pillColor.last.withValues(alpha: 0.55);
        final inset = widget.pillInset;
        // Pill corner radius: tighten by the inset so corners don't overlap track.
        final pillRadius = (_cornerRadius - inset.left * 0.5).clamp(
          0.0,
          _cornerRadius,
        );

        return ClipRRect(
          borderRadius: BorderRadius.circular(_cornerRadius),
          child: Stack(
            children: [
              // Glow halo (behind pill)
              if (widget.initialLabelIndex != null)
                AnimatedPositioned(
                  duration: _animDuration,
                  curve: _effectiveCurve,
                  left: widget.isVertical
                      ? inset.left
                      : (widget.textDirectionRTL
                            ? null
                            : pillOffset + inset.left),
                  right: widget.isVertical
                      ? inset.right
                      : (widget.textDirectionRTL
                            ? pillOffset + inset.right
                            : null),
                  top: widget.isVertical ? pillOffset + inset.top : inset.top,
                  bottom: widget.isVertical ? null : inset.bottom,
                  child: AnimatedContainer(
                    duration: _animDuration,
                    curve: _effectiveCurve,
                    width: widget.isVertical
                        ? null
                        : pillSize - inset.horizontal,
                    height: widget.isVertical
                        ? pillSize - inset.vertical
                        : null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(pillRadius),
                      boxShadow: widget.glowRadius > 0
                          ? [
                              BoxShadow(
                                color: glowColor,
                                blurRadius: widget.glowRadius,
                                spreadRadius: widget.glowRadius * 0.15,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),

              // Animated pill
              if (widget.initialLabelIndex != null)
                AnimatedPositioned(
                  duration: _animDuration,
                  curve: _effectiveCurve,
                  left: widget.isVertical
                      ? inset.left
                      : (widget.textDirectionRTL
                            ? null
                            : pillOffset + inset.left),
                  right: widget.isVertical
                      ? inset.right
                      : (widget.textDirectionRTL
                            ? pillOffset + inset.right
                            : null),
                  top: widget.isVertical ? pillOffset + inset.top : inset.top,
                  bottom: widget.isVertical ? null : inset.bottom,
                  child: AnimatedContainer(
                    duration: _animDuration,
                    curve: _effectiveCurve,
                    width: widget.isVertical
                        ? null
                        : pillSize - inset.horizontal,
                    height: widget.isVertical
                        ? pillSize - inset.vertical
                        : null,
                    decoration: _pillDecoration(
                      colors: pillColor,
                      radius: pillRadius,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(pillRadius),
                      child: _pillEffects(colors: pillColor),
                    ),
                  ),
                ),

              // Items row/column above the pill (transparent background).
              RowToColumn(
                isVertical: widget.isVertical,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_totalSwitches * 2 - 1, (i) {
                  final active = _isActive(states, i ~/ 2);
                  return i % 2 == 1
                      ? _divider(
                          index: i,
                          active: active,
                          forceTransparent: true,
                        )
                      : _switchItem(
                          index: i,
                          active: active,
                          states: states,
                          transparentBg: true,
                        );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration _pillDecoration({
    required List<Color> colors,
    required double radius,
  }) {
    final baseShadow =
        widget.pillElevation > 0 || widget.pillStyle == TogglePillStyle.soft
        ? [
            BoxShadow(
              color:
                  widget.pillShadowColor ??
                  colors.last.withValues(
                    alpha: widget.pillStyle == TogglePillStyle.soft
                        ? 0.32
                        : 0.40,
                  ),
              blurRadius:
                  (widget.pillElevation > 0 ? widget.pillElevation : 5) * 2.5,
              spreadRadius: widget.pillStyle == TogglePillStyle.soft
                  ? 0
                  : widget.pillElevation * 0.3,
              offset: Offset(
                0,
                widget.pillElevation > 0 ? widget.pillElevation : 5,
              ),
            ),
          ]
        : null;

    switch (widget.pillStyle) {
      case TogglePillStyle.filled:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: baseShadow,
        );
      case TogglePillStyle.glass:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: colors.map((c) => c.withValues(alpha: 0.44)).toList(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.42),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: baseShadow,
        );
      case TogglePillStyle.outline:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: colors.last, width: 1.4),
          borderRadius: BorderRadius.circular(radius),
        );
      case TogglePillStyle.soft:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.22),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: baseShadow,
        );
      case TogglePillStyle.liquid:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: baseShadow,
        );
    }
  }

  Widget _pillEffects({required List<Color> colors}) {
    final children = <Widget>[];

    if (widget.pillStyle == TogglePillStyle.liquid) {
      children.add(
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _borderCtrl,
            builder: (context, child) => CustomPaint(
              painter: _LiquidPillPainter(
                colors: colors,
                progress: _borderCtrl.value,
              ),
            ),
          ),
        ),
      );
    }

    if (widget.enableActiveShimmer) {
      children.add(Positioned.fill(child: _shimmerOverlay()));
    }

    if (children.isEmpty) return const SizedBox.expand();
    return Stack(children: children);
  }

  // ── Shimmer sweep overlay ────────────────────────────────────────────────
  // Uses SizedBox.expand (NOT Positioned.fill) so it is safe as the child of
  // any widget — not only a direct Stack child.
  Widget _shimmerOverlay() {
    return AnimatedBuilder(
      animation: _shimmerCtrl,
      builder: (context, child) {
        if (!_shimmerCtrl.isAnimating || _shimmerCtrl.value == 0) {
          return const SizedBox.shrink();
        }
        final t = _shimmerCtrl.value;
        return SizedBox.expand(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.2 + t * 2.4, -1.0),
                  end: Alignment(-0.6 + t * 2.4, 1.0),
                  colors: [
                    widget.shimmerColor.withValues(alpha: 0.0),
                    widget.shimmerColor.withValues(alpha: 0.0),
                    widget.shimmerColor.withValues(alpha: 0.38),
                    widget.shimmerColor.withValues(alpha: 0.0),
                    widget.shimmerColor.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.38, 0.5, 0.62, 1.0],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Divider ──────────────────────────────────────────────────────────────

  Container _divider({
    required int index,
    required bool active,
    bool forceTransparent = false,
  }) {
    final activeDivider =
        active ||
        (widget.initialLabelIndex != null &&
            index ~/ 2 == widget.initialLabelIndex! - 1);
    final color = (forceTransparent || activeDivider)
        ? Colors.transparent
        : widget.dividerColor;
    return Container(
      width: !widget.isVertical ? 1 : double.infinity,
      height: widget.isVertical ? 1 : double.infinity,
      color: color,
      margin: widget.isVertical
          ? EdgeInsets.symmetric(
              horizontal: (activeDivider || forceTransparent)
                  ? 0.0
                  : widget.dividerMargin!,
            )
          : EdgeInsets.symmetric(
              vertical: (activeDivider || forceTransparent)
                  ? 0.0
                  : widget.dividerMargin!,
            ),
    );
  }

  // ── Switch item ──────────────────────────────────────────────────────────

  Widget _switchItem({
    required int index,
    required bool active,
    required List<bool> states,
    bool transparentBg = false,
  }) {
    final inactiveFgColor =
        widget.inactiveFgColor ?? Theme.of(context).textTheme.bodyLarge!.color;
    final activeFgColor =
        widget.activeFgColor ??
        Theme.of(context).primaryTextTheme.bodyLarge!.color;
    final activeBgColor =
        widget.activeBgColor ?? [Theme.of(context).primaryColor];
    final itemIdx = index ~/ 2;
    final enabled = _isEnabled(states, itemIdx);
    final fgColor = active ? activeFgColor : inactiveFgColor;

    List<Color> bgColor = [Colors.transparent];
    if (active && !transparentBg) {
      bgColor =
          widget.activeBgColors == null ||
              itemIdx >= widget.activeBgColors!.length
          ? activeBgColor
          : (widget.activeBgColors![itemIdx] ?? activeBgColor);
    }
    bgColor = _normalizedColors(bgColor);

    final height = Utils.calculateHeight(
      context: context,
      index: itemIdx,
      totalSwitches: _totalSwitches,
      customHeights: widget.customHeights,
      minHeight: widget.minHeight,
    );
    final width = Utils.calculateWidth(
      context: context,
      index: itemIdx,
      totalSwitches: _totalSwitches,
      customWidths: widget.customWidths,
      minWidth: widget.minWidth,
    );

    Border? activeBorder;
    if (widget.activeBorders != null && !transparentBg) {
      activeBorder = widget.activeBorders!.length == 1
          ? widget.activeBorders![0]
          : (widget.activeBorders!.length > itemIdx &&
                    widget.activeBorders![itemIdx] != null
                ? widget.activeBorders![itemIdx]!
                : null);
    }

    // Build icon with animated color transition.
    final icon = _icon(
      index: itemIdx,
      height: height,
      width: width,
      fgColor: fgColor,
      active: active,
    );

    // Build icon + text layout (Text inherits style from DefaultTextStyle).
    Widget content =
        widget.customWidgets != null && itemIdx < widget.customWidgets!.length
        ? widget.customWidgets![itemIdx]
        : _buildIconTextLayout(
            index: itemIdx,
            icon: icon,
            fgColor: fgColor,
            width: width,
          );

    // Always use AnimatedDefaultTextStyle so color + weight animate smoothly.
    // When animate is off, duration is zero — instant change, no overhead.
    if (widget.customWidgets == null) {
      content = AnimatedDefaultTextStyle(
        duration: _animDuration,
        curve: _effectiveCurve,
        style: _textStyle(index: itemIdx, fgColor: fgColor, active: active),
        child: content,
      );
    }

    // Icon wiggle for newly-active item.
    if (active && widget.enableIconWiggle) {
      content = AnimatedBuilder(
        animation: _wiggleCtrl,
        builder: (context, child) {
          final v = _wiggleCtrl.value;
          final angle = sin(v * pi * 3) * (1 - v) * 0.12;
          return Transform.rotate(angle: angle, child: child);
        },
        child: content,
      );
    }

    // Optional bottom-of-item indicator bar.
    Widget itemBody = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        content,
        if (active && widget.isSelectedLableIndicator) ...[
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: _animDuration,
            curve: _effectiveCurve,
            width: widget.indicatorWidth ?? width * 0.4,
            height: widget.indicatorHeight,
            decoration: BoxDecoration(
              color: widget.indicatorColor ?? activeFgColor,
              borderRadius: BorderRadius.circular(widget.indicatorHeight / 2),
            ),
          ),
        ],
      ],
    );

    // Background container (no background when sliding-pill handles it).
    final bool showBg =
        !transparentBg && !(active && widget.isSelectedLableIndicator);

    Widget itemContainer = AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      constraints: BoxConstraints(
        maxWidth: widget.isVertical ? const BoxConstraints().maxWidth : width,
        maxHeight: widget.isVertical
            ? height
            : const BoxConstraints().maxHeight,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: active && !transparentBg ? activeBorder : null,
        borderRadius: widget.radiusStyle
            ? BorderRadius.all(Radius.circular(_cornerRadius))
            : _borderRadius(index: index),
        gradient: showBg
            ? LinearGradient(
                colors: bgColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),
      duration: _animDuration,
      curve: _effectiveCurve,
      child: itemBody,
    );

    // Active-scale + press-in animation.
    final double scale = (_pressedIndex == itemIdx && widget.enableTapPress)
        ? 0.93
        : (active ? widget.activeScale : 1.0);

    Widget animated = AnimatedScale(
      scale: scale,
      duration: _animDuration,
      curve: _effectiveCurve,
      child: AnimatedOpacity(
        duration: _animDuration,
        curve: _effectiveCurve,
        opacity: enabled ? 1.0 : widget.disabledOpacity.clamp(0.0, 1.0),
        child: itemContainer,
      ),
    );

    // Ripple wave overlay.
    if (widget.enableRippleWave && _ripplingIndex == itemIdx) {
      animated = Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          animated,
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _rippleCtrl,
                builder: (context, child) => CustomPaint(
                  painter: _RippleWavePainter(
                    progress: _rippleCtrl.value,
                    origin: _rippleLocalPos ?? Offset(width / 2, height / 2),
                    color:
                        widget.rippleWaveColor ??
                        widget.splashColor ??
                        (bgColor.isNotEmpty
                            ? bgColor.last
                            : activeFgColor ?? Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Optional tooltip.
    if (widget.tooltips != null &&
        widget.tooltips!.length > itemIdx &&
        widget.tooltips![itemIdx] != null) {
      animated = Tooltip(message: widget.tooltips![itemIdx]!, child: animated);
    }

    final borderRadius = widget.radiusStyle
        ? BorderRadius.all(Radius.circular(_cornerRadius))
        : (_borderRadius(index: index) ?? BorderRadius.zero);

    return Flexible(
      child: Semantics(
        container: true,
        button: true,
        selected: active,
        enabled: enabled,
        label: _semanticLabel(itemIdx),
        inMutuallyExclusiveGroup: true,
        child: MouseRegion(
          cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              canRequestFocus: false,
              onTap: enabled ? () => _handleOnTap(itemIdx) : null,
              onTapDown: enabled
                  ? (details) {
                      if (widget.enableTapPress && !widget.enableRippleWave) {
                        setState(() => _pressedIndex = itemIdx);
                      }
                      if (widget.enableRippleWave) {
                        _rippleLocalPos = details.localPosition;
                        _ripplingIndex = itemIdx;
                        _rippleCtrl.forward(from: 0);
                      }
                    }
                  : null,
              onTapCancel: () {
                if (_pressedIndex != null) setState(() => _pressedIndex = null);
              },
              onTapUp: (_) {
                if (_pressedIndex != null) setState(() => _pressedIndex = null);
              },
              splashColor: widget.enableRippleWave
                  ? Colors.transparent
                  : (widget.splashColor ?? Colors.transparent),
              highlightColor: widget.enableRippleWave
                  ? Colors.transparent
                  : (widget.splashColor != null
                        ? widget.splashColor!.withValues(alpha: 0.12)
                        : Colors.transparent),
              borderRadius: borderRadius,
              child: animated,
            ),
          ),
        ),
      ),
    );
  }

  // ── Icon + text layout ────────────────────────────────────────────────────
  // Text widget has NO explicit style — it inherits from the
  // AnimatedDefaultTextStyle ancestor set in _switchItem, enabling smooth
  // color + weight transitions. fgColor is kept for icon tinting only.
  Widget _buildIconTextLayout({
    required int index,
    required Widget icon,
    required Color? fgColor,
    required double width,
  }) {
    final bool hasIcon = icon is! SizedBox;
    final label = widget.labels?[index] ?? '';
    final hasLabel = label.isNotEmpty;

    // No explicit style: inherits AnimatedDefaultTextStyle from ancestor.
    final textWidget = Text(
      label,
      textAlign: widget.centerText ? TextAlign.center : null,
      overflow: !widget.multiLineText ? TextOverflow.ellipsis : null,
    );

    switch (widget.iconPosition) {
      case IconPosition.top:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasIcon) icon,
            if (hasIcon && hasLabel) const SizedBox(height: 4),
            if (hasLabel) textWidget,
          ],
        );

      case IconPosition.bottom:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasLabel) textWidget,
            if (hasIcon && hasLabel) const SizedBox(height: 4),
            if (hasIcon) icon,
          ],
        );

      case IconPosition.right:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasLabel)
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(right: hasIcon ? 5.0 : 0.0),
                  child: textWidget,
                ),
              ),
            if (hasIcon) icon,
          ],
        );

      case IconPosition.left:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Flexible(
              child: Container(
                padding: EdgeInsets.only(left: hasIcon ? 5.0 : 0.0),
                child: textWidget,
              ),
            ),
          ],
        );
    }
  }

  // ── Tap handler ───────────────────────────────────────────────────────────

  void _handleOnTap(int index) async {
    if (index < 0 || index >= _totalSwitches) {
      return;
    }
    if (widget.hapticFeedback) HapticFeedback.lightImpact();

    int? newIndex = index;
    if (widget.doubleTapDisable && widget.initialLabelIndex == index) {
      newIndex = null;
    }

    final cancel = await widget.cancelToggle?.call(newIndex) ?? false;
    if (cancel) return;

    if (widget.changeOnTap) {
      setState(() => widget.initialLabelIndex = newIndex);
      if (widget.enableActiveShimmer) _shimmerCtrl.forward(from: 0);
      if (widget.enableIconWiggle) _wiggleCtrl.forward(from: 0);
    }
    widget.onToggle?.call(newIndex);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Creates the icon widget with an animated color transition.
  Widget _icon({
    required int index,
    required double height,
    required double width,
    required Color? fgColor,
    required bool active,
  }) {
    if (widget.customIcons != null &&
        index < widget.customIcons!.length &&
        widget.customIcons![index] != null) {
      return widget.customIcons![index]!;
    }

    if (widget.icons == null ||
        index >= widget.icons!.length ||
        widget.icons![index] == null) {
      return const SizedBox();
    }

    final size = widget.isVertical
        ? (widget.iconSize > height / 3 ? height / 3 : widget.iconSize)
        : (widget.iconSize > width / 3 ? width / 3 : widget.iconSize);

    // TweenAnimationBuilder smoothly transitions the icon color.
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: fgColor),
      duration: _animDuration,
      curve: _effectiveCurve,
      builder: (context, color, child) =>
          Icon(widget.icons![index], color: color, size: size),
    );
  }

  /// Resolves the text style for an item, incorporating active weight
  /// and any per-item [customTextStyles].
  TextStyle _textStyle({
    required int index,
    Color? fgColor,
    bool active = false,
  }) {
    // Active items get slightly bolder text for visual emphasis.
    final fontWeight = active ? FontWeight.w600 : FontWeight.w400;
    final defaultStyle = TextStyle(
      color: fgColor,
      fontSize: widget.fontSize,
      fontWeight: fontWeight,
    );

    if (widget.customTextStyles == null) return defaultStyle;

    TextStyle merge(TextStyle? custom) {
      if (custom == null) return defaultStyle;
      return defaultStyle.merge(
        custom.copyWith(color: custom.color ?? fgColor),
      );
    }

    if (widget.customTextStyles!.length == 1) {
      return merge(widget.customTextStyles![0]);
    }
    if (widget.customTextStyles!.length > index &&
        widget.customTextStyles![index] != null) {
      return merge(widget.customTextStyles![index]);
    }
    return defaultStyle;
  }

  BorderRadius? _borderRadius({required int index}) {
    BorderRadius? r;
    if (index == 0 && !widget.isVertical) {
      r = widget.textDirectionRTL
          ? BorderRadius.horizontal(right: Radius.circular(_cornerRadius))
          : BorderRadius.horizontal(left: Radius.circular(_cornerRadius));
    }
    if (index == 0 && widget.isVertical) {
      r = BorderRadius.vertical(top: Radius.circular(_cornerRadius));
    }
    if (index ~/ 2 == _totalSwitches - 1 && !widget.isVertical) {
      r = widget.textDirectionRTL
          ? BorderRadius.horizontal(left: Radius.circular(_cornerRadius))
          : BorderRadius.horizontal(right: Radius.circular(_cornerRadius));
    }
    if (index ~/ 2 == _totalSwitches - 1 && widget.isVertical) {
      r = BorderRadius.vertical(bottom: Radius.circular(_cornerRadius));
    }
    return r;
  }

  List<Color> _normalizedColors(List<Color> colors) {
    if (colors.isEmpty) return [Colors.transparent, Colors.transparent];
    if (colors.length == 1) return [colors.first, colors.first];
    return colors;
  }

  String? _semanticLabel(int index) {
    if (widget.semanticLabels != null &&
        index < widget.semanticLabels!.length &&
        widget.semanticLabels![index] != null) {
      return widget.semanticLabels![index];
    }
    if (widget.labels != null &&
        index < widget.labels!.length &&
        widget.labels![index].isNotEmpty) {
      return widget.labels![index];
    }
    if (widget.tooltips != null && index < widget.tooltips!.length) {
      return widget.tooltips![index];
    }
    return 'Option ${index + 1}';
  }

  KeyEventResult _handleKeyEvent(KeyEvent event, List<bool> states) {
    if (event is! KeyDownEvent || _totalSwitches == 0) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;
    final selected = _selectedIndexOrNull();
    int? target;

    if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.arrowDown) {
      final direction =
          key == LogicalKeyboardKey.arrowRight && widget.textDirectionRTL
          ? -1
          : 1;
      target = _nextEnabledIndex(
        from: selected ?? -1,
        direction: direction,
        states: states,
      );
    } else if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.arrowUp) {
      final direction =
          key == LogicalKeyboardKey.arrowLeft && widget.textDirectionRTL
          ? 1
          : -1;
      target = _nextEnabledIndex(
        from: selected ?? _totalSwitches,
        direction: direction,
        states: states,
      );
    } else if (key == LogicalKeyboardKey.home) {
      target = _nextEnabledIndex(from: -1, direction: 1, states: states);
    } else if (key == LogicalKeyboardKey.end) {
      target = _nextEnabledIndex(
        from: _totalSwitches,
        direction: -1,
        states: states,
      );
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.space) {
      target =
          selected ?? _nextEnabledIndex(from: -1, direction: 1, states: states);
    }

    if (target == null) return KeyEventResult.ignored;
    _handleOnTap(target);
    return KeyEventResult.handled;
  }

  int? _nextEnabledIndex({
    required int from,
    required int direction,
    required List<bool> states,
  }) {
    for (int step = 1; step <= _totalSwitches; step++) {
      final index = (from + direction * step) % _totalSwitches;
      final normalized = index < 0 ? index + _totalSwitches : index;
      if (_isEnabled(states, normalized)) return normalized;
    }
    return null;
  }
}

// ── Ambient painters ─────────────────────────────────────────────────────────

class _AuroraTrackPainter extends CustomPainter {
  final List<Color> colors;
  final Color accent;
  final Animation<double> animation;

  _AuroraTrackPainter({
    required this.colors,
    required this.accent,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final t = animation.value;
    final sweep = SweepGradient(
      colors: [
        colors.first.withValues(alpha: 0.20),
        colors.last.withValues(alpha: 0.26),
        accent.withValues(alpha: 0.22),
        colors.first.withValues(alpha: 0.20),
      ],
      transform: GradientRotation(t * pi * 2),
    );

    canvas.drawRect(rect, Paint()..shader = sweep.createShader(rect));

    final pulse = sin(t * pi * 2) * 0.5 + 0.5;
    canvas.drawCircle(
      Offset(size.width * (0.22 + pulse * 0.10), size.height * 0.15),
      size.shortestSide * 0.70,
      Paint()..color = colors.first.withValues(alpha: 0.10),
    );
    canvas.drawCircle(
      Offset(size.width * (0.78 - pulse * 0.08), size.height * 0.90),
      size.shortestSide * 0.80,
      Paint()..color = colors.last.withValues(alpha: 0.10),
    );
  }

  @override
  bool shouldRepaint(covariant _AuroraTrackPainter old) =>
      old.colors != colors ||
      old.accent != accent ||
      old.animation != animation;
}

class _LiquidPillPainter extends CustomPainter {
  final List<Color> colors;
  final double progress;

  _LiquidPillPainter({required this.colors, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final pulse = sin(progress * pi * 2) * 0.5 + 0.5;
    final paint = Paint()..blendMode = BlendMode.screen;

    paint.color = Colors.white.withValues(alpha: 0.18);
    canvas.drawCircle(
      Offset(size.width * (0.18 + pulse * 0.10), size.height * 0.25),
      size.shortestSide * 0.38,
      paint,
    );

    paint.color = colors.first.withValues(alpha: 0.16);
    canvas.drawCircle(
      Offset(size.width * (0.72 - pulse * 0.08), size.height * 0.80),
      size.shortestSide * 0.48,
      paint,
    );

    paint.color = colors.last.withValues(alpha: 0.14);
    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * (0.18 + pulse * 0.12)),
      size.shortestSide * 0.34,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _LiquidPillPainter old) =>
      old.colors != colors || old.progress != progress;
}

// ── Ripple wave painter ───────────────────────────────────────────────────────

class _RippleWavePainter extends CustomPainter {
  final double progress;
  final Offset origin;
  final Color color;

  _RippleWavePainter({
    required this.progress,
    required this.origin,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final maxRadius = sqrt(size.width * size.width + size.height * size.height);
    final r = maxRadius * progress;
    final alpha = (1.0 - progress).clamp(0.0, 1.0);

    canvas.drawCircle(
      origin,
      r,
      Paint()
        ..color = color.withValues(alpha: 0.18 * alpha)
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      origin,
      r,
      Paint()
        ..color = color.withValues(alpha: 0.55 * alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
  }

  @override
  bool shouldRepaint(covariant _RippleWavePainter old) =>
      old.progress != progress || old.origin != origin || old.color != color;
}

// ─────────────────────────────────────────────────────────────────────────────
// Unique binary switch components
// ─────────────────────────────────────────────────────────────────────────────

typedef _BinarySwitchBuilder =
    Widget Function(
      BuildContext context,
      double progress,
      bool enabled,
      bool focused,
    );

class _BinarySwitchShell extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;
  final _BinarySwitchBuilder builder;

  const _BinarySwitchShell({
    required this.value,
    required this.onChanged,
    required this.enabled,
    required this.duration,
    required this.curve,
    required this.builder,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  State<_BinarySwitchShell> createState() => _BinarySwitchShellState();
}

class _BinarySwitchShellState extends State<_BinarySwitchShell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _focused = false;

  bool get _interactive => widget.enabled && widget.onChanged != null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.value ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(covariant _BinarySwitchShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    _controller.animateTo(
      widget.value ? 1 : 0,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (!_interactive) return;
    if (widget.enabled) HapticFeedback.selectionClick();
    widget.onChanged?.call(!widget.value);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!_interactive || event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.space ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      _toggle();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onFocusChange: (focused) => setState(() => _focused = focused),
      onKeyEvent: _handleKeyEvent,
      child: Semantics(
        label: widget.semanticLabel,
        button: true,
        toggled: widget.value,
        enabled: _interactive,
        onTap: _interactive ? _toggle : null,
        child: MouseRegion(
          cursor: _interactive
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _interactive ? _toggle : null,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => widget.builder(
                context,
                _controller.value,
                _interactive,
                _focused,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A faceted gradient switch with a crisp prism thumb.
///
/// Use this when you want a polished, high-contrast switch that still behaves
/// like a regular accessible binary control.
class PrismToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color activeColor;
  final Color activeAccentColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  const PrismToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 68,
    this.height = 36,
    this.activeColor = const Color(0xFF2563EB),
    this.activeAccentColor = const Color(0xFF22D3EE),
    this.inactiveColor = const Color(0xFFE5E7EB),
    this.thumbColor = Colors.white,
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 320),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    final compactHeight = height.clamp(28.0, 72.0);
    final compactWidth = max(width, compactHeight * 1.7);
    final radius = compactHeight / 2;
    final padding = compactHeight * 0.11;
    final thumbSize = compactHeight - padding * 2;

    return _BinarySwitchShell(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      duration: duration,
      curve: curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbSize - padding,
          progress,
        )!;
        final opacity = interactive ? 1.0 : 0.45;
        return Opacity(
          opacity: opacity,
          child: SizedBox(
            width: compactWidth,
            height: compactHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _PrismTrackPainter(
                      progress: progress,
                      activeColor: activeColor,
                      accentColor: activeAccentColor,
                      inactiveColor: inactiveColor,
                    ),
                  ),
                ),
                if (focused)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                          color:
                              focusColor ??
                              Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: left,
                  top: padding,
                  child: Transform.rotate(
                    angle: progress * pi * 0.08,
                    child: CustomPaint(
                      size: Size(thumbSize, thumbSize),
                      painter: _PrismThumbPainter(
                        color: thumbColor,
                        accent: activeAccentColor.withValues(alpha: progress),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A switch with a thumb orbit ring and satellite accent.
class OrbitToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Color orbitColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  const OrbitToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 72,
    this.height = 38,
    this.activeColor = const Color(0xFF111827),
    this.inactiveColor = const Color(0xFFE5E7EB),
    this.thumbColor = Colors.white,
    this.orbitColor = const Color(0xFFF59E0B),
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 360),
    this.curve = Curves.easeOutBack,
  });

  @override
  Widget build(BuildContext context) {
    final compactHeight = height.clamp(30.0, 76.0);
    final compactWidth = max(width, compactHeight * 1.8);
    final padding = compactHeight * 0.10;
    final thumbSize = compactHeight - padding * 2;
    final radius = compactHeight / 2;

    return _BinarySwitchShell(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      duration: duration,
      curve: curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbSize - padding,
          progress,
        )!;
        final trackColor = Color.lerp(inactiveColor, activeColor, progress)!;
        final satelliteAngle = lerpDouble(-pi * 0.85, pi * 0.25, progress)!;
        final orbitRadius = thumbSize * 0.31;
        final satelliteOffset = Offset(
          cos(satelliteAngle) * orbitRadius,
          sin(satelliteAngle) * orbitRadius,
        );

        return Opacity(
          opacity: interactive ? 1 : 0.45,
          child: SizedBox(
            width: compactWidth,
            height: compactHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: trackColor,
                      borderRadius: BorderRadius.circular(radius),
                      boxShadow: progress > 0.02
                          ? [
                              BoxShadow(
                                color: orbitColor.withValues(
                                  alpha: (0.20 * progress).clamp(0.0, 1.0),
                                ),
                                blurRadius: 14,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
                if (focused)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                          color:
                              focusColor ??
                              Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: left,
                  top: padding,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: thumbColor,
                      border: Border.all(
                        color: orbitColor.withValues(
                          alpha: 0.25 + progress * 0.45,
                        ),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.20),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: thumbSize * 0.58,
                          height: thumbSize * 0.58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: orbitColor.withValues(alpha: 0.55),
                              width: 1,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: satelliteOffset,
                          child: Container(
                            width: thumbSize * 0.17,
                            height: thumbSize * 0.17,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: orbitColor,
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
      },
    );
  }
}

/// A fluid switch with a wave fill that rises as the value turns on.
class WaveToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color waveColor;
  final Color thumbColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  const WaveToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 76,
    this.height = 38,
    this.activeColor = const Color(0xFF0F766E),
    this.inactiveColor = const Color(0xFFE0F2FE),
    this.waveColor = const Color(0xFF2DD4BF),
    this.thumbColor = Colors.white,
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 420),
    this.curve = Curves.easeInOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    final compactHeight = height.clamp(30.0, 76.0);
    final compactWidth = max(width, compactHeight * 1.9);
    final padding = compactHeight * 0.10;
    final thumbSize = compactHeight - padding * 2;
    final radius = compactHeight / 2;

    return _BinarySwitchShell(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      duration: duration,
      curve: curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbSize - padding,
          progress,
        )!;
        return Opacity(
          opacity: interactive ? 1 : 0.45,
          child: SizedBox(
            width: compactWidth,
            height: compactHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _WaveTrackPainter(
                        progress: progress,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        waveColor: waveColor,
                      ),
                    ),
                  ),
                  if (focused)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          border: Border.all(
                            color:
                                focusColor ??
                                Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: left,
                    top: padding,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: thumbColor,
                        boxShadow: [
                          BoxShadow(
                            color: activeColor.withValues(
                              alpha: 0.18 + progress * 0.18,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.water_drop_rounded,
                        size: thumbSize * 0.48,
                        color: Color.lerp(
                          activeColor.withValues(alpha: 0.45),
                          activeColor,
                          progress,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A compact switch with a rotating card thumb and clear on/off icons.
class FlipCardToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeThumbColor;
  final Color inactiveThumbColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  const FlipCardToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 70,
    this.height = 36,
    this.activeColor = const Color(0xFF16A34A),
    this.inactiveColor = const Color(0xFFE5E7EB),
    this.activeThumbColor = Colors.white,
    this.inactiveThumbColor = Colors.white,
    this.activeIconColor = const Color(0xFF16A34A),
    this.inactiveIconColor = const Color(0xFF9CA3AF),
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 340),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    final compactHeight = height.clamp(30.0, 76.0);
    final compactWidth = max(width, compactHeight * 1.8);
    final padding = compactHeight * 0.11;
    final thumbHeight = compactHeight - padding * 2;
    final thumbWidth = thumbHeight * 1.08;
    final radius = compactHeight * 0.24;

    return _BinarySwitchShell(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      duration: duration,
      curve: curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbWidth - padding,
          progress,
        )!;
        final trackColor = Color.lerp(inactiveColor, activeColor, progress)!;
        final iconColor = Color.lerp(
          inactiveIconColor,
          activeIconColor,
          progress,
        )!;

        return Opacity(
          opacity: interactive ? 1 : 0.45,
          child: SizedBox(
            width: compactWidth,
            height: compactHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: duration,
                    curve: curve,
                    decoration: BoxDecoration(
                      color: trackColor,
                      borderRadius: BorderRadius.circular(radius),
                      boxShadow: progress > 0.05
                          ? [
                              BoxShadow(
                                color: activeColor.withValues(
                                  alpha: 0.22 * progress,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
                if (focused)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                          color:
                              focusColor ??
                              Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: left,
                  top: padding,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(progress * pi),
                    child: Container(
                      width: thumbWidth,
                      height: thumbHeight,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          inactiveThumbColor,
                          activeThumbColor,
                          progress,
                        ),
                        borderRadius: BorderRadius.circular(radius * 0.72),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.20),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateY(progress > 0.5 ? pi : 0),
                        child: Icon(
                          progress > 0.5
                              ? Icons.check_rounded
                              : Icons.close_rounded,
                          size: thumbHeight * 0.58,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PrismTrackPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color accentColor;
  final Color inactiveColor;

  _PrismTrackPainter({
    required this.progress,
    required this.activeColor,
    required this.accentColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = Radius.circular(size.height / 2);
    final base = Color.lerp(inactiveColor, activeColor, progress)!;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, radius),
      Paint()..color = base,
    );

    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.20 * progress),
          accentColor.withValues(alpha: 0.34 * progress),
          Colors.white.withValues(alpha: 0.06 * progress),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    final facet = Path()
      ..moveTo(size.width * 0.10, 0)
      ..lineTo(size.width * 0.72, 0)
      ..lineTo(size.width * 0.45, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(facet, shimmerPaint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(0.6), radius),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.32)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant _PrismTrackPainter old) =>
      old.progress != progress ||
      old.activeColor != activeColor ||
      old.accentColor != accentColor ||
      old.inactiveColor != inactiveColor;
}

class _PrismThumbPainter extends CustomPainter {
  final Color color;
  final Color accent;

  _PrismThumbPainter({required this.color, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = Radius.circular(size.shortestSide * 0.34);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, radius),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(1), radius),
      Paint()..color = color,
    );

    final facet = Path()
      ..moveTo(size.width * 0.18, size.height * 0.10)
      ..lineTo(size.width * 0.88, size.height * 0.18)
      ..lineTo(size.width * 0.60, size.height * 0.55)
      ..lineTo(size.width * 0.12, size.height * 0.78)
      ..close();
    canvas.drawPath(
      facet,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.55),
            accent.withValues(alpha: 0.40),
          ],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _PrismThumbPainter old) =>
      old.color != color || old.accent != accent;
}

class _WaveTrackPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;
  final Color waveColor;

  _WaveTrackPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = Radius.circular(size.height / 2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, radius),
      Paint()..color = inactiveColor,
    );

    final fillHeight = lerpDouble(
      size.height * 0.72,
      size.height * 0.18,
      progress,
    )!;
    final wave = Path()..moveTo(0, size.height);
    for (double x = 0; x <= size.width; x += 4) {
      final y =
          fillHeight +
          sin((x / size.width * pi * 2) + progress * pi * 1.5) *
              size.height *
              0.07;
      wave.lineTo(x, y);
    }
    wave
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(
      wave,
      Paint()
        ..shader = LinearGradient(
          colors: [waveColor, activeColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rect),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(0.7), radius),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.42)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant _WaveTrackPainter old) =>
      old.progress != progress ||
      old.activeColor != activeColor ||
      old.inactiveColor != inactiveColor ||
      old.waveColor != waveColor;
}

// ─────────────────────────────────────────────────────────────────────────────
// New unique binary switch components (v2.x additions)
// ─────────────────────────────────────────────────────────────────────────────

/// A switch with a breathing thumb and concentric pulse rings that radiate
/// outward while the value is on. Communicates a "live / heartbeat" state and
/// is well suited to streaming, recording, or presence indicators.
class PulseToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Color pulseColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  /// Period of one full pulse cycle.
  final Duration pulseDuration;

  /// Number of staggered pulse rings (1–4 looks best).
  final int pulseRings;

  const PulseToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 72,
    this.height = 38,
    this.activeColor = const Color(0xFFE11D48),
    this.inactiveColor = const Color(0xFFE5E7EB),
    this.thumbColor = Colors.white,
    this.pulseColor = const Color(0xFFFB7185),
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 320),
    this.curve = Curves.easeOutCubic,
    this.pulseDuration = const Duration(milliseconds: 1800),
    this.pulseRings = 3,
  });

  @override
  State<PulseToggleSwitch> createState() => _PulseToggleSwitchState();
}

class _PulseToggleSwitchState extends State<PulseToggleSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ambient;

  @override
  void initState() {
    super.initState();
    _ambient = AnimationController(vsync: this, duration: widget.pulseDuration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant PulseToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pulseDuration != widget.pulseDuration) {
      _ambient.duration = widget.pulseDuration;
      if (!_ambient.isAnimating) _ambient.repeat();
    }
  }

  @override
  void dispose() {
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compactHeight = widget.height.clamp(28.0, 76.0);
    final compactWidth = max(widget.width, compactHeight * 1.85);
    final padding = compactHeight * 0.10;
    final thumbSize = compactHeight - padding * 2;
    final radius = compactHeight / 2;

    return _BinarySwitchShell(
      value: widget.value,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      semanticLabel: widget.semanticLabel,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      duration: widget.duration,
      curve: widget.curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbSize - padding,
          progress,
        )!;
        final trackColor = Color.lerp(
          widget.inactiveColor,
          widget.activeColor,
          progress,
        )!;
        return AnimatedBuilder(
          animation: _ambient,
          builder: (context, _) {
            return Opacity(
              opacity: interactive ? 1 : 0.45,
              child: SizedBox(
                width: compactWidth,
                height: compactHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: Stack(
                    children: [
                      Positioned.fill(child: ColoredBox(color: trackColor)),
                      Positioned(
                        left: left + thumbSize / 2 - compactHeight,
                        top: -compactHeight / 2 + thumbSize / 2,
                        width: compactHeight * 2,
                        height: compactHeight * 2,
                        child: CustomPaint(
                          painter: _PulseRingsPainter(
                            ambient: _ambient.value,
                            progress: progress,
                            color: widget.pulseColor,
                            rings: widget.pulseRings,
                          ),
                        ),
                      ),
                      if (focused)
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              border: Border.all(
                                color:
                                    widget.focusColor ??
                                    Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        left: left,
                        top: padding,
                        width: thumbSize,
                        height: thumbSize,
                        child: CustomPaint(
                          painter: _PulseThumbPainter(
                            ambient: _ambient.value,
                            progress: progress,
                            thumbColor: widget.thumbColor,
                            accentColor: widget.activeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// A switch that morphs between night (moon + stars) and day (sun + rays)
/// scenery. Use it for theme switchers or contextual mode toggles where the
/// metaphor of "on = bright" reinforces the action.
class DayNightToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color nightSkyTop;
  final Color nightSkyBottom;
  final Color daySkyTop;
  final Color daySkyBottom;
  final Color moonColor;
  final Color sunColor;
  final Color starColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  const DayNightToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 84,
    this.height = 40,
    this.nightSkyTop = const Color(0xFF0F172A),
    this.nightSkyBottom = const Color(0xFF1E1B4B),
    this.daySkyTop = const Color(0xFF60A5FA),
    this.daySkyBottom = const Color(0xFFBAE6FD),
    this.moonColor = const Color(0xFFE5E7EB),
    this.sunColor = const Color(0xFFFBBF24),
    this.starColor = Colors.white,
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 460),
    this.curve = Curves.easeInOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    final compactHeight = height.clamp(30.0, 80.0);
    final compactWidth = max(width, compactHeight * 2.0);
    final padding = compactHeight * 0.11;
    final thumbSize = compactHeight - padding * 2;
    final radius = compactHeight / 2;

    return _BinarySwitchShell(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      duration: duration,
      curve: curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbSize - padding,
          progress,
        )!;
        return Opacity(
          opacity: interactive ? 1 : 0.45,
          child: SizedBox(
            width: compactWidth,
            height: compactHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DayNightSkyPainter(
                        progress: progress,
                        nightTop: nightSkyTop,
                        nightBottom: nightSkyBottom,
                        dayTop: daySkyTop,
                        dayBottom: daySkyBottom,
                        starColor: starColor,
                      ),
                    ),
                  ),
                  if (focused)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          border: Border.all(
                            color:
                                focusColor ??
                                Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: left,
                    top: padding,
                    width: thumbSize,
                    height: thumbSize,
                    child: CustomPaint(
                      painter: _DayNightThumbPainter(
                        progress: progress,
                        moonColor: moonColor,
                        sunColor: sunColor,
                        nightSkyColor: Color.lerp(
                          nightSkyTop,
                          nightSkyBottom,
                          0.5,
                        )!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A switch styled like a power button: a glyph-bearing thumb framed by a
/// rotating conic glow when on. Best for "armed / disarmed" or "live / off"
/// states where the user expects a hardware-button feel.
class PowerToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Color glowColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  /// Time for the glow ring to complete one rotation.
  final Duration spinDuration;

  const PowerToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 70,
    this.height = 38,
    this.activeColor = const Color(0xFF10B981),
    this.inactiveColor = const Color(0xFF1F2937),
    this.thumbColor = const Color(0xFFF8FAFC),
    this.glowColor = const Color(0xFF34D399),
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 320),
    this.curve = Curves.easeOutCubic,
    this.spinDuration = const Duration(milliseconds: 2400),
  });

  @override
  State<PowerToggleSwitch> createState() => _PowerToggleSwitchState();
}

class _PowerToggleSwitchState extends State<PowerToggleSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(vsync: this, duration: widget.spinDuration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant PowerToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spinDuration != widget.spinDuration) {
      _spin.duration = widget.spinDuration;
      if (!_spin.isAnimating) _spin.repeat();
    }
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compactHeight = widget.height.clamp(28.0, 76.0);
    final compactWidth = max(widget.width, compactHeight * 1.75);
    final padding = compactHeight * 0.11;
    final thumbSize = compactHeight - padding * 2;
    final radius = compactHeight / 2;

    return _BinarySwitchShell(
      value: widget.value,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      semanticLabel: widget.semanticLabel,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      duration: widget.duration,
      curve: widget.curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbSize - padding,
          progress,
        )!;
        final trackColor = Color.lerp(
          widget.inactiveColor,
          _darken(widget.activeColor, 0.55),
          progress,
        )!;
        return AnimatedBuilder(
          animation: _spin,
          builder: (context, _) {
            return Opacity(
              opacity: interactive ? 1 : 0.45,
              child: SizedBox(
                width: compactWidth,
                height: compactHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedContainer(
                        duration: widget.duration,
                        curve: widget.curve,
                        decoration: BoxDecoration(
                          color: trackColor,
                          borderRadius: BorderRadius.circular(radius),
                          boxShadow: progress > 0.05
                              ? [
                                  BoxShadow(
                                    color: widget.glowColor.withValues(
                                      alpha: 0.30 * progress,
                                    ),
                                    blurRadius: 14,
                                    spreadRadius: 0.5,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ),
                    if (focused)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(
                              color:
                                  widget.focusColor ??
                                  Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      left: left,
                      top: padding,
                      width: thumbSize,
                      height: thumbSize,
                      child: CustomPaint(
                        painter: _PowerThumbPainter(
                          progress: progress,
                          spin: _spin.value,
                          thumbColor: widget.thumbColor,
                          activeColor: widget.activeColor,
                          glowColor: widget.glowColor,
                          inactiveIconColor: const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// A switch whose track is divided into vertical LED-bar segments that
/// illuminate sequentially as the value turns on. Useful for level indicators
/// (e.g. boost / turbo / brightness) where the user wants the "filling up"
/// affordance.
class SegmentBarToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double width;
  final double height;
  final Color activeColor;
  final Color activeAccentColor;
  final Color inactiveColor;
  final Color segmentOffColor;
  final Color thumbColor;
  final Color? focusColor;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;

  /// Number of vertical bar segments (3–7 recommended).
  final int segments;

  const SegmentBarToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 88,
    this.height = 38,
    this.activeColor = const Color(0xFF8B5CF6),
    this.activeAccentColor = const Color(0xFFEC4899),
    this.inactiveColor = const Color(0xFF111827),
    this.segmentOffColor = const Color(0xFF374151),
    this.thumbColor = Colors.white,
    this.focusColor,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 380),
    this.curve = Curves.easeOutCubic,
    this.segments = 5,
  });

  @override
  Widget build(BuildContext context) {
    final compactHeight = height.clamp(30.0, 76.0);
    final compactWidth = max(width, compactHeight * 2.1);
    final padding = compactHeight * 0.12;
    final thumbSize = compactHeight - padding * 2;
    final radius = compactHeight / 2;
    final segCount = segments.clamp(2, 9);

    return _BinarySwitchShell(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      duration: duration,
      curve: curve,
      builder: (context, progress, interactive, focused) {
        final left = lerpDouble(
          padding,
          compactWidth - thumbSize - padding,
          progress,
        )!;
        return Opacity(
          opacity: interactive ? 1 : 0.45,
          child: SizedBox(
            width: compactWidth,
            height: compactHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                children: [
                  Positioned.fill(child: ColoredBox(color: inactiveColor)),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _SegmentBarPainter(
                        progress: progress,
                        segments: segCount,
                        activeColor: activeColor,
                        accentColor: activeAccentColor,
                        offColor: segmentOffColor,
                      ),
                    ),
                  ),
                  if (focused)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          border: Border.all(
                            color:
                                focusColor ??
                                Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: left,
                    top: padding,
                    width: thumbSize,
                    height: thumbSize,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: thumbColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color.lerp(
                              Colors.black,
                              activeColor,
                              progress,
                            )!.withValues(alpha: 0.30 + 0.20 * progress),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: thumbSize * 0.34,
                          height: thumbSize * 0.34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.lerp(
                              segmentOffColor,
                              activeColor,
                              progress,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── shared helpers ────────────────────────────────────────────────────────

Color _darken(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  return hsl
      .withLightness((hsl.lightness * (1 - amount)).clamp(0.0, 1.0))
      .toColor();
}

// ─── painters ──────────────────────────────────────────────────────────────

class _PulseRingsPainter extends CustomPainter {
  final double ambient;
  final double progress;
  final Color color;
  final int rings;

  _PulseRingsPainter({
    required this.ambient,
    required this.progress,
    required this.color,
    required this.rings,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress < 0.04) return;
    final center = size.center(Offset.zero);
    final base = size.shortestSide / 4;
    final count = rings.clamp(1, 4);
    for (int i = 0; i < count; i++) {
      final t = ((ambient + i / count) % 1.0);
      final scale = 1.0 + t * 1.8;
      final alpha = (1.0 - t) * 0.50 * progress;
      canvas.drawCircle(
        center,
        base * scale,
        Paint()
          ..color = color.withValues(alpha: alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PulseRingsPainter old) =>
      old.ambient != ambient ||
      old.progress != progress ||
      old.color != color ||
      old.rings != rings;
}

class _PulseThumbPainter extends CustomPainter {
  final double ambient;
  final double progress;
  final Color thumbColor;
  final Color accentColor;

  _PulseThumbPainter({
    required this.ambient,
    required this.progress,
    required this.thumbColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    final breath = 1.0 + sin(ambient * pi * 2) * 0.05 * progress;

    canvas.drawCircle(
      center.translate(0, 1.6),
      r * breath,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.22)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawCircle(center, r * breath, Paint()..color = thumbColor);

    final dotColor = Color.lerp(
      const Color(0xFF9CA3AF),
      accentColor,
      progress,
    )!;
    canvas.drawCircle(center, r * 0.34, Paint()..color = dotColor);
  }

  @override
  bool shouldRepaint(covariant _PulseThumbPainter old) =>
      old.ambient != ambient ||
      old.progress != progress ||
      old.thumbColor != thumbColor ||
      old.accentColor != accentColor;
}

class _DayNightSkyPainter extends CustomPainter {
  final double progress;
  final Color nightTop;
  final Color nightBottom;
  final Color dayTop;
  final Color dayBottom;
  final Color starColor;

  _DayNightSkyPainter({
    required this.progress,
    required this.nightTop,
    required this.nightBottom,
    required this.dayTop,
    required this.dayBottom,
    required this.starColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final top = Color.lerp(nightTop, dayTop, progress)!;
    final bottom = Color.lerp(nightBottom, dayBottom, progress)!;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, bottom],
        ).createShader(rect),
    );

    final starOpacity = (1 - progress).clamp(0.0, 1.0);
    if (starOpacity > 0.02) {
      const stars = [
        Offset(0.18, 0.32),
        Offset(0.27, 0.66),
        Offset(0.40, 0.22),
        Offset(0.50, 0.55),
        Offset(0.60, 0.30),
        Offset(0.72, 0.68),
        Offset(0.85, 0.40),
      ];
      for (final s in stars) {
        canvas.drawCircle(
          Offset(s.dx * size.width, s.dy * size.height),
          1.1,
          Paint()..color = starColor.withValues(alpha: 0.85 * starOpacity),
        );
      }
    }

    // Soft cloud streaks during the day.
    if (progress > 0.1) {
      final cloudPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.22 * progress);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.width * 0.32, size.height * 0.78),
          width: size.width * 0.30,
          height: size.height * 0.18,
        ),
        cloudPaint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.width * 0.65, size.height * 0.86),
          width: size.width * 0.36,
          height: size.height * 0.14,
        ),
        cloudPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DayNightSkyPainter old) =>
      old.progress != progress;
}

class _DayNightThumbPainter extends CustomPainter {
  final double progress;
  final Color moonColor;
  final Color sunColor;
  final Color nightSkyColor;

  _DayNightThumbPainter({
    required this.progress,
    required this.moonColor,
    required this.sunColor,
    required this.nightSkyColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    final body = Color.lerp(moonColor, sunColor, progress)!;

    // Sun rays fade in for progress > 0.4.
    final rayOpacity = ((progress - 0.4) / 0.6).clamp(0.0, 1.0);
    if (rayOpacity > 0.02) {
      final rayPaint = Paint()
        ..color = sunColor.withValues(alpha: 0.85 * rayOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round;
      const rays = 8;
      for (int i = 0; i < rays; i++) {
        final a = (i / rays) * pi * 2;
        final inner = r * 1.05;
        final outer = r * (1.05 + 0.30 * rayOpacity);
        canvas.drawLine(
          center + Offset(cos(a), sin(a)) * inner,
          center + Offset(cos(a), sin(a)) * outer,
          rayPaint,
        );
      }
    }

    // Soft halo glow while transitioning.
    final glowPaint = Paint()
      ..color = body.withValues(alpha: 0.30 * (0.4 + 0.6 * progress))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center, r * 0.95, glowPaint);

    canvas.drawCircle(center, r * 0.85, Paint()..color = body);

    // Crescent overlay disappears as progress rises.
    final crescentOpacity = (1 - progress).clamp(0.0, 1.0);
    if (crescentOpacity > 0.02) {
      canvas.drawCircle(
        center.translate(r * 0.30, -r * 0.05),
        r * 0.78,
        Paint()
          ..color = nightSkyColor.withValues(alpha: 0.95 * crescentOpacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DayNightThumbPainter old) =>
      old.progress != progress;
}

class _PowerThumbPainter extends CustomPainter {
  final double progress;
  final double spin;
  final Color thumbColor;
  final Color activeColor;
  final Color glowColor;
  final Color inactiveIconColor;

  _PowerThumbPainter({
    required this.progress,
    required this.spin,
    required this.thumbColor,
    required this.activeColor,
    required this.glowColor,
    required this.inactiveIconColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.shortestSide / 2;

    // Rotating conic glow ring (only when on).
    if (progress > 0.05) {
      final ringRect = Rect.fromCircle(center: center, radius: r);
      final ringPaint = Paint()
        ..shader = SweepGradient(
          startAngle: 0,
          endAngle: pi * 2,
          transform: GradientRotation(spin * pi * 2),
          colors: [
            glowColor.withValues(alpha: 0),
            glowColor.withValues(alpha: 0.85 * progress),
            glowColor.withValues(alpha: 0.10 * progress),
            glowColor.withValues(alpha: 0),
          ],
          stops: const [0.0, 0.45, 0.65, 1.0],
        ).createShader(ringRect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = max(1.5, r * 0.18);
      canvas.drawCircle(center, r - max(0.75, r * 0.09), ringPaint);
    }

    // Drop shadow.
    canvas.drawCircle(
      center.translate(0, 1.5),
      r * 0.78,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // Thumb body.
    canvas.drawCircle(center, r * 0.78, Paint()..color = thumbColor);

    // Power glyph: open arc + vertical line.
    final iconColor = Color.lerp(inactiveIconColor, activeColor, progress)!;
    final iconPaint = Paint()
      ..color = iconColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = max(1.4, r * 0.13)
      ..strokeCap = StrokeCap.round;
    final iconR = r * 0.40;
    final arcRect = Rect.fromCircle(center: center, radius: iconR);
    canvas.drawArc(arcRect, -pi / 2 + 0.55, pi * 2 - 1.1, false, iconPaint);
    canvas.drawLine(
      Offset(center.dx, center.dy - iconR * 1.05),
      Offset(center.dx, center.dy + iconR * 0.10),
      iconPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PowerThumbPainter old) =>
      old.progress != progress ||
      old.spin != spin ||
      old.thumbColor != thumbColor ||
      old.activeColor != activeColor ||
      old.glowColor != glowColor;
}

class _SegmentBarPainter extends CustomPainter {
  final double progress;
  final int segments;
  final Color activeColor;
  final Color accentColor;
  final Color offColor;

  _SegmentBarPainter({
    required this.progress,
    required this.segments,
    required this.activeColor,
    required this.accentColor,
    required this.offColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final hPad = size.height * 0.20;
    final vPad = size.height * 0.22;
    final usableW = size.width - hPad * 2;
    final usableH = size.height - vPad * 2;
    final gap = hPad * 0.45;
    final segWidth = (usableW - gap * (segments - 1)) / segments;

    for (int i = 0; i < segments; i++) {
      final segProgress = (progress * segments - i).clamp(0.0, 1.0);
      final color = Color.lerp(
        offColor,
        Color.lerp(activeColor, accentColor, i / max(1, segments - 1))!,
        segProgress,
      )!;
      final x = hPad + i * (segWidth + gap);
      final rect = Rect.fromLTWH(x, vPad, segWidth, usableH);
      final rrect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(segWidth * 0.32),
      );
      canvas.drawRRect(
        rrect,
        Paint()..color = color.withValues(alpha: 0.30 + 0.70 * segProgress),
      );
      if (segProgress > 0.05) {
        canvas.drawRRect(
          rrect,
          Paint()
            ..color = color.withValues(alpha: 0.40 * segProgress)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SegmentBarPainter old) =>
      old.progress != progress ||
      old.segments != segments ||
      old.activeColor != activeColor ||
      old.accentColor != accentColor ||
      old.offColor != offColor;
}

// ─────────────────────────────────────────────────────────────────────────────
// New unique tab components
// ─────────────────────────────────────────────────────────────────────────────

/// Minimal tab strip with a sliding animated underline (and optional indicator
/// dot above it). Use this when you want low-chrome tabs that reduce visual
/// weight on dense screens (e.g. inside cards, modals, drawers).
class UnderlineTabBar extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool enabled;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color indicatorColor;
  final double indicatorThickness;
  final double indicatorInset;
  final bool showIndicatorDot;
  final TextStyle? labelStyle;
  final TextStyle? activeLabelStyle;
  final List<String>? semanticLabels;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration duration;
  final Curve curve;
  final EdgeInsets padding;

  const UnderlineTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.enabled = true,
    this.height = 44,
    this.activeColor = const Color(0xFF111827),
    this.inactiveColor = const Color(0xFF9CA3AF),
    this.indicatorColor = const Color(0xFF6366F1),
    this.indicatorThickness = 3.0,
    this.indicatorInset = 12,
    this.showIndicatorDot = true,
    this.labelStyle,
    this.activeLabelStyle,
    this.semanticLabels,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 380),
    this.curve = Curves.easeOutQuart,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
  }) : assert(tabs.length > 0, 'UnderlineTabBar requires at least one tab.');

  @override
  State<UnderlineTabBar> createState() => _UnderlineTabBarState();
}

class _UnderlineTabBarState extends State<UnderlineTabBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late double _from;
  late double _to;

  @override
  void initState() {
    super.initState();
    _from = widget.selectedIndex.toDouble();
    _to = widget.selectedIndex.toDouble();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: 1,
    );
  }

  @override
  void didUpdateWidget(covariant UnderlineTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _from = _currentIndex(oldWidget.selectedIndex.toDouble());
      _to = widget.selectedIndex.toDouble();
      _controller
        ..stop()
        ..value = 0
        ..animateTo(1, curve: widget.curve);
    }
  }

  double _currentIndex(double fallback) {
    if (!_controller.isAnimating) return _to;
    final t = widget.curve.transform(_controller.value);
    return lerpDouble(_from, _to, t) ?? fallback;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _select(int i) {
    if (!widget.enabled) return;
    if (i == widget.selectedIndex) return;
    HapticFeedback.selectionClick();
    widget.onChanged(i);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (!widget.enabled || event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowRight) {
      _select((widget.selectedIndex + 1).clamp(0, widget.tabs.length - 1));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft) {
      _select((widget.selectedIndex - 1).clamp(0, widget.tabs.length - 1));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.home) {
      _select(0);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.end) {
      _select(widget.tabs.length - 1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        (widget.labelStyle ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500));
    final activeStyle =
        widget.activeLabelStyle ??
        defaultStyle.copyWith(
          color: widget.activeColor,
          fontWeight: FontWeight.w700,
        );

    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onKeyEvent: _onKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabCount = widget.tabs.length;
          final width = constraints.hasBoundedWidth
              ? constraints.maxWidth - widget.padding.horizontal
              : 320.0;
          final tabWidth = width / tabCount;

          return Padding(
            padding: widget.padding,
            child: SizedBox(
              height: widget.height,
              width: width,
              child: Stack(
                children: [
                  Row(
                    children: List.generate(tabCount, (i) {
                      final isActive = i == widget.selectedIndex;
                      final label = widget.tabs[i];
                      final semantics =
                          (widget.semanticLabels != null &&
                              i < widget.semanticLabels!.length)
                          ? widget.semanticLabels![i]
                          : label;
                      return Expanded(
                        child: Semantics(
                          selected: isActive,
                          button: true,
                          label: semantics,
                          enabled: widget.enabled,
                          child: InkResponse(
                            onTap: widget.enabled ? () => _select(i) : null,
                            radius: tabWidth * 0.55,
                            highlightShape: BoxShape.rectangle,
                            child: Center(
                              child: AnimatedDefaultTextStyle(
                                duration: widget.duration,
                                curve: widget.curve,
                                style: (isActive
                                    ? activeStyle
                                    : defaultStyle.copyWith(
                                        color: widget.inactiveColor,
                                      )),
                                child: Text(
                                  label,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          final idx = _currentIndex(
                            widget.selectedIndex.toDouble(),
                          );
                          final segmentWidth =
                              tabWidth - widget.indicatorInset * 2;
                          final left = tabWidth * idx + widget.indicatorInset;
                          return CustomPaint(
                            painter: _UnderlineIndicatorPainter(
                              left: left,
                              width: segmentWidth.clamp(0.0, double.infinity),
                              thickness: widget.indicatorThickness,
                              color: widget.indicatorColor,
                              showDot: widget.showIndicatorDot,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A row of card-style tabs where the active one lifts with a soft shadow and
/// accent border. Inactive cards stay flat. Good for dashboards or settings
/// pages that benefit from a tactile "selected card" affordance.
class StackedCardsTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<IconData>? icons;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool enabled;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeAccentColor;
  final Color activeLabelColor;
  final Color inactiveLabelColor;
  final double cornerRadius;
  final double gap;
  final TextStyle? labelStyle;
  final List<String>? semanticLabels;
  final Duration duration;
  final Curve curve;
  final FocusNode? focusNode;
  final bool autofocus;

  const StackedCardsTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.icons,
    this.enabled = true,
    this.height = 64,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0xFFF1F5F9),
    this.activeAccentColor = const Color(0xFF6366F1),
    this.activeLabelColor = const Color(0xFF111827),
    this.inactiveLabelColor = const Color(0xFF6B7280),
    this.cornerRadius = 16,
    this.gap = 8,
    this.labelStyle,
    this.semanticLabels,
    this.duration = const Duration(milliseconds: 340),
    this.curve = Curves.easeOutCubic,
    this.focusNode,
    this.autofocus = false,
  }) : assert(tabs.length > 0, 'StackedCardsTabBar requires at least one tab.'),
       assert(
         icons == null || icons.length == tabs.length,
         'icons.length must match tabs.length when provided.',
       );

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      autofocus: autofocus,
      onKeyEvent: (node, event) {
        if (!enabled || event is! KeyDownEvent) return KeyEventResult.ignored;
        final key = event.logicalKey;
        if (key == LogicalKeyboardKey.arrowRight &&
            selectedIndex < tabs.length - 1) {
          onChanged(selectedIndex + 1);
          return KeyEventResult.handled;
        }
        if (key == LogicalKeyboardKey.arrowLeft && selectedIndex > 0) {
          onChanged(selectedIndex - 1);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: SizedBox(
        height: height,
        child: Row(
          children: List.generate(tabs.length, (i) {
            final isActive = i == selectedIndex;
            final label = tabs[i];
            final semantics =
                (semanticLabels != null && i < semanticLabels!.length)
                ? semanticLabels![i]
                : label;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: gap / 2),
                child: Semantics(
                  selected: isActive,
                  button: true,
                  label: semantics,
                  enabled: enabled,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: enabled
                        ? () {
                            if (i != selectedIndex) {
                              HapticFeedback.selectionClick();
                              onChanged(i);
                            }
                          }
                        : null,
                    child: AnimatedContainer(
                      duration: duration,
                      curve: curve,
                      transform: Matrix4.translationValues(
                        0,
                        isActive ? -3 : 0,
                        0,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? activeColor : inactiveColor,
                        borderRadius: BorderRadius.circular(cornerRadius),
                        border: Border.all(
                          color: isActive
                              ? activeAccentColor
                              : Colors.transparent,
                          width: 1.6,
                        ),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: activeAccentColor.withValues(
                                    alpha: 0.25,
                                  ),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ]
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (icons != null) ...[
                              Icon(
                                icons![i],
                                size: 18,
                                color: isActive
                                    ? activeAccentColor
                                    : inactiveLabelColor,
                              ),
                              const SizedBox(height: 4),
                            ],
                            AnimatedDefaultTextStyle(
                              duration: duration,
                              curve: curve,
                              style:
                                  (labelStyle ?? const TextStyle(fontSize: 13))
                                      .copyWith(
                                        color: isActive
                                            ? activeLabelColor
                                            : inactiveLabelColor,
                                        fontWeight: isActive
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      ),
                              child: Text(
                                label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// A pill-style tab indicator that stretches like a magnetic blob between
/// positions during a transition, then snaps back to a normal pill shape.
/// Use when you want a playful, energetic feel — e.g. profile filters, story
/// categories, app onboarding.
class MagneticBlobTabBar extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool enabled;
  final double height;
  final Color activeLabelColor;
  final Color inactiveLabelColor;
  final Color trackColor;
  final List<Color> blobGradient;
  final TextStyle? labelStyle;
  final List<String>? semanticLabels;
  final Duration duration;
  final Curve curve;
  final EdgeInsets padding;
  final FocusNode? focusNode;
  final bool autofocus;

  const MagneticBlobTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.enabled = true,
    this.height = 48,
    this.activeLabelColor = Colors.white,
    this.inactiveLabelColor = const Color(0xFF6B7280),
    this.trackColor = const Color(0xFFF1F5F9),
    this.blobGradient = const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    this.labelStyle,
    this.semanticLabels,
    this.duration = const Duration(milliseconds: 520),
    this.curve = Curves.easeOutCubic,
    this.padding = const EdgeInsets.all(4),
    this.focusNode,
    this.autofocus = false,
  }) : assert(tabs.length > 0, 'MagneticBlobTabBar requires at least one tab.'),
       assert(
         blobGradient.length >= 1,
         'blobGradient must contain at least one color.',
       );

  @override
  State<MagneticBlobTabBar> createState() => _MagneticBlobTabBarState();
}

class _MagneticBlobTabBarState extends State<MagneticBlobTabBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late double _from;
  late double _to;

  @override
  void initState() {
    super.initState();
    _from = widget.selectedIndex.toDouble();
    _to = widget.selectedIndex.toDouble();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: 1,
    );
  }

  @override
  void didUpdateWidget(covariant MagneticBlobTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _from = _liveIndex();
      _to = widget.selectedIndex.toDouble();
      _controller
        ..stop()
        ..value = 0
        ..forward();
    }
  }

  double _liveIndex() {
    if (!_controller.isAnimating) return _to;
    final t = widget.curve.transform(_controller.value);
    return lerpDouble(_from, _to, t) ?? _to;
  }

  /// Returns lead/trail edge factors (in tab units) for the blob.
  /// During transition, lead arrives quickly while trail lags, producing a
  /// stretched shape; on settle, both meet at the new position.
  (double, double) _edges() {
    if (!_controller.isAnimating) return (_to, _to);
    final t = _controller.value.clamp(0.0, 1.0);
    final forward = _to >= _from;
    final leadCurve = Curves.easeOutCubic.transform(t);
    final trailCurve = Curves.easeInCubic.transform(t);
    final lead = forward
        ? lerpDouble(_from, _to, leadCurve)!
        : lerpDouble(_from, _to, trailCurve)!;
    final trail = forward
        ? lerpDouble(_from, _to, trailCurve)!
        : lerpDouble(_from, _to, leadCurve)!;
    return (lead, trail);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _select(int i) {
    if (!widget.enabled || i == widget.selectedIndex) return;
    HapticFeedback.selectionClick();
    widget.onChanged(i);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (!widget.enabled || event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowRight &&
        widget.selectedIndex < widget.tabs.length - 1) {
      _select(widget.selectedIndex + 1);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft && widget.selectedIndex > 0) {
      _select(widget.selectedIndex - 1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final tabCount = widget.tabs.length;
    final radius = (widget.height - widget.padding.vertical) / 2;

    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onKeyEvent: _onKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : 320.0;
          final tabWidth = (width - widget.padding.horizontal) / tabCount;

          return Container(
            height: widget.height,
            width: width,
            decoration: BoxDecoration(
              color: widget.trackColor,
              borderRadius: BorderRadius.circular(widget.height / 2),
            ),
            padding: widget.padding,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final (lead, trail) = _edges();
                    final left = min(lead, trail) * tabWidth;
                    final right = (max(lead, trail) + 1) * tabWidth;
                    return Positioned(
                      left: left,
                      top: 0,
                      bottom: 0,
                      width: (right - left).clamp(0.0, double.infinity),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: widget.blobGradient.length == 1
                                ? [
                                    widget.blobGradient.first,
                                    widget.blobGradient.first,
                                  ]
                                : widget.blobGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(radius),
                          boxShadow: [
                            BoxShadow(
                              color: widget.blobGradient.first.withValues(
                                alpha: 0.40,
                              ),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  children: List.generate(tabCount, (i) {
                    final isActive = i == widget.selectedIndex;
                    final label = widget.tabs[i];
                    final semantics =
                        (widget.semanticLabels != null &&
                            i < widget.semanticLabels!.length)
                        ? widget.semanticLabels![i]
                        : label;
                    return Expanded(
                      child: Semantics(
                        selected: isActive,
                        button: true,
                        label: semantics,
                        enabled: widget.enabled,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: widget.enabled ? () => _select(i) : null,
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, _) {
                              final live = _liveIndex();
                              final closeness = (1 - (live - i).abs()).clamp(
                                0.0,
                                1.0,
                              );
                              final color = Color.lerp(
                                widget.inactiveLabelColor,
                                widget.activeLabelColor,
                                closeness,
                              )!;
                              final style =
                                  (widget.labelStyle ??
                                          const TextStyle(fontSize: 14))
                                      .copyWith(
                                        color: color,
                                        fontWeight: closeness > 0.5
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      );
                              return Center(
                                child: Text(
                                  label,
                                  style: style,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UnderlineIndicatorPainter extends CustomPainter {
  final double left;
  final double width;
  final double thickness;
  final Color color;
  final bool showDot;

  _UnderlineIndicatorPainter({
    required this.left,
    required this.width,
    required this.thickness,
    required this.color,
    required this.showDot,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height - thickness / 2 - 1;
    final rect = Rect.fromLTWH(left, y - thickness / 2, width, thickness);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(thickness));
    canvas.drawRRect(rrect, Paint()..color = color);

    if (showDot) {
      final dotR = thickness * 1.4;
      final cx = left + width / 2;
      final cy = y - thickness * 2.6;
      canvas.drawCircle(Offset(cx, cy), dotR, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant _UnderlineIndicatorPainter old) =>
      old.left != left ||
      old.width != width ||
      old.thickness != thickness ||
      old.color != color ||
      old.showDot != showDot;
}
