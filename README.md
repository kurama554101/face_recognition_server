# Face Recognition Server

## Introduction

Face Recognition Server is the service to detect the face in image and recognize someone.
This service use [TensorRT Inference Server](https://github.com/NVIDIA/tensorrt-inference-server).

## Environment

* Docker
* Docker-Compose
* git

## Container Architecture

This repository create the following container.

| Name | Category | Description |
|:----:|:----:|:-----|
|Server Container|Server|Main container in Server|
|Custom-Backend Container|Server|Build the face recognition model in this container|
|Data upload Container|Server|Upload the face data into server|
|Cliend Container|Client|Main container in Client|

## Setup

### Build & Run each containers

need to execute the following command.
```
$ bash setup_trtis_docker_containers.sh
```

After above command is executed, all containers will be created and run.

### Fetch models

If you use the default trtis models(ex. ResNet50, sequence..), need to execute the following command.
```
$ bash fetch_default_models.sh
```

### Execute trtis-client script

* attach the trtis client container
```
$ docker exec -it trtis-client-container bash
```

* execute client script in trtis client container(ex. simple model)
```
$ python3 src/clients/python/simple_client.py
```

* execute custom client script in trtis client container(ex. sample_instance model)
```
$ python3 custom_client/python/sample_instance_client.py
```

## Other information

### setup docker container without building docker images

need to execute the following command.
```
$ bash setup_trtis_docker_containers.sh --no-build
```

### setup docker container without using docker cache

need to execute the following command.
```
$ bash setup_trtis_docker_containers.sh --no-cache
```

### setup only client docker container

```
$ bash setup_trtis_docker_containers.sh --only-client
```

### setup only server docker container

```
$ bash setup_trtis_docker_containers.sh --only-server
```

### setup docker containers with GPU

```
$ bash setup_trtis_docker_containers.sh --use-gpu
```

### use face recognition function

need to prepare the following steps

#### prepare the dataset with face image

The following directory is need to create on the root folder of this repository.

* "dataset/face/image"

You need to store the image files with face in above folder.

#### prepare the config csv file

You need to store the config file of csv format in following path.

* "dataset/face/face.csv"

This csv file format is following.

* first column is "image file name"
* second column is "face name"


```
hoge.jpg, fuga
taro.jpg, hanako

...

```

#### execute demo client of face recognition

* attach the trtis client container
```
$ docker exec -it trtis-client-container bash
```

* execute demo script
```
$ streamlit run custom_client/python/face_recognition_client.py
```

* open the browser and access "http://localhost:8501"

* following page will be displayed
  * This main page is displayed using [streamlit](https://github.com/streamlit/streamlit)

![face recognition main page](document/image/face_recognition_main.png)
