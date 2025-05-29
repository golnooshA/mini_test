import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../core/config/design_config.dart';
import '../../data/models/quiz.dart';
import '../widgets/video_control.dart';
import 'start_page.dart';

class VideoPlayerPage extends StatefulWidget {
  final Quiz quiz;

  const VideoPlayerPage({super.key, required this.quiz});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final VideoPlayerController _controller;
  late final Future<void> _initFuture;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final assetPath = widget.quiz.video;
    try {
      await rootBundle.load(assetPath);
    } catch (e) {
      setState(() => _loadError = 'Could not find video asset:\n$assetPath');
      return;
    }

    _controller = VideoPlayerController.asset(assetPath);
    try {
      await _controller.initialize();
      _controller.setLooping(false);
      setState(() {});
    } catch (e) {
      setState(() => _loadError = 'Video initialization failed:\n$e');
    }
  }

  @override
  void dispose() {
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _togglePlay() {
    if (!_controller.value.isInitialized) return;
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _seekRelative(Duration offset) {
    if (!_controller.value.isInitialized) return;
    final current = _controller.value.position;
    final target = current + offset;
    final max = _controller.value.duration;
    final clamped =
        target < Duration.zero ? Duration.zero : (target > max ? max : target);
    _controller.seekTo(clamped);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConfig.backgroundColor,
      body: FutureBuilder<void>(
        future: _initFuture,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: DesignConfig.progressColor));
          }
          if (_loadError != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  _loadError!,
                  style: const TextStyle(color: DesignConfig.errorColor),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!_controller.value.isInitialized) {
            return const Center(child: CircularProgressIndicator(color: DesignConfig.progressColor));
          }
          if (_controller.value.hasError) {
            return Center(
              child: Text(
                'Playback error:\n${_controller.value.errorDescription}',
                style: const TextStyle(color: DesignConfig.errorColor),
                textAlign: TextAlign.center,
              ),
            );
          }

          return Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),

              Positioned(
                top: 70,
                left: 16,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: DesignConfig.backButtonCircleColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: DesignConfig.backColor,
                    ),
                  ),
                ),
              ),

              // Overlay controls at bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: VideoControls(
                  title: widget.quiz.title,
                  buttonText: 'Start Quiz',
                  position: _controller.value.position,
                  duration: _controller.value.duration,
                  isPlaying: _controller.value.isPlaying,
                  onPlayPause: _togglePlay,
                  onRewind: () => _seekRelative(const Duration(seconds: -5)),
                  onFastForward: () =>
                      _seekRelative(const Duration(seconds: 5)),
                  goToQuiz: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => QuizStartPage(quiz: widget.quiz),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
