import 'dart:async';

import 'package:epbasic_debts/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _surnameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

//Recuperar los datos del Stream
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);

  Stream<String> get surnameStream =>
      _surnameController.stream.transform(validateSurname);

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  //Insertar valores al Stream
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeSurname => _surnameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener los datos
  String get name => _nameController.value;
  String get surname => _surnameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _nameController?.close();
    _surnameController?.close();
    _emailController?.close();
    _passwordController?.close();
  }
}
