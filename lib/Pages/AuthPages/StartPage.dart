import 'package:flutter/material.dart';
import 'SignUpPage.dart';
import 'SignInPage.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset('assets/logo.png',
                  width: 150,
                  height: 150,
                ),
                Text("Find all the care in the world!",
                  textAlign: TextAlign.center, style:
                  Theme.of(context).textTheme.headline5,),
                SizedBox(height: 10),
                Text("not the world, the U.S",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Spacer(),
                InkWell(
                  onTap: () => (
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage())
                      )
                  ),
                  child: Container(
                    child: Center(
                      child: Text("Sign Up with Email",
                          style: Theme.of(context).textTheme.button
                      ),
                    ),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () => (
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage())
                      )
                  ),
                  child: Text(
                      "Already have an account? Sign in",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                const SizedBox(height: 30),
              ],
            ),
          )
      ),
    );
  }
}
