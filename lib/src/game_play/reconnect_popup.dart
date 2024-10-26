import 'package:flutter/material.dart';
import 'package:poker_with_friends/src/network_agent/network_agent.dart';
import 'package:provider/provider.dart';

class ReconnectPopup extends StatelessWidget {
  const ReconnectPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatusProvider>(
      builder: (context, networkStatusProvider, child) {
        if (networkStatusProvider.showRetry) {
          // Reset the pop status to prevent multiple pops
          // networkStatusProvider.resetPopStatus();

          // // Pop the widget
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Navigator.of(context).pop();
          // });
        }

        return Container(
          color: Colors.black.withOpacity(0.6), // Dim background
          child: Center(
            child: Stack(
              children: [
                // Add a circle button to close the dialog
                Align(
                  alignment: const Alignment(0.3, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.close, size: 20, color: Colors.black),
                    ),
                  ),
                ),
                networkStatusProvider.showRetry ?
                Center(
                  child: ElevatedButton.icon(onPressed: () {
                    context.read<NetworkAgent>().wsReconnect();
                    debugPrint('Retry...');
                  }, label: const Text('Retry'),
                  icon: const Icon(Icons.refresh))
                )
                : Center(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 12),
                        Text(
                          'Reconnecting...',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}