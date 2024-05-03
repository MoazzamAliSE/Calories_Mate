import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

final List<String> videoUrls = [
  'https://drive.google.com/uc?export=download&id=1IZRnD3UiXPMqOCkccbPn5rA3NunjUAnl',
  'https://drive.google.com/uc?export=download&id=10zjtjrAz87Ty9SPiTAGB7Sa50Yq9gmmC',
  'https://drive.google.com/uc?export=download&id=10zjtjrAz87Ty9SPiTAGB7Sa50Yq9gmmC',
];

class VideoSuggestions extends StatefulWidget {
  const VideoSuggestions({Key? key}) : super(key: key);

  @override
  _VideoSuggestionsState createState() => _VideoSuggestionsState();
}

class _VideoSuggestionsState extends State<VideoSuggestions> {
  int _currentIndex = 0;
  VideoPlayerController? _previousController;
  VideoPlayerController? _currentController;

  @override
  void initState() {
    super.initState();
    _currentController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrls[_currentIndex]))
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown after initialization
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: false, // Disable auto sliding
            height: 170,
            onPageChanged: (index, reason) {
              setState(() {
                _previousController?.pause();
                _previousController?.dispose();
                _previousController = _currentController;
                _currentIndex = index;
                _currentController = VideoPlayerController.networkUrl(
                    Uri.parse(videoUrls[_currentIndex]))
                  ..initialize().then((_) {
                    setState(
                        () {}); // Ensure the first frame is shown after initialization
                    _currentController!.play();
                  });
              });
            },
          ),
          items: [
            for (var i = 0; i < videoUrls.length; i++)
              VideoWidget(
                controller: i == _currentIndex
                    ? _currentController
                    : _previousController,
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: videoUrls.map((urlOfItem) {
            int index = videoUrls.indexOf(urlOfItem);
            return Container(
              width: 10.0,
              height: 10.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? const Color.fromRGBO(0, 0, 0, 0.8)
                    : const Color.fromRGBO(0, 0, 0, 0.3),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  @override
  void dispose() {
    _currentController?.dispose();
    _previousController?.dispose();
    super.dispose();
  }
}

class VideoWidget extends StatefulWidget {
  final VideoPlayerController? controller;

  const VideoWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child:
            widget.controller != null && widget.controller!.value.isInitialized
                ? VideoPlayer(widget.controller!)
                : Container(),
      ),
    );
  }
}
