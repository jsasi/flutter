import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discount_entity.g.dart';


@JsonSerializable()
class DiscountEntity extends BaseEntity {
  Data data;

  DiscountEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory DiscountEntity.fromJson(Map<String, dynamic> srcJson) => _$DiscountEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DiscountEntityToJson(this);

}


@JsonSerializable()
class Data  {

  int endRow;

  bool hasNextPage;

  bool hasPreviousPage;

  bool isFirstPage;

  bool isLastPage;

  List<DiscountItemBean> list;

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
class DiscountItemBean {

  String activityEndTime;

  String activityListPicture;

  String activityMoney;

  String activityStartTime;

  String activityTag;

  String activityVenues;

  String appDetail;

  String appListPicture;

  String appTagPicture;

  String appTopicLink;

  int contentForm;

  int countCycle;

  String createdAt;

  String createdBy;

  int cycle;

  String displayEndTime;

  String displayForm;

  String displayStartTime;

  String donationMaxMoney;

  String donationRatio;

  double effectiveOdds;

  String flowRequirements;

  String h5MainPicture;

  double hkOdds;

  int id;

  int ifOdds;

  int isDelete;

  int isPermanent;

  String levelRequirement;

  int participation;

  int redemptionPeriod;

  String sharePicture;

  int sort;

  int specialDiscount;

  int status;

  int supportClient;

  String title;

  int type;

  String updatedAt;

  String updatedBy;

  String webBackgroundPicture;

  String webDetail;

  String webListPicture;

  String webMainPicture;

  String webTopicLink;

  DiscountItemBean(this.activityEndTime,this.activityListPicture,this.activityMoney,this.activityStartTime,this.activityTag,this.activityVenues,this.appDetail,this.appListPicture,this.appTagPicture,this.appTopicLink,this.contentForm,this.countCycle,this.createdAt,this.createdBy,this.cycle,this.displayEndTime,this.displayForm,this.displayStartTime,this.donationMaxMoney,this.donationRatio,this.effectiveOdds,this.flowRequirements,this.h5MainPicture,this.hkOdds,this.id,this.ifOdds,this.isDelete,this.isPermanent,this.levelRequirement,this.participation,this.redemptionPeriod,this.sharePicture,this.sort,this.specialDiscount,this.status,this.supportClient,this.title,this.type,this.updatedAt,this.updatedBy,this.webBackgroundPicture,this.webDetail,this.webListPicture,this.webMainPicture,this.webTopicLink,);

  factory DiscountItemBean.fromJson(Map<String, dynamic> srcJson) => _$DiscountItemBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DiscountItemBeanToJson(this);

}

  
