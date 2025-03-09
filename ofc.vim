" Plugin para generar headers y definiciones de clases en C++ (Orthodox Canonical Form)
let s:length = 80
let s:margin = 5

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

	" Incluir la cabecera
	call append(12, "")
	call append(13, '#include "' . l:header . '.hpp"')
	call append(14, "")

	" Constructor
	call append(15, l:classname . "::" . l:classname . "() {")
	call append(16, "	// Constructor por defecto")
	call append(17, "}")
	call append(18, "")

	" Constructor de copia
	call append(19, l:classname . "::" . l:classname . "(const " . l:classname . " &other) {")
	call append(20, "	// Constructor de copia")
	call append(21, "	*this = other;")
	call append(22, "}")
	call append(23, "")

	" Operador de asignación
	call append(24, l:classname . "& " . l:classname . "::operator=(const " . l:classname . " &other) {")
	call append(25, "	// Operador de asignación")
	call append(26, "	if (this != &other) {")
	call append(27, "		// Copiar los atributos necesarios")
	call append(28, "	}")
	call append(29, "	return *this;")
	call append(30, "}")
	call append(31, "")

	" Destructor
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

" Crear el comando y el atajo de teclado
command! OcfHeader call OcfHeader()
map <F2> :OcfHeader<CR>
