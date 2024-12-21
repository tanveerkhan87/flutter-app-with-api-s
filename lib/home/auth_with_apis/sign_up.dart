import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
// using post Request of Api`s

class _SignUpState extends State<SignUp> {
 TextEditingController emailC = TextEditingController();
 TextEditingController passwordC = TextEditingController();
 // for sign Up ,auth ,the api  email: eve.holt@reqres.in , password: pistol put this in textfeild.

 void login(String email , password)async{
 try{
   Response response = await post(Uri.parse("https://reqres.in/api/register"),
     body: {
   "email": email,
   "password" : password,
   }
   );
   if (response.statusCode==200){
     var data = response.body.toString();
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("Sign up successfully"))));
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(data))));

   }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("Faild"))));

   }
 }catch(e){
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(e.toString()))));
 }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up with apis"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            TextFormField(
              controller: emailC,
        decoration: InputDecoration(
              hintText: "Enter your Email ",
              suffixIcon: Icon(Icons.email),
              border: OutlineInputBorder()
            ),),
            SizedBox(height: 13),
            TextFormField(
              controller: passwordC,
              decoration: InputDecoration(
                hintText: "Enter your Password ",
                suffixIcon: Icon(Icons.lock),
                border: OutlineInputBorder()
            ),),
            SizedBox(height: 22),
             GestureDetector(
               onTap: (){
                 login(emailC.text.toString(), passwordC.text.toString());
               },
               child: Container(
                 color: Colors.deepPurple,
                 height: MediaQuery.sizeOf(context).height * 0.05,
                 width: MediaQuery.sizeOf(context).width * 0.6,
                 child: Center(child: Text(
                   "Sign Up",style: TextStyle(
                     color: Colors.white),),),
               ),
             )
          ],
        ),
      ),

    );
  }
}
