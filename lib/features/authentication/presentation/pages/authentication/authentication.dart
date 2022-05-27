import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/states.dart';
import '../../../../../core/constants/image_path.dart';
import '../../provider/authentication_provider.dart';

class Authentication extends StatefulHookConsumerWidget {
  @override
  ConsumerState<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<Authentication> {
  TextEditingController matricNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(authenticationNotifierProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: Stack(children: [
      Positioned(
        top: -40,
        child: Image.asset(ImagesAsset.top_background),
      ),
      Positioned(
        top: 80,
        child: Container(
          width: context.screenWidth(),
          height: 25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(!isDarkMode
                      ? ImagesAsset.logo_light
                      : ImagesAsset.logo_dark))),
        ),
      ),
      Positioned.fill(
        top: 150,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: context.screenWidth(),
                height: 240,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(ImagesAsset.senate_building))),
              ),
              YMargin(40),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      "LOGIN",
                      style: Config.b1(context).copyWith(
                          color: !isDarkMode
                              ? ProbitasColor.ProbitasSecondary
                              : ProbitasColor.ProbitasAccent),
                    ),
                  ),
                ],
              ),
              YMargin(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(children: [
                  ProbitasTextFormField(
                    hintText: "Matric Number",
                    controller: matricNumber,
                    inputType: TextInputType.text,
                  ),
                  YMargin(20),
                  ProbitasTextFormField(
                    hintText: "Password",
                    controller: password,
                    inputType: TextInputType.visiblePassword,
                    obscureText: !visible,
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        child: Icon(
                          !visible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: !isDarkMode
                              ? ProbitasColor.ProbitasSecondary
                              : ProbitasColor.ProbitasAccent,
                        )),
                  ),
                ]),
              ),
              YMargin(40),
              Consumer(
                builder: (context, watch, child) {
                  final state =
                      watch.read(authenticationNotifierProvider.notifier);

                  return ProbitasButton(
                      text: "Login",
                      showLoading: loginState.viewState.isLoading,
                      onTap: () async {
                        await state.login(matricNumber.text, password.text);
                      });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer(builder: (context, watch, child) {
                  return Text(
                    "Note: Use Matric Number and Password \nfrom your student portal to proceed",
                    textAlign: TextAlign.center,
                    style: Config.b3(context).copyWith(
                        color: !isDarkMode
                            ? ProbitasColor.ProbitasSecondary
                            : ProbitasColor.ProbitasAccent),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
