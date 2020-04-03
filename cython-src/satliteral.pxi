
### @file satliteral.pxi
### @brief SatLiteral の python インターフェイス
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2017, 2019, 2020 Yusuke Matsunaga
### All rights reserved.

from libcpp cimport bool
from CXX_SatLiteral cimport SatLiteral as CXX_SatLiteral


### @brief リテラルを表すクラス
###
### C++ のクラスとは別に Python の拡張型を定義する．
### 相互の変換関数を用意する．
cdef class SatLiteral :

    # 変数番号と極性を収めた実体
    cdef int __body

    ### @brief 初期化
    def __init__(SatLiteral self) :
        # 不正な値
        self.__body = -1

    ### @brief 適正な値を持っている時 True を返す．
    @property
    def is_valid(SatLiteral self) :
        return self.__body >= 0

    ### @brief 変数番号を得る．
    @property
    def varid(SatLiteral self) :
        return self.__body >> 1

    ### @brief 正極性の時 True を返す．
    @property
    def is_positive(SatLiteral self) :
        if (self.__body & 1) == 0 :
            return True
        else :
            return False

    ### @brief 負極性の時 True を返す．
    @property
    def is_negative(SatLiteral self) :
        return not self.is_positive()

    ### @brief 変数番号が同じの正極性のリテラルを返す．
    def make_positive(SatLiteral self) :
        return SatLiteral(self.varid(), False)

    ### @brief 変数番号が同じの負極性のリテラルを返す．
    def make_positive(SatLiteral self) :
        return SatLiteral(self.varid(), True)

    ### @brief 否定演算子
    def __invert__(SatLiteral self) :
        return SatLiteral(self.varid(), self.is_positive())

    ### @brief 文字列演算子
    def __repr__(SatLiteral self) :
        inv_str = '' if self.is_positive() else '~'
        return '{}{}'.format(inv_str, self.varid())

    ### @brief ハッシュ関数
    def __hash__(SatLiteral self) :
        return self.__body

    ### @brief 等価比較演算子
    def __eq__(SatLiteral self, SatLiteral other) :
        return self.__body == other.__body


### @brief Python の SatLiteral を C++ の SatLiteral に変換する．
### @param[in] literal Python バージョンの SatLiteral
cdef CXX_SatLiteral from_literal(literal) :
    cdef int varid = literal.varid
    return CXX_SatLiteral.conv_from_varid(varid, literal.is_negative)

### @brief C++ の SatLiteral を Python の SatLiteral に変換する．
### @param[in] c_literal C++ バージョンの SatLiteral
cdef to_literal(CXX_SatLiteral c_literal) :
    cdef int varid = c_literal.varid()
    cdef int inv_offset = 0
    lit = SatLiteral()
    if varid < 0 :
        lit.__body = -1
    else :
        if c_literal.is_negative() :
            inv_offset = 1
        lit.__body = (varid << 1) | inv_offset
    return lit
