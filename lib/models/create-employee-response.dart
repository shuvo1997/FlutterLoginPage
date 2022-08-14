class CreateEmployeeResponse {
  final String name;
  final String job;
  final String id;
  final String createdAt;

  const CreateEmployeeResponse(
      {required this.name,
      required this.job,
      required this.id,
      required this.createdAt});
  factory CreateEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return CreateEmployeeResponse(
        name: json['name'],
        job: json['job'],
        id: json['id'],
        createdAt: json['createdAt']);
  }
}
