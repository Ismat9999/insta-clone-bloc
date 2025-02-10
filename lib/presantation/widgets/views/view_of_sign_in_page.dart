import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_bloc.dart';


Widget viewOfSignInPage (BuildContext context, SignInBloc signInBloc,bool isLoading){
  return GestureDetector(
    onTap: (){
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193,53,132,1),
                Color.fromRGBO(131,58,180,1),
              ]
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: "Billabong"),),
                      //   email
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 50,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: TextField(
                          controller: signInBloc.emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 17, color: Colors.white54
                            ),
                          ),
                        ),
                      ),

                      //   password
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 50,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: TextField(
                          controller:signInBloc.passwordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 17, color: Colors.white54
                            ),
                          ),
                        ),
                      ),

                      //   signIn
                      GestureDetector(
                        onTap: (){
                          signInBloc.doSignIn(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Center(
                            child: Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 17),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(color: Colors.white, fontSize: 16),),
                    const SizedBox(width: 10,),
                    GestureDetector(
                        onTap: (){
                          signInBloc..callSignUpPage(context);
                        },
                        child: const Text("Sign Up",style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}