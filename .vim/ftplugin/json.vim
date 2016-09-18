command! JsonMapToYank silent :%Yankitute/\([a-zA-Z_]\+\) -> [^ ]\{-}(\(.\{-}\))/\1 \2/g
" command! -nargs=? -range -register JsonMapToYank2 silent execute yankitute#execute('/\([a-zA-Z_]\{-} -> [^ ]\{-}(\(.\{-}\))/\1 \2/g', <line1>, <line2>, '<register>')
command! -nargs=1 -range JsonMapFieldToYank :%Yankitute/<args> -> [^ ]\{-}(\(.\{-}\))/\1 \2/g

