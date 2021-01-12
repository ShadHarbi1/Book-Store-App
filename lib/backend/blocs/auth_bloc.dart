import 'dart:async';
import 'dart:math';

import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // ** Get Data
  Stream<String> get name => _name.stream.transform(validateEmail);
  Stream<String> get email => _email.stream;
  Stream<String> get password => _password.stream;
  Stream<bool> get isValid => CombineLatestStream.combine3(
      name, email, password, (name, email, password) => true);

  // ** Set Data
  Function(String) get changename => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _name.close();
    _email.close();
    _password.close();
  }

  // ** Transformers >>> Validation

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isEmpty) {
      sink.add(name.trim());
    } else {
      sink.addError('Must be valid name');
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (regExpEmail.hasMatch(email.trim())) {
      sink.add(email.trim());
    } else {
      sink.addError('Must be valid email address');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password.trim());
    } else {
      sink.addError('6 Charector minimum');
    }
  });
}
