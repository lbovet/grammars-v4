/*
BSD License

Copyright (c) 2022, Tom Everett
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of Tom Everett nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
grammar flowmatic;

flowmatic
   : line* '(' 'END' ')' EOF
   ;

line
   : label statement (';' statement)* '.'
   ;

label
   : '(' NUM ')'
   ;

statement
   : (closeout_statement | test_statement | set_statement | move_statement | compare_statement | otherwise_statement | stop_statement | rewind_statement | transfer_statement | writeitem_statement | jumpto_statement | readitem_statement | input_statement | hsp_statement | output_statement | if_statement)*
   ;

hsp_statement
   : 'HSP' fileletter
   ;

output_statement
   : 'OUTPUT' (filename fileletter)+
   ;

input_statement
   : 'INPUT' (filename fileletter)+
   ;

jumpto_statement
   : 'JUMP' 'TO' 'OPERATION' NUM
   ;

readitem_statement
   : 'READ-ITEM' var
   ;

writeitem_statement
   : 'WRITE-ITEM' var
   ;

transfer_statement
   : 'TRANSFER' var 'TO' var
   ;

if_statement
   : 'IF' op GOTO 'OPERATION' NUM
   ;

otherwise_statement
   : 'OTHERWISE' GOTO 'OPERATION' NUM
   ;

rewind_statement
   : 'REWIND' var
   ;

stop_statement
   : 'STOP'
   ;

compare_statement
   : 'COMPARE' var '(' ID ')' 'WITH' var '(' ID ')'
   ;

move_statement
   : 'MOVE' var '(' ID ')' 'TO' var '(' ID ')'
   ;

set_statement
   : 'SET' 'OPERATION' NUM 'TO' GOTO 'OPERATION' NUM
   ;

test_statement
   : 'TEST' var '(' ID ')' 'AGAINST'
   ;

closeout_statement
   : 'CLOSE-OUT' 'FILES' fileletter (';' fileletter)*
   ;

filename
   : ID
   ;

fileletter
   : ID
   ;

var
   : ID
   ;

op
   : 'EQUAL'
   | 'GREATER'
   | EOD
   ;

GOTO
   : 'GO TO'
   ;

EOD
   : 'END OF DATA'
   ;

ID
   : [a-zA-Z-]+
   ;

NUM
   : [0-9]+
   ;

WS
   : [ \r\n\t]+ -> skip
   ;

