import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:y_guide/modules/login/cubit/states.dart';
import 'package:y_guide/shared/components/constants.dart';


class GuideLoginCubit extends Cubit<GuideLoginStates>{
  GuideLoginCubit() : super(GuideLoginInitialState());

  static GuideLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email ,
    required String password
}){
    emit(GuideLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uId = value.user!.uid;
      emit(GuideLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(GuideLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void changePasswordVisibility(){
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(GuideChangePasswordVisibilityState());
  }
}