
### @file satbvenc.pxi
### @brief SatBvEnc の cython インターフェイス
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2019 Yusuke Matsunaga
### All rights reserved.

from CXX_SatBvEnc cimport SatBvEnc as CXX_SatBvEnc
from CXX_SatLiteral cimport SatLiteral as CXX_SatLiteral
import cython


### @brief SatBvEnc クラスの Python バージョン
cdef class SatBvEnc :

    # C++ レベルのオブジェクト本体
    cdef CXX_SatBvEnc* _this_ptr

    ### @brief 初期化
    def __cinit__(self, SatSolver solver) :
        self._this_ptr = new CXX_SatBvEnc(cython.operator.dereference(solver._this_ptr))

    ### @brief 終了処理
    def __dealloc__(self) :
        if self._this_ptr != NULL :
            del self._this_ptr

    ### @brief A == B という条件を追加する．
    ###
    ### b は SatLiteral のリストか int
    def add_eq(self, a_vec, b) :
        cdef vector[CXX_SatLiteral] c_a_vec
        cdef vector[CXX_SatLiteral] c_b_vec
        cdef int b_val
        for lit in a_vec :
            c_a_vec.push_back(from_literal(lit))
        if type(b) is list :
            for lit in b :
                c_b_vec.push_back(from_literal(lit))
            self._this_ptr.add_eq(c_a_vec, c_b_vec)
        elif type(b) is int :
            b_val = b
            self._this_ptr.add_eq(c_a_vec, b_val)

    ### @brief A != B という条件を追加する．
    ###
    ### b は SatLiteral のリストか int
    def add_ne(self, a_vec, b) :
        cdef vector[CXX_SatLiteral] c_a_vec
        cdef vector[CXX_SatLiteral] c_b_vec
        cdef int b_val
        for lit in a_vec :
            c_a_vec.push_back(from_literal(lit))
        if type(b) is list :
            for lit in b :
                c_b_vec.push_back(from_literal(lit))
            self._this_ptr.add_ne(c_a_vec, c_b_vec)
        elif type(b) is int :
            b_val = b
            self._this_ptr.add_ne(c_a_vec, b_val)

    ### @brief A < B という条件を追加する．
    ###
    ### b は SatLiteral のリストか int
    def add_lt(self, a_vec, b) :
        cdef vector[CXX_SatLiteral] c_a_vec
        cdef vector[CXX_SatLiteral] c_b_vec
        cdef int b_val
        for lit in a_vec :
            c_a_vec.push_back(from_literal(lit))
        if type(b) is list :
            for lit in b :
                c_b_vec.push_back(from_literal(lit))
            self._this_ptr.add_lt(c_a_vec, c_b_vec)
        elif type(b) is int :
            b_val = b
            self._this_ptr.add_lt(c_a_vec, b_val)

    ### @brief A <= B という条件を追加する．
    ###
    ### b は SatLiteral のリストか int
    def add_le(self, a_vec, b) :
        cdef vector[CXX_SatLiteral] c_a_vec
        cdef vector[CXX_SatLiteral] c_b_vec
        cdef int b_val
        for lit in a_vec :
            c_a_vec.push_back(from_literal(lit))
        if type(b) is list :
            for lit in b :
                c_b_vec.push_back(from_literal(lit))
            self._this_ptr.add_le(c_a_vec, c_b_vec)
        elif type(b) is int :
            b_val = b
            self._this_ptr.add_le(c_a_vec, b_val)

    ### @brief A > B という条件を追加する．
    ###
    ### b は SatLiteral のリストか int
    def add_gt(self, a_vec, b) :
        cdef vector[CXX_SatLiteral] c_a_vec
        cdef vector[CXX_SatLiteral] c_b_vec
        cdef int b_val
        for lit in a_vec :
            c_a_vec.push_back(from_literal(lit))
        if type(b) is list :
            for lit in b :
                c_b_vec.push_back(from_literal(lit))
            self._this_ptr.add_gt(c_a_vec, c_b_vec)
        elif type(b) is int :
            b_val = b
            self._this_ptr.add_gt(c_a_vec, b_val)

    ### @brief A >= B という条件を追加する．
    ###
    ### b は SatLiteral のリストか int
    def add_ge(self, a_vec, b) :
        cdef vector[CXX_SatLiteral] c_a_vec
        cdef vector[CXX_SatLiteral] c_b_vec
        cdef int b_val
        for lit in a_vec :
            c_a_vec.push_back(from_literal(lit))
        if type(b) is list :
            for lit in b :
                c_b_vec.push_back(from_literal(lit))
            self._this_ptr.add_ge(c_a_vec, c_b_vec)
        elif type(b) is int :
            b_val = b
            self._this_ptr.add_ge(c_a_vec, b_val)
