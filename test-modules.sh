#!/bin/bash

# Ruta base del repositorio
BASE_DIR="$(pwd)"

# Verifica si se ha pasado un argumento (nombre del módulo)
if [ -n "$1" ]; then
  MODULES_TO_TEST=("$1")
else
  # Si no se pasa un argumento, buscar todos los directorios en la raíz que contengan módulos de Terraform
  MODULES_TO_TEST=($(find . -maxdepth 1 -type d -name 'tfmod-*' -exec basename {} \;))
fi

# Función para ejecutar pruebas en un módulo
test_module() {
  local module_name=$1
  local module_path="$BASE_DIR/$module_name/examples/test"

  echo "--------------------------------------------------"
  echo "Testing module: $module_name"
  echo "--------------------------------------------------"

  # Navega al directorio del módulo
  cd "$module_path" || {
    echo "Test directory not found for $module_name. Skipping..."
    return
  }

  # Inicializa Terraform
  terraform init -input=false

  # Ejecuta terraform validate
  terraform validate
  if [ $? -ne 0 ]; then
    echo "Validation failed for $module_name. Aborting..."
    return
  fi

  # Ejecuta terraform plan
  terraform plan -out=plan.out
  if [ $? -eq 0 ]; then
    echo "Plan successfully created for $module_name."
  else
    echo "Terraform plan failed for $module_name."
  fi

  # Vuelve a la raíz del repositorio
  cd "$BASE_DIR"
}

# Recorre cada módulo y ejecuta las pruebas
for module in "${MODULES_TO_TEST[@]}"; do
  test_module "$module"
done
