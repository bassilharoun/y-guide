import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:y_guide/app_cubit/app_cubit.dart';
import 'package:y_guide/layout/guide_layout.dart';
import 'package:y_guide/modules/login/cubit/cubit.dart';
import 'package:y_guide/modules/login/cubit/states.dart';
import 'package:y_guide/modules/signup/signup_screen.dart';
import 'package:y_guide/shared/colors.dart';
import 'package:y_guide/shared/components/components.dart';
import 'package:y_guide/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>GuideLoginCubit(),
      child: BlocConsumer<GuideLoginCubit , GuideLoginStates>(
        listener: (context , state) {
          if(state is GuideLoginErrorState){
            showToast(text: state.error,
                state: ToastStates.ERROR
            );
          }
          if(state is GuideLoginSuccessState){
            GuideCubit.get(context).getUserData();
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId).then((value) {
              navigateAndFinish(context, GuideLayout());
            });
          }
        },
        builder: (context , state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN.',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 15,),
                        Center(child: Container(
                          height: 220,
                            width: 220,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/logo.jpeg') ,
                                )
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "We are here to help you, Let's try",
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                        Text(
                          "Y Guide !",
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 20,),
                        defaultTxtForm(controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty){
                                return "Your email can't be empty !";
                              }

                            },
                            label: 'Email',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTxtForm(controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty){
                                return "Password is too short !";
                              }
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                GuideLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            label: 'Password',
                            isPassword: GuideLoginCubit.get(context).isPassword,
                            prefix: Icons.lock_open_outlined,
                            suffix: GuideLoginCubit.get(context).suffix,
                            onSuffixPressed: (){
                              GuideLoginCubit.get(context).changePasswordVisibility();
                            }
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! GuideLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  GuideLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'Login'
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(color: buttonsColor,)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(fontSize: 16,color: Colors.grey[500]),
                            ),
                            defaultTextButton(function: (){
                              navigateTo(context , SignupScreen());
                            }, text: 'Signup'),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
