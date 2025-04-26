import 'package:flutter/material.dart';
import 'package:mobile_application/app/profile/data/doctor_service.dart';

class HomeDoctorPage extends StatelessWidget {
  const HomeDoctorPage({super.key});

  Future<String> _getDoctorName() async {
    final doctorService = DoctorService();
    final doctor = await doctorService.getDoctor('1'); // Reemplaza '1' con el ID real del doctor
    return doctor?.name ?? 'Doctor';
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
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFFE3EC), // Fondo completamente rosa
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: FutureBuilder<String>(
                future: _getDoctorName(),
                builder: (context, snapshot) {
                  final doctorName = snapshot.data ?? 'Doctor';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        'Bienvenido, $doctorName.\n¡Bienvenido a tu Portal de Oncontigo!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _DoctorOptionCard(
                        imagePath: 'assets/list_patients.png',
                        label: 'LISTA PACIENTES',
                        onTap: () {
                          Navigator.of(context).pushNamed('/home');
                        },
                      ),
                      const SizedBox(height: 32),
                      _DoctorOptionCard(
                        imagePath: 'assets/calendar.png',
                        label: 'CALENDARIO',
                        icon: Icons.calendar_today,
                        onTap: () {
                          Navigator.of(context).pushNamed('/calendario');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorOptionCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const _DoctorOptionCard({
    required this.imagePath,
    required this.label,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 170),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9BBEF9),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(icon, color: Colors.black54),
                      ]
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}