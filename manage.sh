#!/bin/bash

# Variables
MODULE_PATH=$1
DATE=$(date '+%Y-%m-%d %H:%M:%S')
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Si no se pasa ningún argumento, hacer pull y salir
if [ -z "$MODULE_PATH" ]; then
    echo "No module specified, pulling latest changes..."
    git pull origin $GIT_BRANCH
    echo "No module specified for testing. Please provide a module path."
    exit 1
fi

# Validar si el módulo existe
if [ ! -d "$MODULE_PATH" ]; then
    echo "Error: Module path '$MODULE_PATH' does not exist."
    exit 1
fi

echo "Running tests for module: $MODULE_PATH"

# Ejecutar el script que realiza los tests (test-modules.sh)
# Asegúrate de que el script de tests esté en la raíz del repo
if [ -f "./test-modules.sh" ]; then
    ./test-modules.sh "$MODULE_PATH"

    # Verificar si los tests pasaron
    if [ $? -ne 0 ]; then
        echo "Tests failed for module: $MODULE_PATH. Aborting..."
        exit 1
    fi
else
    echo "Error: test-modules.sh script not found."
    exit 1
fi

# Hacer commit con la información del módulo
echo "All tests passed for module: $MODULE_PATH. Preparing to commit and push."

# Realizar el commit y el push
git add .
COMMIT_MESSAGE="Updated module: $MODULE_PATH | Date: $DATE"
git commit -m "$COMMIT_MESSAGE"

# Hacer push al branch actual
echo "Pushing changes to branch $GIT_BRANCH..."
git push origin $GIT_BRANCH

echo "Done!"
