import 'dart:developer' as developer;
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_frame_inspector/src/figmat_rest_api.dart';
import 'package:flutter/material.dart';

class FigmaFrameInspector extends StatelessWidget {
  final String frameUrl;
  final String figmaToken;
  final double scale;
  final double initialOpacity;
  final bool enabled;
  final bool isTouchToChangeOpacityEnabled;

  final Widget child;

  const FigmaFrameInspector({
    Key? key,
    required this.frameUrl,
    required this.figmaToken,
    this.scale = 3,
    this.initialOpacity = .3,
    this.enabled = true,
    this.isTouchToChangeOpacityEnabled = true,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Stack(
      children: [
        FutureBuilder<String>(
            future: FigmaRestApi.downloadFrameImage(
              figmatToken: figmaToken,
              figmaframeUrl: frameUrl,
              imageScale: scale,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    child,
                    FigmaImageContainer(
                      isTouchToChangeOpacityEnabled:
                          isTouchToChangeOpacityEnabled,
                      initialOpacity: initialOpacity,
                      figmaImageUrl: snapshot.data!,
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!,
                        width: MediaQuery.of(context).size.width,
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                developer.log(
                  'Faced an error: ${snapshot.error}',
                  error: snapshot.error,
                  name: toString(),
                );
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.railway_alert_outlined,
                        color: Colors.redAccent,
                        size: 60,
                      ),
                      Text(
                        "Oops, something went wrong!",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}

class FigmaImageContainer extends StatefulWidget {
  final String figmaImageUrl;
  final double initialOpacity;
  final bool isTouchToChangeOpacityEnabled;
  final Widget child;

  const FigmaImageContainer({
    Key? key,
    required this.figmaImageUrl,
    required this.initialOpacity,
    required this.isTouchToChangeOpacityEnabled,
    required this.child,
  }) : super(key: key);

  @override
  State<FigmaImageContainer> createState() => FigmaImageContainerState();
}

class FigmaImageContainerState extends State<FigmaImageContainer> {
  bool _isTouchToChangeOpacityEnabled = true;

  double _totalWidgetHeight = 0;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    _opacity = widget.initialOpacity;
    _isTouchToChangeOpacityEnabled = widget.isTouchToChangeOpacityEnabled;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isTouchToChangeOpacityEnabled) {
      return Opacity(
        opacity: _opacity,
        child: CachedNetworkImage(
          key: ValueKey(widget.figmaImageUrl),
          imageUrl: widget.figmaImageUrl,
          width: MediaQuery.of(context).size.width,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        _totalWidgetHeight = constraints.maxHeight;

        return GestureDetector(
          onVerticalDragUpdate: (details) {
            final dyAbs = details.delta.dy.abs();
            final opacityChange = dyAbs / (_totalWidgetHeight / 2);

            double newOpacity;

            if (details.delta.dy < 0) {
              newOpacity = _opacity - opacityChange;
              _opacity = max(newOpacity, 0);
            } else {
              newOpacity = _opacity + opacityChange;
              _opacity = min(newOpacity, 1);
            }

            setState(() {});
          },
          child: Opacity(
            opacity: _opacity,
            child: CachedNetworkImage(
              key: ValueKey(widget.figmaImageUrl),
              imageUrl: widget.figmaImageUrl,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        );
      },
    );
  }
}
