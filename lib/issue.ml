module Id = Issue__id
module Action = Issue__action
module Author = Issue__author
module Message = Issue__message
module Tag = Issue__tag
module Timestump = Issue__timestump

type t =
  { id : Id.t
  ; author : Author.t
  ; action : Action.t
  ; tags : Tag.t list
  ; messages : Message.t list
  ; timestump : Timestump.t
  }
