import 'package:movirent/auth/domain/dto/sign_up.dto.dart';

import '../../../core/constants.dart';
import '../../../core/dio_helper.dart';
import '../dto/profile.dto.dart';

class ProfileService extends DioHelper<ProfileDTO, SignUpDTO> {
  ProfileService()
      : super(
    "profile",
        (json) => ProfileDTO.fromJson(json),
        (data) => data.toJson(),
  );

  Future<ProfileDTO> getProfileByEmail(String email) async {
    final response = await dio.get("${Constant.dev.environment}$resourcePath/$email");
    final profileJson = response.data;
    print(profileJson);
    return ProfileDTO.fromJson(profileJson);
  }

}
