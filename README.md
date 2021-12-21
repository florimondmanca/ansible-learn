# ansible-learn

Learning Ansible by using it to configure a Nginx + Python + Uvicorn + Gunicorn + Supervisor deployment in a Vagrant VM.

## Prerequisites

- A Debian/Ubuntu host
- Python 3.8+
- Install [Virtualbox](https://www.linuxshelltips.com/install-virtualbox-in-linux/)
- Install [Vagrant](https://www.linuxshelltips.com/install-vagrant-in-linux/)

## Usage

Install Ansible and example backend (in a venv):

```bash
make install
```

Ensure the example backend runs fine (Ansible setup should not interfere with a real-world project):

```console
$ make serve
INFO:     Started server process [155190]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
```

Start the VM (simulates a remote Cloud instance):

```bash
make vm
```

> NOTE: this step automatically shares your host SSH key with the VM (see `Vagrantfile`). You would have to do this manually for a real remote Cloud instance.

Ensure VM is fine by sending a ping command using Ansible:

```console
$ make ping
web1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

Or run the "Hello, world" playbook:

```console
$ make hello-world
PLAY [Hello world playbook] *************************

TASK [Gathering Facts] ******************************
ok: [web1]

TASK [Saying hello] *********************************
changed: [web1]

TASK [debug] ****************************************
ok: [web1] => {
    "hello_result.stdout_lines": [
        "Hello, world!"
    ]
}
PLAY RECAP ******************************************
web1    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

Now, deploy the example backend into the VM:

```bash
make deploy
```

Check installation went fine:

```console
$ make check

web1 | CHANGED | rc=0 >>
Hello, world!  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    13  100    13    0     0   4333      0 --:--:-- --:--:-- --:--:--  4333
```

## Reference

VM management:

```bash
# Start VM
make start

# SSH into VM
make ssh

# Stop VM
make stop

# Destroy VM
make destroy
```

Ansible commands:

```bash
# Run a 'hello world' playbook
make hello-world

# Run the deploy playbook
make deploy

# Run an arbitrary Ansible command
make ansible args="..."
```

## Resources

- [Ansible documentation](https://docs.ansible.com/ansible/latest/)
- [Ansible Local Testing: Vagrant and Virtualbox](https://devopsideas.com/ansible-local-setup-using-vagrant-virtualbox/)
- [Automating Python with Ansible](https://tdhopper.com/blog/automating-python-with-ansible/)
- [Deploying a Django application](https://books.agiliq.com/projects/essential-python-tools/en/latest/deployment/example_of_django_deployment.html) - Sample Nginx/Gunicorn/Supervisor setup.
