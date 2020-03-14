from enum import Enum


class ModelName(Enum):
    FACE_MODEL = "face_recognition_model"

    @classmethod
    def get_all_names(cls):
        names = []
        for n in cls:
            names.append(n.value)
        return names
