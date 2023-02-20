(fn init []
  (do
    (set vim.g.sexp_filetypes (table.concat conf.lisp-langs ","))
    (set vim.g.sexp_mappings
         {:sexp_outer_list :af
          :sexp_inner_list :if
          :sexp_outer_top_list :aF
          :sexp_inner_top_list :iF
          :sexp_outer_string :as
          :sexp_inner_string :is
          :sexp_outer_element :ae
          :sexp_inner_element :ie
          :sexp_move_to_prev_bracket "[["
          :sexp_move_to_next_bracket "]]"
          :sexp_move_to_prev_element_head :B
          :sexp_move_to_next_element_head :W
          :sexp_move_to_prev_element_tail :gE
          :sexp_move_to_next_element_tail :E
          :sexp_round_head_wrap_list "<("
          :sexp_round_tail_wrap_list ">)"
          :sexp_square_head_wrap_list "<["
          :sexp_square_tail_wrap_list ">]"
          :sexp_curly_head_wrap_list "<{"
          :sexp_curly_tail_wrap_list ">}"
          :sexp_round_head_wrap_element "<W("
          :sexp_round_tail_wrap_element ">W)"
          :sexp_square_head_wrap_element "<W["
          :sexp_square_tail_wrap_element ">W]"
          :sexp_curly_head_wrap_element "<W{"
          :sexp_curly_tail_wrap_element ">W}"
          :sexp_insert_at_list_head :<I
          :sexp_insert_at_list_tail :>I
          :sexp_splice_list :dsf
          :sexp_convolute "<?"
          :sexp_raise_list :<rf
          :sexp_raise_element :<re
          :sexp_swap_list_backward :<F
          :sexp_swap_list_forward :>F
          :sexp_swap_element_backward :<E
          :sexp_swap_element_forward :>E
          :sexp_emit_head_element "("
          :sexp_emit_tail_element "()"
          :sexp_capture_prev_element "(("
          :sexp_capture_next_element "))"})))

{: init}
