# CASE TÉCNICO DEVOPS/SRE DESCOSHOP

## OBJETIVO:

O objetivo deste caso é configurar infraesturtura serveless para executar tarefas agendadas em um ambiente Kubernetes hospedado na AWS (Amazon Web Services). Será utilizado recursos nativos do Kubernetes, chamados CronJobs, para definir e agendar as tarefas que precisam ser executadas em intervalos regulares. Além disso, será integrado ao GitHub Actions para automatizar o processo de implantação, garantindo uma execução confiável e sem intervenção manual.

## PRÉ-REQUISITOS - INFRAESTRUTURA SETUP:

1. Instale o terraform e github cli em seu desktop/laptop (Se necessário). link Apoio: `https://learn.microsoft.com/pt-br/azure/developer/terraform/get-started-windows-bash?tabs=bash`.

2. Instale o visual Studio Code em seu desktop/laptop (Se necessário). Link Apoio: `https://code.visualstudio.com/download`.

3. Crie uma IAM em sua conta AWS com permissões administrativas. Link de acesso: `https://console.aws.amazon.com/console/home?nc2=h_ct&src=header-signin`

4. Clone este repositorio para seu desktop/laptop.

## DEFINIÇÕES:

- dcshp - Abreviação de DescoShop;
- K8S - Kubernets;
- SG - Security Groups;
- CI/CD - Integração Contínua/Entrega Contínua;
- TF - Terraform.

## CHANGES - INFRAESTRUTURA SETUP:

1. Acesse o repositório clonado, e edite os arquivos conforme estrutura a seguir:

##Produção:

- INFRA-PRD-TF: Acesso a pasta "AWS-EKS-STRUCTURE" e edite o arquivo "VARIABLES.TF". Ajuste as variáveis: region, subnet_ids, security_group_id, gfn_security_group_id, de acordo com sua estrutura de VPC. Após ir para próximo step.

- INFRA-PRD-TF: Acesso a pasta "AWS-RDS-STRUCTURE" e edite o arquivo "VARIABLES.TF". Ajuste as variáveis: region, subnet_ids, security_group_id, gfn_security_group_id, de acordo com sua estrutura de VPC.

- INFRA-PRD-TF: Acesso a pasta "AWS-S3-STRUCTURE" e edite o arquivo "VARIABLES.TF". Ajuste as variáveis: region, de acordo com sua estrutura de VPC.

##Staging:

- INFRA-STG-TF: Acesso a pasta "AWS-EKS-STRUCTURE" e edite o arquivo "VARIABLES.TF". Ajuste as variáveis: region, subnet_ids, security_group_id, gfn_security_group_id, de acordo com sua estrutura de VPC. Após ir para próximo step.

- INFRA-STG-TF: Acesso a pasta "AWS-RDS-STRUCTURE" e edite o arquivo "VARIABLES.TF". Ajuste as variáveis: region, subnet_ids, security_group_id, gfn_security_group_id, de acordo com sua estrutura de VPC.

- INFRA-STG-TF: Acesso a pasta "AWS-S3-STRUCTURE" e edite o arquivo "VARIABLES.TF". Ajuste as variáveis: region, de acordo com sua estrutura de VPC.


Observação: Valide se sua estrutura possuí VPC criada, caso não possua, adicione no step 2 nos arquivos de CI/CD deploy a chamada para criação da VPC.

Salve suas alterações, aguarde até o fim dos ajustes para realizar commit e push para seu repositório Github.

## DEPLOY CI/CD - INSTRUÇÕES:

2. Neste estrutura iremos utilizar CI/CD com GitHub Actions para integração e implantação contínuas. A configuração do pipeline está localizada nos seguintes arquivos: 

##Produção:

- Acesse o arquivo `.github/workflows/deploy-aws-prd-cicd.yml`. 

- Adicione suas credênciais AWS criada no step de pré-requisitos. Caso possua suas credênciais atreladas ao Github, será autenticado automaticamente, não sendo necessário adição manual.

##Staging:

- Acesse o arquivo `.github/workflows/deploy-aws-stg-cicd.yml`. 

- Adicione suas credênciais AWS criada no step de pré-requisitos. Caso possua suas credênciais atreladas ao Github, será autenticado automaticamente, não sendo necessário adição manual.

Salve suas alterações, vá para o step 3 para realizar commit e push para seu repositório Github.


3. Para implantar uma nova versão do aplicativo:

- Envie suas alterações para o branch `main`.

- GitHub Actions criará e implantará automaticamente a nova versão.

- Acompanhe o progresso e criação dos serviços serveless em sua contam AWS.

## OBSERVABILIDADE:

Para monitoramento e solução de problemas, acesse o Grafana em `http://PUB_IP_SEU_CLUSTER:3000` e use o Prometheus para coleta de métricas.

## DESENVOLVIDO POR:

- Victor Greco.