import 'package:flutter/material.dart';

class MedicalConsultationListPage extends StatelessWidget {
  const MedicalConsultationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para la tabla
    final List<Map<String, String>> consultations = [
      {'name': 'Consulta 1', 'date': '2025-04-01', 'time': '10:00 AM'},
      {'name': 'Consulta 2', 'date': '2025-04-02', 'time': '11:30 AM'},
      {'name': 'Consulta 3', 'date': '2025-04-03', 'time': '02:00 PM'},
      {'name': 'Consulta 4', 'date': '2025-04-04', 'time': '03:15 PM'},
    ];

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Mis Consultas',
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: false, // Desactiva la columna de selección
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
                        onSelectChanged: (_) => _showConsultationDetails(context, consultation),
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
              ),
            ],
          ),
        ),
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