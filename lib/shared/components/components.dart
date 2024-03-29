import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:y_guide/shared/colors.dart';


void navigateTo(context , widget) => Navigator.push(context,
    MaterialPageRoute(builder:  (context) => widget)) ;

void navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder:  (context) => widget),
    (route) => false
) ;


Widget defaultTxtForm({
  required TextEditingController controller ,
  required TextInputType type ,
  Function(String)? onSubmit ,
  VoidCallback? onTap ,
  Function(String)? onChanged ,
  required String? Function(String?)? validate ,
  required String label ,
  IconData? prefix ,
  IconData? suffix = null ,
  bool isPassword = false,
  bool isClickable = true ,
  VoidCallback? onSuffixPressed ,
  Color prefixColor = buttonsColor

}) => TextFormField(
  validator: validate,
  cursorColor: buttonsColor,
  obscureText: isPassword,
  controller: controller,
  decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[400]),
      prefixIcon: Icon(prefix , color: prefixColor,),
      suffixIcon: GestureDetector(
        child: Icon(suffix),
        onTap: onSuffixPressed,
      ),

      border: OutlineInputBorder()
  ),
  keyboardType: type,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  onTap: onTap,
) ;


Widget defaultButton({
  double width = double.infinity ,
  double height = 50 ,
  Color background = buttonsColor ,
  required VoidCallback function ,
  required String text ,
  bool isUpperCase = true,


}) => Container(
  width: width,
  child: MaterialButton(
    height: height,
    onPressed: function,
    child: Text(isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(color: Colors.white),),
  ),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
    color: background,
  ),
);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  Color color = buttonsColor ,

}) => TextButton(onPressed: function
    ,child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color , fontSize: 16),
    ));

void showToast({
  required String text ,
  required ToastStates state ,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS , ERROR , WARNING}
Color? chooseToastColor(ToastStates state){
  Color? color ;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color ;

}

Widget myDivider() => Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);

PreferredSizeWidget? defaultAppBar({
  required BuildContext context ,
  dynamic title ,
  List<Widget>? actions,
  Color color = textColor,
  Color titleColor = Colors.white,

}) => AppBar(
  backgroundColor: color,
  leading: IconButton(
    color: titleColor,
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios_new),
  ),
  title: Text(title, style: TextStyle(color: titleColor),),
  titleSpacing: 0,
  actions: actions,
);


