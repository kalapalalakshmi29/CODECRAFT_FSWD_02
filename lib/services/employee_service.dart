import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/employee.dart';

class EmployeeService {
  static const String _employeesKey = 'employees';
  static const _uuid = Uuid();

  static Future<List<Employee>> getEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final employeesJson = prefs.getString(_employeesKey) ?? '[]';
    final List<dynamic> employeesList = json.decode(employeesJson);
    return employeesList.map((e) => Employee.fromJson(e)).toList();
  }

  static Future<void> _saveEmployees(List<Employee> employees) async {
    final prefs = await SharedPreferences.getInstance();
    final employeesJson = json.encode(employees.map((e) => e.toJson()).toList());
    await prefs.setString(_employeesKey, employeesJson);
  }

  static Future<Employee> createEmployee(String name, String email, String position, double salary) async {
    final employee = Employee(
      id: _uuid.v4(),
      name: name,
      email: email,
      position: position,
      salary: salary,
    );
    
    final employees = await getEmployees();
    employees.add(employee);
    await _saveEmployees(employees);
    return employee;
  }

  static Future<Employee?> updateEmployee(String id, String name, String email, String position, double salary) async {
    final employees = await getEmployees();
    final index = employees.indexWhere((e) => e.id == id);
    
    if (index == -1) return null;
    
    final updatedEmployee = Employee(
      id: id,
      name: name,
      email: email,
      position: position,
      salary: salary,
    );
    
    employees[index] = updatedEmployee;
    await _saveEmployees(employees);
    return updatedEmployee;
  }

  static Future<bool> deleteEmployee(String id) async {
    final employees = await getEmployees();
    final initialLength = employees.length;
    employees.removeWhere((e) => e.id == id);
    
    if (employees.length < initialLength) {
      await _saveEmployees(employees);
      return true;
    }
    return false;
  }
}