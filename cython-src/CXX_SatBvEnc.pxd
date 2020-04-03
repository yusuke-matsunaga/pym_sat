# @file CXX_SatBvEnc.pxd
# @brief CXX_SatBvEnc の cython インターフェイス
# @author Yusuke Matsunaga (松永 裕介)
#
# Copyright (C) 2017, 2019 Yusuke Matsunaga
# All rights reserved.

from libcpp.vector cimport vector
from CXX_SatLiteral cimport SatLiteral
from CXX_SatSolver cimport SatSolver


cdef extern from "ym/SatBvEnc.h" namespace "nsYm" :

    # SatBvEnc クラスの cython バージョン
    cdef cppclass SatBvEnc :
        SatBvEnc(const SatSolver& solver)
        void add_eq(vector[SatLiteral]& a_vec, vector[SatLiteral]& b_vec);
        void add_eq(vector[SatLiteral]& a_vec, int b_val);
        void add_ne(vector[SatLiteral]& a_vec, vector[SatLiteral]& b_vec);
        void add_ne(vector[SatLiteral]& a_vec, int b_val);
        void add_lt(vector[SatLiteral]& a_vec, vector[SatLiteral]& b_vec);
        void add_lt(vector[SatLiteral]& a_vec, int b_val);
        void add_le(vector[SatLiteral]& a_vec, vector[SatLiteral]& b_vec);
        void add_le(vector[SatLiteral]& a_vec, int b_val);
        void add_gt(vector[SatLiteral]& a_vec, vector[SatLiteral]& b_vec);
        void add_gt(vector[SatLiteral]& a_vec, int b_val);
        void add_ge(vector[SatLiteral]& a_vec, vector[SatLiteral]& b_vec);
        void add_ge(vector[SatLiteral]& a_vec, int b_val);
