import 'package:flutter/material.dart';
import 'package:have_you_heard/features/home/domain/entities/artist.dart';

class ArtistCardWidget extends StatefulWidget {
  final Artist artist;
  final bool isSelected;
  const ArtistCardWidget({super.key, required this.artist, this.isSelected = false});

  @override
  State<ArtistCardWidget> createState() => _ArtistCardWidgetState();
}

class _ArtistCardWidgetState extends State<ArtistCardWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulseController;

  @override
  void didUpdateWidget(covariant ArtistCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _pulseController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      )..repeat(reverse: true);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _pulseController?.dispose();
      _pulseController = null;
    }
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(widget.artist.img),
        ),
      ),
      width: 200,
      height: 200,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          widget.artist.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    if (!widget.isSelected || _pulseController == null) return card;

    return ListenableBuilder(
      listenable: _pulseController!,
      builder: (context, child) {
        final opacity = 0.3 + 0.7 * _pulseController!.value;
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: Colors.greenAccent.withOpacity(opacity),
              width: 3,
            ),
          ),
          child: child,
        );
      },
      child: card,
    );
  }
}
