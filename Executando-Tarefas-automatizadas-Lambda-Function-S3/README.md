# Executando-Tarefas-automatizadas-Lambda-Function-S3
<img width="60" height="160" alt="image" src="https://github.com/user-attachments/assets/d759c827-ea61-400c-a461-a5e5a6953dba" />
 Este repositório foi criado como parte dos estudos e desafios do Santander Code Girls - Executando Tarefas Automatizadas com Lambda Function e S3.
 

🚀 Projeto DIO: O Poder da Automação com AWS Lambda e S3
Neste laboratório, mergulhei no ecossistema da AWS para construir um pipeline de automação de tarefas . O objetivo não foi apenas aprender sobre serviços isolados, mas entender como a combinação inteligente de Amazon S3 e AWS Lambda pode criar soluções que reagem a eventos em tempo real, de forma escalável e sem a necessidade de gerenciamento de servidores.

As Peças do Quebra-Cabeça
Para construir essa automação, utilizamos dois serviços fundamentais da AWS, cada um com um papel muito claro:

1. Amazon S3: O "Depósito Inteligente" (O Gatilho)
Muitos pensam no Amazon S3 (Simple Storage Service) apenas como um "HD na nuvem". No entanto, neste projeto, utilizamos como um serviço de armazenamento ativo .

Ele não é apenas um local para salvar arquivos (objetos) de forma segura e durável. Sua verdadeira força para a automação é sua capacidade de emitir eventos . O S3 pode, literalmente, "avisar" outros serviços da AWS sempre que algo acontece em um bucket , como:

Um novo arquivo foi carregado ( PUT).
Um arquivo foi excluído ( DELETE).
Um arquivo foi modificado.
No nosso desafio, o S3 atua como o ponto de partida , o gatilho que inicia todo o processo.
Exemplo Prático: Imagine um bucket S3 configurado para receber logs de diversas aplicações. Se alguém verificar manualmente essa pasta, o S3 pode disparar nossa automação no segundo exato em que um novo log chega.

2. AWS Lambda: O "Funcionário Sob Demanda" (A Ação)
Se o S3 é o gatilho, o AWS Lambda é a ação . Ele é o cérebro da nossa operação e a essência da computação serverless .

A magia do Lambda é simples: você só se preocupa com o código . Não há servidores para provisionar, atualizar ou escalar.

Ele "dorme" (sem custo) até ser invocado por um evento.
Quando o S3 (ou qualquer outro gatilho) o chama, ele "acorda" instantaneamente, executa a lógica que programamos e volta a "dormir".
Ele escala automaticamente. Se 1000 arquivos chegarem ao S3 ao mesmo tempo, a AWS provisionará 1000 instâncias da função para processá-los em paralelo.
Exemplo Prático: Continuando o exemplo dos logs, assim que o S3 avisa sobre um novo log, o Lambda é acionado. Nossa função poderia, então, ler o log, procurar por mensagens de "ERRO", e,     se encontrar, enviar uma notificação para um horário de suporte via Slack ou SNS.
	 
A Mágica da Integração: S3 + Lambda na Prática
O verdadeiro poder explorado neste desafio está na conexão entre esses dois serviços. Criamos um pipeline orientado a eventos (orientado para eventos) clássico:

  
1- Evento: Um usuário (ou sistema) faz o upload de um arquivo (ex: dados.csv) para um bucket S3.
2- Gatilho: O S3 detecta o evento s3:ObjectCreated:*e envia uma notificação.
3- Invocação: O Lambda, que estava "escutando" esse tipo de evento, é invocado, recebendo um JSON com todos os detalhes do arquivo (nome, local, tamanho, etc.).
4- Processamento: Nosso código dentro do Lambda é executado.

  Analisando o Código (Node.js)
  O "esqueleto" de uma função Lambda que reage a um evento do S3 é direto. O foco é saber “ler” o evento que o S3 nos envia.
  
    // Importamos o SDK da AWS para, se necessário, manipular outros serviços
    const AWS = require('aws-sdk');
    const s3 = new AWS.S3();

    // O 'handler' é o ponto de entrada da nossa função
    exports.handler = async (event) => {
    
    // O 'event' é o JSON enviado pelo S3. 
    // Precisamos "desempacotar" ele para achar o que nos interessa.
    const bucketName = event.Records[0].s3.bucket.name;
    const objectKey = event.Records[0].s3.object.key; // 'key' é o nome/caminho do arquivo

    // Um log para vermos no CloudWatch o que recebemos
    console.log(`Novo arquivo detectado: ${objectKey} no bucket ${bucketName}`);

    //
    // É AQUI QUE A LÓGICA DE NEGÓCIO ENTRA:
    //
    // * Poderíamos ler o conteúdo do arquivo com s3.getObject().
    // * Se fosse uma imagem, poderíamos redimensioná-la.
    // * Se fosse um CSV, poderíamos validar os dados e inserir em um banco de dados.
    //

    // Retornamos uma resposta de sucesso
    return {
        statusCode: 200,
        body: JSON.stringify('Processamento concluído com sucesso!')
    };
    };

  
   Desafio proposto por Digital Innovation One - DIO
 

 
