#!/bin/bash

# Script para remover toda a infraestrutura

STACK_NAME="minha-infraestrutura"

echo "🗑️  Removendo infraestrutura..."
echo "⚠️  ATENÇÃO: Isso vai apagar TODOS os recursos!"
echo ""

read -p "Tem certeza que quer continuar? (digite 'sim'): " confirmacao

if [ "$confirmacao" != "sim" ]; then
    echo "❌ Operação cancelada."
    exit 0
fi

# Verificar se AWS CLI está instalado
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI não encontrado!"
    exit 1
fi

# Verificar se a stack existe
aws cloudformation describe-stacks --stack-name $STACK_NAME &> /dev/null

if [ $? -ne 0 ]; then
    echo "❌ Stack '$STACK_NAME' não encontrada!"
    exit 1
fi

echo "🔥 Iniciando remoção da stack..."

aws cloudformation delete-stack --stack-name $STACK_NAME

echo "⏳ Aguardando remoção completar..."
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

if [ $? -eq 0 ]; then
    echo "✅ Infraestrutura removida com sucesso!"
    echo "💰 Todos os recursos foram deletados. Não haverá mais custos."
else
    echo "❌ Erro ao remover infraestrutura!"
    echo "🔍 Verifique o console da AWS para detalhes."
    exit 1
fi