-- PlanilhaPro Cloud v3.0
-- Execute o arquivo INTEIRO no Supabase > SQL Editor > New query.
-- Todos os arquivos são privados. Não torne o bucket público.

create extension if not exists pgcrypto;

create table if not exists public.spreadsheet_files (
  id uuid primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 255),
  ext text not null check (ext in ('xlsx','xls','csv','ods')),
  size_bytes bigint not null default 0 check (size_bytes >= 0),
  important boolean not null default false,
  current_version integer not null default 1 check (current_version >= 1),
  row_count integer not null default 0 check (row_count >= 0),
  col_count integer not null default 0 check (col_count >= 0),
  sheet_names jsonb not null default '["Dados"]'::jsonb,
  current_storage_path text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.spreadsheet_versions (
  id uuid primary key default gen_random_uuid(),
  file_id uuid not null references public.spreadsheet_files(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  version_number integer not null check (version_number >= 1),
  note text not null default 'Versão salva',
  storage_path text not null,
  ext text not null check (ext in ('xlsx','xls','csv','ods')),
  size_bytes bigint not null default 0 check (size_bytes >= 0),
  row_count integer not null default 0 check (row_count >= 0),
  col_count integer not null default 0 check (col_count >= 0),
  created_at timestamptz not null default now(),
  unique (file_id, version_number)
);

create index if not exists spreadsheet_files_user_updated_idx
  on public.spreadsheet_files (user_id, updated_at desc);
create index if not exists spreadsheet_versions_file_version_idx
  on public.spreadsheet_versions (file_id, version_number desc);

alter table public.spreadsheet_files enable row level security;
alter table public.spreadsheet_versions enable row level security;

grant select, insert, update, delete on public.spreadsheet_files to authenticated;
grant select, insert, delete on public.spreadsheet_versions to authenticated;

drop policy if exists planilhapro_files_owner_all on public.spreadsheet_files;
create policy planilhapro_files_owner_all
on public.spreadsheet_files
for all to authenticated
using (user_id = (select auth.uid()))
with check (user_id = (select auth.uid()));

drop policy if exists planilhapro_versions_select_own on public.spreadsheet_versions;
create policy planilhapro_versions_select_own
on public.spreadsheet_versions
for select to authenticated
using (user_id = (select auth.uid()));

drop policy if exists planilhapro_versions_insert_own on public.spreadsheet_versions;
create policy planilhapro_versions_insert_own
on public.spreadsheet_versions
for insert to authenticated
with check (
  user_id = (select auth.uid())
  and exists (
    select 1 from public.spreadsheet_files f
    where f.id = file_id and f.user_id = (select auth.uid())
  )
);

drop policy if exists planilhapro_versions_delete_own on public.spreadsheet_versions;
create policy planilhapro_versions_delete_own
on public.spreadsheet_versions
for delete to authenticated
using (user_id = (select auth.uid()));

-- Criar bucket privado. O limite do app é 25 MiB por arquivo.
insert into storage.buckets (id, name, public, file_size_limit)
values ('planilhas', 'planilhas', false, 26214400)
on conflict (id) do update
set public = false, file_size_limit = 26214400;

drop policy if exists planilhapro_storage_select_own on storage.objects;
create policy planilhapro_storage_select_own
on storage.objects for select to authenticated
using (bucket_id = 'planilhas' and (storage.foldername(name))[1] = (select auth.uid())::text);

drop policy if exists planilhapro_storage_insert_own on storage.objects;
create policy planilhapro_storage_insert_own
on storage.objects for insert to authenticated
with check (bucket_id = 'planilhas' and (storage.foldername(name))[1] = (select auth.uid())::text);

drop policy if exists planilhapro_storage_update_own on storage.objects;
create policy planilhapro_storage_update_own
on storage.objects for update to authenticated
using (bucket_id = 'planilhas' and (storage.foldername(name))[1] = (select auth.uid())::text)
with check (bucket_id = 'planilhas' and (storage.foldername(name))[1] = (select auth.uid())::text);

drop policy if exists planilhapro_storage_delete_own on storage.objects;
create policy planilhapro_storage_delete_own
on storage.objects for delete to authenticated
using (bucket_id = 'planilhas' and (storage.foldername(name))[1] = (select auth.uid())::text);

-- Configuração do Supabase Auth:
-- 1) Authentication > URL Configuration: Site URL = URL do GitHub Pages.
-- 2) Adicione a mesma URL em Redirect URLs, incluindo o caminho /REPOSITORIO/.
-- 3) Mantenha confirmação de e-mail ativada para contas públicas.
