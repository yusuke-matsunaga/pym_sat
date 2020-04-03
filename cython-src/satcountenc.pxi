
### @file satcountenc.pxi
### @brief SatCountEnc の cython インターフェイス
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2019 Yusuke Matsunaga
### All rights reserved.

from CXX_SatCountEnc cimport SatCountEnc as CXX_SatCountEnc
from CXX_SatLiteral cimport SatLiteral as CXX_SatLiteral
import cython


### @brief SatCountEnc クラスの Python バージョン
cdef class SatCountEnc :

    # C++ レベルのオブジェクト本体
    cdef CXX_SatCountEnc* _this_ptr

    ### @brief 初期化
    def __cinit__(self, SatSolver solver) :
        self._this_ptr = new CXX_SatCountEnc(cython.operator.dereference(solver._this_ptr))

    ### @brief 終了処理
    def __dealloc__(self) :
        if self._this_ptr != NULL :
            del self._this_ptr

    ### @brief 与えられたリテラルのうち１つしか true にならない条件を追加する．
    def add_at_most_one(self, lit_list) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_at_most_one(c_lit_list)

    ### @brief 与えられたリテラルのうち２つしか true にならない条件を追加する．
    def add_at_most_two(self, lit_list) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_at_most_two(c_lit_list)

    ### @brief 与えられたリテラルのうち k 個しか true にならない条件を追加する．
    def add_at_most_k(self, lit_list, int k) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_at_most_k(c_lit_list, k)

    ### @brief 与えられたリテラルのうち1つ以上は true になる条件を追加する．
    def add_at_least_one(self, lit_list) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_at_least_one(c_lit_list)

    ### @brief 与えられたリテラルのうち2つ以上は true になる条件を追加する．
    def add_at_least_two(self, lit_list) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_at_least_two(c_lit_list)

    ### @brief 与えられたリテラルのうちk個以上は true になる条件を追加する．
    def add_at_least_k(self, lit_list, int k) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_at_least_k(c_lit_list, k)

    ### @brief 与えられたリテラルのうち厳密に１つのみ true になる条件を追加する．
    def add_exact_one(self, lit_list) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_exact_one(c_lit_list)

    ### @brief 与えられたリテラルのうち厳密に2つが true になる条件を追加する．
    def add_exact_two(self, lit_list) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_exact_two(c_lit_list)

    ### @brief 与えられたリテラルのうち厳密にk個が true になる条件を追加する．
    def add_exact_k(self, lit_list, int k) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_exact_k(c_lit_list, k)

    ### @brief 与えられたリテラルのうち true になっている個数が 1 でない条件を追加する．
    def add_not_one(self, lit_list) :
        cdef vector[CXX_SatLiteral] c_lit_list
        for lit in lit_list :
            c_lit_list.push_back(from_literal(lit))
        self._this_ptr.add_not_one(c_lit_list)
