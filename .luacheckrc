std = "min"
include_files = {
  "spec/*.lua",
  "*.rockspec",
  ".busted",
  ".luacov",
  ".luacheckrc"
}
files["spec"] = {
	std = "+busted"
}
max_line_length = false
