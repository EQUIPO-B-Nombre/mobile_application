import 'package:flutter/material.dart';

class MenuDoctorPage extends StatelessWidget {
  const MenuDoctorPage({super.key});

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.black87),
              const SizedBox(width: 16),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFBBCD),
      body: SafeArea(
        child: Column(
          children: [
            //  |: Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu, size: 32, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            //  |: Options
            _buildMenuItem(
              icon: Icons.home,
              text: 'Página principal',
              onTap: () {
                Navigator.of(context).pushNamed('/home_doctor');
              },
            ),
            _buildMenuItem(
              icon: Icons.people,
              text: 'Lista de pacientes',
              onTap: () {
                Navigator.of(context).pushNamed('/pacientes');
              },
            ),
            _buildMenuItem(
              icon: Icons.person,
              text: 'Perfil',
              onTap: () {
                Navigator.of(context).pushNamed('/profile_doctor');
              },
            ),
            _buildMenuItem(
              icon: Icons.exit_to_app,
              text: 'Cerrar sesión',
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}