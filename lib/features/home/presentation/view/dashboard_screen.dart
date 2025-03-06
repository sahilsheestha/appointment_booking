import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Appointment model
class Appointment {
  final String name;
  final String email;
  final DateTime date;
  final String time;
  final String description;

  Appointment({this.name, this.email, this.date, this.time, this.description});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      name: json['name'],
      email: json['email'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      description: json['description'],
    );
  }
}

class AppointmentDashboard extends StatefulWidget {
  const AppointmentDashboard({super.key});

  @override
  _AppointmentDashboardState createState() => _AppointmentDashboardState();
}

class _AppointmentDashboardState extends State<AppointmentDashboard> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/appointments'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        appointments = data.map((json) => Appointment.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Dashboard'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return ListTile(
            title: Text(appointment.name),
            subtitle: Text(
                'Time: ${appointment.time}\nDate: ${appointment.date.toLocal()}'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(appointment.name),
                    content: Text(appointment.description),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
