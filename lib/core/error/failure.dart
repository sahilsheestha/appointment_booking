import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}
import 'package:flutter/material.dart';

class AppointmentFormDialog extends StatefulWidget {
  const AppointmentFormDialog({super.key});

  @override
  _AppointmentFormDialogState createState() => _AppointmentFormDialogState();
}

class _AppointmentFormDialogState extends State<AppointmentFormDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Function to show a Snackbar
  void _showSnackbar(String message, {Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Simulate saving the appointment
  Future<void> _saveAppointment() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final date = _dateController.text;
    final time = _timeController.text;
    final description = _descriptionController.text;

    if (name.isEmpty || email.isEmpty || date.isEmpty || time.isEmpty || description.isEmpty) {
      _showSnackbar('Please fill all fields', backgroundColor: Colors.red);
      return;
    }

    // Simulating saving the appointment (this can be replaced with actual logic)
    await Future.delayed(Duration(seconds: 2));

    // Show success message
    _showSnackbar('Appointment saved successfully!');
    
    // You can also perform other actions after saving (like closing the form, etc.)
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Appointment'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _dateController, decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)')),
            TextField(controller: _timeController, decoration: InputDecoration(labelText: 'Time (HH:MM)')),
            TextField(controller: _descriptionController, decoration: InputDecoration(labelText: 'Description')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saveAppointment,
          child: Text('Save'),
        ),
      ],
    );
  }
}
