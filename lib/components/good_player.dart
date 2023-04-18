import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

class GoodPlayer extends HookWidget {
  const GoodPlayer({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController controller = VideoPlayerController.network(
        'https://p-6437b40cf0b700ac197a1ae8-mediahls-api.isaachybrid.com/medias/Sample/sample.m3u8');
    Widget buildPrimaryControls() {
      return Align(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () => controller.play(),
                icon: const Icon(
                  Icons.fast_rewind,
                  color: Colors.white,
                  size: 32,
                )),
            IconButton(
                onPressed: () async {
                  controller.play();
                },
                icon: const Icon(
                  Icons.play_circle_outline_rounded,
                  color: Colors.white,
                  size: 32,
                )),
            IconButton(
                onPressed: () => controller.play(),
                icon: const Icon(
                  Icons.fast_forward,
                  color: Colors.white,
                  size: 32,
                )),
          ],
        ),
      );
    }

    Widget buildSecondaryControls() {
      return Column(
        children: [
          // StreamBuilder<Object>(
          //   stream: null,
          //   builder: (context, snapshot) {
          //     return Slider(value: , onChanged: onChanged);
          //   }
          // ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => controller.setVolume(0),
                    icon: const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 32,
                    )),
                IconButton(
                    onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async {
                                Navigator.of(context).pop();
                                return false;
                              },
                              child: Scaffold(
                                body: Center(
                                  child: RotatedBox(
                                    quarterTurns: 5,
                                    child: Stack(
                                      children: [
                                        VideoPlayer(controller),
                                        buildPrimaryControls(),
                                        buildSecondaryControls()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    icon: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 32,
                    )),
              ],
            ),
          ),
        ],
      );
    }

    // void enterFullScreen() {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (BuildContext context) {
    //       return Scaffold(
    //         body: Center(
    //           child: RotatedBox(
    //             quarterTurns: 0,
    //             child: Stack(
    //               children: [
    //                 VideoPlayer(controller),
    //                 buildPrimaryControls(),
    //                 buildSecondaryControls()
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }

    useEffect(() {
      controller.initialize();
      return () async => {};
    }, []);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: null,
              ),
              SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: RotatedBox(
                      quarterTurns: 0,
                      child: Stack(
                        children: [
                          VideoPlayer(controller),
                          buildPrimaryControls(),
                          buildSecondaryControls()
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
