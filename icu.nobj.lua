
c_module "icu" {

-- enable FFI bindings support.
luajit_ffi = true,

-- load ICU shared library.
ffi_load"icu",

include "icu.h",

subfiles {
"src/object.nobj.lua",
},
}

