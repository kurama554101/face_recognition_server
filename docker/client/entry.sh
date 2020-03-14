#!/usr/bin/env bash

# TODO : need to get the port number from argument
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
streamlit run custom_client/python/face_recognition_client.py --server.port 8501
