
abstract class GuideSignupStates {}

class GuideSignupInitialState extends GuideSignupStates {}
class GuideSignupLoadingState extends GuideSignupStates {}
class GuideSignupSuccessState extends GuideSignupStates {}
class GuideSignupErrorState extends GuideSignupStates {
  final String error ;
  GuideSignupErrorState(this.error);
}

class GuideCreateUserSuccessState extends GuideSignupStates {}
class GuideCreateUserErrorState extends GuideSignupStates {
  final String error ;
  GuideCreateUserErrorState(this.error);
}

class GuideChangePasswordVisibilitySignupState extends GuideSignupStates {}