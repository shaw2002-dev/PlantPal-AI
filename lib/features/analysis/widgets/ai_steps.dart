import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/analysis_controller.dart';

class AiSteps extends StatelessWidget {
  final AnalysisController controller;

  const AiSteps({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final progress = controller.progress.value;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            _StepTile(
              title: "Uploading Image",
              state: _state(progress, 0.15),
            ),

            const Divider(height: 28),

            _StepTile(
              title: "Identifying Plant Species",
              state: _state(progress, 0.40),
            ),

            const Divider(height: 28),

            _StepTile(
              title: "Detecting Diseases",
              state: _state(progress, 0.65),
            ),

            const Divider(height: 28),

            _StepTile(
              title: "Generating Care Guide",
              state: _state(progress, 0.85),
            ),

            const Divider(height: 28),

            _StepTile(
              title: "Preparing Final Report",
              state: _state(progress, 1.0),
            ),
          ],
        ),
      );
    });
  }

  StepStateType _state(
      double progress,
      double target,
      ) {
    if (progress >= target) {
      return StepStateType.completed;
    }

    if (progress >= target - .20) {
      return StepStateType.loading;
    }

    return StepStateType.pending;
  }
}

enum StepStateType {
  pending,
  loading,
  completed,
}

class _StepTile extends StatelessWidget {
  final String title;
  final StepStateType state;

  const _StepTile({
    required this.title,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Widget leading;

    switch (state) {
      case StepStateType.completed:
        leading = Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 20,
          ),
        );
        break;

      case StepStateType.loading:
        leading = const SizedBox(
          width: 34,
          height: 34,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        );
        break;

      case StepStateType.pending:
        leading = Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade400,
            ),
          ),
        );
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: Row(
        key: ValueKey(state),
        children: [
          leading,

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: state ==
                    StepStateType.completed
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: state ==
                    StepStateType.completed
                    ? Colors.green
                    : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}