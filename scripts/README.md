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
- [disable-shutdown-when-idle.sh](disable-shutdown-when-idle.sh) - prevent containers from shutting down when idle.
- [enable-shutdown-when-idle.sh](enable-shutdown-when-idle.sh) - allow containers auto-shut-down after 15 minutes idle.

## Deployment Aspects

### Keep Containers Active When Idle

By default, CloudRun shuts idle projector containers down after 15 minutes.
As a consequence, users have to re-configure Rider.

Deploying containers using the flags `--no-cpu-throttling` and `--min-instances 1`
we prevent the automatic shut down.

Details about configuring the CloudRun deployment are explained in the associated
[CPU allocation (services) documentation](https://cloud.google.com/run/docs/configuring/cpu-allocation?hl=en).

#### Test the Default Deployment and Enable/Disable-... Scripts

```gherkin
SCENARIO 1: Default Deployment with Always-On
GIVEN normal deployment
AND the projector configuration is completed
AND > 15 minutes passed without interaction

WHEN I reload the projector browser page

THEN the projector state is the same as before the reload,
i.e. I don't need to configure the IDE again
AND Google Metrics show that the container has been billable for the entire period of time
```

```gherkin
SCENARIO 2: Enable Auto-Shutdown
GIVEN normal deployment
AND the projector configuration is completed

WHEN I execute the enable-... script
AND I wait for > 15 minutes without interaction
AND I reload the projector browser page

THEN the projector state differs from before the reload,
i.e. I need to configure the IDE again
AND Google Metrics show that the container was not billable for the entire period of time
```

```gherkin
SCENARIO 3: Disable Auto-Shutdown
GIVEN normal deployment
AND the projector configuration is completed
AND I have executed the enable-... script

WHEN I execute the disable-... script
AND I wait for > 15 minutes without interaction
AND I reload the projector browser page

THEN the projector state is the same as before the reload,
i.e. I don't need to configure the IDE again
AND Google Metrics show that the container has been billable for the entire period of time
```

## Helper Scripts

The following script is called by the control scripts described above:

- [read-env.sh](read-env.sh) - Source the [.env](.env) configuration file.
