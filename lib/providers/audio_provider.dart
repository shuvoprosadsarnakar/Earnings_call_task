import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  late final AudioPlayer _audioPlayer;
  final String _url =
      "https://earningscall.biz/f/d9bb3a82-ed00-47e0-bfbe-f6689108bc51.mp3";
  bool _isPlaying = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;

  AudioProvider() {
    _audioPlayer =
        AudioPlayer(mode: PlayerMode.MEDIA_PLAYER, playerId: "My player");
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);

    _audioPlayer.onAudioPositionChanged.listen((Duration d) {
      _position = d;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      _duration = d;
      notifyListeners();
    });
  }

  play() {
    _audioPlayer.play(_url);
    _isPlaying = true;
    notifyListeners();
  }

  pause() {
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  seek(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  fastforward(double value) {
    if (value > _duration.inSeconds) {
      _audioPlayer.seek(_duration - const Duration(seconds: 1));
    } else {
      _audioPlayer.seek(_position - Duration(seconds: value.toInt()));
    }
    _audioPlayer.seek(_position + Duration(seconds: value.toInt()));
    notifyListeners();
  }

  rewind(double value) {
    if (value < 0) {
      _audioPlayer.seek(const Duration(seconds: 0));
    } else {
      _audioPlayer.seek(_position - Duration(seconds: value.toInt()));
    }
    notifyListeners();
  }

  format(Duration duration) =>
      "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
}
