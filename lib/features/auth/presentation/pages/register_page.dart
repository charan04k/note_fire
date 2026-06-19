import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../notes/presentation/pages/dashboard_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  void register() {
    setState(() {
      _submitted = true;
    });

    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      RegisterEvent(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff5B67F1),
              Color(0xff7F53FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DashboardPage(),
                  ),
                );
              }

              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width > 600 ? 450 : double.infinity,
                    ),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _submitted
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [

                              const Icon(
                                Icons.person_add_alt_1,
                                size: 70,
                                color: Color(0xff5B67F1),
                              ),

                              const SizedBox(height: 15),

                              const Text(
                                "Create Account",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "Sign up to continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),

                              const SizedBox(height: 30),

                              TextFormField(
                                controller: nameController,
                                decoration: inputDecoration(
                                  "Full Name",
                                  Icons.person_outline,
                                ),
                                // onChanged: (_) {
                                //   _formKey.currentState?.validate();
                                // },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Full Name is required";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 18),

                              TextFormField(
                                controller: emailController,
                                keyboardType:
                                TextInputType.emailAddress,
                                decoration: inputDecoration(
                                  "Email",
                                  Icons.email_outlined,
                                ),
                                // onChanged: (_) {
                                //   _formKey.currentState?.validate();
                                // },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is required";
                                  }

                                  if (!RegExp(
                                    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value)) {
                                    return "Enter valid email";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 18),

                              TextFormField(
                                controller: passwordController,
                                obscureText: obscurePassword,
                                decoration: inputDecoration(
                                  "Password",
                                  Icons.lock_outline,
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword =
                                        !obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                // onChanged: (_) {
                                //   _formKey.currentState?.validate();
                                // },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password is required";
                                  }

                                  if (value.length < 6) {
                                    return "Minimum 6 characters";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 18),

                              TextFormField(
                                controller:
                                confirmPasswordController,
                                obscureText: obscureConfirm,
                                decoration: inputDecoration(
                                  "Confirm Password",
                                  Icons.lock_outline,
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureConfirm
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscureConfirm =
                                        !obscureConfirm;
                                      });
                                    },
                                  ),
                                ),
                                // onChanged: (_) {
                                //   _formKey.currentState?.validate();
                                // },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Confirm your password";
                                  }

                                  if (value !=
                                      passwordController.text) {
                                    return "Passwords do not match";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 30),

                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: state is AuthLoading
                                      ? null
                                      : register,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    const Color(0xff5B67F1),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: state is AuthLoading
                                      ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                      : const Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                      const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Already have an account? Login",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(
      String hint,
      IconData icon,
      ) {
    return InputDecoration(
      labelText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xff5B67F1),
          width: 2,
        ),
      ),
    );
  }
}