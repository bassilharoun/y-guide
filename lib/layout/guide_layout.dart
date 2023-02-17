import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:y_guide/app_cubit/app_cubit.dart';
import 'package:y_guide/app_cubit/app_states.dart';
import 'package:y_guide/shared/colors.dart';
import 'package:y_guide/shared/components/components.dart';
import 'package:y_guide/shared/components/constants.dart';

class GuideLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuideCubit , GuideStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubit = GuideCubit.get(context);
        return ConditionalBuilder(
          condition: GuideCubit.get(context).userModel != null && cubit.userModel!.image != null,
          builder: (context) =>Scaffold(
              backgroundColor: Colors.white,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                backgroundColor: buttonsColor,
                onPressed: (){
                  GuideCubit.get(context).getProfileImage();
                },
                child: Icon(Icons.camera_alt_outlined),
              ),
              drawer: Drawer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                            child:  Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(cubit.userModel!.image,fit: BoxFit.cover,),
                              ),
                            ),
                            backgroundColor: Colors.white,),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/logo.jpeg")
                            ),
                          ),
                          accountName: Text(cubit.userModel!.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          accountEmail: Text(cubit.userModel!.email,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.person,size: 28,color: buttonsColor,),
                                SizedBox(width: 8,),
                                Text("settings",style: TextStyle(fontSize: 18),)
                              ],
                            ),
                          ),
                        ),
                      ),



                      defaultTextButton(
                          function: (){
                            signOut(context);
                          },
                          text: "logout",
                          color: Colors.red
                      )

                    ],
                  ),
                ),
              ),

              appBar: AppBar(
                actions: [
                  IconButton(onPressed: (){},
                      icon: CircleAvatar(backgroundColor: buttonsColor,child: Icon(Icons.person,color: Colors.white,)),),
                ],
                centerTitle: true,
                title: Text(cubit.titles[cubit.currentIndex]),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeBottomNav(index , context);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Recommendations'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history),
                      label: 'History'),
                ],

              ),
              body: cubit.screens[cubit.currentIndex],
            ),
          fallback: (context) => Scaffold(body: Center(child: CircularProgressIndicator(color: buttonsColor,),)),
        );
      }
    );
  }
}
