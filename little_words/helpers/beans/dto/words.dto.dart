import 'package:json_annotation/json_annotation.dart';
import 'package:littlewords/beans/dto/word.dto.dart';

part 'words.dto.g.dart';

@JsonSerializable()
class WordsDTO {
  WordsDTO(this.data);

  final List<WordDTO>? data;

  Map<String, dynamic> toJson() => _$WordsDTOToJson(this);

  factory WordsDTO.fromJson(Map<String, dynamic> json) =>
      _$WordsDTOFromJson(json);
}
