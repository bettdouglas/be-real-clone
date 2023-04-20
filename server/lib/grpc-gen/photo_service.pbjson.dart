///
//  Generated code. Do not modify.
//  source: photo_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use listPhotosRequestDescriptor instead')
const ListPhotosRequest$json = const {
  '1': 'ListPhotosRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListPhotosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPhotosRequestDescriptor = $convert.base64Decode('ChFMaXN0UGhvdG9zUmVxdWVzdBIWCgZwYXJlbnQYASABKAlSBnBhcmVudBIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');
@$core.Deprecated('Use listPhotosResponseDescriptor instead')
const ListPhotosResponse$json = const {
  '1': 'ListPhotosResponse',
  '2': const [
    const {'1': 'photos', '3': 1, '4': 3, '5': 11, '6': '.bereal.Photo', '10': 'photos'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListPhotosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPhotosResponseDescriptor = $convert.base64Decode('ChJMaXN0UGhvdG9zUmVzcG9uc2USJQoGcGhvdG9zGAEgAygLMg0uYmVyZWFsLlBob3RvUgZwaG90b3MSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');
@$core.Deprecated('Use getPhotoRequestDescriptor instead')
const GetPhotoRequest$json = const {
  '1': 'GetPhotoRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetPhotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPhotoRequestDescriptor = $convert.base64Decode('Cg9HZXRQaG90b1JlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use createPhotoRequestDescriptor instead')
const CreatePhotoRequest$json = const {
  '1': 'CreatePhotoRequest',
  '2': const [
    const {'1': 'photo', '3': 1, '4': 1, '5': 11, '6': '.bereal.Photo', '10': 'photo'},
  ],
};

/// Descriptor for `CreatePhotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPhotoRequestDescriptor = $convert.base64Decode('ChJDcmVhdGVQaG90b1JlcXVlc3QSIwoFcGhvdG8YASABKAsyDS5iZXJlYWwuUGhvdG9SBXBob3Rv');
@$core.Deprecated('Use updatePhotoRequestDescriptor instead')
const UpdatePhotoRequest$json = const {
  '1': 'UpdatePhotoRequest',
  '2': const [
    const {'1': 'photo', '3': 1, '4': 1, '5': 11, '6': '.bereal.Photo', '10': 'photo'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `UpdatePhotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePhotoRequestDescriptor = $convert.base64Decode('ChJVcGRhdGVQaG90b1JlcXVlc3QSIwoFcGhvdG8YASABKAsyDS5iZXJlYWwuUGhvdG9SBXBob3RvEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use deletePhotoRequestDescriptor instead')
const DeletePhotoRequest$json = const {
  '1': 'DeletePhotoRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeletePhotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePhotoRequestDescriptor = $convert.base64Decode('ChJEZWxldGVQaG90b1JlcXVlc3QSDgoCaWQYASABKAlSAmlk');
