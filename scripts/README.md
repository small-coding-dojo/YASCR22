# Scripts to Deploy of JetBrains Projector on Google Cloud Run

The scripts in this folder automate the deployment described in our [JetBrains
Projector](../JetBrains-Projector.md) documentation.

Before using the scripts, please configure the "projector" by commenting and
uncommenting the proper variables in [.env](.env).

## Control Scripts

The following scripts are used to deploy and delete projector images in Cloud
Run:

- [deploy-service.sh](deploy-service.sh) - Deploy a JetBrains Projector image.
- [delete-service.sh](delete-service.sh) - Delete a running projector image.

## Helper Scripts

The following script is called by the control scripts described above:

- [read-env.sh](read-env.sh) - Source the [.env](.env) configuration file.
