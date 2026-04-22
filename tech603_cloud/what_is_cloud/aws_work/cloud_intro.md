# Intro to cloud and AWS

- [Intro to cloud and AWS](#intro-to-cloud-and-aws)
  - [what is cloud computing?](#what-is-cloud-computing)
  - [How do we know if something is in the cloud?](#how-do-we-know-if-something-is-in-the-cloud)
  - [Diffferences between on-prem and the cloud?](#diffferences-between-on-prem-and-the-cloud)
  - [4 deployment models of cloud: private vs public vs hybrid vs multi-cloud](#4-deployment-models-of-cloud-private-vs-public-vs-hybrid-vs-multi-cloud)
  - [Types of cloud services: IaaS, PaaS, SaaS](#types-of-cloud-services-iaas-paas-saas)
  - [pros and cons of the cloud:](#pros-and-cons-of-the-cloud)
  - [Difference between OpEx vs CapEx and how it relates to the cloud](#difference-between-opex-vs-capex-and-how-it-relates-to-the-cloud)
  - [is migrating to the cloud always cheaper?](#is-migrating-to-the-cloud-always-cheaper)
  - [Guaranteed levels of service](#guaranteed-levels-of-service)
  - [what sort of things do you usually need to pay for when using the cloud?](#what-sort-of-things-do-you-usually-need-to-pay-for-when-using-the-cloud)
  - [microsoft azure data center](#microsoft-azure-data-center)
  - [google data center](#google-data-center)
  - [note on virtual networks on AWS](#note-on-virtual-networks-on-aws)

<br>

## what is cloud computing?
- on- demand delivery of computing power, database, storage, application services 

## How do we know if something is in the cloud?
- Access cloud through internet, data isnt tied to one device
- nothing is stored locally
- updates and processes happen remotely

## Diffferences between on-prem and the cloud?
- on-prem
  - own the servers, usually on your own properites
- cloud
  - renting computing power
  
## 4 deployment models of cloud: private vs public vs hybrid vs multi-cloud
- private
  - used by one organisation, or rented from a 3rd party, highly secure but expensive
- public
  - owned by big companies and shared between many users, cheap and scalable but less control
- Hybrid cloud
  - mix of private and public so data can be private but workloads run on public, balance of security and flexible but more complex
- Multi- cloud
  - using multiple cloud providers at the same time, avoids dependence on one provider but harder to manage

## Types of cloud services: IaaS, PaaS, SaaS
- IaaS
  - infrastructure as a service, most hands on, storage, networking, virtual machines, EC2
  - what you manage: operating system, software and apps, security
  - What providers manages: physical servers, data centers
  - Uses: full control and great for custom research
- PaaS
  - Platform as a service, mid level control, ready to use platform to run apps, azure app services
  - What you manage: your code and application logic
  - what providers manage: os, runtime, scaling, infrastructure
  - uses: deploy apps quickly 
- SaaS
  - Software as a service, full working software via browser/app, gmail and 365
  - what you manage: just usage
  - what providers manage: everything
  - Uses: everyday tools, emails, docs, storage

<br>

## pros and cons of the cloud:
- pros:
  - Cloud provider manages the physical data center, cooling, power (backups)
  - scalability, redundancy
  - allows collaboration, whole team acceses all resources
  - Access to certain advanced services 
- cons:
  - Need the internet to see whats happening in the cloud
  - Dont have physical control of security
  - On- going costs, suprising charges
  - requires cloud expertise
  - could be more complexity 

## Difference between OpEx vs CapEx and how it relates to the cloud
- Operating expediture
  - On- going expenses
  - ususally a monthly bill when using cloud
  - get a discount if paying in advance by calculating usage
- Capital expenditure
  - upfront costs
  - on- prem usually have more upfront costs

## is migrating to the cloud always cheaper?
- 2 types of calculators:
  - pricing calculators, 
    - find out monthly costs from adding up resources that are going to be used
  - total cost of ownership calculator, 
    - cost of current costs (on- prem) and cost it would be in cloud. 
    - Works out comparison over period of time
- depends on organisation deep analysis

## Guaranteed levels of service
- service level aagreements - typical for most cloud services - what they are going to provide
- SLO relate to how available the service (uptime) is 
- amazon and microsoft have most marketshare, GCP is more specialised so more in demand
  - microsoft already provide many services so many companies use there cloud

## what sort of things do you usually need to pay for when using the cloud?
- VM running- amount of CPU, memory
- VM is stopped
  - still pay for storage
- generally pay for:
  - CPU
  - memory
  - storage
- network traffic - usually pay for outgoing traffic (egress), especially when data needs to cross different networks in different geographical regions
- anything in limited supply

## microsoft azure data center
- take a large area, 20 aircraft hangers, looks very expensive
- if lose power from power grid, they have backup generator with 19000 battery cells, 140 generators
- generator replaced by hydrogen cells or other energy techhnology

## google data center
- requires so much cooling
- huge operation
- levels upon levels of security, laser beams to detect movement
- increase heat to increase efficiency
- lots of waste when replacing drives

## note on virtual networks on AWS
- AWS has a default VPC (virtual private cloud, similar to azure virtual networks) automatically being created for you in every region
  - In azure, you need to create a virtual network for every region