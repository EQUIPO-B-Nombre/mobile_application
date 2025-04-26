import 'package:flutter/material.dart';
import 'package:mobile_application/app/profile/data/patient_service.dart';
import 'package:intl/intl.dart';

class MedicalConsultationListPage extends StatelessWidget {
  const MedicalConsultationListPage({super.key});

  Future<List<Map<String, String>>> _getUpcomingConsultations(String patientId) async {
    final patientService = PatientService();
    final patient = await patientService.getPatientById(patientId);

    if (patient == null || patient.appointmentDate == null) {
      return [];
    }

    try {
      // Analizar la fecha con el formato específico
      final parsedDate = DateFormat("MMM d, yyyy h:mm a").parse(patient.appointmentDate!);
      print('Parsed Date: $parsedDate'); // Mostrar la fecha analizada en la consola



      return [
        {
          'name': 'Consulta',
          'date': DateFormat('yyyy-MM-dd').format(parsedDate),
          'time': DateFormat('hh:mm a').format(parsedDate),
        }
      ];
    } catch (e) {
      print('Error al analizar la fecha: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    const patientId = '1'; // Reemplaza '1' con el ID real del paciente

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
      body: FutureBuilder<List<Map<String, String>>>(
        future: _getUpcomingConsultations(patientId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las consultas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay próximas consultas disponibles'));
          }

          final consultations = snapshot.data!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Próximas Consultas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE3EC),
                      border: Border.all(color: const Color(0xFFFFBBCD), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DataTable(
                      showCheckboxColumn: false,
                      headingRowColor: MaterialStateProperty.all(const Color(0xFFFFC1D6)),
                      columns: const [
                        DataColumn(
                          label: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Nombre',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Fecha',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Hora',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: consultations.map((consultation) {
                        return DataRow(
                          onSelectChanged: (_) {
                            _showConsultationDetails(context, consultation);
                          },
                          cells: [
                            DataCell(Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(consultation['name']!),
                            )),
                            DataCell(Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(consultation['date']!),
                            )),
                            DataCell(Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(consultation['time']!),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showConsultationDetails(BuildContext context, Map<String, String> consultation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFF5F9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFFFBBCD), width: 2),
        ),
        title: const Text(
          'Detalles de la Consulta',
          style: TextStyle(
            color: Color(0xFFE91E63),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Nombre:', consultation['name']!),
            const SizedBox(height: 12),
            _buildDetailRow('Fecha:', consultation['date']!),
            const SizedBox(height: 12),
            _buildDetailRow('Hora:', consultation['time']!),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFE91E63),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}