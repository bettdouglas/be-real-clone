///
//  Generated code. Do not modify.
//  source: photo_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'photo_service.pb.dart' as $3;
import 'models.pb.dart' as $1;
import 'google/protobuf/empty.pb.dart' as $2;
export 'photo_service.pb.dart';

class PhotoServiceClient extends $grpc.Client {
  static final _$listPhotos =
      $grpc.ClientMethod<$3.ListPhotosRequest, $3.ListPhotosResponse>(
          '/bereal.PhotoService/ListPhotos',
          ($3.ListPhotosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.ListPhotosResponse.fromBuffer(value));
  static final _$getPhoto = $grpc.ClientMethod<$3.GetPhotoRequest, $1.Photo>(
      '/bereal.PhotoService/GetPhoto',
      ($3.GetPhotoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Photo.fromBuffer(value));
  static final _$createPhoto =
      $grpc.ClientMethod<$3.CreatePhotoRequest, $1.Photo>(
          '/bereal.PhotoService/CreatePhoto',
          ($3.CreatePhotoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Photo.fromBuffer(value));
  static final _$updatePhoto =
      $grpc.ClientMethod<$3.UpdatePhotoRequest, $1.Photo>(
          '/bereal.PhotoService/UpdatePhoto',
          ($3.UpdatePhotoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Photo.fromBuffer(value));
  static final _$deletePhoto =
      $grpc.ClientMethod<$3.DeletePhotoRequest, $2.Empty>(
          '/bereal.PhotoService/DeletePhoto',
          ($3.DeletePhotoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  PhotoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.ListPhotosResponse> listPhotos(
      $3.ListPhotosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPhotos, request, options: options);
  }

  $grpc.ResponseFuture<$1.Photo> getPhoto($3.GetPhotoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPhoto, request, options: options);
  }

  $grpc.ResponseFuture<$1.Photo> createPhoto($3.CreatePhotoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPhoto, request, options: options);
  }

  $grpc.ResponseFuture<$1.Photo> updatePhoto($3.UpdatePhotoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePhoto, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> deletePhoto($3.DeletePhotoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePhoto, request, options: options);
  }
}

abstract class PhotoServiceBase extends $grpc.Service {
  $core.String get $name => 'bereal.PhotoService';

  PhotoServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.ListPhotosRequest, $3.ListPhotosResponse>(
        'ListPhotos',
        listPhotos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ListPhotosRequest.fromBuffer(value),
        ($3.ListPhotosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetPhotoRequest, $1.Photo>(
        'GetPhoto',
        getPhoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetPhotoRequest.fromBuffer(value),
        ($1.Photo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.CreatePhotoRequest, $1.Photo>(
        'CreatePhoto',
        createPhoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.CreatePhotoRequest.fromBuffer(value),
        ($1.Photo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UpdatePhotoRequest, $1.Photo>(
        'UpdatePhoto',
        updatePhoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.UpdatePhotoRequest.fromBuffer(value),
        ($1.Photo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.DeletePhotoRequest, $2.Empty>(
        'DeletePhoto',
        deletePhoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.DeletePhotoRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$3.ListPhotosResponse> listPhotos_Pre($grpc.ServiceCall call,
      $async.Future<$3.ListPhotosRequest> request) async {
    return listPhotos(call, await request);
  }

  $async.Future<$1.Photo> getPhoto_Pre(
      $grpc.ServiceCall call, $async.Future<$3.GetPhotoRequest> request) async {
    return getPhoto(call, await request);
  }

  $async.Future<$1.Photo> createPhoto_Pre($grpc.ServiceCall call,
      $async.Future<$3.CreatePhotoRequest> request) async {
    return createPhoto(call, await request);
  }

  $async.Future<$1.Photo> updatePhoto_Pre($grpc.ServiceCall call,
      $async.Future<$3.UpdatePhotoRequest> request) async {
    return updatePhoto(call, await request);
  }

  $async.Future<$2.Empty> deletePhoto_Pre($grpc.ServiceCall call,
      $async.Future<$3.DeletePhotoRequest> request) async {
    return deletePhoto(call, await request);
  }

  $async.Future<$3.ListPhotosResponse> listPhotos(
      $grpc.ServiceCall call, $3.ListPhotosRequest request);
  $async.Future<$1.Photo> getPhoto(
      $grpc.ServiceCall call, $3.GetPhotoRequest request);
  $async.Future<$1.Photo> createPhoto(
      $grpc.ServiceCall call, $3.CreatePhotoRequest request);
  $async.Future<$1.Photo> updatePhoto(
      $grpc.ServiceCall call, $3.UpdatePhotoRequest request);
  $async.Future<$2.Empty> deletePhoto(
      $grpc.ServiceCall call, $3.DeletePhotoRequest request);
}
