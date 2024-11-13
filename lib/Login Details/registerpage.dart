import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_vault/Login%20Details/loginpage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController userName = TextEditingController();
  TextEditingController mobileNum = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Password visibility state
  bool _isPasswordVisible = false;

  Future<void> registerUser() async {
    if (!registerKey.currentState!.validate()) {
      return;
    }

    String name = userName.text.trim();
    String mobile = mobileNum.text.trim();
    String email = emailAddress.text.trim();
    String password = newPassword.text.trim();
    String confirmpassword = confirmPassword.text.trim();

    if (password != confirmpassword) {
      showMessage("Passwords doesn't match");
      return;
    }

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String role = "user";
      QuerySnapshot users =
          await FirebaseFirestore.instance.collection('users').get();

      if (users.docs.isEmpty) {
        role = "admin";
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'mobile': mobile,
        'role': role,
      });

      showMessage(
          "Registration Successful. User: ${userCredential.user!.email}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showMessage('An account already exists for that email.');
      } else {
        showMessage(e.message.toString());
      }
    } catch (e) {
      showMessage("Error: ${e.toString()}");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: registerKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                buildTextField(
                  userName,
                  "Full Name",
                  Icons.person,
                ),
                buildTextField(mobileNum, "Mobile Number", Icons.phone,
                    TextInputType.phone, validateMobile),
                buildTextField(emailAddress, "Email ID", Icons.email,
                    TextInputType.emailAddress, validateEmail),
                buildPasswordField(newPassword, "Password", validatePassword),
                buildPasswordField(confirmPassword, "Confirm Password",
                    validateConfirmPassword),
                const SizedBox(height: 20),
                buildButton("Sign Up", registerUser),
                const SizedBox(height: 15),
                const Center(
                    child: Text("Already Have An Account?",
                        style: TextStyle(fontSize: 18))),
                const SizedBox(height: 10),
                buildButton("Login", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller, String hintText, IconData icon,
      [TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget buildPasswordField(TextEditingController controller, String hintText,
      String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: !_isPasswordVisible, // Update to use the visibility state
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          prefixIcon: const Icon(Icons.lock, color: Colors.deepPurple),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.deepPurple,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile number is required";
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return "Enter a valid 10-digit mobile number";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    } else if (value != newPassword.text) {
      return "Passwords do not match";
    }
    return null;
  }
}
