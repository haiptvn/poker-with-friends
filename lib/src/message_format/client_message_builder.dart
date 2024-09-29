import '../../proto/message.pb.dart' as $proto;

class ClientMessageBuilder {
  final String controlType;
  final List<int> options;

  ClientMessageBuilder._(this.controlType, this.options);

  factory ClientMessageBuilder.build(String type, int option) {
    return ClientMessageBuilder._(type, [option]);
  }

  dynamic toProto() {
    final msg = $proto.ClientMessage()
      ..controlAction = $proto.ControlAction()
      ..controlAction.controlType = controlType
      ..controlAction.options.addAll(options);

      return msg.writeToBuffer();
  }

  @override
  String toString() {
    return 'ClientMessageBuilder{controlType: $controlType, options: $options}';
  }
}