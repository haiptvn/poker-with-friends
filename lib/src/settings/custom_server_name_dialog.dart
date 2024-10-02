// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'settings.dart';

void showCustomServerAddressDialog(BuildContext context) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          CustomServerNameDialog(animation: animation));
}

class CustomServerNameDialog extends StatefulWidget {
  final Animation<double> animation;

  const CustomServerNameDialog({required this.animation, super.key});

  @override
  State<CustomServerNameDialog> createState() => _CustomServerNameDialogState();
}

class _CustomServerNameDialogState extends State<CustomServerNameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        title: const Text('Change server address'),
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 15,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              context.read<SettingsController>().setServerAddress(value);
            },
            onSubmitted: (value) {
              // Player tapped 'Submit'/'Done' on their keyboard.
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _controller.text = context.read<SettingsController>().serverAddress.value;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
