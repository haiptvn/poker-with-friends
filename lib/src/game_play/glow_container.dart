import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';
import 'package:poker_with_friends/proto/message.pb.dart' as proto;
import 'package:provider/provider.dart';


// Static const for timedown duration
const int _timeWaitForActionDurationInSec = 30;
class GlowingContainer extends StatefulWidget {
  final _log = Logger('GlowingContainer');
  final Widget child;
  final int uiIdx;

  final VoidCallback? onTimeExceeded;

  GlowingContainer({
    super.key,
    required this.child,
    required this.uiIdx,
    this.onTimeExceeded,
  });

  @override
  _GlowingContainerState createState() => _GlowingContainerState();
}

class _GlowingContainerState extends State<GlowingContainer> {
  bool _isLightOn = false;
  bool _indicator5sLeft = false;
  bool _indicatorRemainingHalftime = false;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final playerState = context.read<PokerGameStateProvider>().getPlayerByIndex(widget.uiIdx).getState;
    final isActive = playerState == proto.PlayerStatusType.Wait4Act;
    debugPrint('Changing GlowingContainer uiIdx=${widget.uiIdx}, state=$playerState to $isActive');
    if (isActive) {
      _startGlowing();
    } else {
      _stopGlowing();
    }
  }

  @override
  void dispose() {
    debugPrint('Disposing GlowingContainer uiIdx=${widget.uiIdx}');
    _timer?.cancel();
    super.dispose();
  }


  // Start the automatic blinking effect
  void _startGlowing() {
    debugPrint('Starting GlowingContainer uiIdx=${widget.uiIdx}');
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // debugPrint('Timer tick uiIdx=${widget.uiIdx}');
      if (mounted) {
        setState(() {
          _isLightOn = !_isLightOn;
        });
      }
    });
  }

  // Stop the blinking effect
  void _stopGlowing() {
    debugPrint('Stopping GlowingContainer uiIdx=${widget.uiIdx}');
    _timer?.cancel();
    setState(() {
      _isLightOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerState = context.read<PokerGameStateProvider>().getPlayerByIndex(widget.uiIdx).getState;
    final isActive = playerState == proto.PlayerStatusType.Wait4Act;
    // debugPrint('_GlowingContainerState rebuilt at ${DateTime.now()} uiIdx=${widget.uiIdx}, state=$playerState to $isActive' );
    if (_timer == null) {
      if (isActive) {
        _startGlowing();
      }
    } else {
      if (isActive) {
        // debugPrint('Timer tick uiIdx=${widget.uiIdx} tick=${_timer!.tick}');
        if (_timer!.tick > 0) {
          const totalTick = _timeWaitForActionDurationInSec*2;
          final remainingTime = totalTick - _timer!.tick;
          _indicator5sLeft = remainingTime <= 10;
          _indicatorRemainingHalftime = remainingTime <= 20;
          if (_timer!.tick >= totalTick) {
            debugPrint('Time exceeded $totalTick, UiIdx=${widget.uiIdx}');
            widget.onTimeExceeded?.call();
            _stopGlowing();
          }
        }
      }
    }
    final glowingColor = _indicator5sLeft
                    ? Colors.redAccent
                    : _indicatorRemainingHalftime
                    ? Colors.yellowAccent
                    : Colors.white;

    return AnimatedContainer(
      width: 76,
      height: 34,
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 23, 23, 23),
        border: Border.all(
          color: const Color.fromARGB(125, 55, 55, 55),
          width: 1.8,
        ),
        borderRadius: BorderRadius.circular(7),
        boxShadow: _isLightOn
          ? [BoxShadow(color: glowingColor, blurRadius: 5, spreadRadius: 2.2),]
          : [],
      ),
      child: widget.child, // The inner content of the container
    );
  }
}
