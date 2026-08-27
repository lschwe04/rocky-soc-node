#!/usr/bin/env bash
# Enterprise Automated SOC-Node Deployment Script
set -euo pipefail
IFS=$'\n\t'

cleanup_on_error() {
  local exit_code=$?
  local line_no=$1
  echo -e "\n\033[0;31m[FATAL] Deployment fehlgeschlagen in Zeile ${line_no} mit Exit-Code ${exit_code}.\033[0m" >&2
  exit "${exit_code}"
}
trap 'cleanup_on_error ${LINENO}' ERR

echo -e "\033[0;34m[*] Schritt 1: Starte VirtualBox VM via Vagrant...\033[0m"
vagrant up

echo -e "\033[0;34m[*] Schritt 2: Prüfe und installiere Ansible Galaxy Abhängigkeiten...\033[0m"
ansible-galaxy install -r requirements.yml --force

echo -e "\033[0;34m[*] Schritt 3: Warte auf SSH-Bereitschaft...\033[0m"
sleep 5

echo -e "\033[0;34m[*] Schritt 4: Starte Ansible Hardening & Telemetry Playbook...\033[0m"
ansible-playbook -i inventory/hosts.ini playbooks/site.yml --ask-vault-pass

echo -e "\033[0;32m[SUCCESS] SOC-Node wurde vollständig CIS-gehärtet, eBPF-überwacht und mit dem Hub verbunden!\033[0m"
