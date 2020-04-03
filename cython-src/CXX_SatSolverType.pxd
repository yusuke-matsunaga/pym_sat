
### @file CXX_SatSolverType.pxd
### @brief CXX_SatSolverType 用の pxd ファイル
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2018 Yusuke Matsunaga
### All rights reserved.

from libcpp.string cimport string
from CXX_iostream cimport ostream


cdef extern from "ym/SatSolverType.h" namespace "nsYm" :

    ### @brief SatSolverType クラスの cython バージョン
    cdef cppclass SatSolverType :
        SatSolvertype(const string& type,
                      const string& option,
                      ostream*)
        void set(const string& type,
                 const string& option,
                 ostream*)
        string type()
        string option()
