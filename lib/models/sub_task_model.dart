import 'package:hive/hive.dart';
part 'sub_task_model.g.dart';

@HiveType(typeId: 0)
class SubTaskModel {
  // final int id;
  @HiveField(0)
  final String subTaskName;
  @HiveField(1)
  final int exp;
  @HiveField(2)
  final bool completed;

  SubTaskModel({
    // required this.id,
    required this.subTaskName,
    required this.exp,
    required this.completed,
  });
}
