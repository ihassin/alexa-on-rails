#!/usr/bin/env bash
ansible-vault decrypt environments/prod/group_vars/prod-web-server.yml  --vault-password-file ~/.vault_pass.txt
