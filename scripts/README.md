# Scripts to Deploy of JetBrains Projector on Google Cloud Run

The scripts in this folder automate the deployment described in our [JetBrains
Projector](../JetBrains-Projector.md) documentation.

Before using the scripts, please configure the "projector" by commenting and
uncommenting the proper variables in [.env](.env).

## Control Scripts

The following scripts are used to deploy and delete projector images in Cloud
Run:

- [deploy-services.sh](deploy-services.sh) - deploy the configured number of JetBrains Projector images.
- [delete-services.sh](delete-services.sh) - delete all running projector* images.

## Helper Scripts

The following script is called by the control scripts described above:

- [read-env.sh](read-env.sh) - Source the [.env](.env) configuration file.
