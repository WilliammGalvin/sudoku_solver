open Base

module Vector : sig
  type t [@@deriving sexp]

  (* construction / conversion *)
  val of_list : int list -> t
  val to_list : t -> int list

  (* queries *)
  val length : t -> int
  val is_empty : t -> bool

  (* transforms *)
  val map : t -> f:(int -> int) -> t
  val map2 : t -> t -> f:(int -> int -> int) -> t Or_error.t

  (* algebra *)
  val add : t -> t -> t Or_error.t
  val sub : t -> t -> t Or_error.t
  val scale : int -> t -> t
  val dot : t -> t -> int Or_error.t

  (* norms / distances *)
  val norm2 : t -> int
  val norm : t -> float
  val dist : t -> t -> float Or_error.t

  (* predicates *)
  val equal_length : t -> t -> bool
  val is_zero : t -> bool
  val all : t -> f:(int -> bool) -> bool
  val exists : t -> f:(int -> bool) -> bool

  (* reductions *)
  val sum : t -> int
  val min : t -> int Or_error.t
  val max : t -> int Or_error.t

  (* slicing *)
  val take : t -> n:int -> t Or_error.t
  val drop : t -> n:int -> t Or_error.t
  val slice : t -> pos:int -> len:int -> t Or_error.t

  (* formatting *)
  val to_string : t -> string
end

module Matrix : sig
  type t [@@deriving sexp]

  (* construction / conversion *)
  val of_lists : int list list -> t Or_error.t
  val to_lists : t -> int list list
  val identity : int -> t Or_error.t
  val init : rows:int -> cols:int -> f:(int -> int -> int) -> t Or_error.t

  (* dimensions *)
  val dims : t -> int * int
  val rows : t -> int
  val cols : t -> int
  val is_empty : t -> bool

  (* predicates (shape / structure) *)
  val is_rectangular : t -> bool
  val is_square : t -> bool
  val is_symmetric : t -> bool
  val is_diagonal : t -> bool
  val is_identity : t -> bool
  val equal_dims : t -> t -> bool

  (* structural transforms *)
  val transpose : t -> t Or_error.t
  val map : t -> f:(int -> int) -> t
  val map2 : t -> t -> f:(int -> int -> int) -> t Or_error.t

  (* row / column access & replacement *)
  val row : t -> i:int -> Vector.t Or_error.t
  val col : t -> j:int -> Vector.t Or_error.t
  val set_row : t -> i:int -> Vector.t -> t Or_error.t
  val set_col : t -> j:int -> Vector.t -> t Or_error.t

  (* algebra with vectors *)
  val mul_vec : t -> Vector.t -> Vector.t Or_error.t

  (* algebra with matrices *)
  val add : t -> t -> t Or_error.t
  val sub : t -> t -> t Or_error.t
  val scale : int -> t -> t
  val mul : t -> t -> t Or_error.t
  val hadamard : t -> t -> t Or_error.t

  (* reductions / metrics *)
  val trace : t -> int Or_error.t
  val frobenius_norm2 : t -> int
  val frobenius_norm : t -> float

  (* small determinants *)
  val det2 : t -> int Or_error.t
  val det3 : t -> int Or_error.t

  (* slicing / submatrices *)
  val slice_rows : t -> pos:int -> len:int -> t Or_error.t
  val slice_cols : t -> pos:int -> len:int -> t Or_error.t
  val minor : t -> i:int -> j:int -> t Or_error.t

  (* formatting *)
  val to_string : t -> string
end