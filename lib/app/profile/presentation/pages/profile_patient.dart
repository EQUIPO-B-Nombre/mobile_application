import 'package:flutter/material.dart';
import 'package:mobile_application/app/profile/data/patient_service.dart';
import 'package:mobile_application/app/profile/data/patient_model.dart';

class ProfilePatientPage extends StatefulWidget {
  const ProfilePatientPage({super.key});

  @override
  _ProfilePatientPageState createState() => _ProfilePatientPageState();
}

class _ProfilePatientPageState extends State<ProfilePatientPage> {
  final PatientService _patientService = PatientService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  bool _isLoading = true;
  String? _patientId;
  String? _appointmentDate; // Mantener la fecha de cita

  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  Future<void> _loadPatientData() async {
    final patient = await _patientService.getPatientById('1'); // Reemplaza '1' con el ID real del paciente
    if (patient != null) {
      setState(() {
        _patientId = patient.id;
        _nameController.text = patient.name ?? '';
        _dniController.text = patient.dni;
        _telephoneController.text = patient.telephone ?? '';
        _appointmentDate = patient.appointmentDate; // Guardar la fecha de cita
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_patientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No se pudo identificar al paciente')),
      );
      return;
    }

    final updatedPatient = PatientModel(
      id: _patientId,
      name: _nameController.text,
      dni: _dniController.text,
      telephone: _telephoneController.text,
      appointmentDate: _appointmentDate, // Mantener la fecha de cita original
    );

    final success = await _patientService.updatePatient(updatedPatient);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cambios guardados exitosamente')),
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
              Navigator.of(context).pushNamed('/menu');
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
                    _buildEditableField(label: 'DNI', controller: _dniController),
                    _buildEditableField(label: 'Teléfono', controller: _telephoneController),
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