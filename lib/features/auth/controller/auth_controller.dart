import 'dart:html';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/features/auth/repository/auth_repository.dart';

final authcontrollerProvider = Provider((ref) =>
    AuthController(authRepository: ref.read(authRepositoryProvider))
);


class AuthController{
  final AuthRepository _authRepository;
  AuthController({required AuthRepository authRepository})
      : _authRepository=authRepository;

  void signInWithGoogle(){
    _authRepository.signInWithGoogle();
  }

}