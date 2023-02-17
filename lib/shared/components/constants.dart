import 'package:y_guide/app_cubit/app_cubit.dart';
import 'package:y_guide/modules/login/login_screen.dart';
import 'package:y_guide/shared/components/components.dart';
import 'package:y_guide/shared/network/local/cache_helper.dart';

import '../../models/user_model.dart';

void signOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      GuideCubit.get(context).userModel = UserModel.fromJson({});
      navigateAndFinish(context, LoginScreen());
    }
  });
}
dynamic uId  ;