import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:good_player/components/good_player.dart';

class PlayerDemo extends HookWidget {
  const PlayerDemo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: const GoodPlayer(title: 'player widget')),
                ),
              ),
            ],
          )),
    );
  }
}
