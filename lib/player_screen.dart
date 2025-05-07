
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class PlayerScreen extends StatelessWidget {
  final String url;
  PlayerScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BetterPlayer.network(url,
        betterPlayerConfiguration: BetterPlayerConfiguration(
          autoPlay: true,
          aspectRatio: 16 / 9,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableFullscreen: true,
          ),
        ),
      ),
    );
  }
}
