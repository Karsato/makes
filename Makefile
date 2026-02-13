SHELL := /bin/zsh
.DEFAULT_GOAL := help

# Variables globales
PROJECT_NAME := mi_proyecto

# Importar automáticamente todos los módulos .mk en la carpeta make
include $(wildcard make/*.mk)

.PHONY: help
help: ## Muestra la ayuda agrupada por secciones limpias
	@echo "\033[1;34mSISTEMA DE TAREAS\033[0m"
	@echo "\033[1;34m=================\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk ' \
		BEGIN { FS = ":" } \
		{ \
			# 1. Separamos campos básicos \
			archivo_raw = $$1; \
			objetivo = $$2; \
			\
			# 2. Extraemos la descripción limpiamente buscando el "##" \
			linea = $$0; \
			pos_desc = index(linea, "##"); \
			descripcion = substr(linea, pos_desc + 3); \
			\
			# 3. Limpiamos el nombre del archivo/sección \
			gsub(/.*\//, "", archivo_raw); \
			if (archivo_raw == "Makefile") { \
				seccion = "PRINCIPAL"; \
			} else { \
				sub(/\.[Mm][Kk]$$/, "", archivo_raw); \
				seccion = toupper(archivo_raw); \
			} \
			\
			# 4. Control de cabeceras \
			if (seccion != ultima_seccion) { \
				printf "\n\033[1;35m[%s]\033[0m\n", seccion; \
				printf "-----------------------------------\n"; \
				ultima_seccion = seccion; \
			} \
			\
			# 5. Imprimimos la línea final \
			if (objetivo != "") { \
				printf "  \033[36m%-20s\033[0m %s\n", objetivo, descripcion; \
			} \
		}'
