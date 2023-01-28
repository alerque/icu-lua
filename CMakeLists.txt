#
# Lua bindings for libicu
#
cmake_minimum_required(VERSION 3.0)

project(lua-icu C)

set(BUILD_SHARED_LIBS TRUE)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(INSTALL_CMOD share/lua/cmod CACHE PATH "Directory to install Lua binary modules (configure lua via LUA_CPATH)")

set(COMMON_CFLAGS "${CFLAGS}")
set(COMMON_LDFLAGS)
set(COMMON_LIBS)

## Lua 5.1.x
include(FindLua51)
if(NOT ${LUA51_FOUND})
    message(FATAL_ERROR "The FindLua51 module could not find lua :-(")
endif()
set(COMMON_LIBS "${COMMON_LIBS};${LUA_LIBRARIES}")

## LibIcu
include(FindPkgConfig)
pkg_search_module(ICU REQUIRED libicu)
set(COMMON_CFLAGS "${COMMON_CFLAGS} ${ICU_CFLAGS}")
set(COMMON_LDFLAGS "${COMMON_LDFLAGS} ${ICU_LDFLAGS}")
set(COMMON_LIBS "${COMMON_LIBS};${ICU_LIBRARIES}")

## LuaNativeObjects
include(LuaNativeObjects)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}
                    ${CMAKE_CURRENT_BINARY_DIR}
                    ${LUA_INCLUDE_DIR})

## LuaIcu
set(LUA_ICU_SRC
	icu.nobj.lua
)

if(${USE_PRE_GENERATED_BINDINGS})
	set(LUA_ICU_SRC src/pre_generated-icu.nobj.c)
else()
	# Generate Lua bindings.
	GenLuaNativeObjects(LUA_ICU_SRC)
endif()

add_library(lua-icu MODULE ${LUA_ICU_SRC})
target_link_libraries(lua-icu ${COMMON_LIBS})
set_target_properties(lua-icu PROPERTIES PREFIX "")
set_target_properties(lua-icu PROPERTIES COMPILE_FLAGS "${COMMON_CFLAGS}")
set_target_properties(lua-icu PROPERTIES OUTPUT_NAME icu)

install(TARGETS lua-icu
        DESTINATION "${INSTALL_CMOD}")

