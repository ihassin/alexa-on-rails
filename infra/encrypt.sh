#!/usr/bin/env bash
ansible-vault encrypt environments/staging/group_vars/staging-web-server.yml  --vault-password-file ~/.vault_pass.txt
ansible-vault encrypt environments/prod/group_vars/prod-web-server.yml  --vault-password-file ~/.vault_pass.txt

ansible-vault encrypt environments/staging/group_vars/staging-db-server.yml  --vault-password-file ~/.vault_pass.txt
ansible-vault encrypt environments/prod/group_vars/prod-db-server.yml  --vault-password-file ~/.vault_pass.txt
