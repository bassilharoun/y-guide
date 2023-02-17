abstract class GuideStates {}

class GuideInitialStates extends GuideStates {}

class GuideGetUserSuccessState extends GuideStates {}
class GuideGetUserLoadingState extends GuideStates {}
class GuideGetUserErrorState extends GuideStates {
  final String Error ;
  GuideGetUserErrorState(this.Error);
}


class GuideGetProductsSuccessState extends GuideStates {}
class GuideGetProductsLoadingState extends GuideStates {}
class GuideGetProductsErrorState extends GuideStates {
  final String Error ;
  GuideGetProductsErrorState(this.Error);
}

class GuideGetSomeoneProductsSuccessState extends GuideStates {}
class GuideGetSomeoneProductsLoadingState extends GuideStates {}
class GuideGetSomeoneProductsErrorState extends GuideStates {
  final String Error ;
  GuideGetSomeoneProductsErrorState(this.Error);
}

class GuideChangeBottomNavBarState extends GuideStates {}

class GuideProfileImagePickedSuccessState extends GuideStates {}
class GuideProfileImagePickedErrorState extends GuideStates {}

class GuideCoverImagePickedSuccessState extends GuideStates {}
class GuideCoverImagePickedErrorState extends GuideStates {}

class GuideUploadProfileImageSuccessState extends GuideStates {}
class GuideUploadProfileImageErrorState extends GuideStates {}

class GuideUploadCoverImageSuccessState extends GuideStates {}
class GuideUploadCoverImageErrorState extends GuideStates {}

class GuideUserUpdateLoadingState extends GuideStates {}
class GuideUserUpdateErrorState extends GuideStates {}

class GuideCreateProductLoadingState extends GuideStates {}
class GuideCreateProductErrorState extends GuideStates {}
class GuideCreateProductsuccessState extends GuideStates {}

class GuideGetAnotherUserLoadingState extends GuideStates {}
class GuideGetAnotherUserErrorState extends GuideStates {}
class GuideGetAnotherUserSuccessState extends GuideStates {}

class GuideProductImagePickedSuccessState extends GuideStates {}
class GuideProductImagePickedErrorState extends GuideStates {}

class GuideRemoveProductImageState extends GuideStates {}

class GuideSendMessageErrorState extends GuideStates {}
class GuideSendMessageSuccessState extends GuideStates {}
class GuideGetMessagesErrorState extends GuideStates {}
class GuideGetMessagesSuccessState extends GuideStates {}

class GuideGetSearchUserSuccessState extends GuideStates {}
class GuideGetSearchUserErrorState extends GuideStates {}

class GuideGetAllUserSuccessState extends GuideStates {}
class GuideGetAllUserErrorState extends GuideStates {}


class GuideLikePostErrorState extends GuideStates {
  final String Error ;
  GuideLikePostErrorState(this.Error);
}


