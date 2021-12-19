import 'package:just_audio/just_audio.dart';

abstract class RadioPlayer {
  Future<void> play({required String url});
  Future<void> pause();
}

class JustAudioPlayer extends RadioPlayer {
  final audioPlayer = AudioPlayer();
  var _isUrlSet = false;

  @override
  Future<void> pause() {
    return audioPlayer.pause();
  }

  @override
  Future<void> play({required String url}) async {
    if (!_isUrlSet) {
      await audioPlayer.setUrl(url);
      _isUrlSet = true;
    }
    return audioPlayer.play();
  }
}