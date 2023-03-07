import 'package:domain_firebase/screen/login_screen.dart';
import 'package:domain_firebase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(children: [
          TextField(
            controller: _emailController,
            obscureText: false,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          ElevatedButton(
              onPressed: () async {
                bool res = await _service.register(
                    _emailController.text, _passwordController.text);
                if (res) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Account Created")));
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
              child: const Text("Create Account"))
        ]),
      ),
    );
  }
}
