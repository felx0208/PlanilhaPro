# Segurança — PlanilhaPro Cloud v4.0

- O repositório GitHub Pages é público; não envie planilhas reais, senhas, service_role/secret ou client secret OAuth.
- A chave Supabase publishable/anon pode estar no navegador se RLS e as políticas incluídas estiverem corretamente aplicadas.
- A tabela `google_sheet_links` usa RLS e limita os registros ao usuário autenticado.
- A autorização Google solicita leitura (`spreadsheets.readonly`). Tokens de acesso ficam apenas na memória da página e não são salvos no Supabase/localStorage.
- Usuários devem autorizar apenas suas próprias contas/planilhas confiáveis.
- A sincronização de navegador não é um serviço 24/7. Para sincronização com o site fechado, use um backend confiável, tokens offline protegidos e controles de acesso/auditoria adicionais.
