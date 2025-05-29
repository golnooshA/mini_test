import 'package:flutter/material.dart';
import 'package:min_test/core/config/design_config.dart';
import 'bottomButton.dart';

class VideoControls extends StatelessWidget {
  final String title;
  final String buttonText;
  final Duration position;
  final Duration duration;
  final VoidCallback onPlayPause;
  final VoidCallback onRewind;
  final VoidCallback onFastForward;
  final VoidCallback goToQuiz;
  final bool isPlaying;

  const VideoControls({
    super.key,
    required this.title,
    required this.position,
    required this.duration,
    required this.onPlayPause,
    required this.onRewind,
    required this.onFastForward,
    required this.isPlaying,
    required this.goToQuiz,
    required this.buttonText,
  });

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                _formatDuration(position),
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: Slider(
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {},
                  activeColor: DesignConfig.buttonColor,
                  inactiveColor: DesignConfig.sliderColor,
                ),
              ),
              Text(
                _formatDuration(duration),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.replay_5, color: Colors.white),
                onPressed: onRewind,
              ),
              IconButton(
                icon: Icon(
                  isPlaying
                      ? Icons.pause_presentation
                      : Icons.play_circle_filled,
                  size: 48,
                  color: DesignConfig.textColor,
                ),
                onPressed: onPlayPause,
              ),
              IconButton(
                icon: Icon(Icons.forward_5, color: Colors.white),
                onPressed: onFastForward,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28,horizontal: 12),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: BottomButton(
                  buttonText: buttonText, onTap: goToQuiz),
            ),
          ),
        ],
      ),
    );
  }
}
