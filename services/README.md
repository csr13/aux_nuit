### Build scripts for services that can be integrated into systems.

* Arachni is a web application security scanner.
* Firmware is a firmware analysis platform.
* GVM is a network scanner (Greenbone)
* ZAP is a web application security scanner.
* Dfirtrack is an incident response tracker.

### Manager

The manager searches for a `service/build.sh` executable in order to begin installing, modify the build.sh to your needs. 

Some services require docker, and most services are configured to run a system services and can be controlled via `systemctl`

### TO DO:
- [x] Modify the main manager.sh to add the options to pick services.
- [ ] Modify the main manager.sh to build services after picking the service to build.
