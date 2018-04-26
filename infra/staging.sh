#!/bin/sh
ansible-playbook -i environments/staging/inventory playbooks/staging-db-playbook.yml -u deploy -s -v
ansible-playbook -i environments/staging/inventory playbooks/staging-web-playbook.yml -u deploy -s -v
