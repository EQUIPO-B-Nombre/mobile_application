import 'package:flutter/material.dart';
import 'package:mobile_application/app/profile/data/doctor_service.dart';

class ProfileDoctorPage extends StatefulWidget {
  const ProfileDoctorPage({super.key});

  @override
  _ProfileDoctorPageState createState() => _ProfileDoctorPageState();
}

class _ProfileDoctorPageState extends State<ProfileDoctorPage> {
  final DoctorService _doctorService = DoctorService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDoctorData();
  }

  Future<void> _loadDoctorData() async {
    final doctor = await _doctorService.getDoctor('1'); // Reemplaza '1' con el ID real del doctor
    if (doctor != null) {
      setState(() {
        _emailController.text = doctor.email;
        _passwordController.text = doctor.password;
        _nameController.text = doctor.name;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveChanges() async {
    final success = await _doctorService.updateDoctor(
      '1', // Reemplaza '1' con el ID real del doctor
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cambios guardados')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar los cambios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFBBCD),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, size: 32),
            onPressed: () {
              Navigator.of(context).pushNamed('/menu_doctor');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEditableField(label: 'Nombre', controller: _nameController),
                    _buildEditableField(label: 'Email', controller: _emailController),
                    _buildEditableField(label: 'Password', controller: _passwordController),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFBBCD),
                      ),
                      child: const Text('Guardar Cambios'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}