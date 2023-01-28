c_module "icu" {

  -- enable FFI bindings support.
  luajit_ffi = true,

  -- load ICU shared library.
  ffi_load "icui18n",

  include "unicode/ustring.h",

  subfiles {
    "src/ustring.nobj.lua",
  },
}

