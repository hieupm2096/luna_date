import 'package:flutter/material.dart';

/// Create a Circular countdown indicator
class CountDownProgressIndicator extends StatefulWidget {
  // ignore: public_member_api_docs
  const CountDownProgressIndicator({
    required this.duration,
    required this.backgroundColor,
    required this.valueColor,
    super.key,
    this.size = 24,
    this.initialPosition = 0,
    this.strokeColor = Colors.white,
    this.controller,
    this.onComplete,
    this.timeTextStyle,
    this.timeFormatter,
    this.strokeWidth = 2,
    this.autostart = true,
  })  : assert(duration > 0, 'Duration must > 0'),
        assert(initialPosition < duration, 'initialPosition must <= duration');

  /// Timer duration in seconds
  final int duration;

  /// Size
  final double size;

  /// Default Background color
  final Color backgroundColor;

  /// Stroke color
  final Color strokeColor;

  /// Filling color
  final Color valueColor;

  /// This controller is used to restart, stop or resume the countdown
  final CountDownController? controller;

  /// This call callback will be executed when the Countdown ends.
  final VoidCallback? onComplete;

  /// Stroke width, the default is 1
  final double strokeWidth;

  /// Initial time, 0 by default
  final int initialPosition;

  /// The style for the remaining time indicator
  /// The default is black color, and fontWeight of W600
  final TextStyle? timeTextStyle;

  /// The formatter for the time string
  /// By default, no formatting is applied and
  /// the time is displayed in number of seconds left
  final String Function(int seconds)? timeFormatter;

  /// true by default, this value indicates that the timer
  /// will start automatically
  final bool autostart;

  @override
  State<CountDownProgressIndicator> createState() =>
      _CountDownProgressIndicatorState();
}

class _CountDownProgressIndicatorState extends State<CountDownProgressIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.duration,
      ),
    );
    _animation = Tween<double>(
      begin: widget.initialPosition.toDouble(),
      end: widget.duration.toDouble(),
    ).animate(_animationController);

    _animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) widget.onComplete?.call();
      })
      ..addListener(() {
        setState(() {});
      });

    widget.controller?._state = this;

    if (widget.autostart) onAnimationStart();
  }

  @override
  void reassemble() {
    onAnimationStart();
    super.reassemble();
  }

  void onAnimationStart() {
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: widget.size,
            width: widget.size,
            child: CircularProgressIndicator(
              strokeWidth: widget.strokeWidth,
              backgroundColor: widget.strokeColor,
              valueColor: AlwaysStoppedAnimation<Color>(widget.valueColor),
              value: _animation.value / widget.duration,
            ),
          ),
          Center(
            child: Text(
              widget.timeFormatter?.call(
                    (widget.duration - _animation.value).ceil(),
                  ) ??
                  (widget.duration - _animation.value).toStringAsFixed(0),
              style: widget.timeTextStyle ??
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper class for CountDown widget
class CountDownController {
  late _CountDownProgressIndicatorState _state;

  /// Pause countdown timer
  void pause() {
    _state._animationController.stop(canceled: false);
  }

  /// Resumes countdown time
  void resume() {
    _state._animationController.forward();
  }

  /// Starts countdown timer
  /// This method works when autostart is false
  void start() {
    if (!_state.widget.autostart) {
      _state._animationController
          .forward(from: _state.widget.initialPosition.toDouble());
    }
  }

  /// Restarts countdown timer.
  ///
  /// * [duration] is an optional value, if this value is null,
  /// the duration will use the previous one defined in the widget
  /// * Use [initialPosition] if you want the original position
  void restart({required double initialPosition, int? duration}) {
    if (duration != null) {
      _state._animationController.duration = Duration(seconds: duration);
    }

    _state._animationController.forward(from: initialPosition);
  }
}
