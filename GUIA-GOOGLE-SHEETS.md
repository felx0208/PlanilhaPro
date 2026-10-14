# Configurar integração com Google Sheets — PlanilhaPro v4.0

Esta integração importa uma planilha Google para a biblioteca privada do PlanilhaPro e detecta mudanças pela API Google Sheets. A sincronização automática roda a cada 2 minutos enquanto o PlanilhaPro está aberto e o token do Google está válido. Ela lê do Google para o PlanilhaPro; não escreve de volta no Google. Ao detectar alterações remotas, cria uma nova versão e preserva o histórico anterior.

## 1. Criar ou escolher um projeto Google Cloud
1. Acesse https://console.cloud.google.com/ e entre com a conta Google que controla a planilha.
2. Crie um projeto (por exemplo, `PlanilhaPro`) ou selecione um projeto existente.
3. Abra **APIs e serviços → Biblioteca**, pesquise **Google Sheets API** e clique em **Ativar**.

## 2. Configurar consentimento OAuth
1. Abra **Google Auth Platform** (ou **APIs e serviços → Tela de permissão OAuth**).
2. Configure nome do app, e-mail de suporte e contato.
3. Se o app estiver em modo de teste/External, adicione seu próprio endereço Google como **Test user**. Para liberar ao público em geral, avalie os requisitos de verificação do Google. O escopo de leitura de planilhas é sensível.

## 3. Criar o Client ID
1. Em **Google Auth Platform → Clients**, selecione **Create client**.
2. Tipo: **Web application**. Nome: `PlanilhaPro GitHub Pages`.
3. Em **Authorized JavaScript origins**, adicione apenas a origem do seu site, sem caminho. Exemplo: `https://SEU-USUARIO.github.io`. Se usar domínio próprio, adicione também essa origem.
4. Para este fluxo de token no navegador, não é necessário adicionar um redirect URI.
5. Crie o client e copie o **Client ID** que termina em `.apps.googleusercontent.com`. Não publique o client secret (este fluxo do navegador não usa client secret).

## 4. Adicionar ao config.js no GitHub
Preserve os valores que já estão configurados. No objeto `window.PLANILHAPRO_CONFIG`, adicione uma linha com a propriedade abaixo, separada por vírgula da anterior:

```js
GOOGLE_CLIENT_ID: "SEU_CLIENT_ID.apps.googleusercontent.com"
```

Exemplo de estrutura (use sua URL/chave Supabase existentes, não estes placeholders):

```js
window.PLANILHAPRO_CONFIG = {
  SUPABASE_URL: "https://SEU-PROJETO.supabase.co",
  SUPABASE_ANON_KEY: "SUA_CHAVE_PUBLICA_PUBLISHABLE_OU_ANON",
  STORAGE_BUCKET: "planilhas",
  GOOGLE_CLIENT_ID: "SEU_CLIENT_ID.apps.googleusercontent.com"
};
```

**Nunca adicione `service_role`, chave `secret`, senha do banco ou client secret do OAuth ao site.**

## 5. Criar tabela de vínculo no Supabase
1. No ZIP atualizado, abra `supabase/migrations/v4_google_sheets.sql`.
2. Copie o arquivo inteiro.
3. No Supabase, abra **SQL Editor → New query**, cole tudo e clique **Run**.
4. Espere confirmação sem erro. Esta migração cria somente a tabela de vínculos e suas políticas; não apaga arquivos ou versões já existentes.

## 6. Importar e sincronizar
1. Abra o PlanilhaPro, entre na conta Supabase e clique em **Google Sheets**.
2. Cole o link de uma planilha do tipo `https://docs.google.com/spreadsheets/d/...`.
3. Clique **Conectar e importar** e selecione a conta Google correta.
4. Conceda a permissão de leitura de planilhas. Todas as abas acessíveis serão importadas.
5. A planilha importada mostrará um botão **Sincronizar** na biblioteca. Você também pode usar **Reconectar e sincronizar existentes**.

## Limites importantes
- A sincronização é de uma direção: Google Sheets → PlanilhaPro. Editar a cópia no PlanilhaPro não altera o Google original.
- A verificação ocorre a cada 2 minutos enquanto a página permanece aberta e a autorização está válida. Se o navegador fechar, nenhum site estático consegue continuar consultando a API; ao voltar, clique em Google Sheets e reconecte/sincronize se necessário. Para execução contínua com o site fechado, é preciso um serviço de servidor agendado e armazenar tokens de atualização com segurança.
- O pacote solicita o escopo `spreadsheets.readonly`, que permite ler as planilhas visíveis à conta Google autorizada. Para um produto público, veja os requisitos de verificação dos escopos sensíveis do Google.
- Valores e abas são sincronizados. Nomes de abas que não são permitidos pelo formato XLSX ou que ultrapassam 31 caracteres podem ser ajustados na cópia do PlanilhaPro. Formatações avançadas, fórmulas como fórmulas editáveis, gráficos, comentários, proteções, validações e scripts do Google Sheets não são replicados integralmente no arquivo `.xlsx`; a integração importa os valores calculados.
- A API precisa estar ativada e o usuário Google precisa ter acesso de leitura ao arquivo. O Google pode aplicar limites de uso.
