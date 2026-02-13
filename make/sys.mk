# Makefile para SysAdmin Dashboard
# Uso: make [objetivo]
# Ejemplo: make ram

.PHONY: help all usuarios ram disco procesos red

# Colores para los títulos
BOLD=\033[1m
RESET=\033[0m
GREEN=\033[32m

sys--all: sys--usuarios sys--ram sys--disco sys--procesos sys--red ## Ejecuta TODO el reporte de una vez

sys--usuarios: ## Muestra usuarios humanos (UID >= 1000)
	@echo "$(BOLD)>>> Usuarios del Sistema$(RESET)"
	@awk -F: 'BEGIN { printf "%-20s %-10s %s\n", "USUARIO", "UID", "SHELL"; print "-------------------- ---------- ----------------" } \
	$$3 >= 1000 && $$3 < 60000 { printf "%-20s %-10s %s\n", $$1, $$3, $$7 }' /etc/passwd
	@echo ""

sys--ram: ## Muestra barra de progreso de RAM
	@echo "$(BOLD)>>> Estado de la Memoria$(RESET)"
	@free -m | awk 'NR==2 { \
		total=$$2; usado=$$3; \
		porcentaje=(usado/total)*100; \
		barras=int(porcentaje/5); \
		printf "RAM: %d MB / %d MB (%.1f%%) [", usado, total, porcentaje; \
		for(i=0;i<barras;i++) printf "#"; \
		for(i=barras;i<20;i++) printf "."; \
		printf "]\n"; \
	}'
	@echo ""

sys--disco: ## Muestra espacio en disco con alertas de color
	@echo "$(BOLD)>>> Espacio en Disco$(RESET)"
	@df -h | awk 'NR>1 && $$1 !~ /loop/ { \
		usado=$$5; sub("%", "", usado); \
		if (usado > 80) color="\033[31m"; else color="\033[32m"; \
		reset="\033[0m"; \
		printf "%-20s %-10s %s%s%s\n", $$1, $$4 " Libres", color, $$5, reset \
	}'
	@echo ""

sys--procesos: ## Top 5 procesos consumiendo RAM
	@echo "$(BOLD)>>> Top 5 Procesos (RAM)$(RESET)"
	@ps aux | awk 'BEGIN { printf "%-10s %-8s %-6s %s\n", "USER", "PID", "%MEM", "COMMAND" } \
	NR>1 { printf "%-10s %-8s %-6s %s\n", $$1, $$2, $$4, $$11 }' | sort -k3 -nr | head -n 5
	@echo ""

sys--red: ## Muestra IPs locales (excluye 127.0.0.1)
	@echo "$(BOLD)>>> Configuración de Red$(RESET)"
	@ip -4 addr | awk '/inet / && !/127.0.0.1/ { \
		split($$2, a, "/"); \
		printf "Interfaz: %-10s IP: %s\n", $$NF, a[1] \
	}'
	@echo ""
