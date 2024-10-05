import 'package:flutter/material.dart';

import '../../proto/message.pb.dart' as proto;

// Helper function to display community cards
Widget buildCard(String imagePath) {
  return  Image.asset(
      imagePath,
      width: 46, // Card width
      height: 60, // Card height
  );
}

Widget buildCommCardFromProtoCard(proto.Card card) {
  return buildCard('assets/cards/${card.suit.value}_${card.rank.value + 1}.png');
}