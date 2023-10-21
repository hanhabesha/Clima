import 'package:elemental/app/bloc/app_bloc.dart';
import 'package:elemental/core/common/primary_button.dart';
import 'package:elemental/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PermissionDeniedWidget extends StatefulWidget {
  const PermissionDeniedWidget({
    super.key,
    required this.lottie,
    required this.text,
  });
  final String lottie;
  final String text;

  @override
  State<PermissionDeniedWidget> createState() => _PermissionDeniedWidgetState();
}

class _PermissionDeniedWidgetState extends State<PermissionDeniedWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // Add a listener to handle animation status changes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // When animation completes, reverse it after a delay
        Future.delayed(const Duration(seconds: 2), () {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // When animation is reversed completely, play it again
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: PrimaryButton(
          onTap: () {
            print("triggered");
            context.read<AppBloc>().add(RetryPermissionEvent());
          },
          isBorder: true,
          color: AppColors.white,
          text: "Location Permission",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  widget.lottie,
                  fit: BoxFit.cover,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller.duration = composition.duration;
                    _controller.forward();
                  },
                ),
                Text(widget.text, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}