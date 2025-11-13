# 🚀 AWS CloudFormation

Um projeto básico de **Infrastructure as Code (IaC)** usando AWS CloudFormation para automatizar a criação de infraestrutura na nuvem.

## 📋 O que este projeto faz

Cria automaticamente:
- Uma aplicação web simples em EC2
- Load Balancer para distribuir tráfego  
- Banco de dados RDS MySQL
- Rede VPC com subnets públicas e privadas
- Security Groups para segurança

## 🏗️ Arquitetura Simples

```
Internet → Load Balancer → EC2 (Web App) → RDS MySQL
```

## 📁 Estrutura do Projeto

```
aws-cloudformation/
├── cloudformation/
│   └── infrastructure.yaml     # Template principal
├── scripts/
│   ├── deploy.sh              # Script para fazer deploy
│   └── destroy.sh             # Script para remover tudo
├── parameters.json            # Configurações
└── README.md                  # Este arquivo
```

## 🚀 Como usar

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/aws-cloudformation-simples.git
cd aws-cloudformation-simples
```

### 2. Configure suas informações
Edite o arquivo `parameters.json`:
```json
{
  "KeyName": "sua-chave-ec2",
  "DatabasePassword": "SuaSenhaSegura123!"
}
```

### 3. Faça o deploy
```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

### 4. Acesse sua aplicação
Após alguns minutos, você receberá a URL do Load Balancer para acessar sua aplicação.

### 5. Para remover tudo
```bash
./scripts/destroy.sh
```

## ⚙️ Recursos Criados

| Recurso | Tipo | Descrição |
|---------|------|-----------|
| **Web Server** | EC2 t3.micro | Servidor web com Apache |
| **Database** | RDS MySQL | Banco de dados pequeno |
| **Load Balancer** | ALB | Distribui tráfego |
| **VPC** | Rede | Rede isolada na AWS |
| **Security Groups** | Firewall | Regras de segurança |

## 💰 Custo Estimado
- **Desenvolvimento**: ~$25/mês
- **Produção**: ~$50/mês

## 🔧 Personalização

Para modificar a infraestrutura, edite o arquivo `cloudformation/infrastructure.yaml` e execute novamente o deploy.

### Exemplos de modificações:
- Mudar tipo de instância EC2
- Alterar configurações do banco
- Adicionar mais servidores
- Configurar domínio personalizado

## 📞 Suporte

Problemas? Abra uma [issue](https://github.com/seu-usuario/aws-cloudformation-simples/issues)

---

⭐ **Gostou? Deixe uma estrela no repositório!** ⭐
