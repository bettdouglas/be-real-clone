// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grpc/grpc.dart';
import 'package:server/database/models.dart';
import 'package:server/grpc-gen/google/protobuf/empty.pb.dart';
import 'package:server/grpc-gen/google/protobuf/timestamp.pbserver.dart';
import 'package:server/grpc-gen/photo_service.pbgrpc.dart';
import 'package:server/grpc-gen/models.pb.dart' as grpc;
import 'package:server/services/user_service.dart';
import 'package:stormberry/stormberry.dart';
import 'package:uuid/uuid.dart';

class PhotoService extends PhotoServiceBase {
  final PhotoRepository photoRepository;
  PhotoService({
    required this.photoRepository,
  });

  @override
  Future<grpc.Photo> createPhoto(
    ServiceCall call,
    CreatePhotoRequest request,
  ) async {
    final userId = call.clientMetadata!['user_id'];
    if (userId == null) {
      throw GrpcError.internal('Request passed without user_id');
    }
    final photo = request.photo;
    final id = Uuid().v4();
    await photoRepository.insertOne(
      PhotoInsertRequest(
        id: id,
        url: photo.url,
        description: photo.description,
        createdAt: photo.createdAt.toDateTime(),
        creatorId: userId,
      ),
    );
    final got = await photoRepository.queryBaseView(id);
    return got!.asGrpcPhoto();
  }

  @override
  Future<Empty> deletePhoto(
    ServiceCall call,
    DeletePhotoRequest request,
  ) async {
    await photoRepository.deleteOne(request.id);
    return Empty();
  }

  @override
  Future<grpc.Photo> getPhoto(
    ServiceCall call,
    GetPhotoRequest request,
  ) async {
    final completePhoto = await photoRepository.queryBaseView(request.id);
    if (completePhoto == null) {
      throw GrpcError.notFound();
    }
    return completePhoto.asGrpcPhoto();
  }

  @override
  Future<ListPhotosResponse> listPhotos(
    ServiceCall call,
    ListPhotosRequest request,
  ) async {
    final offSet = int.tryParse(request.pageToken) ?? 0;
    final photos = await photoRepository.queryBaseViews(
      QueryParams(offset: offSet, limit: 100),
    );
    return ListPhotosResponse(
      nextPageToken: (offSet + photos.length).toString(),
      photos: photos.map((e) => e.asGrpcPhoto()).toList(),
    );
  }

  @override
  Future<grpc.Photo> updatePhoto(
    ServiceCall call,
    UpdatePhotoRequest request,
  ) async {
    final updateMaskPaths = request.updateMask.paths;
    final photo = request.photo;
    // we can only update the description
    String? description;
    for (var path in updateMaskPaths) {
      if (path == 'description') {
        description = photo.description;
      }
    }
    final updatePhotoRequest = PhotoUpdateRequest(
      id: photo.id,
      description: description,
    );
    await photoRepository.updateOne(updatePhotoRequest);
    final got = await photoRepository.queryBaseView(photo.id);
    return got!.asGrpcPhoto();
  }
}

extension AsBaseGrpcPhoto on BasePhotoView {
  grpc.Photo asGrpcPhoto() {
    return grpc.Photo(
      id: id,
      createdAt: Timestamp.fromDateTime(createdAt),
      creator: creator.asGrpcUser(),
      description: description,
      url: url,
      likers: likes.map((e) => e.user.asGrpcUser()).toList(),
    );
  }
}

extension AsCompleteGrpcPhoto on CompletePhotoView {
  grpc.Photo asGrpcPhoto() {
    return grpc.Photo(
      id: id,
      createdAt: Timestamp.fromDateTime(createdAt),
      creator: creator.asGrpcUser(),
      description: description,
      url: url,
      likers: likes.map((e) => e.user.asGrpcUser()).toList(),
    );
  }
}
