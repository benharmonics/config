"  __          __   __                  __
" |  \        |  \ |  \                |  \
"  \▓▓_______  \▓▓_| ▓▓_      __     __ \▓▓______ ____
" |  \       \|  \   ▓▓ \    |  \   /  \  \      \    \
" | ▓▓ ▓▓▓▓▓▓▓\ ▓▓\▓▓▓▓▓▓     \▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\
" | ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓ __     \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓
" | ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓|  \__   \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓
" | ▓▓ ▓▓  | ▓▓ ▓▓  \▓▓  ▓▓  \   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓
"  \▓▓\▓▓   \▓▓\▓▓   \▓▓▓▓ \▓▓    \▓    \▓▓\▓▓  \▓▓  \▓▓

lua require'init'

" pad line with filler character to a given length
function! PaddedComment(length = 70, fill = "-")
  let line = getline('.')
  " the regex removes comment delimiters, i.e. // or # or "
  let comment = substitute(line, '^["\|\#\|\/]*', '', '')
  let comment_i = stridx(line, comment)
  " collect the comment delimiters
  let prelude = line[:comment_i - 1]
  let start_width = col('$') - 1
  " pad evenly on both sides of comment to given length
  let padsize = (a:length - start_width - comment_i) / 2
  if padsize < 0
    let padsize = 0
  endif
  let pad = repeat(a:fill, padsize)
  " trim whitespace from collected comment
  let trimmed_comment = substitute(substitute(comment, '^  *', '', ''), '  *$', '', '')
  let new_line = prelude .. ' ' .. pad  .. ' ' .. trimmed_comment .. ' ' .. pad
  " replace every character in current line with new line
  .s/.*/\=new_line/
endfunc

command! -nargs=? Pad :call PaddedComment(<f-args>)

