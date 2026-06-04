import 'package:just_audio/just_audio.dart';

class SoundPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> play(String? soundPath) async {
    if (soundPath == null || soundPath.isEmpty) return;

    try {
      await _player.stop();
      await _player.setAsset(soundPath);
      await _player.play();
    } catch (e) {
      print("Error reproduciendo sonido: $e");
    }
  }

  static Future<void> stop() async {
    await _player.stop();
  }
}
