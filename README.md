# BooksAPIRobot

Este projeto é um exemplo de automação de testes utilizando Robot Framework para testar uma API de livros.

## Descrição

O **BooksAPIRobot** é um projeto de estudo focado em automação de testes de APIs usando Robot Framework. Este repositório contém scripts e configurações necessárias para executar testes automatizados na API de livros.

## Funcionalidades

- Testes automatizados de API usando Robot Framework.
- Geração de relatórios de teste usando Allure Framework.
- Integração com GitHub Actions para CI/CD.
- Notificações de status via Telegram.

## Estrutura do Projeto

BooksAPIRobot/
│
├── TestCasesAPIBooks.robot        # Arquivo de casos de teste em Robot Framework
├── .github/
│   ├── workflows/
│   │   └── ci-cd.yml              # Arquivo de configuração do GitHub Actions
│   └── scripts/
│       └── notify-telegram.sh     # Script para notificação via Telegram
│
├── allure-report/                 # Diretório dos relatórios do Allure
└── log/                           # Diretório dos logs dos testes



## Configuração

### Pré-requisitos

- Python 3.x
- Robot Framework
- Allure Framework
- Conta no Telegram para receber notificações

### Instalação

Clone o repositório:

```bash
git clone https://github.com/Rocha29/BooksAPIRobot.git
cd BooksAPIRobot

Instale as dependências:

bash
Copiar código
pip install -r requirements.txt
Execução dos Testes
Para executar os testes:

bash
Copiar código
robot -d ./log -i Regressivo TestCasesAPIBooks.robot
Relatórios
Os relatórios de teste são gerados usando o Allure Framework. Após a execução dos testes, você pode acessar o relatório gerado em ./allure-report.

CI/CD com GitHub Actions
Este projeto utiliza o GitHub Actions para automação de CI/CD. O arquivo de configuração .github/workflows/ci-cd.yml define os passos necessários para execução dos testes, geração de relatórios e notificações de status.

Notificações via Telegram
O script notify-telegram.sh envia notificações de status para um canal no Telegram configurado com o bot. Certifique-se de configurar as variáveis de ambiente TELEGRAM_BOT_TOKEN e TELEGRAM_CHAT_ID nos segredos do GitHub.


Este README estruturado ajudará os usuários a entenderem rapidamente como configurar, instalar e executar seu projeto, além de explicar os detalhes importantes sobre CI/CD e notificações via Telegram.
