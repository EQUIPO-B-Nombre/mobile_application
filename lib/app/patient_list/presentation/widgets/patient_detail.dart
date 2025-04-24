import 'package:flutter/material.dart';

class PatientDetailDialog extends StatelessWidget {
  final String nombre;
  final String dni;
  final String cita;
  final String telefono;

  const PatientDetailDialog({
    super.key,
    required this.nombre,
    required this.dni,
    required this.cita,
    required this.telefono,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFD1D8FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Detalles del Paciente',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            const SizedBox(height: 20),
            Text('Nombre completo: $nombre'),
            const SizedBox(height: 10),
            Text('DNI: $dni'),
            const SizedBox(height: 10),
            Text('Última Cita: $cita'),
            const SizedBox(height: 10),
            Text('Teléfono: $telefono'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D4566),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
