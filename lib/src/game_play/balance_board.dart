import 'package:flutter/material.dart';
import 'package:poker_with_friends/main.dart';
import 'package:poker_with_friends/proto/message.pb.dart' as proto;
import 'package:poker_with_friends/src/audio/audio_controller.dart';
import 'package:provider/provider.dart';


class BalanceBoardProvider with ChangeNotifier {
  bool _isBalanceBoardVisible = false;

  bool get isBalanceBoardVisible => _isBalanceBoardVisible;

  void toggleBalanceBoardVisibility() {
    _isBalanceBoardVisible = !_isBalanceBoardVisible;
    notifyListeners();
  }
}

class BalanceLeaderboardDialog extends StatelessWidget {
  final List<proto.PlayerBalance> entries;

  const BalanceLeaderboardDialog({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return context.watch<BalanceBoardProvider>()._isBalanceBoardVisible ? Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return GestureDetector(
              onTap: () => context.read<BalanceBoardProvider>().toggleBalanceBoardVisibility(),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            );
          },
        ),
        OverlayEntry(
          builder: (context) {
            return Center(
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: GestureDetector(
                  onTap: () {}, // Prevents taps on the dialog from closing it
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 1,
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black54.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Balance Leaderboard',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellowAccent.withOpacity(0.9)),
                          ),
                          Flexible(
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: entries.length,
                                itemBuilder: (context, index) {
                                  final entry = entries[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 10,
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Text(entry.playerName, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.9))),
                                    trailing: Text(entry.balance.toString(), style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.9))),
                                  );
                                },
                              ),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () => Navigator.of(context).pop(),
                          //   child: const Text('Close'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ) : const SizedBox.shrink();
  }
}
