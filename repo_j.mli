(* Auto-generated from "repo.atd" *)


type repo = Repo_t.repo = { id: int; name: string }

val write_repo :
  Bi_outbuf.t -> repo -> unit
  (** Output a JSON value of type {!repo}. *)

val string_of_repo :
  ?len:int -> repo -> string
  (** Serialize a value of type {!repo}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_repo :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> repo
  (** Input JSON data of type {!repo}. *)

val repo_of_string :
  string -> repo
  (** Deserialize JSON data of type {!repo}. *)

