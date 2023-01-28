
c_module "icu-i18n" {

-- enable FFI bindings support.
luajit_ffi = true,

-- load ICU shared library.
ffi_load"icu-i18n",

include "icu-i18n.h",

subfiles {
"src/object.nobj.lua",
},
}

