class EmployeeModel {
    EmployeeModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.role,
        required this.status,
        required this.verified,
    });

    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final String role;
    final String status;
    final bool verified;

    factory EmployeeModel.fromJson(Map<String, dynamic> json){ 
        return EmployeeModel(
            id: json["id"] ?? "",
            firstName: json["firstName"] ?? "",
            lastName: json["lastName"] ?? "",
            email: json["email"] ?? "",
            role: json["role"] ?? "",
            status: json["status"] ?? "",
            verified: json["verified"] ?? false,
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "role": role,
        "status": status,
        "verified": verified,
    };

}