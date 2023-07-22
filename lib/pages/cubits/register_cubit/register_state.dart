part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLodaing extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class Registerfailure extends RegisterState {
  String errorMessage;
  Registerfailure({required this.errorMessage});
}
