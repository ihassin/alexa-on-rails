#!/bin/sh
ansible-playbook -i environments/prod/inventory playbooks/prod-web-playbook.yml -u pi -s -v
