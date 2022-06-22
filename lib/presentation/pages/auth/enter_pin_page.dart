import 'package:auto_route/auto_route.dart';
import 'package:chat_app/presentation/bloc/auth/bloc/phone_auth_bloc.dart';

import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterPinPage extends StatefulWidget {
  final String verId;
  const EnterPinPage({required this.verId, Key? key}) : super(key: key);

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  final TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneAuthVerified) {
            // context.router.replace(const HomeRoute());
            context.router.replaceAll([HomeRoute(), MyProfileRoute()]);
          }

          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 36, right: 36, top: 81),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/background.png')),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              const SizedBox(
                height: 43,
              ),
              const Text(
                'Welcome to Whatsapp',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 32,
              ),
              // TextField(),
              Container(
                width: 200,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: AppColors.textField,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                child: Center(
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    length: 6,
                    obscureText: false,
                    hintCharacter: '-',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      activeColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      errorBorderColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      borderRadius: BorderRadius.zero,
                      fieldHeight: 50,
                      fieldWidth: 20,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 100),
                    enableActiveFill: false,
                    controller: pinController,
                    onCompleted: (v) {
                      print('Completed');
                    },
                    onChanged: print,
                    beforeTextPaste: (text) {
                      print('Allowing to paste $text');

                      return true;
                    },
                    appContext: context,
                  ),
                ),
              ),

              const SizedBox(
                height: 67,
              ),
              ElevatedButton(
                onPressed: () => _verifyOtp(verificationId: widget.verId),
                child: const Text('Done'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.green,
                  fixedSize: const Size(236, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyOtp({required String verificationId}) {
    context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(
          otpCode: pinController.text,
          verificationId: verificationId,
        ));
  }
}
