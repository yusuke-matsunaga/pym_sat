# ===================================================================
# CMAKE のおまじない
# ===================================================================
cmake_minimum_required (VERSION 3.2)


# C++14 の指定
set (CMAKE_CXX_STANDARD 14)


# ===================================================================
# プロジェクト名，バージョンの設定
# ===================================================================
set ( YM_VERSION_MAJOR 1 )
set ( YM_VERSION_MINOR 0 )
set ( YM_VERSION ${YM_VERSION_MAJOR}.${YM_VERSION_MINOR} )
project ( pym_sat VERSION "${YM_VERSION}" )

set ( YM_PROJECT_STRING "${PROJECT_NAME}-${PROJECT_VERSION}" )

# インストール先
set ( CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/stage" )


# ===================================================================
# オプション
# ===================================================================


# ===================================================================
# パッケージの検査
# ===================================================================
list ( APPEND CMAKE_MODULE_PATH
  "${PROJECT_SOURCE_DIR}/ym-common/cmake"
  )

include (YmUtils)


# ===================================================================
# ym-base で用いるサードパーティライブラリの検査
# ===================================================================
ym_init ( "" )
ym_init_python ( REQUIRED )
ym_init_cython ()
ym_init_doxygen ()
ym_init_gperftools ()
ym_init_ctest ()


# ===================================================================
# google-test は内蔵のものを使う．
# ===================================================================
ym_use_gtest ()


# ===================================================================
# ヘッダファイルの生成
# ===================================================================


# ===================================================================
# スクリプトファイルの生成
# ===================================================================

configure_file(
  "${PROJECT_SOURCE_DIR}/etc/ym_python.in"
  "${PROJECT_BINARY_DIR}/ym_python"
  @ONLY
  )

install ( PROGRAMS ${PROJECT_BINARY_DIR}/ym_python
  DESTINATION bin
  )


# ===================================================================
# サブモジュールのリスト
# ===================================================================

ym_init_submodules (
  ym-base
  ym-common
  ym-sat
  )


# ===================================================================
# インクルードパスの設定
# ===================================================================
include_directories (
  ${PROJECT_BINARY_DIR}/include
  ${PROJECT_SOURCE_DIR}/include
  ${YM_SUBMODULE_INCLUDE_LIST}
  )


# ===================================================================
# サブディレクトリの設定
# ===================================================================

foreach ( dir ${YM_SUBMODULE_LIST} )
  add_subdirectory ( ${dir} )
endforeach ()

add_subdirectory ( cython-src )
#add_subdirectory ( py-test )


# ===================================================================
#  ソースファイルの設定
# ===================================================================

set_source_files_properties (
  cython-src/pym_sat.pyx
  cython-src/pym_sat_d.pyx
  PROPERTIES CYTHON_IS_CXX TRUE
  )


# ===================================================================
# ターゲットの設定
# ===================================================================

cython_add_module ( pym_sat
  cython-src/pym_sat.pyx
  ${YM_SUBMODULE_OBJ_LIST}
  )

target_compile_options ( pym_sat
  PRIVATE "-O3"
  )

target_compile_definitions ( pym_sat
  PRIVATE "-DNDEBUG"
  )

target_link_libraries ( pym_sat
  ${YM_LIB_DEPENDS}
  )


cython_add_module ( pym_sat_d
  cython-src/pym_sat_d.pyx
  ${YM_SUBMODULE_OBJ_D_LIST}
  )

target_compile_options ( pym_sat_d
  PRIVATE "-g"
  )

target_link_libraries ( pym_sat_d
  ${YM_LIB_DEPENDS}
  )


# ===================================================================
#  テストの設定
# ===================================================================


# ===================================================================
#  インストールターゲットの設定
# ===================================================================

install ( TARGETS pym_sat pym_sat_d
  DESTINATION "${YM_PYTHON_LIBDIR}"
  )
