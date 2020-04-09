### @file satsolver.pxi
### @brief SatSolver の python インターフェイス
### @author Yusuke Matsunaga (松永 裕介)
###
### Copyright (C) 2017, 2019 Yusuke Matsunaga
### All rights reserved.

from libcpp.string cimport string
from libcpp.vector cimport vector
from CXX_SatSolver cimport SatSolver as CXX_SatSolver
from CXX_SatBool3 cimport SatBool3 as CXX_SatBool3
from CXX_SatLiteral cimport SatLiteral as CXX_SatLiteral
from CXX_SatSolverType cimport SatSolverType as CXX_SatSolverType
from CXX_SatModel cimport SatModel as CXX_SatModel
from CXX_SatStats cimport SatStats as CXX_SatStats


### @brief SatSolver クラスの Python バージョン
cdef class SatSolver :

    # C++ レベルのオブジェクト本体
    cdef CXX_SatSolver* _this_ptr
    cdef list __var_list

    ### @brief 初期化
    ### @param[in] sat_type SATソルバの種類を表す文字列
    ### @param[in] sat_option SATソルバに対するオプションを表す文字列
    def __cinit__(SatSolver self, SatSolverType solver_type = SatSolverType()) :
        self._this_ptr = new CXX_SatSolver(solver_type._this)

    def __init__(SatSolver self) :
        self.__var_list = list()

    ### @brief 終了処理
    def __dealloc__(SatSolver self) :
        if self._this_ptr != NULL :
            del self._this_ptr

    ### @brief ソルバの型を返す．
    @property
    def type(SatSolver self) :
        return to_SatSolverType(self._this_ptr.type())

    ### @brief 新しい変数を確保する．
    ### @param[in] decision 決定変数の時に True にする．
    ### @return その変数に対応するリテラル(Literal)を返す．
    ###
    ### * 変数そのもの(VarId)ではないことに注意
    def new_variable(SatSolver self, bool decision = True) :
        cdef CXX_SatLiteral c_lit = self._this_ptr.new_variable(decision)
        lit = to_literal(c_lit)
        self.__var_list.append(lit)
        return lit

    ### @brief 条件リテラルを設定する．
    ### @param[in] args リテラルのリスト
    def set_conditional_literals(SatSolver self, *args) :
        cdef vector[CXX_SatLiteral] c_lits
        for arg in args :
            if isinstance(arg, SatLiteral) :
                c_lits.push_back(from_literal(arg))
            else :
                for lit in arg :
                    c_lits.push_back(from_literal(lit))
        self._this_ptr.set_conditional_literals(c_lits)

    ### @brief 条件リテラルの設定を解除する．
    def clear_conditional_literals(SatSolver self) :
        self._this_ptr.clear_conditional_literals()

    ### @brief 節を追加する．
    ### @param[in] args リテラルのリスト
    def add_clause(SatSolver self, *args) :
        cdef vector[CXX_SatLiteral] c_lits
        for arg in args :
            if isinstance(arg, SatLiteral) :
                c_lits.push_back(from_literal(arg))
            else :
                for lit in arg :
                    c_lits.push_back(from_literal(lit))
        self._this_ptr.add_clause(c_lits)

    ### @brief 問題を解く．
    ### @param[in] assumptions 仮定(Literal)のリスト
    ### @param[in] time_limit 時間制約(秒) 0 で制約なし
    ### @return stat, model を返す．
    ###
    ### - stat は結果を表す3値(SatBool3)
    ### - model は変数(SatLiteral)をキーにしてその変数の値(SatBool3)を保持する辞書
    ###
    ### 変数の値の型は3値だが常に真(SatBool3.TRUE)か偽(SatBool3.FALSE)となる．
    def solve(SatSolver self, *, assumptions = None, time_limit = 0) :
        cdef vector[CXX_SatLiteral] c_assumptions
        cdef vector[CXX_SatLiteral] c_conflicts
        cdef CXX_SatBool3 c_stat
        cdef CXX_SatLiteral c_lit
        cdef CXX_SatBool3 c_val
        cdef int i, n
        if assumptions :
            c_assumptions.reserve(len(assumptions))
            for lit in assumptions :
                c_assumptions.push_back(from_literal(lit))
        c_stat = self._this_ptr.solve(c_assumptions, time_limit)
        stat = to_SatBool3(c_stat)
        model = None
        if stat == SatBool3.TRUE :
            n = self._this_ptr.model_size()
            model = dict()
            for lit in self.__var_list :
                c_lit = from_literal(lit)
                c_val = self._this_ptr.read_model(c_lit)
                val = to_SatBool3(c_val)
                model[ lit] =  val
                model[~lit] = ~val
        elif stat == SatBool3.FALSE :
            conflicts = []
            #for c_lit in self._this_ptr.conflict_literals() :
            #    conflicts.append(to_literal(c_lit))
        return stat, model

    ### @brief solve() を中止する．
    def stop(SatSolver self) :
        self._this_ptr.stop()

    ### @brief 時間計測を制御する．
    ### @param[in] enable True の時に時間計測を行う．
    def timer_on(SatSolver self, bool enable) :
        self._this_ptr.timer_on(enable)

    ### @brief 矛盾回数の制限値を設定する．
    ### @param[in] limit 制限値
    ### @return 以前の制限値を返す．
    def set_max_conflict(SatSolver self, int limit) :
        return self._this_ptr.set_max_conflict(limit)

    ### @brief 正常な状態なら True を返す．
    def sane(SatSolver self) :
        return self._this_ptr.sane()

    ### @brief 統計情報を得る．
    ### @return Stats を返す．
    def get_stats(SatSolver self) :
        cdef CXX_SatStats c_stats
        self._this_ptr.get_stats(c_stats)
        return to_stats(c_stats)

    ### @brief 変数の数を返す．
    def variable_num(SatSolver self) :
        return self._this_ptr.variable_num()

    ### @brief 節の数を返す．
    def clause_num(SatSolver self) :
        return self._this_ptr.clause_num()

    ### @brief リテラルの数を返す．
    def literal_num(SatSolver self) :
        return self._this_ptr.literal_num()
