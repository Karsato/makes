SHELL := /bin/zsh
.DEFAULT_GOAL := help

# Variables globales
PROJECT_NAME := mi_proyecto

# ----------------------------------------------------------------------
# IMPORTACIÓN DINÁMICA DE MÓDULOS
# ----------------------------------------------------------------------
# Esto carga alfabéticamente cualquier archivo .mk que pongas en make/
include $(wildcard make/*.mk)

# ----------------------------------------------------------------------
# AYUDA AUTOMÁTICA
# ----------------------------------------------------------------------
.PHONY: help
help: ## Muestra la ayuda agrupada por secciones limpias
	@echo "\033[1;34mSISTEMA DE TAREAS\033[0m"
	@echo "\033[1;34m=================\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk ' \
		BEGIN { FS = ":" } \
		{ \
			archivo_raw = $$1; \
			objetivo = $$2; \
			linea = $$0; \
			pos_desc = index(linea, "##"); \
			descripcion = substr(linea, pos_desc + 3); \
			gsub(/.*\//, "", archivo_raw); \
			if (archivo_raw == "Makefile") { \
				seccion = "PRINCIPAL"; \
			} else { \
				sub(/\.[Mm][Kk]$$/, "", archivo_raw); \
				seccion = toupper(archivo_raw); \
			} \
			if (seccion != ultima_seccion) { \
				printf "\n\033[1;35m[%s]\033[0m\n", seccion; \
				printf "-----------------------------------\n"; \
				ultima_seccion = seccion; \
			} \
			if (objetivo != "") { \
				printf "  \033[36m%-20s\033[0m %s\n", objetivo, descripcion; \
			} \
		}'
