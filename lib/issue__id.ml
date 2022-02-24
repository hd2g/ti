module type Monad = sig
  type 'a t

  val return : 'a -> 'a t
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t
end

module type State = sig
  type t

  val empty : t
end

module type State_monad = functor (State : State) -> sig
  include Monad

  val run : 'a t -> 'a
  val get : State.t t
  val put : State.t -> unit t
end

module State_monad : State_monad = functor (State : State) -> struct
  type state = State.t

  type 'a t = state -> ('a * state)

  let return x state = (x, state)

  let bind m f state =
    let (a, state') = m state in
    f a state'

  let ( >>= ) = bind

  let run m = m State.empty |> function x, _state -> x

  let get state = (state, state)

  let put state _state = ((), state)
end

module Id_state = State_monad(struct
  type t = int

  let empty = 0
end)

type t

let create () = Id_state.return @@ Ulid.encode_time (Unix.time () |> int_of_float)
