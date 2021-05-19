import 'package:flutter/material.dart';
class ProgressDialog extends StatelessWidget {
  //pass a message to the dialog
  String message;
  ProgressDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child:Container(
        margin : EdgeInsets.all(15.0),
        width: double.infinity,
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child:Padding(
          padding: EdgeInsets.all(15.0),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.black),),
              SizedBox(height:15.0,),
              Text(message, style:TextStyle(color:Colors.black,fontSize:8.0),),
            ],
          ),
        ),
      ),
    );
  }
}
