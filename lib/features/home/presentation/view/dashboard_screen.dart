import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Appointment model
class Appointment {
  final String id;
  final String name;
  final String email;
  final DateTime date;
  final String time;
  final String description;
  String status;

  Appointment({
    required this.id,
    required this.name,
    required this.email,
    required this.date,
    required this.time,
    required this.description,
    this.status = 'Pending',
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      description: json['description'],
      status: json['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'date': date.toIso8601String(),
      'time': time,
      'description': description,
      'status': status,
    };
  }
}

class AppointmentDashboard extends StatefulWidget {
  const AppointmentDashboard({super.key});

  @override
  _AppointmentDashboardState createState() => _AppointmentDashboardState();
}

class _AppointmentDashboardState extends State<AppointmentDashboard> {
  List<Appointment> appointments = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    setState(() => isLoading = true);
    final response = await http.get(Uri.parse('http://localhost:3000/appointments'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        appointments = data.map((json) => Appointment.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load appointments');
    }
    setState(() => isLoading = false);
  }

  Future<void> createAppointment(Appointment appointment) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/appointments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment.toJson()),
    );

    if (response.statusCode == 200) {
      setState(() {
        appointments.add(Appointment.fromJson(json.decode(response.body)));
      });
    } else {
      throw Exception('Failed to create appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AppointmentFormDialog(
                onSave: createAppointment,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return ListTile(
                  title: Text(appointment.name),
                  subtitle: Text('Time: ${appointment.time} | Date: ${appointment.date.toLocal()}'),
                  trailing: Text(appointment.status),
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AppointmentDetailDialog(
                      appointment: appointment,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class AppointmentFormDialog extends StatefulWidget {
  final Function(Appointment) onSave;

  const AppointmentFormDialog({super.key, required this.onSave});

  @override
  _AppointmentFormDialogState createState() => _AppointmentFormDialogState();
}

class _AppointmentFormDialogState extends State<AppointmentFormDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();

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
          onPressed: () {
            final newAppointment = Appointment(
              id: '', // Leave this empty for new appointments
              name: _nameController.text,
              email: _emailController.text,
              date: DateTime.parse(_dateController.text),
              time: _timeController.text,
              description: _descriptionController.text,
            );
            widget.onSave(newAppointment);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class AppointmentDetailDialog extends StatelessWidget {
  final Appointment appointment;

  const AppointmentDetailDialog({super.key, required this.appointment});



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
