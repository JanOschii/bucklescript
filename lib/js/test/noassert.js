// GENERATED CODE BY BUCKLESCRIPT VERSION 0.8.1 , PLEASE EDIT WITH CARE
'use strict';

var Caml_builtin_exceptions = require("../caml_builtin_exceptions");

function f() {
  throw [
        Caml_builtin_exceptions.assert_failure,
        [
          "noassert.ml",
          5,
          11
        ]
      ];
}

function h() {
  return 0;
}

exports.f = f;
exports.h = h;
/* No side effect */
