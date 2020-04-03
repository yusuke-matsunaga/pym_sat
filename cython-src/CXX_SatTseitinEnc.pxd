# @file CXX_SatTseitinEnc.pxd
# @brief CXX_SatTseitionEnc の cython インターフェイス
# @author Yusuke Matsunaga (松永 裕介)
#
# Copyright (C) 2017, 2019 Yusuke Matsunaga
# All rights reserved.

from libcpp.vector cimport vector
from CXX_SatLiteral cimport SatLiteral
from CXX_SatSolver cimport SatSolver


cdef extern from "ym/SatTseitinEnc.h" namespace "nsYm" :

    # SatTseitinEnc クラスの cython バージョン
    cdef cppclass SatTseitinEnc :
        SatTseitinEnc(const SatSolver& solver)
        void add_buffgate(SatLiteral lit1, SatLiteral lit2)
        void add_notgate(SatLiteral lit1, SatLiteral lit2)
        void add_andgate(SatLiteral olit, vector[SatLiteral]& ilits)
        void add_nandgate(SatLiteral olit, vector[SatLiteral]& ilits)
        void add_orgate(SatLiteral olit, vector[SatLiteral]& ilits)
        void add_norgate(SatLiteral olit, vector[SatLiteral]& ilits)
        void add_xorgate(SatLiteral olit, vector[SatLiteral]& ilits)
        void add_xnorgate(SatLiteral olit, vector[SatLiteral]& ilits)
