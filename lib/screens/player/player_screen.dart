import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/audio_provider.dart';
import 'package:flutter_application_1/screens/player/circle_image.dart';
import 'package:flutter_application_1/widgets/custom_round_slider_overlay_shape.dart';
import 'package:flutter_application_1/widgets/custom_slider_thumb_circle.dart';
import 'package:flutter_application_1/widgets/custom_track_shape.dart';
import 'package:flutter_application_1/screens/draggable_sheet.dart';
import 'package:flutter_application_1/widgets/styles/color_pallate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/backArrow.svg"),
          onPressed: () => {},
        ),
        title: const Text(
          "Earnings Conference Call",
          style: TextStyle(
              fontStyle: FontStyle.normal, fontSize: 18, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircleImage() // Circular image, album art
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Amazon Inc.",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 27,
                          color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(height: 27),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Q3 2022", // audio title
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          color: Colors.black),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Earnings Conference Call", // audio subtitle
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    progressSlider(context),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Consumer<AudioProvider>(builder: (context, audio, child) {
                      return Text(
                        format(audio.position), // elapsed time
                        style: const TextStyle(
                            fontSize: 17, color: Colors.black87),
                      );
                    }),
                    const Spacer(),
                    Consumer<AudioProvider>(builder: (context, audio, child) {
                      return Text(
                        format(
                            audio.duration - audio.position), // remaining time
                        style: const TextStyle(
                            fontSize: 17, color: Colors.black87),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 6),
                audioControls()
              ],
            ),
          ),
          const BottomDraggableScreen()
        ],
      ),
    );
  }

  Stack audioControls() {
    final audioProvider = Provider.of<AudioProvider>(context);
    return Stack(children: [
      SizedBox(
        height: 130,
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/ellipse57.svg", // green circle behind the play button
            height: 90,
          ),
        ),
      ),
      SizedBox(
        height: 130,
        child: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/solid.svg", // download button
                height: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => {},
            ),
            const Spacer(),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/rewind.svg", // rewind 15s button
                height: 22,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                audioProvider.rewind(30);
              },
            ),
            const Spacer(),
            IconButton(
              icon: audioProvider.isPlaying
                  ? SvgPicture.asset(
                      "assets/icons/pause.svg", // pause button
                      height: 22,
                    )
                  : SvgPicture.asset(
                      "assets/icons/play.svg", // play button
                      height: 22,
                    ),
              padding:
                  EdgeInsets.fromLTRB(audioProvider.isPlaying ? 0 : 5, 0, 0, 0),
              onPressed: () {
                if (audioProvider.isPlaying == false) {
                  audioProvider.play();
                } else if (audioProvider.isPlaying == true) {
                  audioProvider.pause();
                }
              },
            ),
            const Spacer(),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/fastforward.svg", // fastforward 30s button
                height: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                audioProvider.fastforward(30);
              },
            ),
            const Spacer(),
            IconButton(
              icon: const Text(
                "1x", // playback speed button
                style: TextStyle(fontSize: 17, color: Colors.black87),
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    ]);
  }

  Widget progressSlider(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    return Expanded(
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
            activeTrackColor: ColorPallate.limeGreen,
            inactiveTrackColor: ColorPallate.limeGreenShade,
            thumbShape: const CustomSliderThumbCircle(thumbRadius: 10),
            overlayColor: ColorPallate.overlay,
            overlayShape: const CustomRoundSliderOverlayShape(overlayRadius: 0),
            trackShape: CustomTrackShape()),
        child: Slider(
          min: 0.0,
          max: audioProvider.duration.inSeconds.toDouble() + 1.0,
          value: audioProvider.position.inSeconds.toDouble(),
          autofocus: true,
          onChanged: (double value) {
            audioProvider.seek(value);
            value = value;
          },
        ),
      ),
    );
  }

  format(Duration duration) =>
      "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
}
