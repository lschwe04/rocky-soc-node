#!/bin/bash
set -e

echo "[*] Schritt 1: Starte VirtualBox VM via Vagrant..."
vagrant up

echo "[*] Schritt 2: Prüfe und installiere Ansible Galaxy Abhängigkeiten..."
ansible-galaxy install -r requirements.yml --force

echo "[*] Schritt 3: Warte kurz, bis SSH bereit ist, und starte Ansible Playbook..."
# Kurze Pause, damit der SSH-Dienst in der frischen VM hochfahren kann
sleep 5

ansible-playbook -i inventory/hosts.ini playbooks/site.yml

echo "[SUCCESS] Der Server wurde in VirtualBox erstellt, CIS-gehärtet und mit dem SOC-Hub verbunden!"
