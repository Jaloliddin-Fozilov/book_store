import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/author_provider.dart';

import '../models/author_model.dart';

import '../services/http_expection.dart';

enum AuthMode { Register, Login }

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();

  final _imageForm = GlobalKey<FormState>();
  var _hasImage = true;

  var _loading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
  };

  var _author = AuthorModel(
    id: Auth().userId!,
    name: '',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    email: '',
  );
  var random = Random();

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Rasm URLni kiriting.'),
          content: Form(
            key: _imageForm,
            child: TextFormField(
              initialValue: _author.imageUrl,
              decoration: const InputDecoration(
                labelText: 'Rasm URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, suratingiz havolasini kiriting.';
                } else if (!value.startsWith('http')) {
                  return 'Suratingizni URLini kiritng.';
                }
              },
              onSaved: (newValue) {
                _author = AuthorModel(
                  id: _author.id,
                  name: _author.name,
                  imageUrl: newValue!,
                  email: _author.email,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('BEKOR QILISH'),
            ),
            ElevatedButton(
              onPressed: _saveImageForm,
              child: const Text('SAQLASH'),
            ),
          ],
        );
      },
    );
  }

  void _saveImageForm() {
    final isValid = _imageForm.currentState!.validate();
    if (isValid) {
      _imageForm.currentState!.save();
      setState(() {
        _hasImage = true;
      });
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Xatolik!'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _loading = false;
                });
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      // save form
      _formKey.currentState!.save();
      setState(() {
        _loading = true;
      });
      try {
        if (_authMode == AuthMode.Login) {
          // login user
          await Provider.of<Auth>(context, listen: false).signin(
            _authData['email']!,
            _authData['password']!,
          );
          setState(() {
            _loading = false;
          });
        } else {
          //  register user
          _author = AuthorModel(
            id: _author.id,
            name: _authData['name']!,
            imageUrl: _author.imageUrl,
            email: _authData['email']!,
            followers: random.nextInt(999),
            following: random.nextInt(999),
          );

          await Provider.of<Auth>(context, listen: false).signup(
            _authData['email']!,
            _authData['password']!,
          );

          await Provider.of<AuthorProvider>(context, listen: false)
              .addAuthor(_author);

          setState(() {
            _loading = false;
          });
        }
      } on HttpExpection catch (error) {
        var errorMessage = 'Kechirasiz xatolik sodir bo\'ldi.';
        if (error.message.contains('EMAIL_EXISTS')) {
          errorMessage = 'Bunday email mavjud.';
        } else if (error.message.contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Bunday email topilmadi';
        } else if (error.message.contains('INVALID_PASSWORD')) {
          errorMessage = 'Parol notog\'ri';
        }
        _showErrorDialog(errorMessage);
      } catch (e) {
        var errorMessage =
            'Kechirasiz xatolik sodir bo\'ldi. Qaytadan urinib ko\'ring';
        _showErrorDialog(errorMessage);
      }
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_authMode == AuthMode.Register)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color:
                        _hasImage ? Colors.grey : Theme.of(context).errorColor,
                  ),
                ),
                child: GestureDetector(
                  onTap: () => _showImageDialog(context),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    child: _author.imageUrl.isEmpty
                        ? Image.network(
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                            fit: BoxFit.cover,
                            width: 75,
                            height: 75,
                          )
                        : Image.network(
                            _author.imageUrl,
                            fit: BoxFit.cover,
                            width: 75,
                            height: 75,
                          ),
                  ),
                ),
              ),
            ),
          if (_authMode == AuthMode.Login)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                fit: BoxFit.cover,
                width: 75,
                height: 75,
              ),
            ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
              child: Column(
                children: [
                  if (_authMode == AuthMode.Register)
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Ismingiz',
                      ),
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'Iltimos ismingizni kiriting';
                        }
                      },
                      onSaved: (name) {
                        _authData['name'] = name!;
                      },
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email manzil',
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Iltimos email manzil kiriting';
                      } else if (!email.contains('@')) {
                        return 'Iltimos, to\'g\'ri email kiriting';
                      }
                    },
                    onSaved: (email) {
                      _authData['email'] = email!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Parol',
                    ),
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Parolni kiriting';
                      } else if (password.length < 6) {
                        return 'Parol 5ta symbol ko\'p bo\'lishi kerak';
                      }
                    },
                    controller: _passwordController,
                    onSaved: (password) {
                      _authData['password'] = password!;
                    },
                    obscureText: true,
                  ),
                  if (_authMode == AuthMode.Register)
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Parolni tasdiqlang',
                          ),
                          obscureText: true,
                          validator: (confirmedPassword) {
                            if (_passwordController.text != confirmedPassword) {
                              return 'Iltimos, parolingizni to\'g\'ri kiting.';
                            }
                          },
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                  _loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _submit(),
                          child: Text(
                            _authMode == AuthMode.Login
                                ? 'KIRISH'
                                : 'RO\'YXATDAN O\'TISH',
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              minimumSize: const Size(double.infinity, 50)),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      _authMode == AuthMode.Login
                          ? 'RO\'YXATDAN O\'TISH'
                          : 'KIRISH',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
