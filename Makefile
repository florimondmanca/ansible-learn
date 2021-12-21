venv = venv
bin = ${venv}/bin/

export ANSIBLE_CONFIG = ansible/ansible.cfg

ansible = ${bin}ansible
ansible-playbook = ${bin}ansible-playbook

# Project commands

install:
	python3 -m venv ${venv}
	${bin}pip install -U pip wheel
	${bin}pip install ansible
	${ansible} --version
	${bin}pip install -r backend/requirements.txt

serve:
	${bin}uvicorn --app-dir backend app:app

deploy:
	${ansible-playbook} ansible/playbook-deploy.yml

# Ansible learning commands

ansible:
	${ansible} $(args)

hello-world:
	${ansible-playbook} ansible/playbook-hello-world.yml

ping:
	${ansible} all -m ping

check:
	${ansible} all -a "curl localhost"

# VM management

vm:
	vagrant up

ssh:
	vagrant ssh

stop:
	vagrant halt

destroy:
	vagrant destroy
