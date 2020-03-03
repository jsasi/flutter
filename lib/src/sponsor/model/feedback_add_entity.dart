import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_add_entity.g.dart';

/// 新增意见反馈Entity
@JsonSerializable()
class FeedbackAddEntity extends BaseEntity {

  String data;

  FeedbackAddEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory FeedbackAddEntity.fromJson(Map<String, dynamic> srcJson) => _$FeedbackAddEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackAddEntityToJson(this);

}


