import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:have_you_heard/features/home/domain/entities/artist.dart';
import 'package:have_you_heard/features/home/presentation/widgets/artist_card_widget.dart';

class ArtistCarouselWidget extends StatefulWidget {
  final List<Artist> artists;
  const ArtistCarouselWidget({super.key, required this.artists});

  @override
  State<ArtistCarouselWidget> createState() => ArtistCarouselWidgetState();
}

class ArtistCarouselWidgetState extends State<ArtistCarouselWidget> {
  late final ScrollController _controller;
  int? randomedIndex;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpTo(_controller.position.maxScrollExtent / 2);
      }
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_controller.hasClients) return;
      final next = _controller.offset + 150;
      if (next >= _controller.position.maxScrollExtent) {
        _controller.jumpTo(0);
      } else {
        _controller.animateTo(
          next,
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
        );
      }
    });
  }

  void scrollToRandomArtist() async{
    _timer?.cancel();
    if (!_controller.hasClients) return;

    const itemWidth = 204.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final extraCards = 40 + Random().nextInt(widget.artists.length);
    final currentIndex = (_controller.offset / itemWidth).round();
    final targetIndex = currentIndex + extraCards;

    final targetOffset =
        targetIndex * itemWidth - (screenWidth / 2.5) + (itemWidth / 2);
    
    await _controller.animateTo(
      targetOffset.clamp(0.0, _controller.position.maxScrollExtent),
      duration: const Duration(seconds: 5),
      curve: Curves.easeInOutExpo,
    );

    setState(() {
      randomedIndex = targetIndex;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.artists.length * 100,
        itemBuilder: (context, index) {
          final artist = widget.artists[index % widget.artists.length];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ArtistCardWidget(
              artist: artist,
              isSelected: index == randomedIndex,
            ),
          );
        },
      ),
    );
  }
}
