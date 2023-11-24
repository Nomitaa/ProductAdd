import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/core/constants/constants.dart';
import '../../features/auth/controller/auth_controller.dart';

class SigninButton extends ConsumerWidget {
  const SigninButton({super.key});
  void signInWithGoogle(WidgetRef ref){
    ref.read(authcontrollerProvider).signInWithGoogle();
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ElevatedButton.icon(onPressed:() => signInWithGoogle(ref),
        icon:Image.asset(Constants.googlepath,width: 34,),
        label: const Text("Continue with google"));
  }

}
