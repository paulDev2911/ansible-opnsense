# OPNsense Ansible Repo

Infrastructure-as-Code für OPNsense – VLANs, Firewall-Regeln, DNS, WireGuard VPN, Suricata IDS/IPS und CrowdSec.

## Voraussetzungen

```bash
pip install ansible
ansible-galaxy collection install ansibleguy.opnsense
```

OPNsense Voraussetzungen:
- OPNsense 23.x oder neuer
- Plugin `os-firewall` installiert (für Firewall-Regeln per API)
- API Key + Secret angelegt unter System → Access → Users

## Repo-Struktur

```
opnsense-ansible/
├── inventory/
│   └── hosts.yml              # Deine OPNsense Host-Definition
├── group_vars/
│   ├── all/
│   │   └── vars.yml           # Globale Variablen
│   └── opnsense/
│       └── vars.yml           # OPNsense-spezifische Variablen
├── host_vars/                 # Host-spezifische Overrides
├── roles/
│   ├── opnsense_vlans/        # VLAN-Konfiguration
│   ├── opnsense_firewall/     # Firewall-Regeln + Inter-VLAN
│   ├── opnsense_dns/          # Unbound DNS
│   ├── opnsense_vpn/          # WireGuard
│   └── opnsense_ids/          # Suricata + CrowdSec
└── playbooks/
    ├── site.yml               # Master Playbook
    ├── vlans.yml
    ├── firewall.yml
    ├── dns.yml
    ├── vpn.yml
    └── ids.yml
```

## Nutzung

```bash
# Alles ausrollen
ansible-playbook playbooks/site.yml

# Nur VLANs
ansible-playbook playbooks/vlans.yml

# Nur Firewall-Regeln
ansible-playbook playbooks/firewall.yml

# Dry-run
ansible-playbook playbooks/site.yml --check --diff
```

## Secrets

API Keys **niemals** in Git committen. Nutze eine der folgenden Methoden:

- **Ansible Vault:** `ansible-vault encrypt_string 'dein-api-secret'`
- **OpenBao/Vault:** Secrets per `community.hashi_vault` Collection injizieren
- **Environment Variables:** `OPNSENSE_API_KEY` / `OPNSENSE_API_SECRET`

```bash
# Vault-verschlüsselte vars erstellen
ansible-vault encrypt group_vars/opnsense/secrets.yml
```

## VLAN-Übersicht

| VLAN | Name | Subnet | Internet |
|------|------|--------|----------|
| 10 | Management | 192.168.10.0/24 | ❌ |
| 20 | Servers | 192.168.20.0/24 | ✅ |
| 30 | Storage | 192.168.30.0/24 | ❌ |
| 40 | Monitoring | 192.168.40.0/24 | ❌ |
| 50 | Clients | 192.168.50.0/24 | ✅ |
