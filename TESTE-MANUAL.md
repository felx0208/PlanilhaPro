# Checklist de teste — PlanilhaPro v4.0

## Design aprovado
- [ ] A logo de planilha com gráfico aparece no login e na barra lateral.
- [ ] Os títulos usam Comfortaa e o texto Cabin (quando as fontes online estão acessíveis).
- [ ] No card Organização inteligente, o arquivo flutua suavemente e pequenas bolhas passam da esquerda para a direita.
- [ ] Abra Configurações e escolha Verde intenso: os destaques e o card Organização inteligente devem mudar para verde forte.
- [ ] Volte para Verde-água: a aparência original deve retornar; recarregar a página mantém a escolha neste navegador.
- [ ] Cada cartão de indicadores da Visão geral abre a seção correspondente.
- [ ] A animação é reduzida automaticamente se o dispositivo estiver configurado para reduzir movimento.


## Navegação lateral
- [ ] Em computador com mouse, confirmar que o painel começa compacto e mostra apenas ícones.
- [ ] Passar o mouse sobre o painel e confirmar que expande mostrando os nomes dos botões.
- [ ] Tirar o mouse do painel e confirmar que ele recolhe sem deslocar o conteúdo principal.
- [ ] Usar Tab para navegar pelos botões e confirmar que o painel também expande com foco do teclado.
- [ ] Em tela estreita/touch, confirmar que o menu continua utilizável.

## Editor e abas
- [ ] Enviar um XLSX com pelo menos três abas (ex.: Agosto, Setembro e Outubro).
- [ ] Abrir no PlanilhaPro e clicar em todas as abas.
- [ ] Alterar uma célula em Agosto, ir a Setembro, alterar outra célula e voltar a Agosto. Verificar que os rascunhos ainda aparecem.
- [ ] Salvar e baixar o arquivo; verificar que ambas as alterações foram salvas nas abas certas.
- [ ] Testar Próxima/Anterior com arquivo de mais de 100 linhas.

## Arquivo local / PWA
- [ ] Clique **Abrir arquivo**, escolha um XLSX e verifique que ele abre no editor e aparece na biblioteca.
- [ ] Instale o app no Chrome/Edge se a opção existir. Teste abrir um XLSX pelo sistema operacional; se o navegador não oferecer integração com arquivos, use o botão interno.

## Autenticação em português
- [ ] Cadastro novo mostra orientação de confirmação de e-mail em português.
- [ ] Login com senha incorreta mostra mensagem em português.
- [ ] E-mail não confirmado mostra mensagem em português.
- [ ] Recuperação de senha mostra orientação em português.

## Google Sheets
- [ ] Configure Google Sheets API e Client ID de acordo com GUIA-GOOGLE-SHEETS.md.
- [ ] Execute a migração `supabase/migrations/v4_google_sheets.sql` no projeto Supabase existente.
- [ ] Importar um link de planilha com pelo menos duas abas.
- [ ] Alterar um valor na planilha Google e aguardar até 2 minutos com o PlanilhaPro aberto; verificar que uma nova versão é criada.
- [ ] Clicar **Sincronizar** para forçar uma verificação.
- [ ] Verificar o histórico, baixar versões anteriores e garantir que continuam disponíveis.
- [ ] Confirmar que outra conta Supabase não consegue acessar o arquivo nem o registro de vínculo.

Não use planilhas com dados sensíveis até concluir todos os testes.
