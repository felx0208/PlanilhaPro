# Histórico de versões

## v4.0 — ajustes visuais aprovados
- Aplicada tipografia Comfortaa nos títulos e Cabin na interface, com fontes alternativas caso Google Fonts esteja indisponível.
- Substituída a marca genérica por um ícone de planilha com gráfico de tendência; alinhados os ícones de aplicativo instalável.
- Adicionada animação suave do arquivo "Relatório mensal.xls" e bolhas pequenas atravessando o fundo do card Organização inteligente.
- Adicionada escolha opcional entre o verde-água original e o verde intenso; o card de Organização inteligente acompanha a cor selecionada.
- Os cartões de indicadores da Visão geral agora levam às áreas correspondentes.
- Adicionado painel Configurações com seleção de cor, persistida neste navegador.
- Mantidos os recursos de login, armazenamento, edição, comparação, histórico, PWA e integração Google existentes.

- Navegação lateral compacta por padrão em desktop; os nomes aparecem ao passar o mouse ou navegar com foco do teclado. Em dispositivos sem hover, o painel continua expandido.

## v4.0 — 2026-10-14
- Corrigida ligação dos cliques do editor e navegação entre abas das planilhas.
- Mantidos rascunhos de várias abas ao navegar; o salvamento aplica todas as abas alteradas na nova versão.
- Adicionado botão para abrir arquivo local diretamente no PlanilhaPro, importando-o para a biblioteca privada.
- Adicionado modo instalável (PWA) e registro de abertura de arquivos no navegador compatível.
- Adicionada integração de leitura com Google Sheets, botão de sincronização manual e verificação automática a cada 2 minutos enquanto o site estiver aberto e autorizado.
- Adicionadas mensagens comuns de login/cadastro em português.
- Adicionada migração Supabase com RLS para vínculos Google, sem apagar as planilhas atuais.
- Ajustado o sincronizador para comparar com a versão salva antes de criar outra versão, evitando versões duplicadas quando não há mudanças.
- Corrigida a persistência de linha/coluna acrescentada durante a edição e tratado o limite de nomes de abas ao importar do Google Sheets.

## v3.0
- Versão inicial Cloud com GitHub Pages e Supabase.
