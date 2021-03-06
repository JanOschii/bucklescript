(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)











external function_length : 'a -> int = "js_function_length" 

external apply1 : 
    ('a -> 'b) -> 'a -> 'b
    = "js_apply1"
external apply2 :
        ('a -> 'b -> 'c) -> 'a -> 'b -> 'c  
    = "js_apply2"

external apply3 : 
            ('a -> 'b -> 'c -> 'd)
          -> 'a -> 'b -> 'c -> 'd  
    = "js_apply3"

external apply4 : 
              ('a -> 'b -> 'c -> 'd -> 'e)
            -> 'a -> 'b -> 'c -> 'd -> 'e
    = "js_apply4"

external apply5 : 
                ('a -> 'b -> 'c -> 'd -> 'e -> 'f )
              -> 'a -> 'b -> 'c -> 'd -> 'e -> 'f = 
  "js_apply5"

external apply6 : 
                  ('a -> 'b -> 'c -> 'd -> 'e ->  'f -> 'g ) 
                -> 'a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'g = 
                  "js_apply6"


external apply7 : 
                    ('a -> 'b -> 'c -> 'd -> 'e ->  'f -> 'g -> 'h ) 
                  -> 'a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'g -> 'h = 
      "js_apply7"


external apply8 : 
                      ('a -> 'b -> 'c -> 'd -> 'e ->  'f -> 'g -> 'h -> 'i) 
                    -> 'a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'g -> 'h -> 'i = 
                      "js_apply8"

external apply_args : 
                        ('a -> 'b) -> _ array -> 'b = "js_apply"



external sub : 'a array -> int -> int -> 'a array = "caml_array_sub"

let rec app f args = 
  let arity = function_length f in
  let arity = if arity = 0 then 1 else arity in (* TOOD: optimize later *) 
  let len = Array.length args in
  let d = arity - len in 
  if d = 0 then 
    apply_args f  args (**f.apply (null,args) *)
  else if d < 0 then 
    (** TODO: could avoid copy by tracking the index *)
    app (Obj.magic (apply_args f (sub args 0 arity)))
      (sub args arity (-d))
  else 
    Obj.magic (fun x -> app f (Caml_array.append args [|x|] ))

(* Generated code 
   [if/else]
   Here it would be nice to just generate 
   [switch .. default]
 *)
let curry1 o x arity = 
  (match arity with 
  | 0 -> apply1 (Obj.magic o) x  
  | 1 -> apply1 (Obj.magic o) x 
  | 2 ->  apply2 (Obj.magic o) x 
  | 3 -> apply3 (Obj.magic o) x
  | 4 ->  apply4 (Obj.magic o) x 
  | 5 -> apply5 (Obj.magic o) x
  | 6 -> apply6 (Obj.magic o) x 
  | 7 -> apply7 (Obj.magic o) x 
  | _ -> (fun a -> app o [|x; a |]))



(** in practice we can unify 
    {[_1, _2, _3 ]} into a single function 
    {[_]}, however, it might slow down a bit 
*)
let _1 o x = 
  let len = function_length o in
  if len = 1 || len = 0 then apply1 o x 
  else Obj.magic (curry1 o x len )

  
let _2 o x y = 
  let len = function_length o in 
  if len = 2 then apply2 o  x y
  else Obj.magic (app o [|x; y|])



let _3 o a0 a1 a2 =  
  let len = function_length o in 
  if len = 3 then apply3 o a0 a1 a2 
  else 
    Obj.magic (app o [|a0;a1;a2|])


let _4 o a0 a1 a2 a3 =  
  let len = function_length o in 
  if len = 4 then apply4 o a0 a1 a2 a3
  else 
    Obj.magic (app o [|a0;a1;a2; a3 |])

let _5 o a0 a1 a2 a3 a4 =  
  let len = function_length o in 
  if len = 5 then apply5 o a0 a1 a2 a3 a4
  else 
    Obj.magic (app o [|a0;a1;a2; a3; a4 |])


let _6 o a0 a1 a2 a3 a4 a5  =  
  let len = function_length o in 
  if len = 6 then apply6 o a0 a1 a2 a3 a4 a5
  else 
    Obj.magic (app o [|a0;a1;a2; a3; a4; a5 |])

let _7 o a0 a1 a2 a3 a4 a5 a6 =  
  let len = function_length o in 
  if len = 7 then apply7 o a0 a1 a2 a3 a4 a5 a6 
  else 
    Obj.magic (app o [|a0;a1;a2; a3; a4; a5; a6 |])

let _8 o a0 a1 a2 a3 a4 a5 a6 a7  =  
  let len = function_length o in 
  if len = 8 then apply8 o a0 a1 a2 a3 a4 a5 a6 a7 
  else 
    Obj.magic (app o [|a0;a1;a2; a3; a4; a5; a6; a7|])

(** For efficiency, [args.(0)] would contain obj as well  *)
let js label cacheid obj args = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  app meth args


(* example like [x#hi] *)
let js1   label cacheid obj = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _1 meth obj 

let js2   label cacheid obj a1 = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _2 meth obj a1 

let js3  label cacheid obj  a1 a2 = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _3 meth obj a1 a2

let js4  label cacheid obj a1 a2 a3 = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _4 meth obj a1 a2 a3 


let js5  label cacheid obj a1 a2 a3 a4 = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _5 meth obj a1 a2 a3 a4

let js6  label cacheid obj a1 a2 a3 a4 a5 = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _6 meth obj a1 a2 a3 a4 a5

let js7  label cacheid obj a1 a2 a3 a4 a5 a6= 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _7 meth obj a1 a2 a3 a4 a5 a6

let js8  label cacheid obj a1 a2 a3 a4 a5 a6 a7 = 
  let meth = 
    (Obj.magic Caml_oo.caml_get_public_method obj label cacheid) in
  _8 meth obj a1 a2 a3 a4 a5 a6 a7 






