// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'db_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DBUser _$DBUserFromJson(Map<String, dynamic> json) {
  return _DBUser.fromJson(json);
}

/// @nodoc
mixin _$DBUser {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  List<String>? get role => throw _privateConstructorUsedError;
  String? get workAs => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool? get completed => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  List<Project>? get projects => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DBUserCopyWith<DBUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DBUserCopyWith<$Res> {
  factory $DBUserCopyWith(DBUser value, $Res Function(DBUser) then) =
      _$DBUserCopyWithImpl<$Res, DBUser>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String email,
      List<String>? role,
      String? workAs,
      DateTime? createdAt,
      bool? completed,
      String? provider,
      List<Project>? projects});
}

/// @nodoc
class _$DBUserCopyWithImpl<$Res, $Val extends DBUser>
    implements $DBUserCopyWith<$Res> {
  _$DBUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? email = null,
    Object? role = freezed,
    Object? workAs = freezed,
    Object? createdAt = freezed,
    Object? completed = freezed,
    Object? provider = freezed,
    Object? projects = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      workAs: freezed == workAs
          ? _value.workAs
          : workAs // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      projects: freezed == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DBUserImplCopyWith<$Res> implements $DBUserCopyWith<$Res> {
  factory _$$DBUserImplCopyWith(
          _$DBUserImpl value, $Res Function(_$DBUserImpl) then) =
      __$$DBUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String email,
      List<String>? role,
      String? workAs,
      DateTime? createdAt,
      bool? completed,
      String? provider,
      List<Project>? projects});
}

/// @nodoc
class __$$DBUserImplCopyWithImpl<$Res>
    extends _$DBUserCopyWithImpl<$Res, _$DBUserImpl>
    implements _$$DBUserImplCopyWith<$Res> {
  __$$DBUserImplCopyWithImpl(
      _$DBUserImpl _value, $Res Function(_$DBUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? email = null,
    Object? role = freezed,
    Object? workAs = freezed,
    Object? createdAt = freezed,
    Object? completed = freezed,
    Object? provider = freezed,
    Object? projects = freezed,
  }) {
    return _then(_$DBUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _value._role
          : role // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      workAs: freezed == workAs
          ? _value.workAs
          : workAs // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      projects: freezed == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DBUserImpl implements _DBUser {
  const _$DBUserImpl(
      {required this.uid,
      required this.name,
      required this.email,
      final List<String>? role,
      this.workAs,
      this.createdAt,
      this.completed,
      this.provider,
      final List<Project>? projects})
      : _role = role,
        _projects = projects;

  factory _$DBUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$DBUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String email;
  final List<String>? _role;
  @override
  List<String>? get role {
    final value = _role;
    if (value == null) return null;
    if (_role is EqualUnmodifiableListView) return _role;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? workAs;
  @override
  final DateTime? createdAt;
  @override
  final bool? completed;
  @override
  final String? provider;
  final List<Project>? _projects;
  @override
  List<Project>? get projects {
    final value = _projects;
    if (value == null) return null;
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DBUser(uid: $uid, name: $name, email: $email, role: $role, workAs: $workAs, createdAt: $createdAt, completed: $completed, provider: $provider, projects: $projects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DBUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._role, _role) &&
            (identical(other.workAs, workAs) || other.workAs == workAs) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      name,
      email,
      const DeepCollectionEquality().hash(_role),
      workAs,
      createdAt,
      completed,
      provider,
      const DeepCollectionEquality().hash(_projects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DBUserImplCopyWith<_$DBUserImpl> get copyWith =>
      __$$DBUserImplCopyWithImpl<_$DBUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DBUserImplToJson(
      this,
    );
  }
}

abstract class _DBUser implements DBUser {
  const factory _DBUser(
      {required final String uid,
      required final String name,
      required final String email,
      final List<String>? role,
      final String? workAs,
      final DateTime? createdAt,
      final bool? completed,
      final String? provider,
      final List<Project>? projects}) = _$DBUserImpl;

  factory _DBUser.fromJson(Map<String, dynamic> json) = _$DBUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get email;
  @override
  List<String>? get role;
  @override
  String? get workAs;
  @override
  DateTime? get createdAt;
  @override
  bool? get completed;
  @override
  String? get provider;
  @override
  List<Project>? get projects;
  @override
  @JsonKey(ignore: true)
  _$$DBUserImplCopyWith<_$DBUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
