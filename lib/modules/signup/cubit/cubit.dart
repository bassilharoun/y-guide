import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:y_guide/models/user_model.dart';
import 'package:y_guide/modules/signup/cubit/states.dart';
import 'package:y_guide/shared/components/constants.dart';

class GuideSignupCubit extends Cubit<GuideSignupStates>{
  GuideSignupCubit() : super(GuideSignupInitialState());

  static GuideSignupCubit get(context) => BlocProvider.of(context);


  void userSignup({
    required String email ,
    required String name ,
    required String phone ,
    required String password
}){
    emit(GuideSignupLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid);
      uId = value.user!.uid;
    }).catchError((error){
      emit(GuideSignupErrorState(error));
    });
  }

  void userCreate({
    required String email ,
    required String name ,
    required String phone ,
    required String uId ,
}){
    UserModel model = UserModel(
      name: name ,
      email: email ,
      phone: phone ,
      uId: uId ,
      image: 'https://i.pinimg.com/564x/77/bc/7a/77bc7a132be8f83584f559f8b7db3089.jpg' ,
      cover: 'https://i.pinimg.com/564x/b3/96/fa/b396fab3dc76bcd77cf84ab9fb068184.jpg' ,
      bio: 'Hello, I help spread peace !' ,
      isEmailVerified: false
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(GuideCreateUserSuccessState());
    }).catchError((error){
      emit(GuideCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void changePasswordVisibility(){
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
   emit(GuideChangePasswordVisibilitySignupState());
  }
}