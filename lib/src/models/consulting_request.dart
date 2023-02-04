class ConsultingRequest {
  final String name;
  final String address;
  final String phone;

  const ConsultingRequest({
    required this.name,
    required this.address,
    required this.phone,
  });

  toJson() => {
        'name': name,
        'address': address,
        'phone': phone,
      };
}
