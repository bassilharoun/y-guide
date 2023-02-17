import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:y_guide/app_cubit/app_states.dart';
import 'package:y_guide/models/user_model.dart';
import 'package:y_guide/modules/history/history_screen.dart';
import 'package:y_guide/modules/recommendation/recommend_screen.dart';
import 'package:y_guide/shared/components/constants.dart';

class GuideCubit extends Cubit<GuideStates>{
  GuideCubit() : super(GuideInitialStates());

  static GuideCubit get(context) => BlocProvider.of(context);


  UserModel? userModel ;

  void getUserData(){
    emit(GuideGetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(GuideGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GuideGetUserErrorState(error.toString()));
    });
  }


  int currentIndex = 0 ;

  List<Widget> screens = [
    RecommendScreen(),
    HistoryScreen(),
  ] ;

  List<String> titles = [
    'Recommendations' ,
    'History' ,
  ];

  void changeBottomNav(int index , context){
    currentIndex = index ;
    emit(GuideChangeBottomNavBarState());
  }

  dynamic profileImage ;
  var picker = ImagePicker() ;

  Future<void> getProfileImage()async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      // uploadProfileImage();
      //emit(GuideProfileImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(GuideProfileImagePickedErrorState());
    }
  }

  dynamic coverImage ;
  Future<void> getCoverImage()async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      // uploadCoverImage();
      //emit(GuideCoverImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(GuideCoverImagePickedErrorState());
    }
  }


  // void uploadProfileImage(){
  //   emit(GuideUserUpdateLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
  //       .putFile(profileImage)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       updateUser(name: userModel!.name,
  //           phone: userModel!.phone,
  //           bio: userModel!.bio ,
  //           image: value
  //       );
  //     }).catchError((error){
  //       emit(GuideUploadProfileImageErrorState());
  //     });
  //   }).catchError((error){
  //     emit(GuideUploadProfileImageErrorState());
  //   });
  // }
  //

  // void uploadCoverImage(){
  //   emit(GuideUserUpdateLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
  //       .putFile(coverImage)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       updateUser(name: userModel!.name,
  //           phone: userModel!.phone,
  //           bio: userModel!.bio ,
  //           cover: value
  //       );
  //     }).catchError((error){
  //       emit(GuideUploadCoverImageErrorState());
  //     });
  //   }).catchError((error){
  //     emit(GuideUploadCoverImageErrorState());
  //   });
  // }

  // void updateUser({
  //   required String name ,
  //   required String phone ,
  //   required String bio ,
  //   String? image ,
  //   String? cover
  //
  // }){
  //   emit(GuideUserUpdateLoadingState());
  //   UserModel model = UserModel(
  //       name: name ,
  //       phone: phone ,
  //       image: image??userModel!.image ,
  //       email: userModel!.email,
  //       cover: cover??userModel!.cover ,
  //       uId: userModel!.uId,
  //       bio: bio ,
  //       isEmailVerified: false
  //   );
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .update(model.toMap())
  //       .then((value) {
  //     getUserData();
  //   })
  //       .catchError((error){
  //     emit(GuideUserUpdateErrorState());
  //   });
  // }
  //
  // dynamic postImage ;
  //
  // void removePostImage(){
  //   postImage = null ;
  //   emit(GuideRemoveProductImageState());
  // }
  //
  // Future<void> getPostImage()async{
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //
  //   if(pickedFile != null){
  //     postImage = File(pickedFile.path);
  //     emit(GuideProductImagePickedSuccessState());
  //   }else{
  //     print('No image selected');
  //     emit(GuideProductImagePickedErrorState());
  //   }
  // }
  //
  //
  // void uploadPostImage({
  //   required String date,
  //   required String postText,
  //   bool isAccountVerified = false
  // }){
  //   emit(GuideCreateProductLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
  //       .putFile(postImage)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       createPost(date: date, postText: postText,postImage: value);
  //     }).catchError((error){
  //       emit(GuideCreateProductErrorState());
  //     });
  //   }).catchError((error){
  //     emit(GuideCreateProductErrorState());
  //   });
  // }

  // void createPost({
  //   required String date,
  //   dynamic postImage,
  //   required String postText,
  // }){
  //   emit(GuideUserUpdateLoadingState());
  //   PostModel model = PostModel(
  //       name: userModel!.name ,
  //       uId: userModel!.uId,
  //       image: userModel!.image,
  //       date: date,
  //       postImage: postImage??'',
  //       postText: postText ,
  //     phone: userModel!.phone
  //   );
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .add(model.toMap())
  //       .then((value) {
  //     emit(GuideCreateProductsuccessState());
  //   })
  //       .catchError((error){
  //     emit(GuideCreateProductErrorState());
  //   });
  // }

  // List<PostModel> posts = [] ;
  // List<String> postsId = [] ;
  // List<int> likes = [] ;
  // List<int> commentsSum = [] ;
  // List<bool> listOfIsLiked = [] ;
  // List<Widget> postItems = [] ;
  //
  // List<Widget> fillPostItems(context){
  //   var length = posts.length ;
  //   postItems = [];
  //   for(int i = 0 ; i < length ; i++){
  //     postItems.add(buildPostItem(posts[i] , context , i ));
  //   }
  //   return postItems ;
  // }
  //
  // void getPosts(){
  //   posts = [] ;
  //   likes = [] ;
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       element.reference
  //           .collection('likes').get()
  //           .then((value) {
  //         likes.add(value.docs.length);
  //         postsId.add(element.id);
  //         posts.add(PostModel.fromJson(element.data()));
          // Check Like Post !!
          // value.docs.forEach((element) {
          //   if (element.id == userModel!.uId){
          //     postLikedList.add(true) ;
          //   }
          //   postLikedList.add(false) ;
          // });
          // print(postLikedList);
          // print('--------------------------');

        //   emit(GuideGetProductsSuccessState());
        //
        // })
        //     .catchError((error){
          // emit(GuideLikePostErrorState(error.toString()));
        // });
        // element.reference.collection('comments').get().then((value) {
        //   commentsSum.add(value.docs.length);
        //
        // }).catchError((error){
        //
        // });

  //     });
  //     emit(GuideGetProductsSuccessState());
  //   }).catchError((error){
  //     emit(GuideGetProductsErrorState(error.toString()));
  //   });
  // }

  // void sendMessage({
  //   required String receiverId,
  //   required String dateTime,
  //   required String text ,
  // }){
  //   MessageModel model = MessageModel(
  //       text: text ,
  //       senderId: userModel!.uId ,
  //       receiverId: receiverId ,
  //       dateTime: dateTime
  //   );
  //
  //   FirebaseFirestore
  //       .instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .collection('chats')
  //       .doc(receiverId)
  //       .collection('messages')
  //       .add(model.toMap())
  //       .then((value) {
  //     emit(GuideSendMessageSuccessState());
  //   }).catchError((error){
  //     emit(GuideSendMessageErrorState());
  //   });
  //
  //   FirebaseFirestore
  //       .instance
  //       .collection('users')
  //       .doc(receiverId)
  //       .collection('chats')
  //       .doc(userModel!.uId)
  //       .collection('messages')
  //       .add(model.toMap())
  //       .then((value) {
  //     emit(GuideSendMessageSuccessState());
  //   }).catchError((error){
  //     emit(GuideSendMessageErrorState());
  //   });
  //
  // }
  //
  // List<MessageModel> messages =[];
  //
  // void getMessages({
  //   required String receiverId
  // }){
  //
  //   FirebaseFirestore
  //       .instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .collection("chats")
  //       .doc(receiverId)
  //       .collection('messages')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //     messages = [];
  //     event.docs.forEach((element) {
  //       messages.add(MessageModel.fromJson(element.data()));
  //     });
  //     emit(GuideGetMessagesSuccessState());
  //   });
  // }
  //
  // UserModel? anotherUserModel ;
  // void getAnotherUser(
  //     String userId
  //     ){
  //   emit(GuideGetAnotherUserLoadingState());
  //   FirebaseFirestore.instance.collection('users')
  //       .doc(userId)
  //       .get()
  //       .then((value) {
  //     print(value.data());
  //     anotherUserModel = UserModel.fromJson(value.data());
  //     emit(GuideGetAnotherUserSuccessState());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(GuideGetAnotherUserErrorState());
  //   });
  // }
  //
  // List<UserModel> users = [] ;
  // void getUsersMessages(){
  //   users = [];
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //           if(element.data()['uId'] != userModel!.uId)
  //             users.add(UserModel.fromJson(element.data()));
  //
  //
  //
  //
  //     });
  //     emit(GuideGetAllUserSuccessState());
  //   }).catchError((error){
  //     emit(GuideGetAllUserErrorState());
  //   });
  // }
  //
  // List<PostModel> search = [] ;
  // void getSearch(String whatSearch)async{
  //   search = [];
  //   posts.forEach((element) {
  //     if(element.postText.toLowerCase().startsWith(whatSearch.toLowerCase())){
  //       search.add(element);
  //     }
  //     print(search);
  //   });
  //   emit(GuideGetSearchUserSuccessState());
  // }
  //
  // List<PostModel> someonePosts = [] ;
  // List<String> someonePostsId = [] ;
  //
  // void getSomeonePosts(String userId){
  //   emit(GuideGetSomeoneProductsLoadingState());
  //   someonePosts = [] ;
  //   someonePostsId = [] ;
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       if(element.get('uId') == userId){
  //
  //           someonePostsId.add(element.id);
  //           someonePosts.add(PostModel.fromJson(element.data()));
  //           emit(GuideGetSomeoneProductsSuccessState());
  //
  //       }
  //
  //
  //     });
  //     emit(GuideGetSomeoneProductsSuccessState());
  //   }).catchError((error){
  //     emit(GuideGetSomeoneProductsErrorState(error.toString()));
  //   });
  // }





}


