import 'package:appointment_system/models/appointment.dart';
import 'package:hive/hive.dart';

class AppointmentRepository {
  static final _box =
      Hive.box('appointments'); // Open a box named "appointments"

  static Future<void> addAppointment(Appointment appointment) async {
    await _box.put(appointment.id, appointment);
  }

  static Future<void> updateAppointment(Appointment appointment) async {
    await _box.put(appointment.id, appointment);
  }

  static Future<void> deleteAppointment(String appointmentId) async {
    await _box.delete(appointmentId);
  }

  static List<Appointment> fetchAppointments() {
    final appointments = _box.values.toList().cast<Appointment>();
    return appointments;
  }

  static Future<void> initialize() async {
    if (!Hive.isBoxOpen('appointments')) {
      await Hive.openBox('appointments');
    }
  }
}
