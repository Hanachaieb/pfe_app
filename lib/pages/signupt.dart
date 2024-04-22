import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signupt extends StatefulWidget {
  const Signupt({Key? key}) : super(key: key);

  @override
  _SignuptState createState() => _SignuptState();
}

class _SignuptState extends State<Signupt> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _email;
  String? _password;
  String? _description;
  String? _city;
  String? _profession;

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
                  onSaved: (value) => _username = value,
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail,
                      color: Colors.purple[800],
                    ),
                    hintText: "Mail :",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.') ||
                        value.indexOf('@') > value.lastIndexOf('.') ||
                        value.indexOf('@') < 1 ||
                        value.length - value.lastIndexOf('.') < 3) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value,
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
                  onSaved: (value) => _password = value,
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
                  onSaved: (value) => _description = value,
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.facebook,
                      color: Colors.purple[800],
                    ),
                    hintText: "Facebook :",
                  ),
                  onSaved: (value) => _description = value,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 225, 190, 231).withOpacity(0.8),
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
                        value: _city,
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
                            _city = newValue;
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
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 225, 190, 231).withOpacity(0.8),
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
                        value: _city,
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
                            _city = newValue;
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
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Validation successful, proceed with form submission
                      // Add your form submission logic here
                      Navigator.pushNamed(context, "/comptet");
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
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(237, 221, 242, 251)),
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
                      onTap: () {
                        Navigator.pushNamed(context, "/logint");
                      },
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
                SizedBox(
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.purple[900],
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.purple[900],
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.purple[900],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.purple, width: 1),
                          ),
                          child: SvgPicture.asset(
                            "assets/AAAA/facebook.svg",
                            color: Colors.purple[400],
                            height: 21,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.purple, width: 1),
                          ),
                          child: SvgPicture.asset(
                            "assets/AAAA/google-plus.svg",
                            color: Colors.purple[400],
                            height: 21,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.purple, width: 1),
                          ),
                          child: SvgPicture.asset(
                            "assets/AAAA/twitter.svg",
                            color: Colors.purple[400],
                            height: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
