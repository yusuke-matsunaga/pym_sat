
### @file sattseitinenc.pxi
### @brief sattseitinenc の cython インターフェイス
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2019, 2020 Yusuke Matsunaga
### All rights reserved.

from CXX_SatTseitinEnc cimport SatTseitinEnc as CXX_SatTseitinEnc
from CXX_SatLiteral cimport SatLiteral as CXX_SatLiteral
import cython


### @brief SatTseitinEnc クラスの Python バージョン
cdef class SatTseitinEnc :

    # C++ レベルのオブジェクト本体
    cdef CXX_SatTseitinEnc* _this_ptr

    ### @brief 初期化
    def __cinit__(self, SatSolver solver) :
        self._this_ptr = new CXX_SatTseitinEnc(cython.operator.dereference(solver._this_ptr))

    ### @brief 終了処理
    def __dealloc__(self) :
        if self._this_ptr != NULL :
            del self._this_ptr

    ### @brief 等価条件の生成
    def add_buffgate(self, lit1, lit2) :
        cdef CXX_SatLiteral c_lit1 = from_literal(lit1)
        cdef CXX_SatLiteral c_lit2 = from_literal(lit2)
        self._this_ptr.add_buffgate(c_lit1, c_lit2)

    ### @brief 非等価条件の生成
    def add_notgate(self, lit1, lit2) :
        cdef CXX_SatLiteral c_lit1 = from_literal(lit1)
        cdef CXX_SatLiteral c_lit2 = from_literal(lit2)
        self._this_ptr.add_notgate(c_lit1, c_lit2)

    ### @brief ANDゲートの生成
    def add_andgate(self, olit, ilits) :
        cdef CXX_SatLiteral c_olit = from_literal(olit)
        cdef vector[CXX_SatLiteral] c_ilits
        for lit in ilits :
            c_ilits.push_back(from_literal(lit))
        self._this_ptr.add_andgate(c_olit, c_ilits)

    ### @brief NANDゲートの生成
    def add_nandgate(self, olit, ilits) :
        cdef CXX_SatLiteral c_olit = from_literal(olit)
        cdef vector[CXX_SatLiteral] c_ilits
        for lit in ilits :
            c_ilits.push_back(from_literal(lit))
        self._this_ptr.add_nandgate(c_olit, c_ilits)

    ### @brief ORゲートの生成
    def add_orgate(self, olit, ilits) :
        cdef CXX_SatLiteral c_olit = from_literal(olit)
        cdef vector[CXX_SatLiteral] c_ilits
        for lit in ilits :
            c_ilits.push_back(from_literal(lit))
        self._this_ptr.add_orgate(c_olit, c_ilits)

    ### @brief NORゲートの生成
    def add_norgate(self, olit, ilits) :
        cdef CXX_SatLiteral c_olit = from_literal(olit)
        cdef vector[CXX_SatLiteral] c_ilits
        for lit in ilits :
            c_ilits.push_back(from_literal(lit))
        self._this_ptr.add_norgate(c_olit, c_ilits)

    ### @brief XORゲートの生成
    def add_xorgate(self, olit, ilits) :
        cdef CXX_SatLiteral c_olit = from_literal(olit)
        cdef vector[CXX_SatLiteral] c_ilits
        for lit in ilits :
            c_ilits.push_back(from_literal(lit))
        self._this_ptr.add_xorgate(c_olit, c_ilits)
