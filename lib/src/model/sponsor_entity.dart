import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sponsor_entity.g.dart';


@JsonSerializable()
class SponsorEntity extends BaseEntity {
  Data data;

  SponsorEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory SponsorEntity.fromJson(Map<String, dynamic> srcJson) => _$SponsorEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SponsorEntityToJson(this);

}


@JsonSerializable()
class Data {

  int endRow;

  bool hasNextPage;

  bool hasPreviousPage;

  bool isFirstPage;

  bool isLastPage;

  List<SponorItemBean> list;

  int navigateFirstPage;

  int navigateLastPage;

  int navigatePages;

  int nextPage;

  int pageNum;

  int pageSize;

  int pages;

  int prePage;

  int size;

  int startRow;

  int total;

  Data(this.endRow,this.hasNextPage,this.hasPreviousPage,this.isFirstPage,this.isLastPage,this.list,this.navigateFirstPage,this.navigateLastPage,this.navigatePages,this.nextPage,this.pageNum,this.pageSize,this.pages,this.prePage,this.size,this.startRow,this.total,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
class SponorItemBean  {

  String createdAt;

  String createdBy;

  String firstCreative;

  int id;

  String infoUrl;

  int isDelete;

  String keyCreative;

  String secondCreative;

  String shareTitle;

  String shareUrl;

  String showEndTime;

  String showStartTime;

  int sort;

  String sponsoredIconUrl;

  String sponsoredTile;

  String sponsoredUrl;

  int status;

  String updatedAt;

  String updatedBy;

  SponorItemBean(this.createdAt,this.createdBy,this.firstCreative,this.id,this.infoUrl,this.isDelete,this.keyCreative,this.secondCreative,this.shareTitle,this.shareUrl,this.showEndTime,this.showStartTime,this.sort,this.sponsoredIconUrl,this.sponsoredTile,this.sponsoredUrl,this.status,this.updatedAt,this.updatedBy,);

  factory SponorItemBean.fromJson(Map<String, dynamic> srcJson) => _$SponorItemBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SponorItemBeanToJson(this);

}


