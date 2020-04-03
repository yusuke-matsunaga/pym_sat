# @file CXX_SatLiteral.pxd
# @brief SatLiteral の cython インターフェイス
# @author Yusuke Matsunaga (松永 裕介)
#
# Copyright (C) 2017, 2019 Yusuke Matsunaga
# All rights reserved.

from libcpp cimport bool


cdef extern from "ym/SatLiteral.h" namespace "nsYm" :

    # SatLiteral クラスの cython バージョン
    cdef cppclass SatLiteral :
        SatLiteral()
        @staticmethod
        SatLiteral conv_from_varid(int, bool)
        @staticmethod
        SatLiteral index2literal(int)
        void set(int, bool)
        bool is_valid()
        int varid()
        bool is_positive()
        bool is_negative()
        SatLiteral make_positive()
        SatLiteral make_negative()
        int index()
