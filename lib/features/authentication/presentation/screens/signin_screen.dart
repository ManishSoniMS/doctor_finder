import 'package:doctor_finder/features/authentication/presentation/widgets/async_value_ui.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/app_style.dart';
import '../controller/auth_controller.dart';
import '../../../../common_widget/common_button.dart';
import '../../../../common_widget/common_container.dart';
import '../../../../common_widget/common_text_form_field.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (p, c) {
      c.showAlertDialogOnError(context);
    });

    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.rsW, 50.rsH, 10.rsW, 0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.rsH),
                  Image.asset(
                    Assets.images.doctorLogo.path,
                    // height: SizeConfig.getProportionateScreenHeight(100),
                    width: 100.rsW,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 20.rsH),
                  Text(
                    "Signin to your account",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.rsH),

                  CommonTextFormField(
                    hintText: "Enter Email...",
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  SizedBox(height: 20.rsH),
                  CommonTextFormField(
                    hintText: "Enter Password...",
                    textInputType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 20.rsH),
                  CommonButton(
                    onTap: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      ref
                          .read(authControllerProvider.notifier)
                          .signInWithEmailAndPassword(email, password);
                    },
                    title: "Sign In",
                    isLoading: authController.isLoading,
                  ),
                  SizedBox(height: 20.rsH),
                  Text(
                    "OR",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.rsH),
                  CommonContainer(
                    onTap: () {
                      context.goNamed(AppRoute.userRegister.name);
                    },
                    text: "Register as a User",
                  ),
                  SizedBox(height: 20.rsH),
                  CommonContainer(
                    onTap: () {
                      context.goNamed(AppRoute.doctorRegister.name);
                    },
                    text: "Register as a Doctor",
                  ),
                  SizedBox(height: 30.rsH),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
