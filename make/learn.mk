help-learn: ## Muestra este menú de ayuda
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

saludo: ## make saludo nombre=Pepito
	@echo "Hola $(nombre), usando $(SHELL)"


awk--hello-world: ## make awk--hello-world
	ls -lh | awk '{ print $$5, $$9 }'

memo: ## make memo -- Muestra procesos en memoria
	ps aux | awk '{print $$2, $$4, $$11}' | sort -k2rn | head -n 5
