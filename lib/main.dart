import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:y_guide/app_cubit/app_cubit.dart';
import 'package:y_guide/app_cubit/app_states.dart';
import 'package:y_guide/firebase_options.dart';
import 'package:y_guide/layout/guide_layout.dart';
import 'package:y_guide/modules/login/login_screen.dart';
import 'package:y_guide/modules/on_boarding/on_boarding_screen.dart';
import 'package:y_guide/shared/bloc_observer.dart';
import 'package:y_guide/shared/components/constants.dart';
import 'package:y_guide/shared/network/local/cache_helper.dart';
import 'package:y_guide/styles/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  print("----------------");
  Widget widget ;
  if(uId != null){
    widget = GuideLayout();
  }else {
    widget = OnBoardingScreen() ;
  }



  runApp(MyApp(
    startWidget : widget,
  ));
}

class MyApp extends StatelessWidget{
  final Widget? startWidget ;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => GuideCubit()..getUserData(),),
      ],
      child: BlocConsumer<GuideCubit , GuideStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light ,
            home: startWidget,
          );
        },
      ),
    );
  }

}