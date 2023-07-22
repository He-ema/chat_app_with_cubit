import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLodaing());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(Registerfailure(errorMessage: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(Registerfailure(errorMessage: 'Email already exist'));
      }
    } on Exception catch (e) {
      emit(Registerfailure(errorMessage: 'Something went wrong'));
    }
  }
}
