abstract class GenericMessage {
  String getMessage();
  void printMessage();
}

class GenericMessageImpl implements GenericMessage {
  final String _message;
  GenericMessageImpl(this._message) : assert(_message.isNotEmpty);
  @override
  void printMessage() => print(_message);
  @override
  String getMessage() => _message;
}

class GenericMessageError implements GenericMessage {
  final String _message;
  GenericMessageError(this._message) : assert(_message.isNotEmpty);
  @override
  String getMessage() => _message;
  @override
  void printMessage() => print(_message);
}
