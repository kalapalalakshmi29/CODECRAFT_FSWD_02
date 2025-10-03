class Employee {
  final String id;
  final String name;
  final String email;
  final String position;
  final double salary;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.salary,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'position': position,
    'salary': salary,
  };

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    position: json['position'],
    salary: json['salary'].toDouble(),
  );

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePosition(String? value) {
    if (value == null || value.trim().isEmpty) return 'Position is required';
    return null;
  }

  static String? validateSalary(String? value) {
    if (value == null || value.trim().isEmpty) return 'Salary is required';
    final salary = double.tryParse(value);
    if (salary == null || salary <= 0) return 'Invalid salary amount';
    return null;
  }
}