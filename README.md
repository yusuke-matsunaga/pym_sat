# pym_sat

<div style="text-align:right;">
松永 裕介
</div>


## 1. はじめに

pym_sat はSATソルバをPython3から呼び出すためのパッケージです．
内部ではc++で書かれたSATソルバのクラスライブラリをcythonを用いて呼び出
しています．


## 2. 使い方

まず，プログラムの先頭で以下のようにpym_satをインポートします．

```python
import pym_sat
```

pym_sat には以下のようなクラスが定義してあります．

* SatBool3 : true/false の他に X(不定)を定義した3値の列挙型．
* SatLiteral : 論理式のリテラル(変数と変数の否定)を表すクラス
* SatSolver : SATソルバ本体
* SatSolverType : SATソルバのタイプを記述するクラス
* SatStats : SATソルバの統計データを持つクラス
* SatBvEnc : bit-vector の符号化を行うクラス
* SatCountEnc : 計数回路の符号化を行うクラス
* SatTseitinEnc : Tseitinの符号化を行うクラス


### 2.1 簡単な使い方

基本的には SatSolver のインスタンスを生成し，
SatSolver.add_clause() 関数を用いてリテラルの集合(CNF節)を追加していくことで問題の論理式を作成し，
SatSolver.solve() 関数で解を求めます．

リテラルは変数もしくはその否定で，変数は実際には整数で表されますが，
SatSolver が関知していない整数値を勝手に使われては困るので，
SatSolver.new_variable() 関数で変数を確保してからその値を使うようになっ
ています．

簡単なSAT問題を解くプログラムを以下に示します．

```python
import pym_sat

sol = pym_sat.SatSolver()

# v1 の型は pym_sat.SatLiteral
v1 = sol.new_variable()
v2 = sol.new_variable()
v3 = sol.new_variable()

# (v1 or ~v2) という節を加える．
# '~' は否定演算子
sol.add_clause(v1, ~v2)

tmp_list = [ ~v1, v3 ]
# リテラルのリストも受け付ける．
sol.add_clause(tmp_list)

# 解を求める．
ans, model = sol.solve()

# ans は SatBool3.TRUEのはず．
# model はこの論理式を充足する変数割り当てを表す辞書が入る．
# キーは SatLiteral
# たとえば
# model[v1] = SatBool3.FALSE
# model[v2] = SatBool3.FALSE
# model[v3] = SatBool3.TRUE
# となる．この値はSATソルバの実装によって異なる．
```

### 2.2 各クラスの詳細

#### 2.2.1 SatBool3

ブール値を表すクラス．Python3 の列挙型 enum.Enum の継承クラス

定義されている値は以下の３つ．

* X: 不定値を表す．
* TRUE: 真を表す．
* FALSE: 偽を表す．

SatBool3 に対して定義されている演算は以下の通り．

* ~: 否定演算子．TRUE と FALSE を入れ替える．Xを否定しても結果はXとなる．
* negate(): 否定演算子の別名．

SatBool3 に関するプログラム例は以下の通り．

~~~Python
 a = SatBool3.TRUE
 b = ~a
 # b は SatBool3.FALSE
 c = SatBool3.X
 d = c.negate()
 # c は SatBool3.X
~~~

本来は論理積(AND)や論理和(OR)演算を定義するべきだがここでは定義していない．

#### 2.2.2 SatLiteral

論理式のリテラルを表すクラス．リテラルとは命題変数そのものとその否定．
意味のある値を持つSatLiteralはSatSolver.new_variable()の結果としてしか作ることはできない．

定義されている関数は以下の通り．

* SatLiteral(): 初期化．内容は不正な値となる．
* is_valid: 適正な値を持っている時に True を返す．この関数は
  @property 宣言されているので呼ぶ時に () は要らない．
* varid: 変数番号を返す．この関数は
  @property 宣言されているので呼ぶ時に () は要らない．
* is_positive: 正のリテラルのときに True を返す．この関数は
  @property 宣言されているので呼ぶ時に () は要らない．
* is_negative: 負のリテラルのときに True を返す．この関数は
  @property 宣言されているので呼ぶ時に () は要らない．
* make_positive(): 変数番号が同じで正のリテラルを返す．
* make_nagative(): 変数番号が同じで負のリテラルを返す．
* ~: 否定演算子．変数番号が同じで極性が反対のリテラルを返す．
* ==: 等価比較演算子．同じ内容の場合に True を返す．

このクラスはハッシュ関数も定義してあるので set() や dict() のキーとして用いることができる．


#### 2.2.2 SatSolverType

SATソルバーの種類を表すためのクラス．SatSolver の初期化の引数として用いる．

定義されている関数は以下の通り．

* SatSolverType(sat_type, sat_option): 初期化を行う．sat_type と
  sat_option はともに文字列．
  sat_type として有効な値は値は以下の通り．

  - 'minisat': MiniSat
  - 'minisat2': MiniSat2
  - 'glueminisat2': glueminisat2
  - 'lingeling': lingeling
  - 'ymsat2': YmSat

  sat_option は sat_type に応じて意味のある値が変わる．現時点では使用していない．

* type(): 初期化時の引数 sat_type の値を返す．

* option(): 初期化時の引数 sat_option の値を返す．


#### 2.2.3 SatSolver

SATソルバー本体を表すクラス．

定義されている関数は以下の通り．

* SatSolver(solver_type): 初期化．solver_type にソルバの型を指定する．省略時には適当なSATソルバが用いられる．

* type: SATソルバの型(SatSolverType)を返す．この関数は@property宣言されているので呼ぶ時に()は要らない．

* new_variable(decision = True): 新たな変数を確保し，その変数(リテラル)を返す．
  decision は決定変数の場合に True とする．lingeling を用いる時は
  decision が True でない変数は内部の最適化の結果，削除されることがある．

* set_conditional_literals(args): 条件リテラルをセットする．命題論理に
  おける A -> b (AならばB)は ~A or B なので，CNF節としては節の前半に
  ~A を表すリテラルが
