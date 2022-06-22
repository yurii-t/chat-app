import 'package:auto_route/auto_route.dart';
import 'package:chat_app/presentation/bloc/auth/bloc/phone_auth_bloc.dart';

import 'package:chat_app/routes/app_router.gr.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EnterPhonePage extends StatefulWidget {
  const EnterPhonePage({Key? key}) : super(key: key);

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocSelector<PhoneAuthBloc, PhoneAuthState, bool>(
        selector: (state) {
          if (state is PhoneAuthCodeSentSuccess) {
            context.router.push(EnterPinRoute(
              verId: state.verificationId,
            ));
          }
          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

          return state is PhoneAuthLoading;
        },
        builder: (context, showLoading) {
          return
              //  showLoading
              //   ? const Center(
              //       child: SizedBox(
              //         width: 24,
              //         height: 24,
              //         child: CircularProgressIndicator(),
              //       ),
              //     )
              //   :
              Container(
            padding: const EdgeInsets.only(left: 36, right: 36, top: 136),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/background.png')),
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
                InternationalPhoneNumberInput(
                  onInputChanged: (number) {
                    print(number.phoneNumber);
                    phoneNumber = number.phoneNumber ?? '';
                    print('TESTTTT$phoneNumber');
                  },
                  textAlignVertical: TextAlignVertical.center, //top,
                  // scrollPadding: EdgeInsets.zero,
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 35,
                    trailingSpace: false,
                  ),

                  maxLength: 15, //10,
                  textStyle: const TextStyle(fontSize: 19, height: 1.45),

                  spaceBetweenSelectorAndTextField: 0,
                  ignoreBlank: true,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                      // textBaseline: TextBaseline.ideographic,
                      ),
                  initialValue: PhoneNumber(isoCode: 'UA'),

                  formatInput: true,
                  keyboardType: TextInputType.phone,

                  // inputBorder: const OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(8)),
                  // ),
                  inputDecoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: '- -  - - -  - -  - -',
                    hintStyle: TextStyle(
                        fontSize: 19, //30
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.zero,
                    alignLabelWithHint: false,
                    constraints: BoxConstraints(
                      minHeight: 45,
                      // minWidth: 303,
                      maxHeight: 45,
                      // maxWidth: 303,
                    ),
                    filled: true,
                    fillColor: AppColors.textField,
                  ),
                ),
                const SizedBox(
                  height: 67,
                ),
                ElevatedButton(
                  onPressed: _sendOtp,
                  child: showLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('Send'),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.green,
                    fixedSize: const Size(236, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context.router.replace(const HomeRoute()),
                  child: const Text('Skip'),
                ),
                ElevatedButton(
                    onPressed: () => context.router.replaceAll([
                          HomeRoute(),
                          MyProfileRoute()
                        ]), //.replace(MyProfileRoute()),
                    child: const Text('Profile')),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  'Read our Privacy Policy. Tap “Agree & \n Continue” to accept the Terms of Service.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _sendOtp() {
    final phoneNumberWithCode = phoneNumber;
    context.read<PhoneAuthBloc>().add(
          SendOtpToPhoneEvent(
            phoneNumber: phoneNumberWithCode,
          ),
        );
  }
}
