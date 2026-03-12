#!/bin/bash
# exportar las credenciales del acr para poder ejecutar cualquier ansible-playbook, 
# ejecutar "source deploy.sh" antes de ansible playbooks


ACR_NAME="acrdevopscasopractico2"
export ACR_USER=$(az acr credential show --name "$ACR_NAME" --query "username" -o tsv | tr -d '\r')
export ACR_PASSWORD=$(az acr credential show --name "$ACR_NAME" --query "passwords[0].value" -o tsv | tr -d '\r')

if [[ -z "${ACR_USER}" || -z "${ACR_PASSWORD}" ]]; then
	echo "No fue posible obtener ACR_USER/ACR_PASSWORD para ${ACR_NAME}."
	return 1
fi

echo "Credenciales ACR exportadas para ${ACR_NAME}."