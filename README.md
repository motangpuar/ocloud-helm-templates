# Helm Charts for OpenAirInterface

### OpenAirInterface License


- [OAI License Model](https://openairinterface.org/legal/oai-license-model/)
- [OAI License v1.1](https://openairinterface.org/legal/oai-public-license/)

It is distributed under OAI Public License V1.1.

### Directory Structure

| Component        | Helm Charts           | Description                                                                 |
|--------------------|---------------------|-------------------------------------------------------------------------|
| `oai-5g-core`      | [`oai-amf`](./oai-5g-core/oai-amf) | Access and Mobility Function                                           |
|                    | [`oai-smf`](./oai-5g-core/oai-smf) | Session Management Function                                            |
|                    | [`oai-upf`](./oai-5g-core/oai-upf) | User Plane Function                                                    |
|                    | [`oai-nrf`](./oai-5g-core/oai-nrf) | Network Repository Function                                            |
|                    | [`oai-ausf`](./oai-5g-core/oai-ausf) | Authentication Server Function                                        |
|                    | [`oai-udm`](./oai-5g-core/oai-udm) | Unified Data Management                                                |
|                    | [`oai-udr`](./oai-5g-core/oai-udr) | Unified Data Repository                                                |
|                    | [`oai-nssf`](./oai-5g-core/oai-nssf) | Network Slice Selection Function                                       |
|                    | [`oai-lmf`](./oai-5g-core/oai-lmf) | Location Management Function                                           |
|                    | [`oai-traffic-server`](./oai-5g-core/oai-traffic-server) | Traffic generation component                                           |
|                    | [`oai-5g-basic`](./oai-5g-core/oai-5g-basic) | Basic deployment of 5G Core components                                 |
|                    | [`oai-5g-mini`](./oai-5g-core/oai-5g-mini) | Minimal deployment of 5G Core components                               |
|                    | [`oai-5g-advance`](./oai-5g-core/oai-5g-advance) | Advanced deployment with additional configuration                      |
|                    | [`mysql`](./oai-5g-core/mysql) | Database backend for core components                                   |
| `oai-5g-ran`       | [`oai-gnb`](./oai-5g-ran/oai-gnb) | 5G gNodeB radio access node                                            |
|                    | [`oai-du`](./oai-5g-ran/oai-du) | Distributed Unit                                                       |
|                    | [`oai-cu`](./oai-5g-ran/oai-cu) | Central Unit                                                           |
|                    | [`oai-cu-cp`](./oai-5g-ran/oai-cu-cp) | Central Unit - Control Plane                                           |
|                    | [`oai-cu-up`](./oai-5g-ran/oai-cu-up) | Central Unit - User Plane                                              |
|                    | [`oai-nr-ue`](./oai-5g-ran/oai-nr-ue) | Simulated NR User Equipment                                            |
| `e2e_scenarios`    | [`case1`](./e2e_scenarios/case1) | End-to-end deployment scenario 1                                       |
|                    | [`case2`](./e2e_scenarios/case2) | End-to-end deployment scenario 2                                       |
|                    | [`case3`](./e2e_scenarios/case3) | End-to-end deployment scenario 3                                       |



Each component in the Helm charts repository typically contains the following files:

##### chart.yaml
This file contains metadata about the Helm chart. It defines the name and version of the chart, and other information that helps Helm identify and manage the chart.

##### values.yaml
This file contains default values for the chart, and it is here that users and developers can configure the chart according to their needs by overriding default values during the Helm install or upgrade process.

##### templates/
The templates directory contains Kubernetes YAML files that define various resources. These templates include placeholders and logic, written using the Go templating syntax, that Helm will replace at runtime to generate the final Kubernetes manifest files. This allows the resources to be dynamically customized based on the user-defined values and configuration. 

##### config.yaml
The config.yaml file is used in Helm charts to define configuration settings that are specific to the application being deployed.

**NOTE:**

Before using the helm-chart we recommend you to read about the OAI codebase and its working from the documents listed on [OAI GitLab](https://gitlab.eurecom.fr/oai/openairinterface5g/-/tree/develop/doc).

The OAI docker images are hosted on [Docker Hub](https://hub.docker.com/u/oaisoftwarealliance).

###  Managing Helm Charts

You should use ```Helm 3.x``` because the charts are using ```apiVersion: v2```.

You can use the below command to check the metadata of the chart locally:

```bash
helm show chart chart-name
```

For example:

```bash
$ cd oai-5g-core/
$ helm show chart oai-amf
```

Perform a dependency update whenever you change anything in the sub-charts or if you have recently cloned the repository.

```bash
helm dependency update
```

For example:

```bash
cd oai-5g-core/oai-5g-basic/
helm dependency update
```

To list all the dependecies your helm chart relies on:

```bash
helm dependency list chart-name
```

For example:

```bash
$ cd oai-5g-core/
$ helm dependency list oai-5g-basic/
```

**NOTE:**
To find all the README files of the components, you can use the below command:

```bash
find . -iname "readme*"
```