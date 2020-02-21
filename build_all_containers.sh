#!/usr/bin/env bash

CUSTOM_BACKEND_CONTAINER_NAME="trtis-custom-backend-build-container"

# create model folder and copy model setting files.
mkdir -p model_repository/sample_instance/1
cp -f ./model_settings/sample_instance/config.pbtxt \
      ./model_repository/sample_instance/
mkdir -p model_repository/simple_sequence/1
cp -f ./tensorrt-inference-server/qa/L0_backend_release/simple_seq_models/simple_sequence/config.pbtxt \
      ./model_repository/simple_sequence/
mkdir -p model_repository/sample_sequence/1
cp -f ./model_settings/sample_sequence/config.pbtxt \
      ./model_repository/sample_sequence/
mkdir -p model_repository/mecab_model/1
cp -f ./model_settings/mecab_model/config.pbtxt \
      ./model_repository/mecab_model/
mkdir -p model_repository/face_recognition_model/1
cp -f ./model_settings/face_recognition_model/config.pbtxt \
      ./model_repository/face_recognition_model/

# TODO : build the server codes
echo "----------  start to build trtis-server-container  ------------"

# build the client codes
echo "----------  start to build trtis-client-container  ------------"
docker exec -it trtis-client-container sh -c "cd /workspace && bash build_client_library.sh"

# build the custom-backend codes
echo "----------  start to build trtis-custom-backend-build-container  ------------"
## add the build target source into CMakeLists.txt(TODO : write target into CMakeLists.txt if needed.)
docker exec -it $CUSTOM_BACKEND_CONTAINER_NAME sh -c \
    "echo 'add_subdirectory(../../custom_backend/sample_instance src/custom/sample_instance)' >> /workspace/build/trtis-custom-backends/CMakeLists.txt"
docker exec -it $CUSTOM_BACKEND_CONTAINER_NAME sh -c \
    "echo 'add_subdirectory(../../custom_backend/sample_sequence src/custom/sample_sequence)' >> /workspace/build/trtis-custom-backends/CMakeLists.txt"
docker exec -it $CUSTOM_BACKEND_CONTAINER_NAME sh -c \
    "echo 'add_subdirectory(../../custom_backend/mecab_model src/custom/mecab_model)' >> /workspace/build/trtis-custom-backends/CMakeLists.txt"
docker exec -it $CUSTOM_BACKEND_CONTAINER_NAME sh -c \
    "echo 'add_subdirectory(../../custom_backend/face_recognition_model src/custom/face_recognition_model)' >> /workspace/build/trtis-custom-backends/CMakeLists.txt"
## build custom backend files and move libraries
bash build_custom_models.sh