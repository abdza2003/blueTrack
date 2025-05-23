enum OrderStatusEnum {
  pending(
    id: 0,
    key: 'pending',
    color: '0xFF0000',
  ),
  inDelivery(
    id: 1,
    key: 'in_delivery',
    color: '0x00FF00',
  ),
  completed(
    id: 2,
    key: 'completed',
    color: '0x0000FF',
  ),
  canceled(
    id: 3,
    key: 'canceled',
    color: '0xFFA500',
  );

  const OrderStatusEnum({
    required this.id,
    required this.key,
    required this.color,
  });

  final int id;
  final String key;
  final String color;

  factory OrderStatusEnum.fromWord(String word) {
    return OrderStatusEnum.values.firstWhere(
      (status) => status.key == word,
    );
  }

  @override
  String toString() => key;
}
