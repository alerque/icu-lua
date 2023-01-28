package "ustring" {
  -- ffi_cdef[[typedef struct u_strlen]],
  constructor {
    c_call "u_strlen"
  }
}
