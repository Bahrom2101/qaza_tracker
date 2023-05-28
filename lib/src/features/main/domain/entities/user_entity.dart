import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/features/main/data/models/history_model.dart';
import 'package:qaza_tracker/src/features/main/data/models/user_model.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/history_entity.dart';

class UserEntity extends Equatable {
  final String email;
  final int fajr;
  final int zuhr;
  final int asr;
  final int maghrib;
  final int isha;
  final int witr;
  @HistoryConverter()
  final Map<String, HistoryEntity>? changes;

  @override
  String toString() {
    return 'UserEntity{email: $email, fajr: $fajr, zuhr: $zuhr, asr: $asr, maghrib: $maghrib, isha: $isha, witr: $witr}';
  }

  const UserEntity({
    this.email = '',
    this.fajr = 0,
    this.zuhr = 0,
    this.asr = 0,
    this.maghrib = 0,
    this.isha = 0,
    this.witr = 0,
    this.changes,
  });

  UserModel copWith({
    required int index,
    required int value,
    required String salah,
    required int amount,
  }) {
    final Map<String, HistoryEntity> map = {};
    map.addAll(changes ?? {});
    map[salah] = HistoryModel(
      changeAmount: amount,
      changeTime: DateFormat(appDateFormat).format(DateTime.now()),
    );
    return UserModel(
      email: email,
      fajr: index == 0 ? value : fajr,
      zuhr: index == 1 ? value : zuhr,
      asr: index == 2 ? value : asr,
      maghrib: index == 3 ? value : maghrib,
      isha: index == 4 ? value : isha,
      witr: index == 5 ? value : witr,
      changes: map,
    );
  }

  @override
  List<Object?> get props => [
        email,
        fajr,
        zuhr,
        asr,
        maghrib,
        isha,
        witr,
        changes,
      ];
}
