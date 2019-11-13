
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

add_subdirectory ( debug )


# ===================================================================
#  ソースファイルの設定
# ===================================================================


# ===================================================================
# ターゲットの設定
# ===================================================================


# ===================================================================
#  cython 用のソースファイルの設定
# ===================================================================

set ( CYTHON_SOURCES
  ${PROJECT_SOURCE_DIR}/ym-sat/cython-src/pym_sat.pyx
  )

set_source_files_properties (
  ${CYTHON_SOURCES}
  PROPERTIES CYTHON_IS_CXX TRUE
  )


# ===================================================================
#  module ターゲットの設定
# ===================================================================

cython_add_module ( pym_sat
  ${CYTHON_SOURCES}
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
  ${CYTHON_SOURCES}
  ${YM_SUBMODULE_OBJ_D_LIST}
  )

target_compile_options ( pym_sat_d
  PRIVATE "-g"
  )

target_link_libraries ( pym_sat_d
  ${YM_LIB_DEPENDS}
  )

add_custom_command (
  TARGET pym_sat_d
  POST_BUILD
  COMMAND ${CMAKE_COMMAND}
  ARGS -E copy $<TARGET_FILE:pym_sat_d> ${CMAKE_CURRENT_BINARY_DIR}/debug/pym_sat.so
  )


# ===================================================================
#  テストの設定
# ===================================================================


# ===================================================================
#  インストールターゲットの設定
# ===================================================================

install ( TARGETS pym_sat
  DESTINATION "${YM_PYTHON_LIBDIR}"
  )
