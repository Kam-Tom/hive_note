import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class JarSize extends Equatable {
  final String name;
  final double size;
  final String unit;

  const JarSize(this.name, this.size, this.unit);
  
  static List<JarSize> get jarSizes => [
    JarSize('undefined_jar'.tr(), -1, 'l'),
    JarSize('jar_small_name'.tr(), 0.7, 'l'),
    JarSize('jar_standard_name'.tr(), 1.0, 'l'),
    JarSize('jar_large_name'.tr(), 1.5, 'l'),
    JarSize('jar_xl_name'.tr(), 2.0, 'l'),
  ];
  
  @override
  List<Object?> get props => [name, size, unit];

}

