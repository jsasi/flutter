import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_entity.g.dart';


@JsonSerializable()
class FeedbackEntity extends BaseEntity {
  Data data;
  FeedbackEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory FeedbackEntity.fromJson(Map<String, dynamic> srcJson) => _$FeedbackEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackEntityToJson(this);

}


@JsonSerializable()
class Data  {

  int endRow;

  bool hasNextPage;

  bool hasPreviousPage;

  bool isFirstPage;

  bool isLastPage;

  List<FeedbackItemBean> list;

  int navigateFirstPage;

  int navigateLastPage;

  int navigatePages;

  List<int> navigatepageNums;

  int nextPage;

  int pageNum;

  int pageSize;

  int pages;

  int prePage;

  int size;

  int startRow;

  int total;

  Data(this.endRow,this.hasNextPage,this.hasPreviousPage,this.isFirstPage,this.isLastPage,this.list,this.navigateFirstPage,this.navigateLastPage,this.navigatePages,this.navigatepageNums,this.nextPage,this.pageNum,this.pageSize,this.pages,this.prePage,this.size,this.startRow,this.total,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
class FeedbackItemBean  {

  int category;

  String content;

  String createdAt;

  String description;

  String feedbackContent;

  int id;

  int memberId;

  String memberName;

  int pageNum;

  int pageSize;

  String picUrls;

  String siteName;

  int status;

  int updatedAt;

  FeedbackItemBean(this.category,this.content,this.createdAt,this.description,this.feedbackContent,this.id,this.memberId,this.memberName,this.pageNum,this.pageSize,this.picUrls,this.siteName,this.status,this.updatedAt,);

  factory FeedbackItemBean.fromJson(Map<String, dynamic> srcJson) => _$FeedbackItemBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackItemBeanToJson(this);

}


