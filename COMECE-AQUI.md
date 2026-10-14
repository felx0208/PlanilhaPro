# PlanilhaPro Cloud v4.0 — atualização

## Antes de enviar
- Este pacote atualiza o `index.html`, adiciona o modo de aplicativo instalável e oferece integração de leitura/sincronização com Google Sheets.
- **Não substitua seu `config.js` pelos valores de exemplo.** Preserve sua URL/chave pública do Supabase e acrescente `GOOGLE_CLIENT_ID` depois de criar a credencial no Google Cloud.
- Para Google Sheets, execute `supabase/migrations/v4_google_sheets.sql` no Supabase. Não execute apenas uma seleção do SQL: copie o arquivo inteiro para uma nova consulta.

## Enviar atualização ao GitHub
1. Extraia o ZIP.
2. No repositório GitHub `planilhapro`, use **Add file → Upload files**.
3. Envie os arquivos da pasta extraída para a raiz do repositório, mantendo a pasta `supabase`, `icons`, `manifest.webmanifest` e `sw.js`.
4. Se houver conflito com `config.example.js`, pode atualizar esse arquivo. **Não apague nem substitua seu `config.js` já configurado.** Se ainda não existir `config.js`, copie `config.example.js`, renomeie para `config.js` no computador, preencha os dados e envie.
5. Faça Commit changes e aguarde o GitHub Pages publicar a atualização.
6. Abra o site e recarregue com Ctrl+F5 para ignorar o cache antigo.

## Arquivo local aberto no PlanilhaPro
- Dentro do app, clique **Abrir arquivo** e selecione `.xlsx`, `.xls`, `.csv` ou `.ods`. O arquivo será salvo na sua biblioteca privada e aberto no editor.
- Para abrir com duplo clique no Explorador do Windows, use Chrome/Edge, abra o site, escolha **Instalar PlanilhaPro** no menu do navegador e aceite o registro de tipos de arquivo quando o navegador oferecer essa opção. O suporte a abrir arquivos pelo sistema operacional depende do navegador/versão e das permissões do computador. Se essa opção não aparecer, use o botão **Abrir arquivo** dentro do site.

## Google Sheets
Siga `GUIA-GOOGLE-SHEETS.md` para ativar a API, criar o Client ID, configurar `config.js` e executar a migração de vínculo do Supabase.
### Painel lateral (desktop)
O painel começa recolhido mostrando apenas os ícones. Passe o mouse por cima para expandir e ver os nomes dos botões. Também expande ao navegar por teclado. Em dispositivos sem mouse/hover, permanece aberto para facilitar o uso.
