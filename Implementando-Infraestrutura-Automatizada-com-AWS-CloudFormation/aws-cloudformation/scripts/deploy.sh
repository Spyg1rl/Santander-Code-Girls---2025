#!/bin/bash

# Script simples para fazer deploy da infraestrutura

STACK_NAME="minha-infraestrutura"
TEMPLATE_FILE="cloudformation/infrastructure.yaml"
PARAMETERS_FILE="parameters.json"

echo "🚀 Iniciando deploy da infraestrutura..."

# Verificar se AWS CLI está instalado
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI não encontrado. Instale primeiro!"
    exit 1
fi

# Verificar se os arquivos existem
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "❌ Arquivo $TEMPLATE_FILE não encontrado!"
    exit 1
fi

if [ ! -f "$PARAMETERS_FILE" ]; then
    echo "❌ Arquivo $PARAMETERS_FILE não encontrado!"
    exit 1
fi

# Validar template
echo "🔍 Validando template..."
aws cloudformation validate-template --template-body file://$TEMPLATE_FILE

if [ $? -ne 0 ]; then
    echo "❌ Template inválido!"
    exit 1
fi

# Verificar se a stack já existe
aws cloudformation describe-stacks --stack-name $STACK_NAME &> /dev/null

if [ $? -eq 0 ]; then
    echo "🔄 Stack já existe. Fazendo update..."
    aws cloudformation update-stack \
        --stack-name $STACK_NAME \
        --template-body file://$TEMPLATE_FILE \
        --parameters file://$PARAMETERS_FILE \
        --capabilities CAPABILITY_IAM
    
    echo "⏳ Aguardando update completar..."
    aws cloudformation wait stack-update-complete --stack-name $STACK_NAME
    
else
    echo "🆕 Criando nova stack..."
    aws cloudformation create-stack \
        --stack-name $STACK_NAME \
        --template-body file://$TEMPLATE_FILE \
        --parameters file://$PARAMETERS_FILE \
        --capabilities CAPABILITY_IAM
    
    echo "⏳ Aguardando criação completar..."
    aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
fi

if [ $? -eq 0 ]; then
    echo "✅ Deploy concluído com sucesso!"
    
    # Mostrar outputs importantes
    echo ""
    echo "📋 Informações importantes:"
    aws cloudformation describe-stacks \
        --stack-name $STACK_NAME \
        --query 'Stacks[0].Outputs[*].[OutputKey,OutputValue]' \
        --output table
else
    echo "❌ Deploy falhou!"
    exit 1
fi