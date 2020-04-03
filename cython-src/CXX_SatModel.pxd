
### @file CXX_SatModel.pxd
### @brief SatModel 用の pxd ファイル
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2019 Yusuke Matsunaga
### All rights reserved.

from CXX_SatBool3 cimport SatBool3
from CXX_SatLiteral cimport SatLiteral


cdef extern from "ym/SatModel.h" namespace "nsYm" :

    # SatModel の cython バージョン
    cdef cppclass SatModel :
        SatModel()
        int size()
        SatBool3 get(SatLiteral lit)
        void resize(int)
        void set(int, SatBool3)
