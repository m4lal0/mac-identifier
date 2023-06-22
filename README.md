# MAC-identifier

[![GitHub top language](https://img.shields.io/github/languages/top/m4lal0/mac-identifier?logo=gnu-bash&style=for-the-badge)](#)
[![GitHub repo size](https://img.shields.io/github/repo-size/m4lal0/mac-identifier?logo=webpack&style=for-the-badge)](#)
[![Debian Supported](https://img.shields.io/badge/Debian-Supported-blue?style=for-the-badge&logo=debian)](#)
[![By](https://img.shields.io/badge/By-m4lal0-green?style=for-the-badge&logo=github)](#)

![Help-Panel](./images/helpPanel.png)

<h4 align="center">Script hecho en Bash para identificar el fabricante de direcciones MAC.</h4><br>

---

## Instalación
```bash
git clone https://github.com/m4lal0/mac-identifier
cd mac-identifier ; chmod +x mac-identifier.sh
./mac-identifier.sh
```

## ¿Cómo funciona la herramienta?
Tras ejecutar la herramienta, nos mostrará el panel de ayuda.

La herramienta cuenta con 3 parámetros:

* **-m** ó **--mac** : Lee una dirección MAC.
    + Usamos el parámetro **-m** ó **--mac** seguido como argumento la dirección MAC.

* **-f** ó **--file** :  Lee un archivo que tiene un listado de direcciones MAC.
    + Usamos el parámetro **-f** ó **--file** seguido como argumento la ruta y nombre del archivo.

* **-o** ó **--output** : Guarda el resultado en un archivo.
    + Usamos el parámetro **-o** ó **--output** seguido como argumento el nombre que queremos llamar a nuestro archivo.

* **-u** ó **--update** : Actualiza el archivo OUI.
    + Usamos el parámetro **-u** ó **--update** para actualizar la herramienta.


> *Al ejecutar por primera vez el script, descargará un archivo (OUI) que contiene listado de fabricantes para el correcto uso de la herramienta.*