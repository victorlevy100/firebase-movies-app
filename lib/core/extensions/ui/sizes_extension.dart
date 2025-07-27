import 'package:firebase_movies_app/core/enums/sizes_enum.dart';

extension SizesExtension on SizesEnum {
  double get getSize{
    switch (this) {
      case SizesEnum.xxxl:
        return 64.0;
      case SizesEnum.xxl:
        return 48.0;
      case SizesEnum.xl:
        return 32.0;
      case SizesEnum.lg:
        return 24.0;
      case SizesEnum.md:
        return 16.0;
      case SizesEnum.sm:
        return 12.0;
      case SizesEnum.xs:
        return 8.0;
      case SizesEnum.xxs:
        return 6.0;
      case SizesEnum.xxxs:
        return 4.0;
    }
  }
}