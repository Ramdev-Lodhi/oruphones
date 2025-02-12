import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

// Auth Events
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String phoneNumber;
  LoginEvent(this.phoneNumber);
}

class LogoutEvent extends AuthEvent {}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;
  VerifyOtpEvent(this.phoneNumber, this.otp);
}

// Auth States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;  // ✅ Store complete user data
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

// Auth BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      bool success = await _authService.sendOTP(event.phoneNumber);
      if (success) {
        emit(AuthInitial()); // ✅ OTP Sent Successfully
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      bool success = await _authService.verifyOTP(event.phoneNumber, event.otp);
      if (success) {
        emit(Authenticated(_authService.currentUser!)); // ✅ Store User Data
      }
    });

    on<LogoutEvent>((event, emit) {
      _authService.logout();
      emit(Unauthenticated());
    });
  }
}
