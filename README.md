# PlanilhaPro Cloud v4.0

Aplicação estática para GitHub Pages, com Supabase para autenticação/armazenamento e integração opcional de leitura/sincronização do Google Sheets. Sem necessidade de instalar Node.js/XAMPP no computador do usuário.

## Identidade visual v4.0 aprovada
- Tipografia Comfortaa nos títulos e Cabin no texto, com fallbacks se Google Fonts estiver indisponível.
- Nova logo de planilha com gráfico de tendência, aplicada também aos ícones PWA.
- Arquivo de exemplo flutuando e bolhas lentas no card Organização inteligente.
- Seletor opcional entre verde-água (padrão) e verde intenso, com mudança coordenada no card de destaque.
- Cards de indicadores da Visão geral clicáveis e painel Configurações.

## Incluído
- Cadastro, login e mensagens comuns de autenticação em português.
- Biblioteca privada, upload/download, edição e histórico de versões.
- Navegação funcional entre abas de arquivos Excel; rascunhos de abas diferentes são mantidos ao alternar e salvos juntos.
- Botão **Abrir arquivo** para importar um arquivo local direto para o editor e para a biblioteca.
- PWA instalável com tratamento de arquivo em navegadores compatíveis; o seletor interno continua disponível em todos os navegadores suportados pelo site.
- Importar planilhas Google e verificar alterações a cada 2 minutos enquanto o site permanece aberto e a autorização estiver válida. Cada detecção de mudança cria uma nova versão.

## Atualização de uma instalação v3.0
1. Não sobrescreva `config.js` com os valores de exemplo. Preserve os valores Supabase existentes e acrescente `GOOGLE_CLIENT_ID` usando `config.example.js` como referência.
2. Envie a nova versão de `index.html`, `manifest.webmanifest`, `sw.js`, `icons/`, documentação e pasta `supabase/` ao diretório raiz do repositório GitHub Pages.
3. Execute uma vez `supabase/migrations/v4_google_sheets.sql` no SQL Editor do projeto Supabase existente. A migração não apaga dados de planilha.
4. Configure OAuth e o Client ID seguindo `GUIA-GOOGLE-SHEETS.md`.
5. Faça commit no GitHub, aguarde o deploy e atualize o navegador com Ctrl+F5.

## Google Sheets: arquitetura e limites
- OAuth Google Identity Services usando o escopo `spreadsheets.readonly`.
- O link da planilha e o ID ficam na tabela privada `google_sheet_links`, com RLS por usuário. Tokens de acesso não são persistidos no banco nem no `localStorage`; permanecem na memória do navegador.
- A sincronização é de Google para a cópia do PlanilhaPro. Ela não envia edições de volta para a planilha original.
- A verificação em segundo plano no navegador ocorre a cada 2 minutos apenas enquanto a página está aberta e o token segue válido. Se o site estiver fechado, não há processo em segundo plano; o usuário precisa reabrir/reconectar e sincronizar. Sincronização contínua 24/7 requer backend/serviço agendado seguro.
- A cópia xlsx mantém valores e abas, mas não replica completamente formatação avançada, gráficos, comentários, proteções, validações e scripts do Google Sheets.

## Publicação
Veja `COMECE-AQUI.md` para atualizar o GitHub Pages e `GUIA-GOOGLE-SHEETS.md` para configurar a API. O `config.js` não está incluído neste pacote de atualização de propósito, para evitar apagar os dados de configuração já configurados na instalação existente. `config.example.js` é apenas um modelo.

## Validação
O pacote teve a sintaxe do JavaScript, os IDs HTML, o manifesto e os principais comportamentos de interface verificados em navegador de teste. O teste completo de login, armazenamento e integração Google ainda depende das credenciais reais Google/Supabase; use planilhas de teste antes de armazenar dados importantes.
