abstract class GuideLoginStates {}

class GuideLoginInitialState extends GuideLoginStates {}
class GuideLoginLoadingState extends GuideLoginStates {}
class GuideLoginSuccessState extends GuideLoginStates {
  final String uId ;

  GuideLoginSuccessState(this.uId);
}
class GuideLoginErrorState extends GuideLoginStates {
  final String error ;
  GuideLoginErrorState(this.error);
}

class GuideChangePasswordVisibilityState extends GuideLoginStates {}