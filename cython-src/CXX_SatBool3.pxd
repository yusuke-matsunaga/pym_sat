### @file CXX_SatBool3.pxd
### @brief CXX_SatBool3 の cython インターフェイス
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2017, 2018 Yusuke Matsunaga
### All rights reserved.

cdef extern from "ym/SatBool3.h" namespace "nsYm" :

    cdef enum SatBool3 :
        False,
        True,
        X

    cdef int __SatBool3_to_int(SatBool3)
    cdef SatBool3 __int_to_SatBool3(int)
