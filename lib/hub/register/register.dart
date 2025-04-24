import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers para cada campo
  final _nameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _dniCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  // Valor seleccionado en los radios
  String _role = 'Paciente';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _passwordCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _dniCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Color(0XFFFF94B0),
      ),
      body: Stack(
        children: [
          //  |: BackGround
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/rose_bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.deepOrange.withAlpha(64),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          //  |: Items
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100.withAlpha(225),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //  |: Title
                      Text(
                        'Crear Cuenta',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: 24),

                      //  |: Name
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: _inputDecoration(label: 'Nombre'),
                      ),

                      SizedBox(height: 16),

                      //  |: Password
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _passwordCtrl,
                              obscureText: true,
                              decoration:
                              _inputDecoration(label: 'Contraseña'),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      //  |: Email
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailCtrl,
                              decoration: _inputDecoration(label: 'Email'),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 16),

                      //  |: Phone
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phoneCtrl,
                              decoration: _inputDecoration(label: 'Teléfono'),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      //  |: Dni
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _dniCtrl,
                              decoration: _inputDecoration(label: 'DNI'),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _ageCtrl,
                              decoration: _inputDecoration(label: 'Edad'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      //  |: Radio
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildRadio('Paciente'),
                          SizedBox(width: 16),
                          _buildRadio('Médico'),
                        ],
                      ),

                      SizedBox(height: 32),

                      //  |: Register Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFFFF94B0),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Registar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: decoración común para los TextFormField
  InputDecoration _inputDecoration({required String label}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  // Helper: radio + texto
  Widget _buildRadio(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _role,
          onChanged: (v) => setState(() => _role = v!),
          activeColor: Colors.pinkAccent,
        ),
        Text(
          value,
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ],
    );
  }
}