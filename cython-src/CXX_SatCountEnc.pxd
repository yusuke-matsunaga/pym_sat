# @file CXX_SatCountEnc.pxd
# @brief CXX_SatCountEnc の cython インターフェイス
# @author Yusuke Matsunaga (松永 裕介)
#
# Copyright (C) 2017, 2019 Yusuke Matsunaga
# All rights reserved.

from libcpp.vector cimport vector
from CXX_SatLiteral cimport SatLiteral
from CXX_SatSolver cimport SatSolver



cdef extern from "ym/SatCountEnc.h" namespace "nsYm" :

    # SatCountEnc クラスの cython バージョン
    cdef cppclass SatCountEnc :
        SatCountEnc(const SatSolver& solver)
        void add_at_most_one(vector[SatLiteral]& lits)
        void add_at_most_two(vector[SatLiteral]& lits)
        void add_at_most_k(vector[SatLiteral]& lits, int k)
        void add_at_least_one(vector[SatLiteral]& lits)
        void add_at_least_two(vector[SatLiteral]& lits)
        void add_at_least_k(vector[SatLiteral]& lits, int k)
        void add_exact_one(vector[SatLiteral]& lits)
        void add_exact_two(vector[SatLiteral]& lits)
        void add_exact_k(vector[SatLiteral]& lits, int k)
        void add_not_one(vector[SatLiteral]& lits)
