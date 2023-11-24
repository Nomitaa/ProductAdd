import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/core/common/signinbutton.dart';
import 'package:newpro/core/constants/constants.dart';

var h;
var w;

class Loginscreen extends ConsumerWidget {
   Loginscreen({super.key});
TextEditingController name=TextEditingController();
TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h * 0.25,

              ),
              // Text(
              //   "Dive Into anything",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20,
              //       letterSpacing: 0.5),
              // ),
              //
              TextFormField(
                keyboardType: TextInputType.name,
                textAlign: TextAlign.start,
                controller: name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Name',
                    hintText: 'Enter valid name'),
              ),
              SizedBox(
                height: h*0.03,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                textAlign: TextAlign.start,
                controller: password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'password',
                    hintText: 'Enter valid password'),
              ),

              SizedBox(
                height: h * 0.3,
              ),
              const Center(child: SigninButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
