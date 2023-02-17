import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:y_guide/app_cubit/app_cubit.dart';
import 'package:y_guide/layout/guide_layout.dart';
import 'package:y_guide/modules/signup/cubit/cubit.dart';
import 'package:y_guide/modules/signup/cubit/states.dart';
import 'package:y_guide/shared/colors.dart';
import 'package:y_guide/shared/components/constants.dart';
import 'package:y_guide/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';

class SignupScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuideSignupCubit(),
      child: BlocConsumer<GuideSignupCubit , GuideSignupStates>(
        listener:(context , state) {
          if(state is GuideCreateUserSuccessState){
            GuideCubit.get(context).getUserData();
            CacheHelper.saveData(
                key: 'uId',
                value: uId).then((value) {
              navigateAndFinish(context, GuideLayout());
            });
          }
        } ,
        builder:(context , state) {
          return Scaffold(
            appBar: AppBar(
            ),
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
                          'Signup',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register to be with our family !',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 30,),
                        defaultTxtForm(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty){
                                return "What\'s your name !";
                              }

                            },
                            label: 'Name',
                            prefix: Icons.person
                        ),
                        SizedBox(height: 15,),
                        defaultTxtForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value){
                              if(value!.isEmpty){
                                return "We need your phone !";
                              }

                            },
                            label: 'Phone',
                            prefix: Icons.phone_iphone_outlined
                        ),
                        SizedBox(height: 15,),
                        defaultTxtForm(
                            controller: emailController,
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
                              
                            },
                            label: 'Password',
                            isPassword: GuideSignupCubit.get(context).isPassword,
                            prefix: Icons.lock_open_outlined,
                            suffix: GuideSignupCubit.get(context).suffix,
                            onSuffixPressed: (){
                              GuideSignupCubit.get(context).changePasswordVisibility();
                            }
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! GuideSignupLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  GuideSignupCubit.get(context).userSignup(
                                    name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'Signup'
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(color: buttonsColor,)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
