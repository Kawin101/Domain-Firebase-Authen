import 'package:domain_firebase/main.dart';
import 'package:domain_firebase/screen/create_account_screen.dart';
import 'package:domain_firebase/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:domain_firebase/main.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to app"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                // call service.login
                // check result and open new screen
                onPressed: () async {
                  final message = await AuthService().login(
                      email: _emailController.text,
                      password: _passwordController.text);
                  if (message!.contains("Success")) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: 'Flutter Home Page',
                            )));
                  }
                },
                child: const Text("Login")),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateAccountScreen()));
                },
                child: const Text("No account? create new >>"))
          ],
        ),
      ),
    );
  }
}
