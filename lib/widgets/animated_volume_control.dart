import 'package:flutter/material.dart';
import '../services/audio_service.dart';
// We have GlassContainer from before
import '../services/tts_service.dart';

class AnimatedVolumeControl extends StatefulWidget {
  const AnimatedVolumeControl({super.key});

  @override
  State<AnimatedVolumeControl> createState() => _AnimatedVolumeControlState();
}

class _AnimatedVolumeControlState extends State<AnimatedVolumeControl> {
  bool _isHovered = false;
  bool _isDragging = false;
  bool _isManuallyExpanded = false;

  bool get _isExpanded => _isHovered || _isDragging || _isManuallyExpanded;

  @override
  Widget build(BuildContext context) {
    final bool isMuted = AudioService().isMuted;
    final double volume = AudioService().volume;

    return TapRegion(
      onTapOutside: (_) {
        if (_isManuallyExpanded) {
          setState(() => _isManuallyExpanded = false);
        }
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: _isExpanded ? 160 : 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    if (!_isExpanded) {
                      _isManuallyExpanded = true;
                    } else {
                      AudioService().toggleMute();
                      if (AudioService().isMuted) {
                        TtsService().stop();
                      }
                    }
                  });
                },
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  child: Icon(
                    isMuted || volume == 0
                        ? Icons.volume_off
                        : (volume > 0.5 ? Icons.volume_up : Icons.volume_down),
                    color: Colors.amberAccent,
                    size: 20,
                  ),
                ),
              ),
              if (_isExpanded)
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.0,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
                      activeTrackColor: Colors.amberAccent,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.amberAccent,
                    ),
                    child: Slider(
                      value: isMuted ? 0.0 : volume,
                      min: 0.0,
                      max: 1.0,
                      onChangeStart: (_) => setState(() => _isDragging = true),
                      onChangeEnd: (_) => setState(() => _isDragging = false),
                      onChanged: (val) {
                        setState(() {
                          if (isMuted && val > 0) {
                            AudioService().setMute(false);
                          }
                          AudioService().setVolume(val);
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
