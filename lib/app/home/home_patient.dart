import 'package:flutter/material.dart';
import 'package:mobile_application/app/profile/data/patient_service.dart';

class HomePatientPage extends StatelessWidget {
  const HomePatientPage({super.key});

  Future<String> _getPatientName() async {
    final patientService = PatientService();
    final patient = await patientService.getPatientById('1'); // Reemplaza '1' con el ID real del paciente
    return patient?.name ?? 'Paciente';
  }

  @override
  Widget build(BuildContext context) {
    final consultas = List.generate(
      4,
      (_) => {
        'titulo': 'Consulta',
        'fecha': '02/04/2024',
        'hora': '11:30 am',
      },
    );

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
              Navigator.of(context).pushNamed('/menu');
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
                future: _getPatientName(),
                builder: (context, snapshot) {
                  final patientName = snapshot.data ?? 'Paciente';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        'Te damos la bienvenida,\n$patientName.',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildConsultsSection(consultas),
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

  Widget _buildConsultsSection(List<Map<String, String>> consultas) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFE3EC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFFFBBCD),
            width: 6,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'MIS CONSULTAS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ...consultas.map((c) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFABC0),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            c['titulo']!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            c['fecha']!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            c['hora']!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}