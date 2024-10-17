abstract class GenericMessage {
  void getMessage();
}

class PrintGenericMessage implements GenericMessage {
  final String _message;
  PrintGenericMessage(this._message) : assert(_message.isNotEmpty);
  @override
  void getMessage() => print(_message);
}

class PrintGenericMessageError implements GenericMessage {
  final String _message;
  PrintGenericMessageError(this._message) : assert(_message.isNotEmpty);
  @override
  void getMessage() => print(_message);
}
