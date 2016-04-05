# Puppet GoCD Module

#### Table of Contents

 1. [Overview](#overview)
 2. [Description](#description)
 3. [Configuration](#configuration)
 4. [Librarian](#librarian)
 5. [Development](#development)

## Overview

This is a Puppet Module to deploy and manage the ThoughtWorks GoCD server and agent(s). This is a fork of jmkeyes/gocd module. 

Fork changes include:
  * WORKING with version 15.x ```default version: latest``` 
  * paramaterized with params.pp
  * calling module directly works
  * default's to server install if server not specified for agent
  * fixes git dependency
  * drops Debian/Ubuntu support
  * renames and moves user to /home/gocd from /var/go
  * New User type for creating users
  * Vagrantfile added to fast testing

## Description

For a server: 
```
class { '::gocd': server => true, }
``` 

For agents you must specify the server to use like this:
```
class { '::gocd': server => '172.16.2.101', }
```

## Configuration

This module installs the openjdk appropriate, but can be used in conjunction with oracle jdk using the puppetlabs-java  module, but you will need to edit ::gocd::common::dependencies to do that. GoCD also uses a bunch of java deprecated ssl cyphers as of version Java 1.7p79 so the package ```nss``` requires an upgrade to the latest work-around this, which is handled in this module.

The server install is currently a bare minimum setup, it does not configure pipelines, environments, repositories, plugins or OAUTH, currently this must be done from the GUI or extend the module at will, see [TODO](#development).

## Librarian

To use this module with puppet librarian add the following to your Puppetfile

```
mod "gocd",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/swizzley88-gocd-0.1.0.tar.gz"
mod "stdlib",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/puppetlabs-stdlib-4.11.0.tar.gz"
mod "java",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/puppetlabs-java-1.4.3.tar.gz"
mod "java_ks",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/puppetlabs-java_ks-1.4.1.tar.gz"
mod "firewall",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/puppetlabs-firewall-1.8.0.tar.gz"
mod "concat",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/puppetlabs-concat-2.1.0.tar.gz"
mod "git",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/puppetlabs-git-0.4.0.tar.gz"
mod "epel",
    :tarball => "https://forgeapi.puppetlabs.com/v3/files/stahnma-epel-1.2.2.tar.gz"
```

## Development

Send a pull request with a concise description or a valid test. 

Current TODO List:

  * Add Plugins Type for managing plugins
  * Add LDAP conf to params
  * Add OAuth conf to params
  * Add git service account to params
  * Add baseline templates
  * Add pipelines to params
  * Add environments to params
  * Add proxy configuration to params
  * Add Jobs type for managing jobs
  * Add stage conf to params
  * Add backup conf to params
  * Add repo type for managing repos
  * Add option to restore from backup via xml
  * Add server conf to params

