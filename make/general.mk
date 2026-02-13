.PHONY: help

help-general: ## Muestra este menú de ayuda
	@echo "Uso: make [comando]"
	@echo ""
	@echo "Comandos disponibles:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

hello: ## Hello World!
	echo "Hello World!"


hey: one two ## Outputs "hey", since this is the target name
	echo $@

	# Outputs all prerequisites newer than the target
	echo $?

	# Outputs all prerequisites
	echo $^

	# Outputs the first prerequisite
	echo $<

	touch hey

one:
	touch one

two:
	touch two

clean: ## Clean
	rm -f hey one two

date--iso8601: ## Fecha ISO 8601
	@echo "--------------------"
	@date +%Y-%m-%dT%H:%M:%S
	@echo "--------------------"


cal: ## Mostrar calendario
	@cal

cal--all: date--iso8601	cal ## Calendario con indicación de día


toml--hello: ## Hola Mundo. TOML
	@echo "[[item]]"
	@echo 'clave = "valor"'


user--whoami: ## whoami
	@whoami
