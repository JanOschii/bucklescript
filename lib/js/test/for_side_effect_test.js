// GENERATED CODE BY BUCKLESCRIPT VERSION 0.8.1 , PLEASE EDIT WITH CARE
'use strict';

var Mt    = require("./mt");
var Block = require("../block");

function tst() {
  for(var i = (console.log("hi"), 0) ,i_finish = (console.log("hello"), 3); i <= i_finish; ++i){
    
  }
  return /* () */0;
}

function test2() {
  var v = 0;
  v = 3;
  v = 10;
  for(var i = 0; i <= 1; ++i){
    
  }
  return v;
}

var suites_000 = /* tuple */[
  "for_order",
  function () {
    return /* Eq */Block.__(0, [
              10,
              test2(/* () */0)
            ]);
  }
];

var suites = /* :: */[
  suites_000,
  /* [] */0
];

Mt.from_pair_suites("for_side_effect_test.ml", suites);

exports.tst    = tst;
exports.test2  = test2;
exports.suites = suites;
/*  Not a pure module */
