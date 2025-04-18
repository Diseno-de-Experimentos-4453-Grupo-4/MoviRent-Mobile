import 'package:movirent/auth/domain/dto/sign_up.dto.dart';

import '../../../core/dio_helper.dart';
import '../dto/profile.dto.dart';

class ProfileService extends DioHelper<ProfileDTO, SignUpDTO> {
  ProfileService()
      : super(
    "profile",
        (json) => ProfileDTO.fromJson(json),
        (data) => data.toJson(),
  );
}
