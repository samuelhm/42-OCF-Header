# Vim Header Generator (Modified)

Este es un plugin de Vim basado en el trabajo original de [gicamerl](https://42.fr).  
Se ha modificado para generar archivos `.hpp` y `.cpp` con la Orthodox Canonical Form en C++.

## 🚀 Características
- Inserta automáticamente un **header** en `.hpp` y `.cpp`.
- Genera clases con la **Orthodox Canonical Form** en archivos `.hpp`.
- Crea la implementación de la clase en archivos `.cpp` con el `#include` correspondiente.
- Compatible con **Vim y Neovim**.

## 🛠 Instalación
Para instalar el plugin, copia el archivo **`ocf_header.vim`** en la carpeta de plugins de Vim:

```bash
mkdir -p ~/.vim/plugin
cp ocf_header.vim ~/.vim/plugin/
```

Para **Neovim**, colócalo en:
```bash
mkdir -p ~/.config/nvim/plugin
cp ocf_header.vim ~/.config/nvim/plugin/
```

## 🖥️ Uso
Puedes ejecutar el plugin de dos maneras:

1. **Atajo de teclado**:  
   - Pulsa **`fd`** en modo normal para generar automáticamente el header y la clase en archivos `.hpp` o la implementación en `.cpp`.

2. **Comando manual**:  
   - Escribe `:OcfHeader` y presiona `Enter`.

### 📌 Ejemplo en `.hpp`
Si creas un archivo **`WrongCat.hpp`** y ejecutas `:OcfHeader`, se generará:

```cpp
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   WrongCat.hpp                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tu_usuario <tu_email>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/09 12:00:00 by tu_usuario        #+#    #+#             */
/*   Updated: 2025/03/09 12:00:00 by tu_usuario       ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef WRONGCAT_HPP
#define WRONGCAT_HPP

class WrongCat {
	public:
		WrongCat();
		WrongCat(const WrongCat &other);
		WrongCat& operator=(const WrongCat &other);
		~WrongCat();
};

#endif
```

### 📌 Ejemplo en `.cpp`
Si creas un archivo **`WrongCat.cpp`** y ejecutas `:OcfHeader`, se generará:

```cpp
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   WrongCat.cpp                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tu_usuario <tu_email>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/09 12:00:00 by tu_usuario        #+#    #+#             */
/*   Updated: 2025/03/09 12:00:00 by tu_usuario       ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "WrongCat.hpp"

WrongCat::WrongCat() {
	// Constructor por defecto
}

WrongCat::WrongCat(const WrongCat &other) {
	// Constructor de copia
	*this = other;
}

WrongCat& WrongCat::operator=(const WrongCat &other) {
	// Operador de asignación
	if (this != &other) {
		// Copiar los atributos necesarios
	}
	return *this;
}

WrongCat::~WrongCat() {
	// Destructor
}
```

## 📝 Licencia
Este código es una modificación de un trabajo originalmente publicado por gicamerl bajo dominio público.  
Puedes usarlo, modificarlo y distribuirlo libremente.

## ✨ Contribuciones
¡Las contribuciones son bienvenidas! Si tienes mejoras, siéntete libre de abrir un **Pull Request**.
