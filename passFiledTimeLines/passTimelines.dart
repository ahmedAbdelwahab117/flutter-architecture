import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meetor/shared/components/default_form_field.dart';
import 'package:meetor/shared/components/fallback_timeline.dart';
import 'package:meetor/shared/components/style.dart';
import 'package:meetor/shared/strings_manager.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Passtimelines extends StatefulWidget {
  const Passtimelines({super.key});

  @override
  State<Passtimelines> createState() => _PasstimelinesState();
}

class _PasstimelinesState extends State<Passtimelines> {
  TextEditingController passwordController = TextEditingController();

  // checking some validations of password to show for user if password is strong or not
  List<bool> passwordValidations = [false, false, false, false];

  // labels show user how to create strong password
  List<String> passwordValidationsLabels = [
    StringsManager.oneUppercase,
    StringsManager.oneLowercase,
    StringsManager.oneNumber,
    StringsManager.eightChar
  ];

  // labels shown on password bar to make user know if the password is weak, strong or medium
  List<String> passwordValidationsBarLabels = [
    StringsManager.none,
    StringsManager.weak,
    StringsManager.weak,
    StringsManager.medium,
    StringsManager.strong
  ];

  // these variables controlling and checking if the password text field is focused on or not
  bool isPasswordFocused = false;
  late FocusNode passwordFocus;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordObscured = true; // check if password is  hidden or not

  // these variables controlling the password bar colors and bar completeness according to the state of password (weak -> strong)
  int PasswordSteps = 0;
  List<Color> passwordBarColor = [
    Colors.grey,
    AppStyle.PrimaryColor,
    AppStyle.PrimaryColor,
    Colors.red,
    AppStyle.SecondaryColor
  ];
@override
  void initState() {
  passwordFocus = FocusNode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Visibility(
              maintainSize: false,
              visible: passwordFocus.hasFocus,
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    margin: EdgeInsetsDirectional.only(
                        bottom: 10.h),
                    child: _buildTimeline(context),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: 4,
                          currentStep: PasswordSteps,
                          size: 6.h,
                          padding: 0,
                          selectedColor: Colors.yellow,
                          unselectedColor: Colors.cyan,
                          roundedEdges:
                          Radius.circular(10.r),
                          selectedGradientColor:
                          LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context)
                                  .primaryColor,
                              Theme.of(context)
                                  .secondaryHeaderColor
                            ],
                          ),
                          unselectedGradientColor:
                          LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.yellow
                                  .withOpacity(0.5),
                              AppStyle.closeColor
                                  .withOpacity(0.5)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.bounceOut,
                        padding:
                        REdgeInsetsDirectional.all(
                            10),
                        decoration: BoxDecoration(
                            color: passwordBarColor[
                            PasswordSteps],
                            borderRadius:
                            BorderRadiusDirectional
                                .circular(10.r)),
                        child: Text(
                          passwordValidationsBarLabels[
                          PasswordSteps]
                              .tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                              color: Theme.of(context)
                                  .canvasColor,
                              fontWeight:
                              FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            DefaultFormField(
              textInputAction: TextInputAction.done,
              hint: StringsManager.passwordHint.tr(),
              focusNode: passwordFocus,
              onTap: (focus) {
                setState(() {
                  isPasswordFocused = focus;
                });
              },
              validate: (value) {
                if (passwordValidations[3] == false) {
                  return StringsManager.passwordEight
                      .tr();
                }
                return null;
              },
              onchange: (value) {
                var uppercase = RegExp(r'[A-Z]');
                var lowercase = RegExp(r'[a-z]');
                var number = RegExp(r'[0-9]');
                if (uppercase.hasMatch(value)) {
                  if (!passwordValidations[0]) {
                    passwordValidations[0] = true;
                    PasswordSteps++;

                    setState(() {});
                  }
                } else {
                  if (passwordValidations[0]) {
                    passwordValidations[0] = false;
                    PasswordSteps--;
                    setState(() {});
                  }
                }
                if (lowercase.hasMatch(value)) {
                  if (!passwordValidations[1]) {
                    passwordValidations[1] = true;
                    PasswordSteps++;
                    setState(() {});
                  }
                } else {
                  if (passwordValidations[1]) {
                    passwordValidations[1] = false;
                    PasswordSteps--;
                    setState(() {});
                  }
                }

                if (number.hasMatch(value)) {
                  if (!passwordValidations[2]) {
                    passwordValidations[2] = true;
                    PasswordSteps++;
                    setState(() {});
                  }
                } else {
                  if (passwordValidations[2]) {
                    passwordValidations[2] = false;
                    PasswordSteps--;
                    setState(() {});
                  }
                }
                if (value.length >= 8) {
                  if (!passwordValidations[3]) {
                    passwordValidations[3] = true;
                    PasswordSteps++;
                    setState(() {});
                  }
                } else {
                  if (passwordValidations[3]) {
                    passwordValidations[3] = false;
                    PasswordSteps--;
                    setState(() {});
                  }
                }
              },
              controller: passwordController,
              textInputType:
              TextInputType.visiblePassword,
              isObscured: isPasswordObscured,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordObscured =
                    !isPasswordObscured;
                  });
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.black,
                ),
              ),
              suffixIconObscured: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordObscured =
                    !isPasswordObscured;
                  });
                },
                icon: Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    try {
      return FallbackTimeline(
        direction: Axis.horizontal,
        connectorSpace: 20.w,
        connectorThickness: 3.0.w,
        itemCount: passwordValidations.length,
        itemExtentBuilder: (_, __) =>
        (MediaQuery.of(context).size.width - 100) /
            passwordValidations.length,
        oppositeContentsBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.bounceOut,
            transform: passwordValidations[index]
                ? Matrix4.translationValues(0, index % 2 == 0 ? -10.h : 10.h, 0)
                : Matrix4.translationValues(0, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10.r),
              color: passwordValidations[index] ? Colors.green : Colors.yellow,
            ),
            padding: REdgeInsetsDirectional.all(10),
            child: Text(
              passwordValidationsLabels[index].tr(),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
            ),
          );
        },
        indicatorBuilder: (_, index) {
          return FallbackDotIndicator(
            size: 10.h,
            color: Theme.of(context).secondaryHeaderColor,
          );
        },
        connectorBuilder: (_, index, type) {
          return FallbackDecoratedLineConnector(
            direction: Axis.horizontal,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).primaryColor, Colors.grey],
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Fallback to simple row if timeline fails
      debugPrint('Timeline error: $e');
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(passwordValidations.length, (index) {
          return Column(
            children: [
              if (index % 2 == 0)
                Container(
                  padding: REdgeInsetsDirectional.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10.r),
                    color: passwordValidations[index]
                        ? Colors.green
                        : Colors.yellow,
                  ),
                  child: Text(
                    passwordValidationsLabels[index].tr(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(height: 10.h),
              FallbackDotIndicator(
                size: 10.h,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              SizedBox(height: 10.h),
              if (index % 2 == 1)
                Container(
                  padding: REdgeInsetsDirectional.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10.r),
                    color: passwordValidations[index]
                        ? Colors.green
                        : Colors.yellow,
                  ),
                  child: Text(
                    passwordValidationsLabels[index].tr(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          );
        }),
      );
    }
  }
}
