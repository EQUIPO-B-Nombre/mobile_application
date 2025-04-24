import 'package:flutter/material.dart';
import 'package:mobile_application/app/patient_list/data/patient_model.dart';
import 'package:mobile_application/app/patient_list/data/patient_service.dart';
import 'package:mobile_application/app/patient_list/presentation/widgets/add_patient.dart';
import 'package:mobile_application/app/patient_list/presentation/widgets/delete_patient.dart';
import 'package:mobile_application/app/patient_list/presentation/widgets/patient_detail.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  List<PatientModel> _patients = [];
  PatientModel? _selectedPatient;

  Future<void> _loadData() async {
    List<PatientModel> patients = await PatientService().getPatients();
    print('patients: $patients');
    setState(() {
      _patients = patients;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
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
              child: Image.asset('assets/logo.png', fit: BoxFit.contain),
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
      backgroundColor: const Color(0xFFFFD1DB),
      body: SafeArea(
        child: SingleChildScrollView(
          // Solución para evitar el error de restricciones no definidas
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ), // Reduce el ancho de la tabla
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Lista de pacientes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF3D4566),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _HeaderText('DNI'),
                            _HeaderText('Nombre\ncompleto'),
                            _HeaderText('Ult.\nCita'),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: _patients.length,
                          itemBuilder: (context, index) {
                            final patient = _patients[index];
                            final isSelected = _selectedPatient == patient;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedPatient = patient;
                                });
                              },
                              child: Container(
                                color:
                                    isSelected
                                        ? Colors.blueAccent
                                        : (index % 2 == 0
                                            ? const Color(0xFFD1D8FF)
                                            : const Color(0xFFE8EBFF)),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(patient.dni),
                                    Text(patient.name ?? 'N/A'),
                                    Text(patient.appointmentDate ?? 'N/A'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _Boton(
                  texto: 'Agregar Paciente',
                  icono: Icons.add,
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => AddPatientDialog(),
                    );

                    if (result == true) {
                      _loadData();
                    }
                  },
                ),
                _Boton(
                  texto: 'Ver detalles',
                  icono: Icons.remove_red_eye,
                  onPressed: () {
                    if (_selectedPatient != null) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => PatientDetailDialog(
                              nombre: _selectedPatient!.name ?? 'N/A',
                              dni: _selectedPatient!.dni,
                              cita: _selectedPatient!.appointmentDate ?? 'N/A',
                              telefono: _selectedPatient!.telephone ?? 'N/A',
                            ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, seleccione un paciente'),
                        ),
                      );
                    }
                  },
                ),
                _Boton(
                  texto: 'Eliminar Paciente',
                  icono: Icons.delete,
                  onPressed: () {
                    if (_selectedPatient != null) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => DeletePatientDialog(
                              nombre: _selectedPatient!.name ?? 'N/A',
                              dni: _selectedPatient!.dni,
                              onConfirm: () async {
                                final success = await PatientService()
                                    .deletePatient(_selectedPatient!.id!);

                                if (success) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Paciente eliminado exitosamente',
                                        ),
                                      ),
                                    );
                                  }

                                  await _loadData();

                                  setState(() {
                                    _selectedPatient = null;
                                  });
                                  Navigator.pop(context);
                                } else {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Error al eliminar paciente',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, seleccione un paciente'),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }
}

class _Boton extends StatelessWidget {
  final String texto;
  final IconData icono;
  final VoidCallback onPressed;

  const _Boton({
    required this.texto,
    required this.icono,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: ElevatedButton.icon(
        icon: Icon(icono, size: 16),
        label: Text(texto),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3D4566),
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
