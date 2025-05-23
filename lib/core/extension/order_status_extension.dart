import 'package:bluetrack/core/enum/app_education_type_enum.dart';
import 'package:bluetrack/core/enum/constant_categories_enum.dart';
import 'package:bluetrack/core/enum/device_theme_mode_enum.dart';
import 'package:bluetrack/core/enum/order_status_enum.dart';

extension OrderStatusExtension on OrderStatusEnum {
  String get rawValue {
    switch (this) {
      case OrderStatusEnum.pending:
        return 'pending';
      case OrderStatusEnum.inDelivery:
        return 'in_delivery';
      case OrderStatusEnum.completed:
        return 'completed';
      case OrderStatusEnum.canceled:
        return 'canceled';

      default:
        throw -1;
    }
  }
}
