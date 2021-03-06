#!/usr/bin/env ocaml
#directory "pkg";;
#use "topkg.ml";;
#use "config.ml";;

let () =
  let exts = List.filter ((<>) (`Ext ".mli")) Exts.module_library in
  Vars.subst_file ~skip:Config.subst_skip ~vars:Config.vars "pkg/META" >>& fun () ->
  Vars.subst_file ~skip:Config.subst_skip ~vars:Config.vars "lib/version.ml" >>& fun () ->
  Pkg.describe "shcaml" ~builder:(`OCamlbuild []) [
    Pkg.lib "pkg/META";
    Pkg.lib ~exts "shcaml";
    Pkg.lib ~exts "shcaml_top";
    Pkg.lib "shcaml_top_init.ml"; ]
