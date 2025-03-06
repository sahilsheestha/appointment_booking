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
import 'package:flutter/material.dart';

class AppointmentFormDialog extends StatefulWidget {
  @override
  _AppointmentFormDialogState createState() => _AppointmentFormDialogState();
}

class _AppointmentFormDialogState extends State<AppointmentFormDialog> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();

  // Function to show a Snackbar
  void showSnackbar(String message, {Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Simulate saving the appointment
  Future<void> saveAppointment() async {
    final name = nameController.text;
    final email = emailController.text;
    final date = dateController.text;
    final time = timeController.text;
    final description = descriptionController.text;

    if (name.isEmpty || email.isEmpty || date.isEmpty || time.isEmpty || description.isEmpty) {
      showSnackbar('Please fill all fields', backgroundColor: Colors.red);
      return;
    }

    // Simulating saving the appointment (this can be replaced with actual logic)
    await Future.delayed(Duration(seconds: 2));

    // Show success message
    showSnackbar('Appointment saved successfully!');
    
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
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: dateController, decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)')),
            TextField(controller: timeController, decoration: InputDecoration(labelText: 'Time (HH:MM)')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: saveAppointment,
          child: Text('Save'),
        ),
      ],
    );
  }
}
