import 'dart:async';
import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

class CircularTimer extends StatefulWidget {
  final int durationSeconds;
  final Function()? onTimerFinish;

  const CircularTimer({
    super.key,
    this.durationSeconds = 15,
    this.onTimerFinish,
  });

  @override
  CircularTimerState createState() => CircularTimerState();
}

class CircularTimerState extends State<CircularTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );

    _animation = Tween<double>(begin: 1, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onTimerFinish != null) {
          widget.onTimerFinish!();
        }
      }
    });

    // Démarrer automatiquement le timer
    startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _controller.reset();
    _controller.forward();

    _timer?.cancel();
    _timer = Timer(Duration(seconds: widget.durationSeconds), () {
      // Action à réaliser lorsque le timer est terminé
    });
  }

  void stopTimer() {
    _controller.stop();
    _timer?.cancel();
  }

  int getRemainingSeconds() {
    return (_animation.value * widget.durationSeconds).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: _animation.value,
          strokeWidth: 6,
          color: thirdColor,
        ),
        Text(
          "${(_animation.value * widget.durationSeconds).ceil()}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
