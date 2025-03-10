let s:asciiart = [
			\"        :::      ::::::::",
			\"      :+:      :+:    :+:",
			\"    +:+ +:+         +:+  ",
			\"  +#+  +:+       +#+     ",
			\"+#+#+#+#+#+   +#+        ",
			\"     #+#    #+#          ",
			\"    ###   ########.fr    "
			\]

let s:start		= '/*'
let s:end		= '*/'
let s:fill		= '*'
let s:length	= 80
let s:margin	= 5

let s:types		= {
			\'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php':
			\['/*', '*/', '*'],
			\'\.htm$\|\.html$\|\.xml$':
			\['<!--', '-->', '*'],
			\'\.js$':
			\['//', '//', '*'],
			\'\.tex$':
			\['%', '%', '*'],
			\'\.ml$\|\.mli$\|\.mll$\|\.mly$':
			\['(*', '*)', '*'],
			\'\.vim$\|\vimrc$':
			\['"', '"', '*'],
			\'\.el$\|\emacs$':
			\[';', ';', '*'],
			\'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
			\['!', '!', '/']
			\}

function! s:filetype()
	let l:f = s:filename()

	let s:start	= '#'
	let s:end	= '#'
	let s:fill	= '*'

	for type in keys(s:types)
		if l:f =~ type
			let s:start	= s:types[type][0]
			let s:end	= s:types[type][1]
			let s:fill	= s:types[type][2]
		endif
	endfor

endfunction

function! s:ascii(n)
	return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 2 - strlen(a:right))

	return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n)
	if a:n == 1 || a:n == 11 " top and bottom line
		return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
	elseif a:n == 2 || a:n == 10 " blank line
		return s:textline('', '')
	elseif a:n == 3 || a:n == 5 || a:n == 7 " empty with ascii
		return s:textline('', s:ascii(a:n))
	elseif a:n == 4 " filename
		return s:textline(s:filename(), s:ascii(a:n))
	elseif a:n == 6 " author
		return s:textline("By: " . s:user() . " <" . s:mail() . ">", s:ascii(a:n))
	elseif a:n == 8 " created
		return s:textline("Created: " . s:date() . " by " . s:user(), s:ascii(a:n))
	elseif a:n == 9 " updated
		return s:textline("Updated: " . s:date() . " by " . s:user(), s:ascii(a:n))
	endif
endfunction

function! s:user()
	if exists('g:user42')
		return g:user42
	endif
	let l:user = $USER
	if strlen(l:user) == 0
		let l:user = "marvin"
	endif
	return l:user
endfunction

function! s:mail()
	if exists('g:mail42')
		return g:mail42
	endif
	let l:mail = $MAIL
	if strlen(l:mail) == 0
		let l:mail = "marvin@42.fr"
	endif
	return l:mail
endfunction

function! s:filename()
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:date()
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert()
	let l:line = 11

	" empty line after header
	call append(0, "")

	" loop over lines
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update()
	call s:filetype()
	if getline(9) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "Updated: "
		if &mod
			call setline(9, s:line(9))
		endif
		call setline(4, s:line(4))
		return 0
	endif
	return 1
endfunction

function! s:stdheader()
	if s:update()
		call s:insert()
	endif
endfunction

function! s:insert_header()
	let l:line = 11
	call append(0, "")
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:insert_class()
	let l:classname = substitute(expand("%:t"), '\..*$', '', '')
	let l:macro = toupper(l:classname) . "_HPP"

	call append(12, "")
	call append(13, "#ifndef " . l:macro)
	call append(14, "#define " . l:macro)
	call append(15, "")
	call append(16, "class " . l:classname . " {")
	call append(17, "	public:")
	call append(18, "		" . l:classname . "();")
	call append(19, "		" . l:classname . "(const " . l:classname . " &other);")
	call append(20, "		" . l:classname . "& operator=(const " . l:classname . " &other);")
	call append(21, "		~" . l:classname . "();")
	call append(22, "};")
	call append(23, "")
	call append(24, "#endif")
	call append(25, "")
endfunction

function! s:insert_cpp()
	let l:classname = substitute(expand("%:t"), '\..*$', '', '')
	let l:header = substitute(expand("%:t"), '\.cpp$', '.hpp', '')

	call append(12, "")
	call append(13, '#include "' . l:header . '"')
	call append(14, "")

	call append(15, l:classname . "::" . l:classname . "() {")
	call append(16, "	// Constructor por defecto")
	call append(17, "}")
	call append(18, "")

	call append(19, l:classname . "::" . l:classname . "(const " . l:classname . " &other) {")
	call append(20, "	// Constructor de copia")
	call append(21, "	*this = other;")
	call append(22, "}")
	call append(23, "")

	call append(24, l:classname . "& " . l:classname . "::operator=(const " . l:classname . " &other) {")
	call append(25, "	// Operador de asignación")
	call append(26, "	if (this != &other) {")
	call append(27, "		// Copiar los atributos necesarios")
	call append(28, "	}")
	call append(29, "	return *this;")
	call append(30, "}")
	call append(31, "")

	call append(32, l:classname . "::~" . l:classname . "() {")
	call append(33, "	// Destructor")
	call append(34, "}")
	call append(35, "")
endfunction

function! OcfHeader()
	if expand("%:e") == "hpp"
		call s:insert_header()
		call s:insert_class()
	elseif expand("%:e") == "cpp"
		call s:insert_header()
		call s:insert_cpp()
	else
		echo "Este comando solo funciona en archivos .hpp o .cpp"
	endif
endfunction

command! OcfHeader call OcfHeader()
map <F2> :OcfHeader<CR>
