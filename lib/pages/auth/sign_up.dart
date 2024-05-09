import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app1/pages/ressources/router/router.dart';
import 'package:my_app1/services/AuthServices.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignuptState createState() => _SignuptState();
}

class _SignuptState extends State<SignUp> {
  String role = 'Client';
  String? profession;
  String? adresse;
  bool loading = false;
  TextEditingController description = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController facebook = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 33, fontFamily: "myfont"),
                ),
                SizedBox(
                  height: 15,
                ),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  width: 200,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: fullName,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.purple[800],
                    ),
                    hintText: "Nom d'utilisateur :",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Username is required and must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ce champ est obligatoire';
                    } else if (!value.contains('@') ||
                        !value.contains('.') ||
                        value.indexOf('@') > value.lastIndexOf('.') ||
                        value.indexOf('@') < 1 ||
                        value.length - value.lastIndexOf('.') < 3) {
                      return 'Veuillez saisir un e-mail valide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail,
                      color: Colors.purple[800],
                    ),
                    hintText: "Mail :",
                  ),
                  controller: email,
                ),
                SizedBox(height: 12),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.purple[900],
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.purple[800],
                      size: 19,
                    ),
                    hintText: "Mot de passe :",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  controller: password,
                ),
                SizedBox(height: 12),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 225, 190, 231).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: EdgeInsets.all(10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.work,
                        color: Colors.purple[800],
                      ),
                      hintText: 'Role',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        color: const Color.fromARGB(255, 109, 101, 115),
                      ),
                      border: InputBorder.none, // Supprime la bordure
                    ),
                    value: role,
                    items: <String>[
                      'Client',
                      'Travailleur',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        role = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez sélectionner votre profession';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 12),
                if (role == 'Travailleur') ...[
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 225, 190, 231).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    margin: EdgeInsets.all(10),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.location_city,
                          color: Colors.purple[800],
                        ),
                        hintText: 'Votre Ville',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          color: const Color.fromARGB(255, 109, 101, 115),
                        ),
                        border: InputBorder.none,
                      ),
                      value: adresse,
                      items: <String>[
                        'Tunis',
                        'Gabes',
                        'Mahdia',
                        'Kébili',
                        'Mounastir',
                        'Sousse',
                        'Ariana',
                        'Béja',
                        'Ben Arous',
                        'Bizerte',
                        'Jendouba',
                        'Médenine',
                        'Manouba',
                        'Nabeul',
                        'Gafsa',
                        'Sfax',
                        'Sidi Bouzid',
                        'Siliana',
                        'Tatouine',
                        'Tozeur',
                        'Zaghouan',
                        'El Kef',
                        'Kasserine',
                        'Kairouan',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          adresse = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez sélectionner votre ville';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 225, 190, 231).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    margin: EdgeInsets.all(10),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.work,
                          color: Colors.purple[800],
                        ),
                        hintText: 'Profession',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          color: const Color.fromARGB(255, 109, 101, 115),
                        ),
                        border: InputBorder.none, // Supprime la bordure
                      ),
                      value: profession,
                      items: <String>[
                        'Plomberie',
                        'Électricien',
                        'Ouvrier de batiment',
                        'Peintre',
                        'Femme de ménage ',
                        'Baby-sitter',
                        'Menuiserie',
                        'Technicien en climatisation',
                        'Forgeron',
                        'Jardinier',
                        'Autres',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          profession = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez sélectionner votre profession';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.description,
                        color: Colors.purple[800],
                      ),
                      hintText: "Description :",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 50) {
                        return 'Description is required and must be at least 50 characters';
                      }
                      return null;
                    },
                    controller: description,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: facebook,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.facebook,
                        color: Colors.purple[800],
                      ),
                      hintText: "Facebook :",
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: gsmController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.purple[800],
                      ),
                      hintText: "GSM :",
                    ),
                  ),
                  SizedBox(height: 12),
                ],
                loading
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.purple),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });

                            bool check = await AuthServices().signUp(
                                emailController: email.text,
                                occupation: profession,
                                role: role,
                                adresse: adresse,
                                desc: description.text,
                                GsmController: gsmController.text,
                                fullName: fullName.text,
                                passwordController: password.text,
                                facebook: facebook.text);

                            if (check) {
                              setState(() {
                                loading = false;
                              });
                              AuthServices().getUserData().then((value) {
                                AuthServices().saveUserLocally(value);

                                if (value.role == 'Client') {
                                  Navigator.pushNamed(context, AppRouting.HomeClient);
                                } else if (value.role == 'Travailleur') {
                                  Navigator.pushNamed(context, AppRouting.HomeWorker);
                                } else {}
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "un erreur s'est produite",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purple),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 79, vertical: 10),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                          ),
                        ),
                        child: Text(
                          "Créer",
                          style: TextStyle(fontSize: 17, color: Color.fromARGB(237, 221, 242, 251)),
                        ),
                      ),
                SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("j'ai un compte ? "),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "se connecter",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
