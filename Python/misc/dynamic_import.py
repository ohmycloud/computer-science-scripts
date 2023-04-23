# -*- coding: utf-8 -*-

import importlib

class DynamicallyImport:
    """
    动态加载 python 模块
    """
    @staticmethod
    def load_class(moduleName,className):
        """
        :param moduleName: 模块名
        :param className: 类名
        :return: <class 'type'>
        """
        module = importlib.import_module(moduleName)
        dynamic_class  = getattr(module, className)
        return dynamic_class


if __name__ == '__main__':
    import os, time
    import pandas as pd
    import numpy as np

    alg = DynamicallyImport.load_class("alg.consistency.{0}.{1}".format('v1', 'Consistency'),'Consistency')
    print(dir(alg))

    alg().run(None, None)