#! /bin/bash
set -euo pipefail

mkdir -p lib/grpc-gen/

# Generate models only
protoc -I protos/ --dart_out=lib/grpc-gen/ protos/models.proto 

# Generate Well-Known Types
protoc -I protos/ --dart_out=lib/grpc-gen/ google/protobuf/timestamp.proto google/protobuf/field_mask.proto google/protobuf/empty.proto

# Generate models + grpc stubs
protoc -I protos/ --dart_out=grpc:lib/grpc-gen/ protos/user_service.proto